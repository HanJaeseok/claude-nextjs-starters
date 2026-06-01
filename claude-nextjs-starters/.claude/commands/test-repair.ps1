# 테스트 자동 수정 에이전트 호출 커맨드
# 기능: 실패한 테스트를 자동으로 분석하고 수정하는 에이전트를 호출합니다.

Write-Host "🚀 Test Repair Agent 시작..." -ForegroundColor Cyan
Write-Host ""

# 테스트 실행 및 결과 수집
Write-Host "📊 테스트 스위트 실행 중..." -ForegroundColor Yellow
$testOutput = npm test 2>&1
$testExitCode = $LASTEXITCODE

if ($testExitCode -eq 0) {
    Write-Host "✅ 모든 테스트가 통과했습니다!" -ForegroundColor Green
    Write-Host ""
    Write-Host "테스트 에이전트를 실행할 필요가 없습니다."
    exit 0
}

# 실패한 테스트 정보를 파일로 저장
$failureLogDir = ".\.claude"
if (-not (Test-Path $failureLogDir)) {
    New-Item -ItemType Directory -Path $failureLogDir -Force | Out-Null
}

$failureLogPath = "$failureLogDir\test-failures.log"
$failureLog = @"
=== 테스트 실패 로그 ===
생성 시간: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
테스트 명령: npm test

--- 출력 ---
$testOutput
"@

$failureLog | Out-File -FilePath $failureLogPath -Encoding UTF8 -Force

# 사용자에게 에이전트 호출 안내
Write-Host ""
Write-Host "❌ 테스트 실패 감지됨" -ForegroundColor Red
Write-Host "📝 실패 로그: $failureLogPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "🤖 Test Repair Agent 활성화" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host ""
Write-Host "에이전트가 자동으로 다음을 수행합니다:" -ForegroundColor Green
Write-Host "  1. 🔍 실패한 테스트 원인 분석"
Write-Host "  2. 📖 소스 코드 및 테스트 파일 검토"
Write-Host "  3. 🔧 자동 수정 가능한 문제 해결"
Write-Host "  4. ✅ 수정된 테스트 재실행 및 검증"
Write-Host "  5. 📝 변경사항 Git 커밋"
Write-Host ""
Write-Host "💡 AGENTS.md 파일에서 에이전트 정책을 확인하세요" -ForegroundColor Yellow
Write-Host ""

exit $testExitCode
