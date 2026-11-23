## LeetCode 151: Reverse Words in a String
**Difficulty:** Medium | **Pattern:** Split, trim, reverse (two-pointer scan from the end) | **Language:** Java

### 1. Problem
- Given a string `s` of words separated by one or more spaces (possibly with leading/trailing spaces), return the words in reverse order, joined by exactly one space, with no leading or trailing space.
- Example: `"  the sky  is blue "` -> `"blue is sky the"`.
- Constraints: `1 <= s.length <= 10^4`, at least one word exists. A linear O(n) pass is expected.
- **Key insight:** a word is a maximal run of non-space characters. If you scan the string from the right, you meet the words already in reversed order, so you never need to reverse anything: just copy each word out as you find it.

### 2. Solution
1. **Brute force / library:** `String[] w = s.trim().split("\\s+")`, then join from the back. Correct and short, O(n), but it allocates a regex engine pass, an array of substrings and intermediate strings. Fine for a phone screen, but interviewers often ask for the manual version.
2. **Observation:** extra spaces are only a nuisance when you look at them one at a time. If you skip all spaces, then grab the next run of non-spaces, you naturally ignore leading, trailing and repeated spaces.
3. **Optimal:** walk `i` from the end. Skip spaces; mark `end`; walk left over non-spaces; the word is `s[i+1..end]`. Append it to a `StringBuilder`, inserting a single space only before words that are not the first. One pass, O(n) time, O(n) output.

```java
class Solution {
    public String reverseWords(String s) {
        StringBuilder sb = new StringBuilder(s.length());
        int i = s.length() - 1;
        while (i >= 0) {
            while (i >= 0 && s.charAt(i) == ' ') i--;   // skip spaces
            if (i < 0) break;                            // only spaces were left
            int end = i;
            while (i >= 0 && s.charAt(i) != ' ') i--;   // consume the word
            if (sb.length() > 0) sb.append(' ');
            sb.append(s, i + 1, end + 1);                // word is s[i+1..end]
        }
        return sb.toString();
    }
}
```
Implementation notes: `StringBuilder.append(CharSequence, start, end)` copies the slice without creating a temporary substring. The separator is added before a word (not after) so there is never a trailing space.

### 3. Dry Run
Input `s = " a  bc d "` (indices: 0 `' '`, 1 `a`, 2 `' '`, 3 `' '`, 4 `b`, 5 `c`, 6 `' '`, 7 `d`, 8 `' '`).

| Step | i at start | After skipping spaces | end | i after word scan | Word s[i+1..end] | sb |
|---|---|---|---|---|---|---|
| 1 | 8 | 7 | 7 | 6 | `d` | `d` |
| 2 | 6 | 5 | 5 | 3 | `bc` | `d bc` |
| 3 | 3 | 1 | 1 | 0 | `a` | `d bc a` |
| 4 | 0 | -1 | - | - | none, break | `d bc a` |

Answer: `"d bc a"`.

**Complexity:** Time O(n), each index is visited a constant number of times. Space O(n) for the output (O(1) extra beyond it).

### 4. Takeaway
- **Pattern:** tokenising with "skip separators, then consume token". Scanning from the right gives reverse order for free. In languages with mutable strings, the in-place variant is: reverse the whole array, reverse each word, compact spaces.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"hello"` | `"hello"` | single word |
| `"   hello   "` | `"hello"` | leading/trailing spaces dropped |
| `"a   b"` | `"b a"` | multiple inner spaces collapse to one |
| `" "` (outside constraints) | `""` | the `i < 0` break keeps it safe |

- **Mistakes to avoid:**
  - Using `split(" ")` (produces empty strings for repeated spaces) instead of `split("\\s+")` after `trim()`.
  - Adding a trailing space and forgetting to trim.
  - Off-by-one on the slice: the word is `[i+1, end]` inclusive.
- **Related problems:** #186 Reverse Words in a String II (premium, in-place on a char array), #557 Reverse Words in a String III (reverse each word, keep order).

---

## LeetCode 14: Longest Common Prefix
**Difficulty:** Easy | **Pattern:** Vertical scanning / horizontal folding | **Language:** Java

### 1. Problem
- Return the longest string that is a prefix of every string in the array, or `""` if none.
- Example: `["flower","flow","flight"]` -> `"fl"`.
- Constraints: `1 <= n <= 200`, each length `0..200`, lowercase letters. Anything O(total characters) is fine.
- **Key insight:** the common prefix can never be longer than the shortest string, and it ends at the first column where any string disagrees with the first one.

### 2. Solution
1. **Horizontal folding:** `prefix = strs[0]`; for each next string, shrink `prefix` until `s.startsWith(prefix)`. Correct, O(S) where S is the total number of characters, but it may re-scan the long prefix against many strings even though the answer is short.
2. **Observation:** instead of shrinking whole strings, compare character by character, column by column. We stop at the very first mismatch and never look past it.
3. **Optimal (vertical scan):** for each column `col` of the first string, check that every other string has the same character at `col` (and is long enough). On the first failure return `first.substring(0, col)`. Worst case O(S), best case O(n * answer length).

```java
class Solution {
    public String longestCommonPrefix(String[] strs) {
        String first = strs[0];
        for (int col = 0; col < first.length(); col++) {
            char c = first.charAt(col);
            for (int row = 1; row < strs.length; row++) {
                String t = strs[row];
                if (col == t.length() || t.charAt(col) != c) {
                    return first.substring(0, col);
                }
            }
        }
        return first;   // first itself is a prefix of all others
    }
}
```
Implementation notes: the `col == t.length()` check must come before `charAt` to avoid an exception. If the loop finishes, the whole first string is the prefix. This is also the idea behind walking a Trie until a node has more than one child.

### 3. Dry Run
Input `["flower","flow","flight"]`, `first = "flower"`.

| col | c | row | strs[row][col] | Match? | Action |
|---|---|---|---|---|---|
| 0 | f | 1 | f | yes | continue |
| 0 | f | 2 | f | yes | column OK |
| 1 | l | 1 | l | yes | continue |
| 1 | l | 2 | l | yes | column OK |
| 2 | o | 1 | o | yes | continue |
| 2 | o | 2 | i | no | return `first.substring(0,2)` |

Answer: `"fl"`.

**Complexity:** Time O(S), S = total characters (at worst, all strings equal). Space O(1) besides the returned substring.

### 4. Takeaway
- **Pattern:** compare many strings in lockstep and stop at first disagreement. Alternatives in one line: sort and compare only first and last string; binary search on prefix length; Trie.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `["a"]` | `"a"` | single string is its own prefix |
| `["","b"]` | `""` | empty string, loop never runs |
| `["abc","abc"]` | `"abc"` | loop ends, return `first` |
| `["ab","abc"]` | `"ab"` | `first` shorter than others |
| `["abc","ab"]` | `"ab"` | `col == t.length()` guard triggers |

- **Mistakes to avoid:**
  - Indexing past a shorter string.
  - Assuming `strs[0]` is the shortest; the guard handles either case.
  - Returning `null` instead of `""`.
- **Related problems:** #208 Implement Trie (prefix queries structurally), #1032 Stream of Characters (suffix matching with a Trie).

---

## LeetCode 8: String to Integer (atoi)
**Difficulty:** Medium | **Pattern:** Deterministic parser / state machine | **Language:** Java

### 1. Problem
- Implement `atoi`: skip leading spaces, read an optional `+`/`-`, read digits until a non-digit, and clamp to the 32-bit signed range.
- Example: `"  -042x"` -> `-42`. `"2147483648"` -> `2147483647` (clamped).
- Constraints: `0 <= s.length <= 200`. Linear time. The real challenge is correctness at the boundaries without using `long`.
- **Key insight:** process in fixed phases (whitespace, sign, digits) and, before each `result * 10 + d`, check whether it would exceed `Integer.MAX_VALUE`, using only `int` arithmetic.

### 2. Solution
1. **Brute force:** accumulate in a `long` and clamp at the end. Works for 200 characters only if you cap early, otherwise even `long` overflows with long digit strings. Also hides the lesson.
2. **Observation:** overflow in `result * 10 + d` happens exactly when `result > MAX/10`, or `result == MAX/10` and `d > MAX % 10`. `MAX = 2147483647`, so `MAX/10 = 214748364` and the last digit limit is `7`.
3. **Optimal:** accumulate the magnitude as a non-negative `int`. If the next digit would overflow, return `MAX_VALUE` for positive sign or `MIN_VALUE` for negative. This is correct for negatives too: magnitude `2147483648` with sign `-` equals `MIN_VALUE`, which is exactly the clamp value, so the digit `8` falling into the clamp branch is harmless.

```java
class Solution {
    public int myAtoi(String s) {
        int n = s.length(), i = 0;
        while (i < n && s.charAt(i) == ' ') i++;

        int sign = 1;
        if (i < n && (s.charAt(i) == '+' || s.charAt(i) == '-')) {
            if (s.charAt(i) == '-') sign = -1;
            i++;
        }

        final int limit = Integer.MAX_VALUE / 10;   // 214748364
        int result = 0;
        while (i < n) {
            char c = s.charAt(i);
            if (c < '0' || c > '9') break;
            int d = c - '0';
            if (result > limit || (result == limit && d > 7)) {
                return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;
            }
            result = result * 10 + d;
            i++;
        }
        return sign * result;
    }
}
```
Implementation notes: only a single sign is consumed, so `"+-12"` returns 0. Do not use `Character.isDigit` (it accepts non-ASCII digits). Only a literal space counts as whitespace in this problem.

### 3. Dry Run
Input `"  -042x"` (0,1 spaces; 2 `-`; 3 `0`; 4 `4`; 5 `2`; 6 `x`).

| i | char | Phase | d | result | Action |
|---|---|---|---|---|---|
| 0 | space | whitespace | - | 0 | skip |
| 1 | space | whitespace | - | 0 | skip |
| 2 | `-` | sign | - | 0 | sign = -1 |
| 3 | `0` | digits | 0 | 0 | 0*10+0 |
| 4 | `4` | digits | 4 | 4 | 0*10+4 |
| 5 | `2` | digits | 2 | 42 | 4*10+2 |
| 6 | `x` | digits | - | 42 | non-digit, stop |

Answer: `sign * result = -42`.

Overflow spot check, `"2147483648"`: after nine digits `result = 214748364 == limit`; next digit `d = 8 > 7`, so return `Integer.MAX_VALUE` (2147483647).

**Complexity:** Time O(n), single pass. Space O(1).

### 4. Takeaway
- **Pattern:** hand-written parser as phases; pre-check overflow before the multiply-add rather than detecting it afterwards.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `""` | `0` | nothing to parse |
| `"   "` | `0` | only whitespace |
| `"-"` | `0` | sign without digits |
| `"+-12"` | `0` | second sign is a non-digit |
| `"4193 with words"` | `4193` | stop at first non-digit |
| `"words 987"` | `0` | first non-space is not a digit |
| `"-2147483648"` | `-2147483648` | magnitude hits clamp branch, same value |
| `"-91283472332"` | `-2147483648` | clamped |
| `"00000-42a"` | `0` | stops at `-` |

- **Mistakes to avoid:**
  - Checking overflow after multiplying (already wrapped).
  - Using `abs(MIN_VALUE)` or negating at each step.
  - Forgetting that leading zeros are fine.
- **Related problems:** #7 Reverse Integer (same overflow pre-check), #65 Valid Number (a bigger state machine), #166 Fraction to Recurring Decimal.

---

## LeetCode 13: Roman to Integer
**Difficulty:** Easy | **Pattern:** Lookup table + lookahead rule | **Language:** Java

### 1. Problem
- Convert a Roman numeral to an integer. Symbols: `I=1 V=5 X=10 L=50 C=100 D=500 M=1000`. A smaller symbol before a larger one means subtraction (`IV = 4`, `CM = 900`).
- Example: `"MCMXCIV"` -> `1994`.
- Constraints: length `1..15`, valid numeral in `1..3999`. Linear scan is trivial in size.
- **Key insight:** Roman numerals are a sum where a symbol is negative exactly when the next symbol is larger. So one pass with a one-character lookahead is enough.

### 2. Solution
1. **Brute force:** pattern-match the six two-character subtractive pairs (`IV, IX, XL, XC, CD, CM`) first, then single characters. Works but needs string comparisons and special cases.
2. **Observation:** every subtractive pair is "small then large". Instead of recognising pairs, compare values: if `value(s[i]) < value(s[i+1])` subtract it, else add it.
3. **Optimal:** one pass, `switch` expression for the symbol value (no HashMap boxing), lookahead guarded by `i + 1 < n`.

```java
class Solution {
    public int romanToInt(String s) {
        int total = 0, n = s.length();
        for (int i = 0; i < n; i++) {
            int v = value(s.charAt(i));
            if (i + 1 < n && v < value(s.charAt(i + 1))) total -= v;
            else total += v;
        }
        return total;
    }

