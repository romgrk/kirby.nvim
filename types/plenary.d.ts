
declare module 'plenary.job' {
  class Job {
    static new(opts: {
      command: string,
      args: string[],
      cwd?: string,
      env?: Record<string, string>,
      on_exit: (this: void, code: number, signal: number) => void,
    }): Job
    start(): void
    shutdown(code?: number, signal?: number): void
    sync(): LuaMultiReturn<[string[] | null, number | null]>
    result(): string[]
  }

  export = Job
}
