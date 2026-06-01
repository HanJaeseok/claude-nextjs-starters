# Claude Code 프로젝트 설정

## 프로젝트 정보
- **이름**: Claude Next.js Starter Kit
- **프레임워크**: Next.js 16.2.6, React 19.2.4
- **언어**: TypeScript, Korean

## 에이전트 정책

@AGENTS.md

### 커스텀 에이전트: test-repair

**호출 방법:**
```bash
/test-repair
```

**동작:**
- 테스트 실행 및 실패 원인 분석
- 소스 코드 및 테스트 파일 검토
- 자동 수정 가능한 문제 해결
- 수정된 테스트 재실행 및 검증
- 변경사항 Git 커밋

**적용 대상:**
- 테스트 실패 시 `/test-repair` 커맨드 실행
- 또는 "테스트 수정해줘" 등의 요청

## 커스텀 커맨드

### `/clean-cache`
프로젝트 캐시 파일 정리 (.next, node_modules/.cache 등)

### `/run-tests [mode]`
테스트 자동 실행
- `all` - 전체 테스트
- `watch` - 감시 모드
- `coverage` - 커버리지 분석
- `changed` - 변경된 파일만

### `/test-repair`
실패한 테스트 자동 분석 및 수정