    private static int value(char c) {
        return switch (c) {
            case 'I' -> 1;
            case 'V' -> 5;
            case 'X' -> 10;
            case 'L' -> 50;
            case 'C' -> 100;
            case 'D' -> 500;
            case 'M' -> 1000;
            default -> 0;
        };
    }
}
```
Implementation notes: a `switch` is faster and allocation-free compared to `Map<Character,Integer>`. The last symbol is always added because it has no successor.

### 3. Dry Run
Input `"MCMXCIV"`.

| i | char | value | next value | Rule | total |
|---|---|---|---|---|---|
| 0 | M | 1000 | 100 (C) | not smaller, add | 1000 |
| 1 | C | 100 | 1000 (M) | smaller, subtract | 900 |
| 2 | M | 1000 | 10 (X) | add | 1900 |
| 3 | X | 10 | 100 (C) | subtract | 1890 |
| 4 | C | 100 | 1 (I) | add | 1990 |
| 5 | I | 1 | 5 (V) | subtract | 1989 |
| 6 | V | 5 | none | last, add | 1994 |

Answer: `1994`.

**Complexity:** Time O(n). Space O(1).

### 4. Takeaway
- **Pattern:** "compare with neighbour to decide sign" in parsing. Right-to-left variant: add if `v >= prev`, else subtract.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"III"` | `3` | all additive |
| `"IV"` | `4` | one subtractive pair |
| `"IX"` | `9` | subtractive |
| `"LVIII"` | `58` | 50+5+3 |
| `"MMMCMXCIX"` | `3999` | maximum |

- **Mistakes to avoid:**
  - Reading `s[i+1]` at the last index.
  - Subtracting when values are equal (`II` must add).
  - Hard-coding only some of the six pairs.
- **Related problems:** #12 Integer to Roman (the reverse direction, greedy over value table), #8 atoi (another parser).

---

## LeetCode 6: Zigzag Conversion
**Difficulty:** Medium | **Pattern:** Index simulation with direction flag | **Language:** Java

### 1. Problem
- Write `s` in a zigzag down and up across `numRows` rows, then read row by row.
- Example: `s = "PAYPALISHIRING"`, `numRows = 3` -> `"PAHNAPLSIIGYIR"`.
- Constraints: `1 <= s.length <= 1000`, `1 <= numRows <= 1000`. O(n) is expected.
- **Key insight:** you never need the 2D grid. Each character just needs its row number, which bounces between `0` and `numRows-1`. Keep a current row and a direction that flips at the two ends.

### 2. Solution
1. **Brute force:** build a 2D grid of `numRows x columns`, place characters along the zigzag, read rows. Needs column math and wastes space for blanks.
2. **Observation:** row-by-row reading only cares which row each character lands in, in order. Rows go `0,1,...,r-1,r-2,...,1,0,1,...`.
3. **Optimal:** `StringBuilder[] rows`; for each character append to `rows[row]`, flip direction when `row` hits `0` or `numRows-1`, then move. Special case `numRows == 1` (or `numRows >= n`): return `s`, because the direction logic would otherwise bounce between row 0 and row `-1`.

```java
class Solution {
    public String convert(String s, int numRows) {
        if (numRows == 1 || numRows >= s.length()) return s;

        StringBuilder[] rows = new StringBuilder[numRows];
        for (int r = 0; r < numRows; r++) rows[r] = new StringBuilder();

        int row = 0, dir = 1;
        for (int i = 0; i < s.length(); i++) {
            rows[row].append(s.charAt(i));
            if (row == 0) dir = 1;
            else if (row == numRows - 1) dir = -1;
            row += dir;
        }

        StringBuilder out = new StringBuilder(s.length());
        for (StringBuilder sb : rows) out.append(sb);
        return out.toString();
    }
}
```
Implementation notes: the direction is decided right after placing the character, from the row we just used. With `numRows >= 2` the row is always in range.

### 3. Dry Run
`s = "PAYPALISHIRING"`, `numRows = 3`.

| i | char | row used | dir after | next row |
|---|---|---|---|---|
| 0 | P | 0 | +1 | 1 |
| 1 | A | 1 | +1 | 2 |
| 2 | Y | 2 | -1 | 1 |
| 3 | P | 1 | -1 | 0 |
| 4 | A | 0 | +1 | 1 |
| 5 | L | 1 | +1 | 2 |
| 6 | I | 2 | -1 | 1 |
| 7 | S | 1 | -1 | 0 |
| 8 | H | 0 | +1 | 1 |
| 9 | I | 1 | +1 | 2 |
| 10 | R | 2 | -1 | 1 |
| 11 | I | 1 | -1 | 0 |
| 12 | N | 0 | +1 | 1 |
| 13 | G | 1 | +1 | 2 |

Rows: row0 = `PAHN`, row1 = `APLSIIG`, row2 = `YIR`. Concatenate: `PAHN` + `APLSIIG` + `YIR` = `"PAHNAPLSIIGYIR"`.

**Complexity:** Time O(n). Space O(n) for the row buffers.

### 4. Takeaway
- **Pattern:** bouncing index with a direction flag (also seen in ping-pong simulations, spiral traversal). Alternative: compute indices mathematically with cycle length `2*(numRows-1)`.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `("AB", 1)` | `"AB"` | early return |
| `("AB", 5)` | `"AB"` | rows >= length |
| `("ABC", 2)` | `"ACB"` | row0 = AC, row1 = B |
| `("A", 1)` | `"A"` | trivial |

