# 테스트 자동 실행 및 분석 커맨드
# 기능: 변경된 파일의 관련 테스트를 자동 실행하고, 실패 시 분석

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("all", "watch", "coverage", "changed")]
    [string]$Mode = "all",

    [Parameter(Mandatory=$false)]
    [switch]$AutoFix
)

Write-Host "🧪 테스트 실행 시작 (모드: $Mode)" -ForegroundColor Cyan

switch ($Mode) {
    "all" {
        Write-Host "전체 테스트 실행 중..." -ForegroundColor Yellow
        npm test
    }
    "watch" {
        Write-Host "감시 모드 활성화" -ForegroundColor Yellow
        npm run test:watch
    }
    "coverage" {
        Write-Host "커버리지 분석 실행 중..." -ForegroundColor Yellow
        npm run test:coverage
    }
    "changed" {
        Write-Host "변경된 파일의 테스트만 실행..." -ForegroundColor Yellow
        npm test -- --onlyChanged
    }
}

$testResult = $LASTEXITCODE

if ($testResult -ne 0) {
    Write-Host "❌ 테스트 실패 감지됨 (종료 코드: $testResult)" -ForegroundColor Red

    if ($AutoFix) {
        Write-Host "🔧 테스트 자동 수정 모드 활성화..." -ForegroundColor Yellow
        Write-Host "💡 팁: 테스트 수정 에이전트를 사용하려면 다음 명령어를 실행하세요:" -ForegroundColor Cyan
        Write-Host "   /test-repair" -ForegroundColor Green
    }
} else {
    Write-Host "✅ 모든 테스트 통과!" -ForegroundColor Green
}

exit $testResult
