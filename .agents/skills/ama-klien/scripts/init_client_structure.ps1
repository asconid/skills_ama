[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateSet("SingleClient", "MultiClient")]
    [string]$Mode = "SingleClient",

    [Parameter(Mandatory = $false)]
    [string]$ClientName = "",

    [Parameter(Mandatory = $false)]
    [string]$TargetDir = (Get-Location).Path,

    [Parameter(Mandatory = $false)]
    [int[]]$Years = @(2025, 2026)
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$templatePath = Join-Path $scriptDir "..\assets\Template_Struktur_client"
if (-not (Test-Path $templatePath)) {
    # Fallback to root template if available
    $rootTemplate = Join-Path (Get-Location).Path "Template_Struktur_client"
    if (Test-Path $rootTemplate) {
        $templatePath = $rootTemplate
    } else {
        throw "Template folder Template_Struktur_client not found in assets or workspace root."
    }
}

if ($Mode -eq "MultiClient") {
    if ([string]::IsNullOrWhiteSpace($ClientName)) {
        throw "Parameter -ClientName wajib diisi untuk mode MultiClient (contoh: -ClientName 'PT_Maju_Jaya')."
    }
    $sanitizedName = $ClientName -replace '[\\/:*?"<>|]', '_'
    $destRoot = Join-Path $TargetDir "Klien\$sanitizedName"
} else {
    # Single Client mode: subfolder template langsung di root TargetDir
    $destRoot = $TargetDir
}

Write-Host "=== Inisialisasi Struktur Folder Klien AMA ===" -ForegroundColor Cyan
Write-Host "Mode        : $Mode"
Write-Host "Client Name : $(if ($ClientName) { $ClientName } else { '(Single Client Root)' })"
Write-Host "Destination : $destRoot"

if (-not (Test-Path $destRoot)) {
    New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
}

# 1. Salin 00_Dokumen_Permanen
$permSrc = Join-Path $templatePath "00_Dokumen_Permanen"
$permDest = Join-Path $destRoot "00_Dokumen_Permanen"
if (Test-Path $permSrc) {
    Copy-Item -Path $permSrc -Destination $destRoot -Recurse -Force
}

# 2. Salin keterangan.txt root jika ada
$rootKet = Join-Path $templatePath "keterangan.txt"
if (Test-Path $rootKet) {
    Copy-Item -Path $rootKet -Destination $destRoot -Force
}

# 3. Salin / Buat Folder Tahun
foreach ($yr in $Years) {
    $yrSrc = Join-Path $templatePath "$yr"
    if (Test-Path $yrSrc) {
        Copy-Item -Path $yrSrc -Destination $destRoot -Recurse -Force
    } else {
        # Duplikasi dari template 2026 jika tahun berbeda
        $fallbackYr = Join-Path $templatePath "2026"
        if (Test-Path $fallbackYr) {
            $destYrFolder = Join-Path $destRoot "$yr"
            Copy-Item -Path $fallbackYr -Destination $destYrFolder -Recurse -Force
        }
    }
}

Write-Host "Struktur folder berhasil dibuat di: $destRoot" -ForegroundColor Green