- **Mistakes to avoid:**
  - Not special-casing `numRows == 1` (row goes to `-1` and crashes).
  - Flipping direction before placing the char, shifting everything by one.
  - Using `String +=` per character (O(n^2)).
- **Related problems:** #54 Spiral Matrix and #59 Spiral Matrix II (direction-driven simulation in 2D), #498 Diagonal Traverse (bouncing at borders).

---

## LeetCode 38: Count and Say
**Difficulty:** Medium | **Pattern:** Iterative string generation (run-length encoding) | **Language:** Java

### 1. Problem
- `countAndSay(1) = "1"`. For `n > 1`, `countAndSay(n)` is the run-length description of `countAndSay(n-1)`: read the previous string and for each run of equal digits say "count then digit".
- Example: `"21"` is read as one 2, one 1 -> `"1211"`. So `countAndSay(4) = "1211"`.
- Constraints: `1 <= n <= 30`. The string grows by roughly 30% per step, so building it iteratively is cheap.
- **Key insight:** each term is just the run-length encoding of the previous term. Loop `n-1` times, scanning runs.

### 2. Solution
1. **Brute force / recursive:** `countAndSay(n)` calls `countAndSay(n-1)` and encodes it. Same work, but uses stack frames for no benefit.
2. **Observation:** only the previous string matters, so keep one string and replace it.
3. **Optimal:** iterate `n-1` times. For each pass, scan with two indices: `i` starts a run, `j` advances while characters match; append `(j - i)` then the digit. Because the digits are 1, 2 or 3 only and run lengths are at most 3, the count is a single digit, but `append(int)` is safe regardless.

```java
class Solution {
    public String countAndSay(int n) {
        String cur = "1";
        for (int step = 2; step <= n; step++) {
            StringBuilder next = new StringBuilder();
            int i = 0;
            while (i < cur.length()) {
                char c = cur.charAt(i);
                int j = i;
                while (j < cur.length() && cur.charAt(j) == c) j++;
                next.append(j - i).append(c);
                i = j;
            }
            cur = next.toString();
        }
        return cur;
    }
}
```
Implementation notes: `append(int)` writes the decimal digits directly. Chain `append(j - i).append(c)` avoids creating intermediate strings.

### 3. Dry Run
`n = 4`.

| Step | cur (input) | Runs found | next (output) |
|---|---|---|---|
| start | - | - | `"1"` |
| 2 | `"1"` | 1x`1` | `"11"` |
| 3 | `"11"` | 2x`1` | `"21"` |
| 4 | `"21"` | 1x`2`, 1x`1` | `"1211"` |

Inner trace of step 4 (`cur = "21"`):

| i | c | j (end of run) | append | next |
|---|---|---|---|---|
| 0 | 2 | 1 | `1`,`2` | `12` |
| 1 | 1 | 2 | `1`,`1` | `1211` |

Answer: `"1211"`.

**Complexity:** Time O(L_1 + ... + L_n) where L_k is the length of term k (it grows about 1.3x per step); in practice O(1.3^n). Space O(L_n) for the current and next strings.

### 4. Takeaway
- **Pattern:** run-length encoding by grouping consecutive equal characters with a two-index scan.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `n = 1` | `"1"` | loop never runs |
| `n = 2` | `"11"` | one `1` |
| `n = 5` | `"111221"` | term 4 `1211` = one 1, one 2, two 1s |

- **Mistakes to avoid:**
  - Forgetting to flush the last run (the inner `while` bound handles it here).
  - Using `String +=` in the loop.
  - Off-by-one on the number of iterations (`n-1`, not `n`).
- **Related problems:** #443 String Compression (in-place RLE), #271 Encode and Decode Strings (another encoding scheme).

---

## LeetCode 443: String Compression
**Difficulty:** Medium | **Pattern:** In-place run-length encoding with read/write pointers | **Language:** Java

### 1. Problem
- Compress `char[] chars` in place: each run of a repeated character becomes the character followed by the run length (digits written separately) if the length is greater than 1. Return the new length.
- Example: `['a','a','b','b','c','c','c']` -> first 6 chars are `a2b2c3`, return `6`.
- Constraints: `1 <= chars.length <= 2000`. Must use O(1) extra space.
- **Key insight:** the compressed form is never longer than the original run (a run of length 2 becomes 2 characters, longer runs shrink), so a write pointer can never overtake the read pointer.

### 2. Solution
1. **Brute force:** build a `StringBuilder` of the encoding, copy back into `chars`. Correct but O(n) extra space, violating the requirement.
2. **Observation:** this is #38's run grouping combined with the read/write pointer partition from #283. We only write after fully consuming a run, and the output for a run is at most as long as the run itself, so overwriting is safe.
3. **Optimal:** `read` finds the end of the current run; write the character; if the count is greater than 1, write its digits. Digits come out in reverse when extracted with `% 10`, so write them and then reverse that small slice in place (no `toString`, no allocation).

```java
class Solution {
    public int compress(char[] chars) {
        int n = chars.length, write = 0, read = 0;
        while (read < n) {
            char c = chars[read];
            int start = read;
            while (read < n && chars[read] == c) read++;
            chars[write++] = c;

            int count = read - start;
            if (count > 1) {
                int digitsStart = write;
                while (count > 0) {
                    chars[write++] = (char) ('0' + count % 10);
                    count /= 10;
                }
                // digits were emitted least-significant first: reverse the slice
                for (int l = digitsStart, r = write - 1; l < r; l++, r--) {
                    char t = chars[l]; chars[l] = chars[r]; chars[r] = t;
                }
            }
        }
        return write;
    }
}
```
Implementation notes: `c` and `start` are saved before `read` moves, because writing may overwrite `chars[start]` later but never before the run was fully read. A run of 10 or more is written as separate digit characters (`12` -> `'1','2'`), not as one char.

### 3. Dry Run
`chars = [a, b, b, b, b, b, b, b, b, b, b, b, b]` (one `a`, twelve `b`), n = 13.

| Run | start | read after | c | count | write actions | write after | chars[0..write) |
|---|---|---|---|---|---|---|---|
| 1 | 0 | 1 | a | 1 | `chars[0]='a'`; count not > 1 | 1 | `a` |
| 2 | 1 | 13 | b | 12 | `chars[1]='b'`; digits: `12%10=2` at idx 2, `1` at idx 3; reverse idx 2..3 | 4 | `a b 1 2` |

Digit detail: count 12 -> emit `'2'` (count 1) -> emit `'1'` (count 0) gives `2,1` at indices 2,3; reversing yields `1,2`.

Answer: returns `4`, array starts `['a','b','1','2']`.

**Complexity:** Time O(n), each element read once, writes are bounded by n. Space O(1).

### 4. Takeaway
- **Pattern:** read/write pointers for in-place rewriting where output length is bounded by input length.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `['a']` | `1` | single char, no count |
| `['a','a']` | `2` (`a2`) | run of 2 is same size |
| `['a','b','c']` | `3` | no counts written |
| 100 x `'a'` | `4` (`a100`) | multi-digit count |

- **Mistakes to avoid:**
  - Writing `"12"` as a single char or forgetting the digits are separate characters.
  - Writing a `1` for runs of length 1.
  - Reading from positions already overwritten (save `c`, `start` first).
  - Forgetting to reverse the digits.
- **Related problems:** #38 Count and Say (builds a new string), #283 Move Zeroes (read/write partition), #26 Remove Duplicates from Sorted Array.

---

## LeetCode 451: Sort Characters By Frequency
**Difficulty:** Medium | **Pattern:** Frequency map + bucket sort | **Language:** Java

### 1. Problem
- Sort the characters of `s` in decreasing order of frequency; equal-frequency characters can be in any order, but characters of the same kind must be grouped together.
- Example: `"tree"` -> `"eert"` (or `"eetr"`).
- Constraints: `1 <= s.length <= 5 * 10^5`, characters are ASCII letters and digits. Prefer O(n).
- **Key insight:** frequencies are bounded by `n`, so instead of comparison-sorting by count (O(k log k)) put each character into a bucket indexed by its frequency and sweep buckets from high to low, exactly like #347.

### 2. Solution
1. **Brute force:** count, build a list of characters, sort it with a comparator on counts, rebuild. O(n log n) with boxing and the comparator overhead.
2. **Observation:** a heap on counts gives O(n + k log k), where k is the number of distinct characters, still more than needed. The count of any character lies in `[1, n]`.
3. **Optimal:** count into `int[128]`; for each character with a count, append it to `buckets[count]`; walk `f` from `n` down to `1` and emit each character in the bucket `f` times. Total output is exactly `n` characters.

