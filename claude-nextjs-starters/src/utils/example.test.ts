describe('예제 테스트', () => {
  it('덧셈이 정확하게 작동해야 함', () => {
    const add = (a: number, b: number) => a + b
    expect(add(2, 3)).toBe(5)
  })

  it('문자열이 정확하게 연결되어야 함', () => {
    const concat = (a: string, b: string) => a + b
    expect(concat('Hello', ' World')).toBe('Hello World')
  })
})
