# 테스트 자동 수정 에이전트 호출
# 기능: 실패한 테스트를 분석하고 자동으로 수정

Write-Host "🔧 테스트 자동 수정 에이전트 시작..." -ForegroundColor Cyan
Write-Host ""

# 테스트 실행 및 실패 정보 수집
Write-Host "📊 테스트 실행 중..." -ForegroundColor Yellow
$testOutput = npm test 2>&1
$testExitCode = $LASTEXITCODE

if ($testExitCode -eq 0) {
    Write-Host "✅ 모든 테스트가 이미 통과했습니다!" -ForegroundColor Green
    exit 0
}

# 실패한 테스트 정보 저장
$failureLog = @"
=== 테스트 실패 로그 ===
타임스탬프: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

$testOutput
"@

$failureLogPath = ".\.claude\test-failures.log"
$failureLog | Out-File -FilePath $failureLogPath -Encoding UTF8

Write-Host ""
Write-Host "❌ 테스트 실패 감지" -ForegroundColor Red
Write-Host "📝 실패 로그: $failureLogPath" -ForegroundColor Yellow
Write-Host ""

Write-Host "🤖 에이전트 지시:" -ForegroundColor Cyan
Write-Host "1. 위의 실패 로그를 분석하세요"
Write-Host "2. 실패한 테스트 파일을 읽으세요"
Write-Host "3. 원인이 되는 소스 코드를 검토하세요"
Write-Host "4. 테스트 코드를 수정하세요"
Write-Host "5. 수정된 테스트를 재실행하여 검증하세요"
Write-Host ""

Write-Host "💡 팁: 테스트 파일은 다음 패턴으로 검색하세요:" -ForegroundColor Green
Write-Host "   *.test.ts, *.test.tsx, *.spec.ts, *.spec.tsx"
Write-Host ""

exit $testExitCode