```java
class Solution {
    public String frequencySort(String s) {
        int n = s.length();
        int[] count = new int[128];
        for (int i = 0; i < n; i++) count[s.charAt(i)]++;

        StringBuilder[] buckets = new StringBuilder[n + 1];
        for (char c = 0; c < 128; c++) {
            int f = count[c];
            if (f > 0) {
                if (buckets[f] == null) buckets[f] = new StringBuilder();
                buckets[f].append(c);
            }
        }

        StringBuilder out = new StringBuilder(n);
        for (int f = n; f >= 1; f--) {
            if (buckets[f] == null) continue;
            for (int k = 0; k < buckets[f].length(); k++) {
                char c = buckets[f].charAt(k);
                for (int rep = 0; rep < f; rep++) out.append(c);
            }
        }
        return out.toString();
    }
}
```
Implementation notes: `int[128]` suffices for ASCII input (use 256 if the input could contain extended characters). Buckets are created lazily so memory stays small when few distinct frequencies exist.

### 3. Dry Run
`s = "tree"`, n = 4.

Counting:

| i | char | count after |
|---|---|---|
| 0 | t | t=1 |
| 1 | r | r=1 |
| 2 | e | e=1 |
| 3 | e | e=2 |

Bucket fill (scanning char codes ascending: `e`=101, `r`=114, `t`=116):

| char | f | bucket[f] |
|---|---|---|
| e | 2 | `e` |
| r | 1 | `r` |
| t | 1 | `rt` |

Sweep from f = 4 down:

| f | bucket | Emit | out |
|---|---|---|---|
| 4 | null | - | `` |
| 3 | null | - | `` |
| 2 | `e` | e x2 | `ee` |
| 1 | `rt` | r x1, t x1 | `eert` |

Answer: `"eert"`.

**Complexity:** Time O(n + 128 + n) = O(n). Space O(n) for the buckets and output.

### 4. Takeaway
- **Pattern:** "sort by frequency" where counts are bounded by n -> bucket sort. Mention heap as the O(n + k log k) alternative.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `"a"` | single char |
| `"Aabb"` | `"bbAa"` or `"bbaA"` | case-sensitive; `A` and `a` differ |
| `"cccaaa"` | `"aaaccc"` or `"cccaaa"` | tie, any order, groups intact |

- **Mistakes to avoid:**
  - Treating upper and lower case as the same character.
  - Allocating `n+1` StringBuilders eagerly (wasteful for 5*10^5).
  - Interleaving equal-frequency characters instead of keeping groups.
- **Related problems:** #347 Top K Frequent Elements (same buckets, returns top k), #692 Top K Frequent Words, #387 First Unique Character.

---

## LeetCode 125: Valid Palindrome
**Difficulty:** Easy | **Pattern:** Two pointers + character filtering | **Language:** Java

### 1. Problem
- After lowercasing and removing all non-alphanumeric characters, is the string a palindrome?
- Example: `"A man, a plan, a canal: Panama"` -> `true` (it reads `amanaplanacanalpanama`).
- Constraints: `1 <= s.length <= 2 * 10^5`. O(n) time; try for O(1) extra space.
- **Key insight:** do not build a cleaned copy. Put pointers at both ends, skip anything that is not a letter or digit, and compare case-insensitively.

### 2. Solution
1. **Brute force:** build a filtered, lowercased string, reverse it, compare. O(n) time but two extra strings.
2. **Observation:** comparison only ever needs the next valid character from each side, so the filter can be applied lazily while walking inward.
3. **Optimal:** `l = 0`, `r = n-1`. Move `l` right while not alphanumeric, `r` left likewise (with `l < r` guards). Compare `toLowerCase` of both; mismatch -> false.

```java
class Solution {
    public boolean isPalindrome(String s) {
        int l = 0, r = s.length() - 1;
        while (l < r) {
            while (l < r && !Character.isLetterOrDigit(s.charAt(l))) l++;
            while (l < r && !Character.isLetterOrDigit(s.charAt(r))) r--;
            if (Character.toLowerCase(s.charAt(l)) != Character.toLowerCase(s.charAt(r))) {
                return false;
            }
            l++;
            r--;
        }
        return true;
    }
}
```
Implementation notes: the `l < r` guard inside the inner loops stops pointers crossing on strings made only of punctuation. The input is ASCII here, so `Character` methods are safe.

### 3. Dry Run
`s = "ab,A"` (0 `a`, 1 `b`, 2 `,`, 3 `A`).

| Iteration | l | r | After skipping | Compare | Result |
|---|---|---|---|---|---|
| 1 | 0 | 3 | l=0, r=3 | `a` vs `a` (lowercased `A`) | equal, l=1, r=2 |
| 2 | 1 | 2 | r skips `,` -> r=1 (stops since l<r false) | `b` vs `b` (same index) | equal, l=2, r=0 |
| exit | 2 | 0 | l < r false | - | true |

Answer: `true` (cleaned string `abA` -> `aba`).

**Complexity:** Time O(n), each pointer moves at most n steps total. Space O(1).

### 4. Takeaway
- **Pattern:** converging two pointers with lazy filtering; the entry point to all palindrome problems.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `" "` | `true` | empty after cleaning |
| `".,"` | `true` | only punctuation |
| `"race a car"` | `false` | `e` vs `a` mismatch |
| `"0P"` | `false` | digit vs letter, not equal |

- **Mistakes to avoid:**
  - Forgetting case-insensitivity.
  - Skipping loops without `l < r` guard (index out of range).
  - Using `isLetter` only and dropping digits.
- **Related problems:** #680 Valid Palindrome II (one deletion allowed), #234 Palindrome Linked List, #5 Longest Palindromic Substring.

---

## LeetCode 5: Longest Palindromic Substring
**Difficulty:** Medium | **Pattern:** Expand-around-center (odd and even centers) | **Language:** Java

### 1. Problem
- Return the longest contiguous substring of `s` that reads the same forwards and backwards.
- Example: `"babad"` -> `"bab"` (`"aba"` is also accepted).
- Constraints: `1 <= s.length <= 1000`. O(n^2) is fine; O(n^3) is too slow in principle.
- **Key insight:** every palindrome is mirrored around a center. There are `2n-1` centers (n characters for odd length, n-1 gaps for even length). Grow outward from each center while the two ends match.

### 2. Solution
1. **Brute force:** check every substring (O(n^2) of them) for palindrome-ness (O(n)) -> O(n^3). Wasteful: checking `s[i..j]` repeats the work of `s[i+1..j-1]`.
2. **DP:** `dp[i][j] = s[i]==s[j] && dp[i+1][j-1]` gives O(n^2) time and O(n^2) space. It fills a table when most entries are never needed.
3. **Optimal (expand around center):** same O(n^2) time, O(1) space. For each `i`, expand with centers `(i, i)` (odd) and `(i, i+1)` (even). The expansion function returns the palindrome length; track the best length and its start. Start for a palindrome of length `len` found around center `i` is `i - (len - 1) / 2` (works for both parities: odd `len=3` -> `i-1`; even `len=4` centered between `i` and `i+1` -> `i-1`).

```java
class Solution {
    public String longestPalindrome(String s) {
        int n = s.length();
        int bestStart = 0, bestLen = 1;
        for (int i = 0; i < n; i++) {
            int len = Math.max(expand(s, i, i), expand(s, i, i + 1));
            if (len > bestLen) {
                bestLen = len;
                bestStart = i - (len - 1) / 2;
            }
        }
        return s.substring(bestStart, bestStart + bestLen);
    }

    // returns length of the palindrome grown from the given center
    private static int expand(String s, int l, int r) {
        while (l >= 0 && r < s.length() && s.charAt(l) == s.charAt(r)) {
            l--;
            r++;
        }
        return r - l - 1;   // loop overshoots by one on each side
    }
}
```
Implementation notes: after the loop `l` and `r` are one step beyond the palindrome, so its length is `(r-1) - (l+1) + 1 = r - l - 1`. An empty even expansion (first characters differ) returns 0. Manacher's algorithm does this in O(n) but is rarely expected.

### 3. Dry Run
`s = "babad"` (n = 5). `bestLen` starts at 1, `bestStart` 0.

| i | odd expand(i,i) | even expand(i,i+1) | len | bestLen / bestStart |
|---|---|---|---|---|
| 0 | b; (-1,1) stops -> 1 | b vs a no -> 0 | 1 | 1 / 0 |
| 1 | a; (0,2) b=b ok; (-1,3) stops -> 3 | a vs b no -> 0 | 3 | 3 / 1-1 = 0 |
| 2 | b; (1,3) a=a ok; (0,4) b vs d no -> 3 | b vs a no -> 0 | 3 | not greater, stays 3 / 0 |
| 3 | d; (2,4) b vs d no -> 1 | d vs a no -> 0 | 1 | 3 / 0 |
| 4 | a; (3,5) out of range -> 1 | (4,5) out -> 0 | 1 | 3 / 0 |

Answer: `s.substring(0, 3) = "bab"`.

**Complexity:** Time O(n^2): 2n-1 centers, each expansion up to O(n). Space O(1) besides the output.

### 4. Takeaway
- **Pattern:** palindrome questions with "longest" or "count" -> expand around each of the 2n-1 centers. The O(n^2) DP table is the entry point to interval DP (section 18), but the center expansion is shorter and uses O(1) space.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `"a"` | single char |
| `"bb"` | `"bb"` | even center only |
| `"abc"` | `"a"` | no longer palindrome; first kept |
| `"aaaa"` | `"aaaa"` | every center expands fully |

