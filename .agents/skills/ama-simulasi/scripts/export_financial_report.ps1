[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$JsonPath,

    [Parameter(Mandatory = $false)]
    [string]$OutputDir = (Get-Location).Path,

    [Parameter(Mandatory = $false)]
    [string]$FileNamePrefix = ""
)

if (-not (Test-Path $JsonPath)) {
    throw "Berkas JSON data laporan keuangan tidak ditemukan: $JsonPath"
}

$rawJson = Get-Content $JsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

$companyName = if ($rawJson.company_name) { $rawJson.company_name } else { "PT SIMULASI BISNIS NUSANTARA" }
$period = if ($rawJson.period) { $rawJson.period } else { "Tahun Buku 2026" }
$dateStr = if ($rawJson.date_str) { $rawJson.date_str } else { (Get-Date).ToString("yyyyMMdd") }

if ([string]::IsNullOrWhiteSpace($FileNamePrefix)) {
    $cleanComp = ($companyName -replace '[^a-zA-Z0-9]', '_').Trim('_')
    $FileNamePrefix = "${dateStr}_Laporan_Keuangan_${cleanComp}"
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$csvPath = Join-Path $OutputDir "${FileNamePrefix}.csv"
$htmlPath = Join-Path $OutputDir "${FileNamePrefix}.html"
$pdfPath = Join-Path $OutputDir "${FileNamePrefix}.pdf"

# 1. GENERATE CSV
$csvLines = @()
$csvLines += "LAPORAN KEUANGAN STANDAR 15 KELOMPOK AKUN"
$csvLines += "Nama Entitas;""$companyName"""
$csvLines += "Periode;""$period"""
$csvLines += "Tanggal Terbit;""$(Get-Date -Format 'dd MMMM yyyy')"""
$csvLines += ""
$csvLines += "I. LAPORAN LABA RUGI KOMPREHENSIF"
$csvLines += "No;Urutan;Nama Kelompok Akun;Jenis Laporan;Nilai (Rp);% thd Omzet;Catatan"

$omzet = [double]($rawJson.laba_rugi | Where-Object { $_.no -eq 7 } | Select-Object -ExpandProperty nilai -ErrorAction SilentlyContinue)
if (-not $omzet -or $omzet -eq 0) { $omzet = 1 }

foreach ($item in $rawJson.laba_rugi) {
    $pct = [math]::Round(([double]$item.nilai / $omzet) * 100, 2)
    $valStr = [string]::Format("{0:N0}", [double]$item.nilai)
    $catatan = if ($item.catatan) { $item.catatan } else { "" }
    $csvLines += "$($item.no);$($item.urutan);""$($item.nama)"";""$($item.jenis)"";""$valStr"";""$pct%"";""$catatan"""
}

$csvLines += ""
$csvLines += "II. LAPORAN POSISI KEUANGAN (NERACA)"
$csvLines += "No;Urutan;Nama Kelompok Akun;Jenis Laporan;Nilai (Rp);Keterangan;Catatan"

foreach ($item in $rawJson.neraca) {
    $valStr = [string]::Format("{0:N0}", [double]$item.nilai)
    $catatan = if ($item.catatan) { $item.catatan } else { "" }
    $csvLines += "$($item.no);$($item.urutan);""$($item.nama)"";""$($item.jenis)"";""$valStr"";"""";""$catatan"""
}

$csvLines | Set-Content -Path $csvPath -Encoding UTF8
Write-Host "[OK] CSV berhasil dibuat: $csvPath" -ForegroundColor Green

# 2. GENERATE HTML FOR PDF
function Format-Rp([double]$num) {
    return "Rp " + [string]::Format("{0:N0}", $num)
}

$lrRowsHtml = ""
foreach ($item in $rawJson.laba_rugi) {
    $val = [double]$item.nilai
    $pct = [math]::Round(($val / $omzet) * 100, 2)
    $valFormatted = Format-Rp $val
    if ($val -lt 0) {
        $valFormatted = "(" + (Format-Rp ([math]::Abs($val))) + ")"
    }
    $isTotal = $item.is_total -eq $true
    $trClass = if ($isTotal) { "class='row-total'" } else { "" }
    $lrRowsHtml += "<tr $trClass>
        <td style='text-align:center;'>$($item.no)</td>
        <td><strong>$($item.nama)</strong></td>
        <td>$($item.jenis)</td>
        <td style='text-align:right;'>$valFormatted</td>
        <td style='text-align:right;'>$pct%</td>
    </tr>`n"
}

$neracaRowsHtml = ""
foreach ($item in $rawJson.neraca) {
    $val = [double]$item.nilai
    $valFormatted = Format-Rp $val
    $isTotal = $item.is_total -eq $true
    $trClass = if ($isTotal) { "class='row-total'" } else { "" }
    $neracaRowsHtml += "<tr $trClass>
        <td style='text-align:center;'>$($item.no)</td>
        <td><strong>$($item.nama)</strong></td>
        <td>$($item.jenis)</td>
        <td style='text-align:right;'>$valFormatted</td>
    </tr>`n"
}

$totalAset = [double]($rawJson.neraca | Where-Object { $_.no -in @(1, 2, 3) } | Measure-Object -Property nilai -Sum).Sum
$totalKewajibanEkuitas = [double]($rawJson.neraca | Where-Object { $_.no -in @(4, 5, 6) } | Measure-Object -Property nilai -Sum).Sum
$balanceStatus = if ([math]::Abs($totalAset - $totalKewajibanEkuitas) -lt 1) { 
    "<span style='color:#16a34a; font-weight:bold;'>SEIMBANG (BALANCED: Rp $([string]::Format('{0:N0}', $totalAset)))</span>" 
} else { 
    "<span style='color:#dc2626; font-weight:bold;'>SELISIH (Aset: $(Format-Rp $totalAset) vs Kewajiban+Ekuitas: $(Format-Rp $totalKewajibanEkuitas))</span>" 
}

$htmlContent = @"
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<title>Laporan Keuangan - $companyName</title>
<style>
    @page { size: A4 portrait; margin: 15mm 12mm 15mm 12mm; }
    body { font-family: 'Segoe UI', Arial, Helvetica, sans-serif; font-size: 9pt; color: #1e293b; line-height: 1.4; margin: 0; }
    .header { text-align: center; border-bottom: 2px solid #0f172a; padding-bottom: 8px; margin-bottom: 12px; }
    .header h1 { margin: 0 0 4px 0; font-size: 14pt; color: #0f172a; text-transform: uppercase; letter-spacing: 0.5px; }
    .header h2 { margin: 0 0 4px 0; font-size: 11pt; color: #334155; font-weight: 600; }
    .header p { margin: 0; font-size: 8.5pt; color: #64748b; }
    
    .section-title { font-size: 10pt; font-weight: bold; color: #0f172a; background-color: #f1f5f9; padding: 4px 8px; margin: 12px 0 6px 0; border-left: 4px solid #2563eb; }
    
    table { width: 100%; border-collapse: collapse; margin-bottom: 8px; font-size: 8.5pt; }
    th { background-color: #0f172a; color: #ffffff; text-align: left; padding: 5px 8px; font-weight: 600; border: 1px solid #0f172a; }
    td { padding: 4px 8px; border: 1px solid #cbd5e1; }
    tr:nth-child(even) { background-color: #f8fafc; }
    .row-total { background-color: #e2e8f0 !important; font-weight: bold; border-top: 2px solid #0f172a; border-bottom: 2px solid #0f172a; }
    
    .footer { margin-top: 15px; border-top: 1px solid #cbd5e1; padding-top: 6px; font-size: 7.5pt; color: #64748b; display: flex; justify-content: space-between; }
    .badge-box { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 4px; padding: 6px 10px; margin-top: 8px; font-size: 8pt; }
</style>
</head>
<body>

<div class="header">
    <h1>$companyName</h1>
    <h2>LAPORAN KEUANGAN KOMPREHENSIF (15 KELOMPOK AKUN BAKU)</h2>
    <p>Periode: $period | Standar Akuntansi Keuangan & Perpajakan Indonesia | Coretax DJP Ready</p>
</div>

<div class="section-title">I. LAPORAN LABA RUGI KOMPREHENSIF</div>
<table>
    <thead>
        <tr>
            <th style="width:5%; text-align:center;">No</th>
            <th style="width:40%;">Nama Kelompok Akun</th>
            <th style="width:25%;">Jenis Laporan</th>
            <th style="width:20%; text-align:right;">Nilai (Rp)</th>
            <th style="width:10%; text-align:right;">% Omzet</th>
        </tr>
    </thead>
    <tbody>
        $lrRowsHtml
    </tbody>
</table>

<div class="section-title">II. LAPORAN POSISI KEUANGAN (NERACA)</div>
<table>
    <thead>
        <tr>
            <th style="width:5%; text-align:center;">No</th>
            <th style="width:45%;">Nama Kelompok Akun</th>
            <th style="width:25%;">Jenis Posisi</th>
            <th style="width:25%; text-align:right;">Nilai (Rp)</th>
        </tr>
    </thead>
    <tbody>
        $neracaRowsHtml
    </tbody>
</table>

<div class="badge-box">
    <strong>Status Rekonsiliasi Neraca:</strong> $balanceStatus<br>
    <em>Catatan: Disusun berdasarkan matriks 15 kelompok akun resmi untuk keperluan simulasi manajemen, rekonsiliasi fiskal PPh Badan (Pasal 31E), dan ekualisasi SPT Masa/Tahunan.</em>
</div>

<div class="footer">
    <span>Dihasilkan secara otomatis oleh AMA (Asisten Manajemen & Akuntan Pajak Indonesia) v1.1.0</span>
    <span>Tanggal Cetak: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') WIB</span>
</div>

</body>
</html>
"@

$htmlContent | Set-Content -Path $htmlPath -Encoding UTF8

# 3. CONVERT HTML TO PDF USING HEADLESS CHROME / EDGE
$browserPath = $null
if (Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe") {
    $browserPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
} elseif (Test-Path "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe") {
    $browserPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
}

if ($browserPath) {
    try {
        $proc = Start-Process -FilePath $browserPath -ArgumentList "--headless=new", "--disable-gpu", "--no-pdf-header-footer", "--print-to-pdf=`"$pdfPath`"", "`"$htmlPath`"" -Wait -PassThru
        if (Test-Path $pdfPath) {
            Write-Host "[OK] PDF berhasil dibuat: $pdfPath" -ForegroundColor Green
        } else {
            Write-Warning "PDF gagal dibuat oleh browser headless."
        }
    } catch {
        Write-Warning "Gagal mengeksekusi browser headless: $($_.Exception.Message)"
    }
} else {
    Write-Warning "Chrome atau Edge tidak ditemukan untuk konversi PDF otomatis."
}

# Return paths
return @{
    csv = $csvPath
    pdf = $pdfPath
    html = $htmlPath
}

