# 캐시 및 빌드 파일 정리 커맨드
# 기능: .next, node_modules/.cache 폴더를 삭제하여 프로젝트 캐시를 초기화합니다.

Write-Host "🧹 프로젝트 캐시 정리 시작..." -ForegroundColor Cyan

$itemsToRemove = @(
    ".next",
    "node_modules\.cache",
    ".turbo"
)

foreach ($item in $itemsToRemove) {
    if (Test-Path $item) {
        Write-Host "삭제 중: $item" -ForegroundColor Yellow
        Remove-Item -Recurse -Force $item -ErrorAction SilentlyContinue
        Write-Host "✓ $item 삭제 완료" -ForegroundColor Green
    } else {
        Write-Host "건너뜀: $item (존재하지 않음)" -ForegroundColor Gray
    }
}

Write-Host "✨ 캐시 정리 완료!" -ForegroundColor Green