- **Mistakes to avoid:**
  - Forgetting the even-length centers.
  - Computing the length as `r - l + 1` after the loop (off by two).
  - Start index formula wrong for even lengths.
- **Related problems:** #647 Palindromic Substrings (count instead of longest), #516 Longest Palindromic Subsequence (non-contiguous, true DP), #214 Shortest Palindrome.

---

## LeetCode 647: Palindromic Substrings
**Difficulty:** Medium | **Pattern:** Expand-around-center, count all | **Language:** Java

### 1. Problem
- Count how many substrings of `s` are palindromes. Substrings at different positions are counted separately even if equal.
- Example: `"aaa"` -> `6` (`a`,`a`,`a`,`aa`,`aa`,`aaa`).
- Constraints: `1 <= s.length <= 1000`. O(n^2) is acceptable.
- **Key insight:** same as #5, but instead of keeping the longest, each successful expansion step is one more palindrome. A center that expands `k` times contributes exactly `k` palindromes.

### 2. Solution
1. **Brute force:** test all O(n^2) substrings in O(n) each -> O(n^3).
2. **Observation:** if `s[l..r]` is a palindrome and `s[l-1] == s[r+1]`, then `s[l-1..r+1]` is a palindrome. So palindromes nest around centers, and each valid growth step creates a new one.
3. **Optimal:** for each of the `2n-1` centers, expand and count one per successful step.

```java
class Solution {
    public int countSubstrings(String s) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            count += expand(s, i, i);       // odd centers
            count += expand(s, i, i + 1);   // even centers
        }
        return count;
    }

    private static int expand(String s, int l, int r) {
        int found = 0;
        while (l >= 0 && r < s.length() && s.charAt(l) == s.charAt(r)) {
            found++;
            l--;
            r++;
        }
        return found;
    }
}
```
Implementation notes: the max answer is about n(n+1)/2 = 500,500, which fits easily in `int`.

### 3. Dry Run
`s = "aaa"`.

| i | odd center (i,i) steps | odd count | even center (i,i+1) steps | even count | running total |
|---|---|---|---|---|---|
| 0 | (0,0) ok; (-1,1) stop | 1 | (0,1) ok; (-1,2) stop | 1 | 2 |
| 1 | (1,1) ok; (0,2) ok; (-1,3) stop | 2 | (1,2) ok; (0,3) r out | 1 | 5 |
| 2 | (2,2) ok; (1,3) r out | 1 | (2,3) r out | 0 | 6 |

Answer: `6`.

**Complexity:** Time O(n^2) worst (all equal characters). Space O(1).

### 4. Takeaway
- **Pattern:** counting palindromic substrings -> expand and count. With #5, this covers the palindrome-substring family.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `1` | single |
| `"ab"` | `2` | only single chars |
| `"abc"` | `3` | no longer palindromes |
| `"aaa"` | `6` | maximum for n = 3 |

- **Mistakes to avoid:**
  - Counting only odd centers.
  - Counting a palindrome once per center instead of once per expansion step.
  - Deduplicating equal substrings (not wanted).
- **Related problems:** #5 Longest Palindromic Substring (length not count), #132 Palindrome Partitioning II (min cuts, DP), #131 Palindrome Partitioning (backtracking).

---

## LeetCode 680: Valid Palindrome II
**Difficulty:** Easy | **Pattern:** Two pointers + one allowed deletion | **Language:** Java

### 1. Problem
- Can `s` become a palindrome by deleting at most one character?
- Example: `"abca"` -> `true` (delete `c` or `b`).
- Constraints: `1 <= s.length <= 10^5`, lowercase letters. Need O(n).
- **Key insight:** walk inward from both ends. At the first mismatch, the one deletion must be either the left or the right character, so just try both and check whether the remainder is a palindrome.

### 2. Solution
1. **Brute force:** try deleting each character and test each result: O(n^2). Too slow at 10^5.
2. **Observation:** while characters match, nothing needs to be deleted. The first mismatch `s[l] != s[r]` is the only place where a deletion is forced, and it must remove `s[l]` or `s[r]` (deleting anything else leaves this mismatch).
3. **Optimal:** on mismatch return `isPal(l+1, r) || isPal(l, r-1)`. Each check is O(n), done once, so total O(n).

```java
class Solution {
    public boolean validPalindrome(String s) {
        int l = 0, r = s.length() - 1;
        while (l < r) {
            if (s.charAt(l) != s.charAt(r)) {
                return isPalindrome(s, l + 1, r) || isPalindrome(s, l, r - 1);
            }
            l++;
            r--;
        }
        return true;
    }

    private static boolean isPalindrome(String s, int l, int r) {
        while (l < r) {
            if (s.charAt(l++) != s.charAt(r--)) return false;
        }
        return true;
    }
}
```
Implementation notes: no substrings are created; the helper works on index ranges. Only one level of "try both" is needed because the budget is a single deletion.

### 3. Dry Run
`s = "abca"` (indices 0 a, 1 b, 2 c, 3 a).

| Step | l | r | s[l] | s[r] | Action |
|---|---|---|---|---|---|
| 1 | 0 | 3 | a | a | match, move in |
| 2 | 1 | 2 | b | c | mismatch: check isPalindrome(2,2) and isPalindrome(1,1) |
| 3 | - | - | - | - | isPalindrome(2,2): l<r false -> true; return true |

Answer: `true`.

Failing example `"abc"`: l=0,r=2 `a` vs `c`; isPalindrome(1,2): `b` vs `c` false; isPalindrome(0,1): `a` vs `b` false -> `false`.

**Complexity:** Time O(n), one main pass plus at most two helper passes. Space O(1).

### 4. Takeaway
- **Pattern:** "tolerance of k errors" with two pointers: on mismatch branch into the allowed skips. With k = 1 the branching is just two linear checks.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `true` | trivial |
| `"ab"` | `true` | delete either |
| `"abc"` | `false` | needs two deletions |
| `"aba"` | `true` | already a palindrome |
| `"deeee"` | `true` | delete the `d` |

- **Mistakes to avoid:**
  - Trying only one side on mismatch.
  - Allowing a second deletion by recursing instead of using the helper.
  - Building substrings (extra O(n) allocations).
- **Related problems:** #125 Valid Palindrome (no deletions, filtering), #1216 Valid Palindrome III (k deletions, needs DP), #1328 Break a Palindrome.

---

## LeetCode 271: Encode and Decode Strings
**Difficulty:** Medium | **Pattern:** Length-prefix protocol (`len#string`) | **Language:** Java

Premium problem with no clean free substitute: written from the standard statement. Assumption: strings may contain any character (including `#` and digits), may be empty, and the decoder receives exactly the encoder's output.

### 1. Problem
- Design `encode(List<String>) -> String` and `decode(String) -> List<String>` such that `decode(encode(list))` equals `list`. The strings can contain any of the 256 ASCII characters.
- Example: `["lint","code"]` -> encoded `"4#lint4#code"` -> decoded `["lint","code"]`.
- Constraints: `0 <= list size <= 200`, each string length `0..200`. Linear time in total characters.
- **Key insight:** a delimiter fails because the payload may contain it. Instead of searching for the end of each string, state its length first. The decoder reads the length, then skips exactly that many characters without looking at their content.

### 2. Solution
1. **Naive:** join with a delimiter such as `","`. Breaks when strings contain the delimiter, and cannot distinguish `[]` from `[""]`.
2. **Escaping:** escape the delimiter inside strings. Works but needs careful rules and doubles up characters.
3. **Optimal (length prefix):** write `len + '#' + s` for each string. To decode: from position `i`, scan digits up to the first `#`; the first `#` after `i` is always the separator because only digits come before it. Parse the length, take the next `len` characters verbatim, and continue after them. The payload may contain `#` or digits, but the decoder never inspects it.

```java
import java.util.ArrayList;
import java.util.List;

public class Codec {

    public String encode(List<String> strs) {
        StringBuilder sb = new StringBuilder();
        for (String s : strs) {
            sb.append(s.length()).append('#').append(s);
        }
        return sb.toString();
    }

    public List<String> decode(String s) {
        List<String> result = new ArrayList<>();
        int i = 0, n = s.length();
        while (i < n) {
            int len = 0;
            while (s.charAt(i) != '#') {
                len = len * 10 + (s.charAt(i) - '0');
                i++;
            }
            i++;                                  // skip '#'
            result.add(s.substring(i, i + len));  // copy exactly len chars
            i += len;
        }
        return result;
    }
}
```
Implementation notes: an empty list encodes to `""` and decodes to `[]`; a list `[""]` encodes to `"0#"` and decodes to `[""]`, so the two are distinguishable. Using chars (not bytes) keeps this correct for Java `String`s. If the input must be a byte stream, use a fixed-width 4-byte length header instead.

### 3. Dry Run
Round trip on `["a#1", "", "b"]` (contains `#` and a digit, plus an empty string).

Encode:

| Item | len | Appended |
|---|---|---|
| `a#1` | 3 | `3#a#1` |
| `` | 0 | `0#` |
| `b` | 1 | `1#b` |

