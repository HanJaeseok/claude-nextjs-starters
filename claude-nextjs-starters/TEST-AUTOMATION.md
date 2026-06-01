# 테스트 자동 실행 및 수정 시스템

## 개요
코드 변경 시 자동으로 테스트를 실행하고, 실패 시 원인을 분석하여 자동으로 수정하는 시스템입니다.

## 설치

### 1. 의존성 설치
```bash
npm install
```

### 2. Jest 설정 확인
- `jest.config.js` - Jest 설정 파일
- `jest.setup.js` - Jest 초기화 파일

## 사용 방법

### 기본 테스트 실행
```bash
npm test
```

### 감시 모드 (자동 재실행)
```bash
npm run test:watch
```

### 커버리지 분석
```bash
npm run test:coverage
```

### 변경된 파일의 테스트만 실행
```bash
npm test -- --onlyChanged
```

## Claude Code 커스텀 커맨드

### `/run-tests` - 테스트 자동 실행
```bash
/run-tests [mode] [--AutoFix]
```

**모드 옵션:**
- `all` (기본값) - 전체 테스트 실행
- `watch` - 감시 모드
- `coverage` - 커버리지 분석
- `changed` - 변경된 파일의 테스트만 실행

**예시:**
```bash
/run-tests all
/run-tests watch
/run-tests changed --AutoFix
```

### `/test-repair` - 테스트 자동 수정 에이전트
```bash
/test-repair
```

**기능:**
- 실패한 테스트 분석
- 원인 파악
- 테스트 코드 자동 수정
- 수정된 테스트 재실행 및 검증

**워크플로우:**
1. 테스트 실행
2. 실패 원인 분석
3. 소스 코드 검토
4. 테스트 수정
5. 재실행 및 검증
6. 자동 커밋

## 테스트 파일 작성 규칙

### 파일명 규칙
```
src/components/Button.test.tsx
src/utils/helpers.spec.ts
src/__tests__/utils.ts
```

### 기본 구조
```typescript
describe('컴포넌트/함수 이름', () => {
  it('should do something', () => {
    // 준비 (Arrange)
    const input = ...
    
    // 실행 (Act)
    const result = ...
    
    // 검증 (Assert)
    expect(result).toBe(expected)
  })
})
```

## 에이전트 자동 수정 범위

### ✅ 자동 수정 가능
- 변수명 오타 수정
- Import 누락 추가
- 타입 정의 업데이트
- Mock 객체 구조 변경
- 어서션 로직 수정

### ❌ 수동 개입 필요
- 설계 문제
- 복잡한 리팩토링
- 명확하지 않은 신규 테스트
- 외부 API 변경

## 예제

### 예제 테스트
```bash
npm test src/utils/example.test.ts
```

### 실패 테스트 수정
```bash
# 1. 테스트 실행
npm test

# 2. 실패 확인
# ❌ 테스트 실패

# 3. 에이전트 호출
/test-repair

# 4. 자동 수정 및 재실행
# ✅ 모든 테스트 통과
```

## 설정 파일

### jest.config.js
- Next.js와의 통합
- 경로 매핑 (@/ → src/)
- 테스트 환경 설정
- 커버리지 제외 패턴

### jest.setup.js
- Testing Library 초기화
- 전역 설정

## 트러블슈팅

### 테스트 실행 오류
```bash
# 캐시 초기화
npm test -- --clearCache

# 모듈 재설치
rm -rf node_modules
npm install
```

### 타입 오류
```bash
# TypeScript 컴파일 확인
npx tsc --noEmit
```

### 특정 테스트만 실행
```bash
npm test -- --testNamePattern="테스트 이름"
npm test -- src/components/Button.test.tsx
```

## 추가 리소스

- [Jest 공식 문서](https://jestjs.io/)
- [Testing Library](https://testing-library.com/)
- [React 테스트 가이드](https://react.dev/learn/testing)

---

**주의:** 에이전트는 다음 경우에 수정을 시도하지 않습니다:
- 테스트 로직이 근본적으로 잘못된 경우
- 테스트 대상 코드의 설계가 문제인 경우
- 외부 의존성의 API가 변경된 경우

이런 경우에는 수동 개입이 필요하며, 에이전트가 상세한 분석과 권장사항을 제시합니다.
