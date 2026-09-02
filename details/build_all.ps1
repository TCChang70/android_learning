<#>
.SYNOPSIS
    一鍵建置 android_learning 目錄下所有範例專案

.DESCRIPTION
    依序對每個範例專案執行 gradlew assembleDebug，
    驗證所有程式碼可正常編譯。

.NOTES
    執行前請確認：
    1. 已安裝 Android SDK、且 ANDROID_HOME 環境變數正確
    2. 每個範例專案根目錄下有 gradlew.bat（Android Studio 產生專案時會自動建立）
    3. 在 PowerShell 執行：Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#>

param(
    [switch]$Clean,
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "專案根目錄：$root" -ForegroundColor Cyan

# 範例專案清單（依教學順序）
$projects = @(
    "04_Example_BMI",
    "10_Day1_TempConverter",
    "11_Day1_LoginForm",
    "07_Complete_Guide",        # 內含 Part 2 待辦清單
    "12_Day2_ProductEdit",
    "13_Day2_ColorPicker",
    "05_Example_MemoApp",
    "15_Day3_SignUpApp",
    "14_Day3_UserSettings",
    "08_Extra_ExpenseTracker"
)

$success = @()
$failed = @()

foreach ($proj in $projects) {
    $projPath = Join-Path $root $proj
    $gradlew = Join-Path $projPath "gradlew.bat"

    Write-Host "`n========== [$proj] ==========" -ForegroundColor Yellow

    if (-not (Test-Path $projPath)) {
        Write-Host "  ❌ 專案資料夾不存在：$projPath" -ForegroundColor Red
        $failed += $proj
        continue
    }

    if (-not (Test-Path $gradlew)) {
        Write-Host "  ⚠️  找不到 gradlew.bat，可能非 Android Studio 產生專案" -ForegroundColor Yellow
        Write-Host "  請先在 Android Studio 開啟該專案產生 Gradle Wrapper" -ForegroundColor Yellow
        $failed += $proj
        continue
    }

    Set-Location $projPath

    $args = @("assembleDebug")
    if ($Clean) { $args = "clean", "assembleDebug" }

    Write-Host "  執行：.\gradlew.bat $($args -join ' ')" -ForegroundColor Gray

    try {
        $exitCode = 0
        if ($Verbose) {
            & .\gradlew.bat @args
            $exitCode = $LASTEXITCODE
        } else {
            $proc = Start-Process -FilePath ".\gradlew.bat" -ArgumentList $args -Wait -PassThru -NoNewWindow
            $exitCode = $proc.ExitCode
        }

        if ($exitCode -eq 0) {
            Write-Host "  ✅ 建置成功" -ForegroundColor Green
            $success += $proj
        } else {
            Write-Host "  ❌ 建置失敗 (exit code: $exitCode)" -ForegroundColor Red
            $failed += $proj
        }
    } catch {
        Write-Host "  ❌ 例外：$($_.Exception.Message)" -ForegroundColor Red
        $failed += $proj
    }

    Set-Location $root
}

# 總結
Write-Host "`n========== 總結 ==========" -ForegroundColor Cyan
Write-Host "成功：$($success.Count) / $($projects.Count)" -ForegroundColor Green
$success | ForEach-Object { Write-Host "  ✅ $_" -ForegroundColor Green }

if ($failed.Count -gt 0) {
    Write-Host "失敗：$($failed.Count)" -ForegroundColor Red
    $failed | ForEach-Object { Write-Host "  ❌ $_" -ForegroundColor Red }
    exit 1
} else {
    Write-Host "`n🎉 所有專案建置通過！" -ForegroundColor Green
    exit 0
}