Encoded: `3#a#10#1#b` (indices 0 `3`, 1 `#`, 2 `a`, 3 `#`, 4 `1`, 5 `0`, 6 `#`, 7 `1`, 8 `#`, 9 `b`).

Decode:

| i at start | Digits read | len | `#` at | Slice | Result so far | i after |
|---|---|---|---|---|---|---|
| 0 | `3` | 3 | 1 | s[2..5) = `a#1` | [`a#1`] | 5 |
| 5 | `0` | 0 | 6 | s[7..7) = `` | [`a#1`, ``] | 7 |
| 7 | `1` | 1 | 8 | s[9..10) = `b` | [`a#1`, ``, `b`] | 10 |

i = 10 = n, stop. Decoded equals the original list.

**Complexity:** Time O(total characters) for both encode and decode. Space O(total characters) for the output.

### 4. Takeaway
- **Pattern:** length-prefixed framing (as in HTTP chunked bodies, Protobuf, Redis RESP). Prefer it to delimiters whenever payloads are arbitrary.
- **Edge cases:**

| Input | Encoded | Note |
|---|---|---|
| `[]` | `""` | decodes to empty list |
| `[""]` | `"0#"` | distinct from `[]` |
| `["#"]` | `"1##"` | payload `#` is never parsed |
| `["12"]` | `"2#12"` | digits in payload are skipped by length |
| string of length 200 | `"200#..."` | multi-digit length handled |

- **Mistakes to avoid:**
  - Reading a single digit for the length.
  - Searching for the next `#` inside the payload.
  - Making `[]` and `[""]` encode identically.
  - Using stateful or static fields (the decoder must work on a fresh object).
- **Related problems:** #297 Serialize and Deserialize Binary Tree (structure serialization), #38 Count and Say, #443 String Compression.

---

## LeetCode 28: Find the Index of the First Occurrence in a String
**Difficulty:** Easy | **Pattern:** Sliding window match -> Rabin-Karp rolling hash -> KMP | **Language:** Java

### 1. Problem
- Return the index of the first occurrence of `needle` in `haystack`, or `-1` if absent.
- Example: `haystack = "abcabd"`, `needle = "abd"` -> `3`.
- Constraints: lengths `1..10^4`, lowercase letters. Brute force passes; the point here is to know all three techniques. Let `n = haystack.length()`, `m = needle.length()`.
- **Key insight:** the brute force throws away what it learned on a failed window. Rabin-Karp compares a fingerprint in O(1) per window; KMP never moves the text pointer backwards because it remembers how much of the needle is still matched.

### 2. Solution
1. **Brute force (window comparison):** for each start `i` in `[0, n-m]`, compare up to `m` characters. Worst case O(n*m) (for example `aaaa...ab` in `aaaa...a`). Wasteful because after a mismatch at offset `k`, we already know the previous `k` text characters equal the needle prefix, yet we forget it.
2. **Rabin-Karp:** treat each length-`m` window as a number in base `B` modulo a prime `P`. Hashing a window naively is O(m), but sliding by one only removes the leading character and adds a trailing one: `h = (h - s[i]*B^(m-1)) * B + s[i+m]`. Equal hashes may be collisions, so verify with a real comparison. Expected O(n+m); worst case O(n*m) if collisions are adversarial. Used in plagiarism detection, DNA search, dedup.
3. **KMP:** precompute `pi[k]` = length of the longest proper prefix of `needle[0..k]` that is also its suffix. On mismatch with `j` matched characters, fall back to `j = pi[j-1]` instead of restarting; the text index `i` only moves forward. True O(n+m) worst case.

```java
class Solution {
    // Approach 1: brute force, O(n*m) time, O(1) space
    public int strStrBrute(String haystack, String needle) {
        int n = haystack.length(), m = needle.length();
        for (int i = 0; i + m <= n; i++) {
            int k = 0;
            while (k < m && haystack.charAt(i + k) == needle.charAt(k)) k++;
            if (k == m) return i;
        }
        return -1;
    }

    // Approach 2: Rabin-Karp, expected O(n+m), O(1) space
    public int strStrRabinKarp(String haystack, String needle) {
        int n = haystack.length(), m = needle.length();
        if (m > n) return -1;
        final long MOD = 1_000_000_007L, BASE = 131;

        long highPow = 1;                       // BASE^(m-1) mod MOD
        for (int k = 1; k < m; k++) highPow = highPow * BASE % MOD;

        long target = 0, window = 0;
        for (int k = 0; k < m; k++) {
            target = (target * BASE + needle.charAt(k)) % MOD;
            window = (window * BASE + haystack.charAt(k)) % MOD;
        }
        for (int i = 0; ; i++) {
            if (window == target && haystack.regionMatches(i, needle, 0, m)) return i;
            if (i + m >= n) return -1;
            long out = haystack.charAt(i) * highPow % MOD;
            window = ((window - out + MOD) % MOD * BASE + haystack.charAt(i + m)) % MOD;
        }
    }

    // Approach 3: KMP, O(n+m) time, O(m) space
    public int strStr(String haystack, String needle) {
        int n = haystack.length(), m = needle.length();
        int[] pi = new int[m];
        for (int i = 1, j = 0; i < m; i++) {
            while (j > 0 && needle.charAt(i) != needle.charAt(j)) j = pi[j - 1];
            if (needle.charAt(i) == needle.charAt(j)) j++;
            pi[i] = j;
        }
        for (int i = 0, j = 0; i < n; i++) {
            while (j > 0 && haystack.charAt(i) != needle.charAt(j)) j = pi[j - 1];
            if (haystack.charAt(i) == needle.charAt(j)) j++;
            if (j == m) return i - m + 1;
        }
        return -1;
    }
}
```
Implementation notes: all hash arithmetic is in `long`; products stay below `1e9+7 * 131`, no overflow. Adding `MOD` before the modulo keeps the subtraction non-negative. `regionMatches` verifies hash hits, so collisions cannot cause a wrong answer. In KMP, `j` never equals `m` when we compare because we return as soon as it reaches `m`.

Building `pi` example, needle `"aabaa"`:

| i | char | j before | action | pi[i] |
|---|---|---|---|---|
| 1 | a | 0 | match, j=1 | 1 |
| 2 | b | 1 | `a != b`, j=pi[0]=0; `a != b` | 0 |
| 3 | a | 0 | match, j=1 | 1 |
| 4 | a | 1 | match (needle[1]=a), j=2 | 2 |

`pi = [0,1,0,1,2]`.

### 3. Dry Run
`haystack = "abcabd"`, `needle = "abd"` (n = 6, m = 3), expected answer 3.

**Brute force**

| i | Comparison | Result |
|---|---|---|
| 0 | a=a, b=b, c vs d | fail at k=2 |
| 1 | b vs a | fail at k=0 |
| 2 | c vs a | fail at k=0 |
| 3 | a=a, b=b, d=d | k=3=m, return 3 |

**Rabin-Karp** (use BASE 31 here only so the numbers are small; MOD never triggers). Letter values a=97, b=98, c=99, d=100. `highPow = 31^2 = 961`.
target = hash("abd") = 97*961 + 98*31 + 100 = 93217 + 3038 + 100 = 96355.

| i | Window | Hash | Equals 96355? | Roll to next |
|---|---|---|---|---|
| 0 | abc | 93217+3038+99 = 96354 | no | (96354 - 93217)*31 + 97 = 3137*31 + 97 = 97344 |
| 1 | bca | 97344 (check: 94178+3069+97) | no | (97344 - 94178)*31 + 98 = 3166*31 + 98 = 98244 |
| 2 | cab | 98244 (check: 95139+3007+98) | no | (98244 - 95139)*31 + 100 = 3105*31 + 100 = 96355 |
| 3 | abd | 96355 | yes, `regionMatches` true | return 3 |

**KMP** (`pi` of `"abd"` = `[0,0,0]`)

| i | haystack[i] | j before | Action | j after |
|---|---|---|---|---|
| 0 | a | 0 | match | 1 |
| 1 | b | 1 | match | 2 |
| 2 | c | 2 | `c != d`, j=pi[1]=0; `c != a` | 0 |
| 3 | a | 0 | match | 1 |
| 4 | b | 1 | match | 2 |
| 5 | d | 2 | match, j=3=m | return 5-3+1 = 3 |

All three return `3`.

**Complexity:**

| Approach | Time | Space |
|---|---|---|
| Brute force | O(n*m) worst, every window can fail late | O(1) |
| Rabin-Karp | O(n+m) expected, O(n*m) worst on many collisions | O(1) |
| KMP | O(n+m) worst: `i` only advances, `j` falls back at most as many times as it advanced | O(m) for `pi` |

### 4. Takeaway
- **Pattern:** substring search. Reach for KMP when guaranteed linear time matters; Rabin-Karp when you must hash many windows or search many patterns at once; brute force when sizes are small. In real Java code `String.indexOf` is the answer.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `("a","a")` | `0` | equal strings |
| `("a","ab")` | `-1` | needle longer; brute loop and Rabin-Karp guard handle it |
| `("mississippi","issip")` | `4` | repeated prefixes exercise KMP fallback |
| `("aaaaa","bba")` | `-1` | worst case for brute force |
| `("abc","c")` | `2` | match at the very end |

