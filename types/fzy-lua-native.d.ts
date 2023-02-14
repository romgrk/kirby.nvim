// The fzy matching algorithm
//
// by Seth Warn <https://github.com/swarn>
// a lua port of John Hawthorn's fzy <https://github.com/jhawthorn/fzy>
//
// > fzy tries to find the result the user intended. It does this by favouring
// > matches on consecutive letters and starts of words. This allows matching
// > using acronyms or different parts of the path." - J Hawthorn

/** @noSelf */
declare module 'fzy-lua-native' {
  export function has_match(needle: string, haystack: string, is_case_sensitive: boolean): boolean;
  export function score(needle: string, haystack: string, is_case_sensitive: boolean): number
  export function match_many(needle: string, lines: string[], is_case_sensitive: boolean): string[]
  export function positions(needle: string, lines: string[], is_case_sensitive: boolean): number[]
  export function positions_many(needle: string, lines: string[], is_case_sensitive: boolean): number[][]
  export function get_score_min(): number
  export function get_score_max(): number
  export function get_score_floor(): number
  export function filter(needle: string, lines: string[], is_case_sensitive: boolean): {
    line: string,
    positions: number[],
    score: number,
  }[]
}
