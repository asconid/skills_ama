<#
.SYNOPSIS
    Skrip Pengecekan Versi dan Pembaruan Otomatis Skill AMA dari GitHub.
.DESCRIPTION
    Memeriksa versi skill AMA yang terpasang terhadap versi rilis terbaru di GitHub (https://github.com/asconid/skills_ama).
    Dapat melakukan pembaruan otomatis (Action: Update) jika pengguna menyetujui.
.PARAMETER Action
    "Check" untuk memeriksa ketersediaan pembaruan (default).
    "Update" untuk mengunduh dan menerapkan pembaruan.
.PARAMETER SkillsDir
    Direktori tempat kumpulan skills AMA terpasang.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateSet("Check", "Update")]
    [string]$Action = "Check",

    [Parameter(Mandatory = $false)]
    [string]$SkillsDir = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if ([string]::IsNullOrWhiteSpace($SkillsDir)) {
    # Default ke direktori induk folder ama
    $SkillsDir = Split-Path -Parent (Split-Path -Parent $scriptDir)
    if (-not (Test-Path (Join-Path $SkillsDir "ama"))) {
        $SkillsDir = "C:\Users\ascon\.gemini\config\skills"
    }
}

$localSkillFile = Join-Path $SkillsDir "ama\SKILL.md"
$localVersion = "1.1.0"
if (Test-Path $localSkillFile) {
    $content = Get-Content $localSkillFile -Raw -Encoding UTF8
    if ($content -match 'version:\s*"([^"]+)"') {
        $localVersion = $matches[1]
    }
}

$repoOwner = "asconid"
$repoName = "skills_ama"
$repoUrl = "https://github.com/$repoOwner/$repoName"
$rawUrl = "https://raw.githubusercontent.com/$repoOwner/$repoName/main/.agent/skills/ama/SKILL.md"
$commitApi = "https://api.github.com/repos/$repoOwner/$repoName/commits/main"

$remoteVersion = $localVersion
$latestCommit = $null
$isUpToDate = $true

try {
    $rawContent = (Invoke-WebRequest -Uri $rawUrl -UseBasicParsing -TimeoutSec 7).Content
    if ($rawContent -match 'version:\s*"([^"]+)"') {
        $remoteVersion = $matches[1]
    }
    
    $commitData = Invoke-RestMethod -Uri $commitApi -Headers @{"User-Agent"="PowerShell"} -TimeoutSec 7
    $latestCommit = @{
        Sha = $commitData.sha.Substring(0, 7)
        Message = $commitData.commit.message.Split("`n")[0]
        Date = $commitData.commit.author.date
    }
} catch {
    Write-Warning "Peringatan: Gagal menghubungi repositori GitHub ($($_.Exception.Message))"
}

function Compare-SemVer([string]$v1, [string]$v2) {
    try {
        $p1 = [version]($v1.TrimStart('v'))
        $p2 = [version]($v2.TrimStart('v'))
        return $p1.CompareTo($p2)
    } catch {
        return [string]::Compare($v1, $v2)
    }
}

$cmp = Compare-SemVer $localVersion $remoteVersion
$isUpToDate = ($cmp -ge 0)

if ($Action -eq "Check") {
    $statusText = if ($isUpToDate) { "UP_TO_DATE" } else { "UPDATE_AVAILABLE" }
    
    return [PSCustomObject]@{
        Status          = $statusText
        LocalVersion    = $localVersion
        RemoteVersion   = $remoteVersion
        IsUpToDate      = $isUpToDate
        LatestCommitSha = if ($latestCommit) { $latestCommit.Sha } else { "" }
        LatestCommitMsg = if ($latestCommit) { $latestCommit.Message } else { "" }
        SkillsDir       = $SkillsDir
        CheckedAt       = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }
} elseif ($Action -eq "Update") {
    Write-Host "=== Memulai Pembaruan Skill AMA dari GitHub ===" -ForegroundColor Cyan
    Write-Host "Repositori: $repoUrl"
    Write-Host "Target    : $SkillsDir"
    
    $tempZip = Join-Path $env:TEMP "skills_ama_update_$([System.Guid]::NewGuid().ToString('N')).zip"
    $tempExtract = Join-Path $env:TEMP "skills_ama_extracted_$([System.Guid]::NewGuid().ToString('N'))"
    
    try {
        Invoke-WebRequest -Uri "$repoUrl/archive/refs/heads/main.zip" -OutFile $tempZip -UseBasicParsing
        Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force
        
        $srcSkills = Join-Path $tempExtract "skills_ama-main\.agent\skills"
        if (-not (Test-Path $srcSkills)) {
            $srcSkills = Join-Path $tempExtract "skills_ama-main\skills"
        }
        
        if (Test-Path $srcSkills) {
            Copy-Item -Path "$srcSkills\*" -Destination $SkillsDir -Recurse -Force
            
            # Normalisasi path internal untuk sistem operasi Windows
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            $mdFiles = Get-ChildItem -Path $SkillsDir -Recurse -Filter "*.md"
            foreach ($f in $mdFiles) {
                $c = [System.IO.File]::ReadAllText($f.FullName)
                $orig = $c
                $c = $c -replace "file:///d:/Project/Skills%20AI%20ASCON/\.agent/skills/", "file:///$($SkillsDir.Replace('\','/'))/"
                $c = $c -replace "file:///d:/Project/Skills%20AI%20ASCON/Template_Struktur_client", "file:///$($SkillsDir.Replace('\','/'))/ama-klien/assets/Template_Struktur_client"
                $c = $c -replace "file:///d:/Project/Skills%20AI%20ASCON/", "file:///$($SkillsDir.Replace('\','/'))/"
                if ($c -ne $orig) {
                    [System.IO.File]::WriteAllText($f.FullName, $c, $utf8NoBom)
                }
            }
            Write-Host "[OK] Berhasil memperbarui seluruh modul AMA ke versi $remoteVersion!" -ForegroundColor Green
            return [PSCustomObject]@{
                Status         = "SUCCESS"
                UpdatedVersion = $remoteVersion
                SkillsDir      = $SkillsDir
                CompletedAt    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }
        } else {
            throw "Struktur folder .agent/skills tidak ditemukan di berkas arsip zip."
        }
    } finally {
        Remove-Item -Path $tempZip, $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
    }
}