- **Mistakes to avoid:**
  - Brute-force loop bound `i < n` instead of `i + m <= n` (index errors).
  - Rabin-Karp: negative modulo after subtraction; no verification on hash hit; overflowing `int`.
  - KMP: using `if` instead of `while` for the fallback; resetting `i` backwards.
- **Related problems:** #1392 Longest Happy Prefix (the `pi` array itself), #214 Shortest Palindrome (`pi` on a concatenation), #459 Repeated Substring Pattern, #686 Repeated String Match, #187 Repeated DNA Sequences (rolling hash), #1044 Longest Duplicate Substring (rolling hash + binary search).

---

## LeetCode 1392: Longest Happy Prefix
**Difficulty:** Hard | **Pattern:** KMP prefix function (failure array) | **Language:** Java

### 1. Problem
- A happy prefix is a non-empty proper prefix of `s` that is also a suffix. Return the longest one, or `""`.
- Example: `"ababab"` -> `"abab"`.
- Constraints: `1 <= s.length <= 10^5`. O(n^2) comparisons are too slow; need O(n).
- **Key insight:** the question is literally "longest proper border of `s`", and the prefix function stores exactly that: `pi[i]` is the longest proper border of `s[0..i]`. The answer is `s.substring(0, pi[n-1])`.

### 2. Solution
1. **Brute force:** for length `L` from `n-1` down to 1, compare `s[0..L)` with `s[n-L..n)`. O(n^2) time (each comparison O(n)). Too slow for 10^5.
2. **Hashing:** compare prefix and suffix hashes in O(1) per length -> O(n), but with collision risk.
3. **Optimal (prefix function):** build `pi` incrementally. Maintain `j`, the border length for the previous position. For position `i`, try to extend the border: if `s[i] == s[j]` then `j+1`. If not, the next-best border of the current border is `pi[j-1]`, so fall back and retry. Each fallback strictly decreases `j`, and `j` increases at most once per `i`, so total work is O(n) amortised.

```java
class Solution {
    public String longestPrefix(String s) {
        int n = s.length();
        int[] pi = new int[n];
        for (int i = 1, j = 0; i < n; i++) {
            while (j > 0 && s.charAt(i) != s.charAt(j)) j = pi[j - 1];
            if (s.charAt(i) == s.charAt(j)) j++;
            pi[i] = j;
        }
        return s.substring(0, pi[n - 1]);
    }
}
```
Implementation notes: `pi` values are always less than `i+1`, so the border is automatically proper. For `n = 1` the loop is skipped and `pi[0] = 0` gives `""`.

### 3. Dry Run
`s = "aabaaab"` (indices 0 a, 1 a, 2 b, 3 a, 4 a, 5 a, 6 b).

| i | s[i] | j before | Steps | pi[i] |
|---|---|---|---|---|
| 1 | a | 0 | `s[1]=a == s[0]=a`, j=1 | 1 |
| 2 | b | 1 | `b != s[1]=a`, j=pi[0]=0; `b != s[0]=a` | 0 |
| 3 | a | 0 | `a == s[0]`, j=1 | 1 |
| 4 | a | 1 | `a == s[1]=a`, j=2 | 2 |
| 5 | a | 2 | `a != s[2]=b`, j=pi[1]=1; `a == s[1]=a`, j=2 | 2 |
| 6 | b | 2 | `b == s[2]=b`, j=3 | 3 |

`pi = [0,1,0,1,2,2,3]`, `pi[6] = 3`. Answer: `s.substring(0,3) = "aab"`; suffix `s[4..6] = "aab"` matches.

**Complexity:** Time O(n), amortised: `j` rises at most n times in total, so falls at most n times. Space O(n) for `pi`.

### 4. Takeaway
- **Pattern:** "longest prefix that is also a suffix" or any border question -> prefix function. Understanding the fallback `j = pi[j-1]` is the whole of KMP.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `""` | prefix must be proper |
| `"ab"` | `""` | no border |
| `"aaaa"` | `"aaa"` | pi = [0,1,2,3] |
| `"level"` | `"l"` | border of length 1 only |
| `"abab"` | `"ab"` | overlapping borders are allowed |

- **Mistakes to avoid:**
  - Using `if` instead of `while` for the fallback.
  - Falling back to `j - 1` or 0 instead of `pi[j - 1]`.
  - Returning `s.substring(0, pi[n-1])` using a non-proper border (`pi` can never reach n, so this is safe).
- **Related problems:** #28 (use `pi` to search), #214 Shortest Palindrome, #459 Repeated Substring Pattern, #796 Rotate String.

---

## LeetCode 214: Shortest Palindrome
**Difficulty:** Hard | **Pattern:** KMP prefix function on `s + '#' + reverse(s)` | **Language:** Java

### 1. Problem
- You may only add characters in front of `s`. Return the shortest palindrome you can make.
- Example: `"aacecaaa"` -> `"aaacecaaa"`.
- Constraints: `0 <= s.length <= 5 * 10^4`, lowercase letters. O(n^2) will be borderline; aim for O(n).
- **Key insight:** whatever we add in front must mirror the tail that is not already part of a palindrome. So find the longest palindromic prefix `s[0..p)`; the answer is `reverse(s[p..n)) + s`. The longest palindromic prefix is a border of `s + '#' + reverse(s)`.

### 2. Solution
1. **Brute force:** for `p` from `n` down to 0, test whether `s[0..p)` is a palindrome (O(n) each). O(n^2) worst case, e.g. `aaaa...ab`.
2. **Observation:** a prefix `s[0..p)` is a palindrome iff it equals its own reverse. The reverse of `s` ends with the reverse of that prefix, so "prefix of `s` equals suffix of `rev(s)`" is the same as "prefix of `s` is a palindrome".
3. **Optimal:** build `t = s + '#' + rev(s)` (the `#` separator stops a border from exceeding `n` and from spanning across). The last value of the prefix function of `t` is the length of the longest prefix of `s` that equals a suffix of `rev(s)`, i.e. the longest palindromic prefix. Prepend `rev(s.substring(p))` to `s`.

```java
class Solution {
    public String shortestPalindrome(String s) {
        int n = s.length();
        if (n < 2) return s;
        String rev = new StringBuilder(s).reverse().toString();
        String t = s + "#" + rev;

        int[] pi = new int[t.length()];
        for (int i = 1, j = 0; i < t.length(); i++) {
            while (j > 0 && t.charAt(i) != t.charAt(j)) j = pi[j - 1];
            if (t.charAt(i) == t.charAt(j)) j++;
            pi[i] = j;
        }
        int p = pi[t.length() - 1];                    // longest palindromic prefix length
        return rev.substring(0, n - p) + s;            // rev(s[p..n)) equals rev[0..n-p)
    }
}
```
Implementation notes: the first `n-p` characters of `rev` are exactly the reverse of `s[p..n)`, so no second reversal is needed. The separator must be a character absent from the input (input is lowercase, so `#` is safe).

### 3. Dry Run
`s = "aacecaaa"` (n = 8), `rev = "aaacecaa"`, `t = "aacecaaa#aaacecaa"` (length 17).

Indices: 0 a, 1 a, 2 c, 3 e, 4 c, 5 a, 6 a, 7 a, 8 #, 9 a, 10 a, 11 a, 12 c, 13 e, 14 c, 15 a, 16 a.

| i | t[i] | j before | Steps | pi[i] |
|---|---|---|---|---|
| 1 | a | 0 | match t[0], j=1 | 1 |
| 2 | c | 1 | `c != t[1]=a`, j=pi[0]=0; `c != a` | 0 |
| 3 | e | 0 | no match | 0 |
| 4 | c | 0 | no match | 0 |
| 5 | a | 0 | match, j=1 | 1 |
| 6 | a | 1 | match t[1], j=2 | 2 |
| 7 | a | 2 | `a != t[2]=c`, j=pi[1]=1; `a == t[1]`, j=2 | 2 |
| 8 | # | 2 | `# != c`, j=pi[1]=1; `# != a`, j=pi[0]=0; no match | 0 |
| 9 | a | 0 | match, j=1 | 1 |
| 10 | a | 1 | match, j=2 | 2 |
| 11 | a | 2 | `a != c`, j=1; `a == t[1]`, j=2 | 2 |
| 12 | c | 2 | `c == t[2]`, j=3 | 3 |
| 13 | e | 3 | `e == t[3]`, j=4 | 4 |
| 14 | c | 4 | `c == t[4]`, j=5 | 5 |
| 15 | a | 5 | `a == t[5]`, j=6 | 6 |
| 16 | a | 6 | `a == t[6]`, j=7 | 7 |

`p = pi[16] = 7`: longest palindromic prefix is `"aacecaa"`. Remaining tail `s[7..8) = "a"`, `rev.substring(0, 1) = "a"`. Answer: `"a" + "aacecaaa" = "aaacecaaa"`.

**Complexity:** Time O(n): the prefix function over `2n+1` characters. Space O(n) for `t`, `rev` and `pi`.

### 4. Takeaway
- **Pattern:** "longest palindromic prefix/suffix" -> KMP on `s + sep + rev(s)`. KMP is a general longest-border tool. (Alternative: Z-function, or Manacher, or rolling hash.)
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `""` | `""` | early return |
| `"a"` | `"a"` | already palindrome |
| `"abcd"` | `"dcbabcd"` | p = 1, prepend `dcb` |
| `"aba"` | `"aba"` | p = n, add nothing |
| `"aaaaa"` | `"aaaaa"` | p = n |

- **Mistakes to avoid:**
  - Omitting the separator: for `"aaa"`, `t = "aaaaaa"` would give border 5 > n.
  - Using the longest palindromic substring rather than prefix.
  - Quadratic string concatenation in a loop.
- **Related problems:** #5 Longest Palindromic Substring, #1392 Longest Happy Prefix (same machinery), #28, #336 Palindrome Pairs.

---

## LeetCode 459: Repeated Substring Pattern
**Difficulty:** Easy | **Pattern:** String doubling trick / KMP failure function | **Language:** Java

### 1. Problem
- Can `s` be built by repeating a substring two or more times?
- Example: `"abab"` -> `true` (`"ab"` twice). `"aba"` -> `false`.
- Constraints: `1 <= s.length <= 10^4`. O(n) is the goal.
- **Key insight:** if `s` is made of repeats, then rotating it by one block gives `s` again. So `s` appears inside `s + s` at a position other than `0` and `n`. Equivalently, `s` has a period `n - pi[n-1]` that divides `n`.

### 2. Solution
1. **Brute force:** for each divisor length `L` of `n` (`L <= n/2`), repeat `s[0..L)` `n/L` times and compare. O(n * d(n)) where d is the divisor count. Correct but clumsy.
2. **Doubling trick:** `(s + s).substring(1, 2n - 1).contains(s)`. Chopping the first and last character excludes the trivial matches at offsets `0` and `n`. Any other occurrence means `s` equals one of its non-trivial rotations, which happens exactly when `s` is a repetition. Shown as the idiomatic answer, though `contains` relies on the library search.
3. **Optimal and library-independent (prefix function):** `pi[n-1]` is the longest border. The smallest period is `p = n - pi[n-1]`. `s` is a repetition iff `pi[n-1] > 0` and `n % p == 0`.

```java
class Solution {
    public boolean repeatedSubstringPattern(String s) {
        int n = s.length();
        int[] pi = new int[n];
        for (int i = 1, j = 0; i < n; i++) {
            while (j > 0 && s.charAt(i) != s.charAt(j)) j = pi[j - 1];
            if (s.charAt(i) == s.charAt(j)) j++;
            pi[i] = j;
        }
        int period = n - pi[n - 1];
        return pi[n - 1] > 0 && n % period == 0;
    }

    // One-line alternative using the doubling trick
    public boolean repeatedSubstringPatternDoubling(String s) {
        return (s + s).indexOf(s, 1) != s.length();
    }
}
```
Implementation notes: `indexOf(s, 1)` finds the first occurrence at or after 1 in `s+s`; it is always found at `n` at the latest, so the result differs from `n` exactly when there is an earlier one. This is equivalent to the substring check and avoids the copy.

### 3. Dry Run
`s = "abab"` (n = 4).

| i | s[i] | j before | Steps | pi[i] |
|---|---|---|---|---|
| 1 | b | 0 | `b != a`, no match | 0 |
| 2 | a | 0 | match s[0], j=1 | 1 |
| 3 | b | 1 | match s[1]=b, j=2 | 2 |

`pi[3] = 2`, `period = 4 - 2 = 2`, `pi > 0` and `4 % 2 == 0` -> `true`.

Contrast `"abcab"`: pi = [0,0,0,1,2], `period = 5 - 2 = 3`, `5 % 3 != 0` -> `false` (border `ab` exists but does not tile the string).

Doubling check for `"abab"`: `s+s = "abababab"`, `indexOf("abab", 1) = 2 != 4` -> `true`.

**Complexity:** Time O(n). Space O(n) for `pi` (doubling variant also O(n) for the copy).

### 4. Takeaway
- **Pattern:** repetition / period questions -> `n - pi[n-1]` is the smallest period; a full tiling needs it to divide `n`. The doubling trick is the memorable shortcut.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `"a"` | `false` | needs at least two repeats; `pi[0]=0` |
| `"aa"` | `true` | `pi=1`, period 1 |
| `"abcabcabc"` | `true` | pi=6, period 3 |
| `"aba"` | `false` | pi=1, period 2, `3 % 2 != 0` |
| `"abaababaab"` | `true` | `abaab` twice |

- **Mistakes to avoid:**
  - Skipping the `n % period == 0` check (`"aba"` would wrongly be true).
  - Checking `contains` on the full `s+s` (always true because of offsets 0 and n).
  - Forgetting `pi[n-1] > 0` (if 0, period = n and `n % n == 0`).
- **Related problems:** #1392 Longest Happy Prefix (same `pi[n-1]`), #28, #796 Rotate String (same doubling trick), #686 Repeated String Match.

---

## LeetCode 49: Group Anagrams
**Difficulty:** Medium | **Pattern:** HashMap with canonical key (sorted string or char-count) | **Language:** Java

### 1. Problem
- Group the strings that are anagrams of each other. Order of groups and within groups is free.
- Example: `["eat","tea","tan","ate","nat","bat"]` -> `[["eat","tea","ate"],["tan","nat"],["bat"]]`.
- Constraints: up to `10^4` strings, each length `0..100`, lowercase letters.
- **Key insight:** two strings are anagrams iff they share the same canonical form. Make that form the hash map key and grouping becomes a single pass.

### 2. Solution
1. **Brute force:** compare every pair as anagrams: O(N^2 * K) for N strings of length K. Too slow and awkward to group.
2. **Sorted-string key:** sort each string's characters: `eat`, `tea`, `ate` all become `aet`. Cost O(K log K) per string, O(N * K log K) total. Simple and handles any alphabet.
3. **Optimal for a fixed alphabet (count key):** count the 26 letters and use the counts as the key: O(K) per string, O(N * K) total. Trade-off: the key is a fixed 26 characters regardless of K, but it only suits a small known alphabet; sorting works for arbitrary characters.

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String, List<String>> groups = new HashMap<>();
        for (String s : strs) {
            char[] counts = new char[26];
            for (int i = 0; i < s.length(); i++) counts[s.charAt(i) - 'a']++;
            // each count (max 100) is stored as one char; fixed width means no ambiguity
            groups.computeIfAbsent(new String(counts), k -> new ArrayList<>()).add(s);
        }
        return new ArrayList<>(groups.values());
    }
}
```
Implementation notes: a `char[26]` converted to a `String` is a compact, immutable, hashable key (no `Arrays.toString` formatting cost, no delimiter issues). `char` increments are fine since counts never exceed 100. The sorted-key variant is: `char[] a = s.toCharArray(); Arrays.sort(a); key = new String(a);`.

### 3. Dry Run
Input `["eat","tea","tan","ate","nat","bat"]`. Keys shown as non-zero letter counts (the real key is the 26-char array).

| Step | String | Count key | Map state after |
|---|---|---|---|
| 1 | eat | a1 e1 t1 | {a1e1t1: [eat]} |
| 2 | tea | a1 e1 t1 | {a1e1t1: [eat, tea]} |
| 3 | tan | a1 n1 t1 | {a1e1t1: [eat, tea], a1n1t1: [tan]} |
| 4 | ate | a1 e1 t1 | {a1e1t1: [eat, tea, ate], a1n1t1: [tan]} |
| 5 | nat | a1 n1 t1 | {a1e1t1: [eat, tea, ate], a1n1t1: [tan, nat]} |
| 6 | bat | a1 b1 t1 | {..., a1b1t1: [bat]} |

Answer: `[[eat, tea, ate], [tan, nat], [bat]]` (map iteration order may vary).

**Complexity:** Time O(N * K) with the count key (O(N * K log K) with the sorted key). Space O(N * K) to store the strings and keys.

### 4. Takeaway
- **Pattern:** group by equivalence -> map from canonical form to list. Choose sorted key for generality and simplicity; count key for speed on a small alphabet.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[""]` | `[[""]]` | empty string has all-zero key |
| `["a"]` | `[["a"]]` | single |
| `["ab","ba","abc"]` | `[["ab","ba"],["abc"]]` | different lengths never collide |
| `["aab","aba","baa"]` | one group | counts handle repeats |

- **Mistakes to avoid:**
  - Using the unsorted string or a `Set` of characters as the key (loses duplicates).
  - Count key built by concatenating counts without a delimiter (`1,11` vs `11,1` ambiguity); a fixed-width array avoids this.
  - Using an `int[]` as a map key (arrays use identity hashing).
- **Related problems:** #242 Valid Anagram (a single pair check), #438 Find All Anagrams in a String (sliding window with counts), #249 Group Shifted Strings (premium, a different canonical form), #1048 Longest String Chain.
