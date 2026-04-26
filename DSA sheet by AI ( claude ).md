# 🧠 Definitive DSA Master List — Backend Java Engineers

> **Goal:** Solve every problem here → recognize any DSA pattern in disguise, in any interview. **Rule:** Free-tier LeetCode + NeetCode.io (free). No obscure math tricks. Pattern-first. **Language:** Java — `HashMap`, `ArrayDeque`, `PriorityQueue`, `int[]`, `Arrays.sort()`. **Version:** 2.0 — Fully restructured by topic with subtopics. 160+ problems.

---

## 📌 How to Use This List

1. **Read the Core Pattern** before coding — understand _why_, not just _how_.
2. Follow the **sequence within each section** — earlier problems are subroutines of later ones.
3. After solving, ask: _"What is the skeleton of this solution? Where else does this skeleton appear?"_
4. Track status: ⬜ Not Started → 🟡 Attempted → ✅ Solved → 🔁 Revisit

---

## 🗺️ Topic Index

|#|Topic|Subtopics|Problems|
|---|---|---|---|
|1|[Arrays](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-1--arrays)|Fundamentals, Prefix Sum, Two Pointers, Sliding Window|28|
|2|[Strings](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-2--strings)|Manipulation, Palindromes, Pattern Matching, Encoding|14|
|3|[Hashing](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-3--hashing)|HashMap, HashSet, Frequency, Design|10|
|4|[Binary Search](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-4--binary-search)|Classic, On Condition, On Answer Space|12|
|5|[Linked Lists](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-5--linked-lists)|Traversal, Fast/Slow Pointers, Reversal, Design|12|
|6|[Stacks](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-6--stacks)|Basics, Monotonic Stack, Expression Parsing|11|
|7|[Queues & Deques](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-7--queues--deques)|BFS Queue, Monotonic Deque, Design|5|
|8|[Trees](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-8--trees)|DFS (Pre/In/Post), BFS, BST, Construction|22|
|9|[Tries](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-9--tries)|Design, Search, Backtracking on Trie|3|
|10|[Heaps & Priority Queues](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-10--heaps--priority-queues)|Top-K, Two Heaps, K-way Merge|8|
|11|[Graphs — DFS](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-11--graphs--dfs)|Grid DFS, Component DFS, Cycle Detection|10|
|12|[Graphs — BFS](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-12--graphs--bfs)|Grid BFS, Multi-source BFS, Shortest Path|8|
|13|[Graphs — Topological Sort](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-13--graphs--topological-sort)|Kahn's BFS, DFS Coloring|4|
|14|[Graphs — Union Find](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-14--graphs--union-find)|Path Compression, Rank, MST|5|
|15|[Graphs — Shortest Path](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-15--graphs--shortest-path)|Dijkstra, Bellman-Ford, Floyd-Warshall|5|
|16|[Dynamic Programming — 1D](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-16--dynamic-programming--1d)|Fibonacci, Decision, Unbounded|12|
|17|[Dynamic Programming — 2D](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-17--dynamic-programming--2d)|Grid, Sequence, String|8|
|18|[Dynamic Programming — Intervals](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-18--dynamic-programming--intervals)|Range DP, Palindromes|4|
|19|[Dynamic Programming — Knapsack](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-19--dynamic-programming--knapsack)|0/1, Unbounded, Subset Sum|5|
|20|[Intervals & Greedy](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-20--intervals--greedy)|Merge, Schedule, Activity Selection|7|
|21|[Backtracking](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-21--backtracking)|Subsets, Permutations, Constraint Satisfaction|10|
|22|[Bit Manipulation](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-22--bit-manipulation)|XOR, Bit Tricks, Masks|7|
|23|[Math & Simulation](https://claude.ai/chat/61003a3b-f72f-401b-a834-f369f201c9a0#-23--math--simulation)|Modular, Simulation, Number Theory|6|

---

# 📂 1 — Arrays

> Arrays are the foundation of all DSA. Every pattern you learn here—prefix sums, two pointers, sliding window—will reappear in strings, linked lists, graphs, and DP. Master the mechanics before moving on.

---

## 1.1 — Array Fundamentals

### 1. [Contains Duplicate — #217](https://leetcode.com/problems/contains-duplicate/) ---> done

- **Difficulty:** Easy | **Pattern:** HashSet for O(1) lookup
- **Why:** The simplest trade-space-for-time problem. The `set.add()` returns false on duplicate pattern is reused in 40+ problems. Always the first question to warm up.

### 2. [Move Zeroes — #283](https://leetcode.com/problems/move-zeroes/)

- **Difficulty:** Easy | **Pattern:** Read/Write two pointers (in-place partition)
- **Why:** The read-pointer scans, write-pointer places valid elements. This partition mechanic is the foundation of QuickSort, Remove Duplicates, and Dutch National Flag.

### 3. [Find All Numbers Disappeared in an Array — #448](https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/)

- **Difficulty:** Easy | **Pattern:** Index-as-hash (negation marking), O(1) space
- **Why:** Teaches using the array itself as a hash map. Values bounded by `[1,n]` → use index `nums[i]-1` as the key. This O(1) space trick recurs in #287 and any "bounded value" problem.

### 4. [Best Time to Buy and Sell Stock — #121](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

- **Difficulty:** Easy | **Pattern:** Running minimum + greedy single pass
- **Why:** Track `minPrice` and `maxProfit` in one scan. This "track running optimal" pattern spawns a 6-problem series. The state-machine thinking here is essential before tackling the harder stock variants.

### 5. [Maximum Subarray — #53](https://leetcode.com/problems/maximum-subarray/)

- **Difficulty:** Medium | **Pattern:** Kadane's Algorithm
- **Why:** At each index: extend current subarray OR start fresh. `dp[i] = max(nums[i], dp[i-1] + nums[i])`. A gateway to 1D DP. Interviewers will ask you to modify this — circular variant #918, or return the actual subarray.

### 6. [Product of Array Except Self — #238](https://leetcode.com/problems/product-of-array-except-self/)

- **Difficulty:** Medium | **Pattern:** Prefix product + suffix product, no division
- **Why:** Thinking in two passes — forward and backward — is a recurring trick. The "no division" constraint forces the prefix/suffix pattern that also appears in trapping rain water and histogram problems.

### 7. [Find the Duplicate Number — #287](https://leetcode.com/problems/find-the-duplicate-number/)

- **Difficulty:** Medium | **Pattern:** Floyd's cycle detection (array as implicit graph)
- **Why:** The array `nums[i]` defines a pointer graph. Applying fast/slow pointers on an array is a key meta-skill — learning to model a problem in a different domain. O(1) space with no modification to input.

### 8. [Maximum Product Subarray — #152](https://leetcode.com/problems/maximum-product-subarray/)

- **Difficulty:** Medium | **Pattern:** DP tracking both max and min simultaneously
- **Why:** Negative × negative = positive, so you must track both `maxSoFar` and `minSoFar`. The "track both extremes" DP pattern appears wherever sign flips can occur.

### 9. [Rotate Array — #189](https://leetcode.com/problems/rotate-array/)

- **Difficulty:** Medium | **Pattern:** Triple reverse trick (in-place rotation)
- **Why:** Reverse whole array → reverse first k → reverse rest. This O(1) space rotation is a common follow-up in array manipulation interviews and models circular buffer rotation.

### 10. [First Missing Positive — #41](https://leetcode.com/problems/first-missing-positive/)

- **Difficulty:** Hard | **Pattern:** Index-as-hash (cyclic sort / placement)
- **Why:** The hardest "index-as-hash" problem. Place each number at its correct index (nums[i]-1), then scan for the first mismatch. O(n) time, O(1) space. A top-tier interview problem that tests deep array manipulation thinking.

---

## 1.2 — Prefix Sums

### 11. [Running Sum of 1D Array — #1480](https://leetcode.com/problems/running-sum-of-1d-array/)

- **Difficulty:** Easy | **Pattern:** Prefix sum in-place
- **Why:** Purest intro. `prefix[i] = prefix[i-1] + nums[i]`. Internalize this before everything else in this section.

### 12. [Range Sum Query — Immutable #303](https://leetcode.com/problems/range-sum-query-immutable/)

- **Difficulty:** Easy | **Pattern:** Precomputed prefix array → O(1) range query
- **Why:** Forces you to think about precomputation. Build once, query many times. This is how backend systems work — cache the expensive computation. Bridges to 2D prefix sums.

### 13. [Subarray Sum Equals K — #560](https://leetcode.com/problems/subarray-sum-equals-k/)

- **Difficulty:** Medium | **Pattern:** Prefix sum + HashMap (`sum → count`)
- **Why:** A landmark problem. _"Have I seen `currentSum - k` before?"_ destroys the O(n²) brute force instinct. This exact pattern appears in subarray divisibility, matrix path sums, and financial ledger problems.

### 14. [Contiguous Array — #525](https://leetcode.com/problems/contiguous-array/)

- **Difficulty:** Medium | **Pattern:** Prefix sum with +1/-1 encoding + HashMap
- **Why:** Convert 0s to -1s. Now "equal 0s and 1s" → "prefix sum = 0" or "two equal prefix sums." The encoding trick (transform the problem domain) is powerful and reusable.

### 15. [Minimum Size Subarray Sum — #209](https://leetcode.com/problems/minimum-size-subarray-sum/)

- **Difficulty:** Medium | **Pattern:** Variable sliding window (shrink when valid)
- **Why:** Paired here because it also touches on prefix sums conceptually, but the sliding window approach is the right tool. "Shrink when valid" vs "shrink when invalid" is the key variable-window distinction.

---

## 1.3 — Two Pointers

### 16. [Two Sum II — Sorted Array #167](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/)

- **Difficulty:** Easy | **Pattern:** Opposite-end two pointers on sorted array
- **Why:** Left + right converge based on sum comparison. Foundation for 3Sum, 4Sum, Container With Most Water. The simplest possible two-pointer problem.

### 17. [3Sum — #15](https://leetcode.com/problems/3sum/)

- **Difficulty:** Medium | **Pattern:** Sort + two pointers + deduplication
- **Why:** Sort, fix one element, two-pointer the rest. The `while(nums[l]==nums[l-1]) l++` dedup line is a micro-pattern that appears everywhere. Solving this makes all k-Sum trivial.

### 18. [3Sum Closest — #16](https://leetcode.com/problems/3sum-closest/)

- **Difficulty:** Medium | **Pattern:** Sort + two pointers, track closest sum
- **Why:** A natural extension of #15 — instead of exact match, track minimum difference. Reinforces two-pointer mechanics and teaches "closest value" tracking.

### 19. [Container With Most Water — #11](https://leetcode.com/problems/container-with-most-water/)

- **Difficulty:** Medium | **Pattern:** Two pointers — always move the bottleneck
- **Why:** You always move the shorter pointer because that's the limiting factor. This "move the constraint" greedy reasoning appears in interval scheduling and capacity planning problems.

### 20. [Trapping Rain Water — #42](https://leetcode.com/problems/trapping-rain-water/)

- **Difficulty:** Hard | **Pattern:** Two pointers with running max from both ends
- **Why:** Water at index i = `min(maxLeft, maxRight) - height[i]`. Two-pointer approach eliminates the need for prefix/suffix arrays. Appears at FAANG onsites. Can also solve with monotonic stack — knowing both approaches is valuable.

### 21. [Sort Colors — #75](https://leetcode.com/problems/sort-colors/)

- **Difficulty:** Medium | **Pattern:** Dutch National Flag — 3-way partition
- **Why:** `low`, `mid`, `high` three pointers. Partition into 3 groups in one pass. This exact mechanic is QuickSort's 3-way partition and appears in any "categorize in-place" problem.

---

## 1.4 — Sliding Window

### 22. [Maximum Average Subarray I — #643](https://leetcode.com/problems/maximum-average-subarray-i/)

- **Difficulty:** Easy | **Pattern:** Fixed-size sliding window
- **Why:** Build first window, then slide: subtract left element, add right element. The simplest possible fixed window. Understand this before any variable window.

### 23. [Longest Substring Without Repeating Characters — #3](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

- **Difficulty:** Medium | **Pattern:** Variable sliding window + HashSet
- **Why:** `int left=0; for(int right=0; right<n; right++)` — this skeleton is reused in 20+ problems. "Expand right, shrink left when invalid." Non-negotiable.

### 24. [Permutation in String — #567](https://leetcode.com/problems/permutation-in-string/)

- **Difficulty:** Medium | **Pattern:** Fixed window + frequency match counter
- **Why:** Instead of comparing `int[26]` arrays each step, maintain a `matches` counter. O(1) window validity check. This optimization technique is used in Minimum Window Substring and Find All Anagrams.

### 25. [Find All Anagrams in a String — #438](https://leetcode.com/problems/find-all-anagrams-in-a-string/)

- **Difficulty:** Medium | **Pattern:** Fixed window + frequency matching, collect all results
- **Why:** Same as #567 but collects all valid windows. Solidifies the "maintain matches counter" pattern with result collection.

### 26. [Longest Repeating Character Replacement — #424](https://leetcode.com/problems/longest-repeating-character-replacement/)

- **Difficulty:** Medium | **Pattern:** Variable window + lazy maxFreq tracking
- **Why:** Window is valid if `windowSize - maxFreq <= k`. The trick of not reducing `maxFreq` when shrinking (lazy update) is non-obvious but critical. This "lazy shrink" pattern recurs in harder problems.

### 27. [Minimum Window Substring — #76](https://leetcode.com/problems/minimum-window-substring/)

- **Difficulty:** Hard | **Pattern:** Variable window — shrink aggressively once valid
- **Why:** The hardest sliding window problem. Must have correct characters AND correct counts. The "have/need" counter with a required characters map is the full sliding window toolkit. After this, all sliding window problems are in reach.

### 28. [Sliding Window Maximum — #239](https://leetcode.com/problems/sliding-window-maximum/)

- **Difficulty:** Hard | **Pattern:** Monotonic Deque (decreasing)
- **Why:** `Deque` stores indices of candidates in decreasing value order. Front = current window max. This O(n) pattern solves all "window maximum/minimum aggregate" problems. Placed here as it belongs to the sliding window family, though the data structure is a deque.

---

# 📂 2 — Strings

> Strings are arrays of characters. Every array technique applies here. The unique additions are: character frequency maps, palindrome detection, pattern matching, and encoding/decoding.

---

## 2.1 — String Manipulation

### 29. [Reverse Words in a String — #151](https://leetcode.com/problems/reverse-words-in-a-string/)

- **Difficulty:** Medium | **Pattern:** Split, trim, reverse
- **Why:** Tests handling edge cases — multiple spaces, leading/trailing spaces. In Java: `s.trim().split("\\s+")` vs manual two-pointer reverse. Both approaches tested. Classic phone screen.

### 30. [Longest Common Prefix — #14](https://leetcode.com/problems/longest-common-prefix/)

- **Difficulty:** Easy | **Pattern:** Vertical scanning / horizontal folding
- **Why:** Systematic string comparison across an array. The "fold/reduce" approach mirrors Trie prefix queries conceptually. Gateway to Trie design.

### 31. [String to Integer (atoi) — #8](https://leetcode.com/problems/string-to-integer-atoi/)

- **Difficulty:** Medium | **Pattern:** Deterministic parser / state machine
- **Why:** Overflow detection (`result > Integer.MAX_VALUE / 10`), sign, whitespace. Backend engineers write parsers — this tests rigorous defensive coding. Every edge case matters.

### 32. [Roman to Integer — #13](https://leetcode.com/problems/roman-to-integer/)

- **Difficulty:** Easy | **Pattern:** HashMap lookup + lookahead rule
- **Why:** "If current < next, subtract; else add." The lookahead/lookbehind in string traversal is a recurring micro-pattern in parsing problems.

### 33. [Zigzag Conversion — #6](https://leetcode.com/problems/zigzag-conversion/)

- **Difficulty:** Medium | **Pattern:** Index simulation with direction flag
- **Why:** Simulate row assignment using a direction variable. Tests clean simulation thinking — a common machine-coding round skill.

### 34. [Count and Say — #38](https://leetcode.com/problems/count-and-say/)

- **Difficulty:** Medium | **Pattern:** Iterative string generation (run-length encoding)
- **Why:** Build each sequence from the previous one by scanning for consecutive characters. Models run-length encoding — directly relevant to compression algorithms.

---

## 2.2 — Palindromes

### 35. [Valid Palindrome — #125](https://leetcode.com/problems/valid-palindrome/)

- **Difficulty:** Easy | **Pattern:** Two pointers + character filtering
- **Why:** `Character.isLetterOrDigit()` + two pointers from both ends. The entry point to all palindrome problems.

### 36. [Longest Palindromic Substring — #5](https://leetcode.com/problems/longest-palindromic-substring/)

- **Difficulty:** Medium | **Pattern:** Expand-around-center (odd and even centers)
- **Why:** Two center types (single char, between chars). Expanding outward is cleaner and more intuitive than 2D DP. Teaches that a mathematical insight can beat a DP table.

### 37. [Palindromic Substrings — #647](https://leetcode.com/problems/palindromic-substrings/)

- **Difficulty:** Medium | **Pattern:** Expand-around-center, count all
- **Why:** Extends #5 — count all valid palindromes. Solidifies both odd/even center handling. Together, #5 and #647 cover every palindrome interview question variant.

### 38. [Valid Palindrome II — #680](https://leetcode.com/problems/valid-palindrome-ii/)

- **Difficulty:** Easy | **Pattern:** Two pointers + one allowed deletion
- **Why:** On mismatch, try skipping left OR right character and check if either is a palindrome. This "try both options on mismatch" pattern appears in several string problems with tolerance.

---

## 2.3 — Pattern Matching & Encoding

### 39. [Encode and Decode Strings — #271](https://leetcode.com/problems/encode-and-decode-strings/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Length-prefix protocol (`len#string`)
- **Why:** Delimiter-safe serialization. How do you encode a list of strings containing any character? This is how wire protocols work. Tests real-world engineering thinking over algorithmic tricks.

### 40. [Find the Index of the First Occurrence in a String — #28](https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/)

- **Difficulty:** Easy | **Pattern:** Sliding window string match / KMP foundation
- **Why:** The brute force teaches the window comparison mechanic. Understanding why it's O(n×m) motivates KMP. Even without KMP, this is the baseline pattern for all substring search.

### 41. [Repeated Substring Pattern — #459](https://leetcode.com/problems/repeated-substring-pattern/)

- **Difficulty:** Easy | **Pattern:** String doubling trick / KMP failure function
- **Why:** `(s + s).substring(1, 2n-1).contains(s)` — the string doubling trick is elegant and instructive. Teaches creative problem reformulation.

### 42. [Group Anagrams — #49](https://leetcode.com/problems/group-anagrams/)

- **Difficulty:** Medium | **Pattern:** HashMap with canonical key (sorted string or char-count)
- **Why:** Design a hashing key that captures equivalence. Sorted string key vs `int[26]` char-count key — knowing both and their trade-offs is a strong signal. "Canonical form as key" appears in many grouping problems.

---

# 📂 3 — Hashing

> Hashing is the #1 tool to reduce O(n²) to O(n). Every "find pair," "seen before," "count frequencies" problem is solved with a HashMap or HashSet.

---

## 3.1 — Core HashMap Patterns

### 43. [Two Sum — #1](https://leetcode.com/problems/two-sum/)

- **Difficulty:** Easy | **Pattern:** HashMap (value → index), complement lookup
- **Why:** Problem #1 for a reason. `map.containsKey(target - nums[i])` is the most reused snippet in DSA. Every "find pair with constraint" problem is a Two Sum variant.

### 44. [Valid Anagram — #242](https://leetcode.com/problems/valid-anagram/)

- **Difficulty:** Easy | **Pattern:** `int[26]` character frequency comparison
- **Why:** Teaches the `int[26]` trick as a fast O(1)-space alternative to `HashMap<Character, Integer>`. This frequency-comparison pattern is used in all sliding window anagram problems.

### 45. [Top K Frequent Elements — #347](https://leetcode.com/problems/top-k-frequent-elements/)

- **Difficulty:** Medium | **Pattern:** HashMap + bucket sort (or min-heap)
- **Why:** Bucket sort: index = frequency, value = list of elements. O(n) solution. Also solvable with min-heap O(n log k). Teaches thinking about the frequency of frequencies.

### 46. [Longest Consecutive Sequence — #128](https://leetcode.com/problems/longest-consecutive-sequence/)

- **Difficulty:** Medium | **Pattern:** HashSet + sequence-start detection
- **Why:** Only start counting from sequence starts (`!set.contains(n-1)`). Converts O(n log n) sort into O(n). Teaches using a HashSet to simulate sorted order without sorting.

### 47. [Valid Sudoku — #36](https://leetcode.com/problems/valid-sudoku/)

- **Difficulty:** Medium | **Pattern:** Multi-dimensional HashSet constraint validation
- **Why:** Three sets — rows, columns, boxes. Box index formula: `(r/3)*3 + c/3`. Systematic constraint validation across multiple dimensions. Models backend rule-engine validation.

---

## 3.2 — HashMap Design Problems

### 48. [LRU Cache — #146](https://leetcode.com/problems/lru-cache/)

- **Difficulty:** Medium | **Pattern:** HashMap + Doubly Linked List, O(1) get & put
- **Why:** The most important data structure design problem for backend engineers. LRU is used in Redis, database buffer pools, and CDN eviction. HashMap gives O(1) lookup; DLL gives O(1) eviction. A career-defining problem.

### 49. [Insert Delete GetRandom O(1) — #380](https://leetcode.com/problems/insert-delete-getrandom-o1/)

- **Difficulty:** Medium | **Pattern:** HashMap + ArrayList for O(1) random access
- **Why:** Delete in O(1) from an array by swapping with the last element then removing. HashMap tracks indices. This "swap-with-last-delete" pattern is used in dynamic random sampling — relevant to load balancers and A/B testing systems.

### 50. [First Unique Character in a String — #387](https://leetcode.com/problems/first-unique-character-in-a-string/)

- **Difficulty:** Easy | **Pattern:** Frequency array + second pass
- **Why:** Simple two-pass problem: count frequencies, then find first with count=1. Teaches that two passes at O(n) each is still O(n) total — a common optimization mindset.

### 51. [Ransom Note — #383](https://leetcode.com/problems/ransom-note/)

- **Difficulty:** Easy | **Pattern:** Character frequency difference check
- **Why:** Check if one string's character counts are a subset of another's. Foundation for all "can we form X from Y?" problems.

### 52. [Word Pattern — #290](https://leetcode.com/problems/word-pattern/)

- **Difficulty:** Easy | **Pattern:** Bijection mapping (two-way HashMap)
- **Why:** Both pattern → word AND word → pattern mappings must be consistent. The bijection (one-to-one mapping) check with two HashMaps is a recurring pattern in isomorphism problems (#205).

---

# 📂 4 — Binary Search

> Binary Search is the most important O(log n) tool. It's not just for sorted arrays — it applies to any problem where you can define a monotonic condition on an answer space.

---

## 4.1 — Classic Binary Search

### 53. [Binary Search — #704](https://leetcode.com/problems/binary-search/)

- **Difficulty:** Easy | **Pattern:** `while(left<=right)`, overflow-safe mid
- **Why:** Get the template _exactly_ right. `mid = left + (right-left)/2`. The `<=` vs `<`, and `left=mid+1` vs `left=mid` distinctions are critical. Every other BS problem is a variation.

### 54. [Search Insert Position — #35](https://leetcode.com/problems/search-insert-position/)

- **Difficulty:** Easy | **Pattern:** Binary search — leftmost insertion point
- **Why:** When the loop ends, `left` is always the insertion position. This property of binary search (`left` = answer when element not found) is used in 90% of advanced BS problems.

### 55. [First Bad Version — #278](https://leetcode.com/problems/first-bad-version/)

- **Difficulty:** Easy | **Pattern:** Binary search — find first true in boolean sequence
- **Why:** The condition switches from `false` to `true` at one point — find that boundary. This "find the boundary between false/true" is the most common BS pattern in real-world code (version control, feature flags, A/B tests).

### 56. [Search a 2D Matrix — #74](https://leetcode.com/problems/search-a-2d-matrix/)

- **Difficulty:** Medium | **Pattern:** Binary search on flattened 2D index
- **Why:** `mid` maps to `(mid/cols, mid%cols)`. Treats the 2D matrix as a 1D sorted array. This index-mapping trick appears in all matrix binary search problems.

### 57. [Sqrt(x) — #69](https://leetcode.com/problems/sqrtx/)

- **Difficulty:** Easy | **Pattern:** Binary search on integer answer range
- **Why:** Find largest k such that `k*k <= x`. A gentle intro to binary searching on an answer range (not an array). Gateway to the "binary search on answer" family.

---

## 4.2 — Binary Search on Condition (Rotated Arrays)

### 58. [Find Minimum in Rotated Sorted Array — #153](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)

- **Difficulty:** Medium | **Pattern:** BS on condition — find inflection point
- **Why:** No target needed. `nums[mid] > nums[right]` tells you which half has the minimum. Teaches BS on a _property_, not equality.

### 59. [Search in Rotated Sorted Array — #33](https://leetcode.com/problems/search-in-rotated-sorted-array/)

- **Difficulty:** Medium | **Pattern:** BS — identify sorted half, check if target is in it
- **Why:** One half is always sorted. Check if target falls in the sorted half; go there if yes, else go opposite. Classic FAANG phone-screen.

### 60. [Search in Rotated Sorted Array II — #81](https://leetcode.com/problems/search-in-rotated-sorted-array-ii/)

- **Difficulty:** Medium | **Pattern:** Rotated BS with duplicates — handle `nums[left]==nums[mid]`
- **Why:** Duplicates make the sorted-half check ambiguous. The fix: `left++` to skip. Tests robustness of your BS reasoning under edge cases.

### 61. [Find Peak Element — #162](https://leetcode.com/problems/find-peak-element/)

- **Difficulty:** Medium | **Pattern:** BS on local property (move toward the rising slope)
- **Why:** If `nums[mid] < nums[mid+1]`, the peak is to the right; else to the left. Teaching BS on a non-sorted array where a local condition guides direction.

---

## 4.3 — Binary Search on Answer Space

### 62. [Koko Eating Bananas — #875](https://leetcode.com/problems/koko-eating-bananas/)

- **Difficulty:** Medium | **Pattern:** BS on answer — find minimum k satisfying condition
- **Why:** The most important BS insight: binary search on the _answer itself_. "Find minimum X such that `f(X)` is true and `f` is monotonic." This template solves #1011, #410, #1231, and many more.

### 63. [Capacity to Ship Packages Within D Days — #1011](https://leetcode.com/problems/capacity-to-ship-packages-within-d-days/)

- **Difficulty:** Medium | **Pattern:** BS on answer — minimum capacity
- **Why:** Same template as #875. Binary search on capacity; simulate to check feasibility. Reinforces the "answer space BS" template on a slightly harder feasibility function.

### 64. [Time Based Key-Value Store — #981](https://leetcode.com/problems/time-based-key-value-store/)

- **Difficulty:** Medium | **Pattern:** HashMap + BS on timestamps (floor value)
- **Why:** A real-world system design problem — versioned key-value stores, audit logs, event sourcing. BS finds the largest timestamp ≤ query. Bridges data structures and binary search.

---

# 📂 5 — Linked Lists

> Linked lists force pointer manipulation without index shortcuts. Master the mechanics here — they resurface in graph traversal, stack/queue implementation, and cache design.

---

## 5.1 — Traversal & Manipulation

### 65. [Reverse Linked List — #206](https://leetcode.com/problems/reverse-linked-list/)

- **Difficulty:** Easy | **Pattern:** Iterative pointer reversal (prev/curr/next)
- **Why:** The `prev=null; while(curr!=null){next=curr.next; curr.next=prev; prev=curr; curr=next;}` skeleton is the most reused LL snippet. Also learn the recursive version for call-stack thinking.

### 66. [Merge Two Sorted Lists — #21](https://leetcode.com/problems/merge-two-sorted-lists/)

- **Difficulty:** Easy | **Pattern:** Dummy head + two-pointer merge
- **Why:** The **dummy head** node eliminates head-node edge cases entirely. This is one of the most important LL tricks. The merge logic is used in Merge K Sorted Lists and Merge Sort.

### 67. [Remove Nth Node From End — #19](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

- **Difficulty:** Medium | **Pattern:** N-gap two pointers + dummy head
- **Why:** Fast pointer advances N steps, then both move together. When fast hits null, slow is at the target. Dummy head handles removing the head node. Tests precise off-by-one reasoning.

### 68. [Swap Nodes in Pairs — #24](https://leetcode.com/problems/swap-nodes-in-pairs/)

- **Difficulty:** Medium | **Pattern:** Iterative pointer re-wiring
- **Why:** Teaches careful `prev → second → first → next` re-wiring. Builds the pointer manipulation precision needed for Reverse Nodes in K-Group (#25), a common hard follow-up.

### 69. [Reverse Nodes in k-Group — #25](https://leetcode.com/problems/reverse-nodes-in-k-group/)

- **Difficulty:** Hard | **Pattern:** Reversal in segments + connection
- **Why:** Combines #206 (reverse a sublist) with careful segment boundary tracking. A top-tier pointer manipulation problem. Tests whether you can compose linked list operations cleanly.

---

## 5.2 — Fast & Slow Pointers

### 70. [Linked List Cycle — #141](https://leetcode.com/problems/linked-list-cycle/)

- **Difficulty:** Easy | **Pattern:** Floyd's fast/slow pointer (cycle detection)
- **Why:** `slow=slow.next; fast=fast.next.next` — they meet if and only if there's a cycle. The canonical fast/slow problem. O(n) time, O(1) space.

### 71. [Linked List Cycle II — #142](https://leetcode.com/problems/linked-list-cycle-ii/)

- **Difficulty:** Medium | **Pattern:** Floyd's — find cycle entry point
- **Why:** After meeting, reset one pointer to head. Both advance at speed 1 — they meet at the cycle entry. Understanding _why_ this works builds mathematical reasoning. Used in #287 (array duplicate).

### 72. [Middle of the Linked List — #876](https://leetcode.com/problems/middle-of-the-linked-list/)

- **Difficulty:** Easy | **Pattern:** Fast/slow — midpoint
- **Why:** When fast reaches end, slow is at mid. This midpoint subroutine is used in Merge Sort on LL, Palindrome LL, and Reorder List.

### 73. [Palindrome Linked List — #234](https://leetcode.com/problems/palindrome-linked-list/)

- **Difficulty:** Easy | **Pattern:** Find middle + reverse second half + compare
- **Why:** Composes three separate patterns: #876 + #206 + two-pointer compare. A multi-step composition problem — the skill of combining patterns cleanly is what separates strong from average candidates.

---

## 5.3 — Design

### 74. [Reorder List — #143](https://leetcode.com/problems/reorder-list/)

- **Difficulty:** Medium | **Pattern:** Find mid + reverse second half + merge alternating
- **Why:** The ultimate LL composition problem — three algorithms in sequence, zero extra space. Clean implementation here signals mastery.

### 75. [Merge K Sorted Lists — #23](https://leetcode.com/problems/merge-k-sorted-lists/)

- **Difficulty:** Hard | **Pattern:** Min-heap (PriorityQueue) + dummy head
- **Why:** `PriorityQueue<ListNode>((a,b)->a.val-b.val)` — custom comparator on a node. Models K-way merge used in databases, log aggregation, and distributed sort. Divide-and-conquer alternative teaches Merge Sort thinking.

### 76. [LRU Cache — #146](https://leetcode.com/problems/lru-cache/)

- **Difficulty:** Medium | **Pattern:** HashMap + Doubly Linked List
- **Why:** (Repeated from Hashing section — it belongs in both.) The DLL gives O(1) move-to-front / evict-last. The most backend-relevant data structure design problem in all of LeetCode.

---

# 📂 6 — Stacks

> A stack is a LIFO structure. Whenever you need to process "the most recent unresolved item" — brackets, temperatures, histograms — reach for a stack.

---

## 6.1 — Stack Basics

### 77. [Valid Parentheses — #20](https://leetcode.com/problems/valid-parentheses/)

- **Difficulty:** Easy | **Pattern:** Stack for bracket matching
- **Why:** The canonical stack problem. Push opens, pop on close and verify match. Edge cases: empty stack on close, non-empty stack at end. This pattern is the foundation of all expression parsing.

### 78. [Min Stack — #155](https://leetcode.com/problems/min-stack/)

- **Difficulty:** Medium | **Pattern:** Auxiliary stack tracking running minimum
- **Why:** A parallel `minStack` stores the minimum at each level. O(1) `getMin()`. The "augmented stack" pattern — storing metadata alongside data — appears in stock span, histogram, and monotonic stack problems.

### 79. [Implement Stack using Queues — #225](https://leetcode.com/problems/implement-stack-using-queues/)

- **Difficulty:** Easy | **Pattern:** Simulate stack with queue rotation
- **Why:** Teaches deep understanding of LIFO vs FIFO by forcing you to simulate one with the other. Pairs with #232 (queue using stacks). Both are classic amortized complexity questions.

---

## 6.2 — Monotonic Stack

### 80. [Daily Temperatures — #739](https://leetcode.com/problems/daily-temperatures/)

- **Difficulty:** Medium | **Pattern:** Monotonic decreasing stack (Next Greater Element)
- **Why:** The gateway to monotonic stacks. Stack stores _indices_ waiting for their "next greater" answer. When we find it, pop and record distance. This skeleton solves every "next greater/smaller element" problem.

### 81. [Next Greater Element I — #496](https://leetcode.com/problems/next-greater-element-i/)

- **Difficulty:** Easy | **Pattern:** Monotonic stack + HashMap for cross-array lookup
- **Why:** Precompute NGE for `nums2` into a HashMap, then answer queries for `nums1` in O(1). Bridges monotonic stacks with hashing — a combo that appears in many interview problems.

### 82. [Next Greater Element II — #503](https://leetcode.com/problems/next-greater-element-ii/)

- **Difficulty:** Medium | **Pattern:** Monotonic stack on circular array (modular index)
- **Why:** Process array twice using `i % n`. Teaching circular array handling with a monotonic stack — the same modular trick appears in circular DP and queue problems.

### 83. [Car Fleet — #853](https://leetcode.com/problems/car-fleet/)

- **Difficulty:** Medium | **Pattern:** Sort + stack to simulate merging events
- **Why:** Sort by position descending, compute arrival time. If a car arrives before the car ahead, it merges into that fleet. Stack represents current fleets. Models real-world event merging (network packets, process batches).

### 84. [Largest Rectangle in Histogram — #84](https://leetcode.com/problems/largest-rectangle-in-histogram/)

- **Difficulty:** Hard | **Pattern:** Monotonic increasing stack (prev/next smaller element)
- **Why:** For each bar, the stack finds nearest smaller bar on both sides, determining max width. This is the most instructive hard stack problem — it teaches both "previous smaller" and "next smaller" in one pass. Unlocks Maximal Rectangle (#85).

---

## 6.3 — Expression Parsing

### 85. [Evaluate Reverse Polish Notation — #150](https://leetcode.com/problems/evaluate-reverse-polish-notation/)

- **Difficulty:** Medium | **Pattern:** Stack-based RPN evaluation
- **Why:** Push numbers, pop two on operator. The cleanest expression-evaluation problem. Backend engineers build calculators, rule engines, and query parsers — this is the algorithmic core.

### 86. [Basic Calculator II — #227](https://leetcode.com/problems/basic-calculator-ii/)

- **Difficulty:** Medium | **Pattern:** Stack with operator precedence (no parentheses)
- **Why:** Handle `*` and `/` before `+` and `-` using a stack. On `+`/`-`, push; on `*`/`/`, pop and compute. A realistic parser that models how compilers handle operator precedence.

### 87. [Decode String — #394](https://leetcode.com/problems/decode-string/)

- **Difficulty:** Medium | **Pattern:** Two stacks (count stack + string stack) for nested decoding
- **Why:** Nested brackets require unwinding. Two stacks — one for multipliers, one for string segments. The nested-structure decoding pattern is how you'd parse JSON, XML, or recursive data formats.

---

# 📂 7 — Queues & Deques

---

## 7.1 — Queue Design

### 88. [Implement Queue using Stacks — #232](https://leetcode.com/problems/implement-queue-using-stacks/)

- **Difficulty:** Easy | **Pattern:** Amortized O(1) queue via lazy transfer
- **Why:** Pour from `inbox` to `outbox` only when `outbox` is empty. Total pours = total pushes → amortized O(1). Tests understanding of amortized complexity — a common interview topic.

### 89. [Design Circular Queue — #622](https://leetcode.com/problems/design-circular-queue/)

- **Difficulty:** Medium | **Pattern:** Circular buffer with `head`/`tail` and modular arithmetic
- **Why:** `(tail+1) % capacity` for circular indexing. Ring buffers are everywhere in backend systems: Kafka partitions, OS I/O buffers, producer-consumer implementations.

---

## 7.2 — Monotonic Deque

### 90. [Sliding Window Maximum — #239](https://leetcode.com/problems/sliding-window-maximum/)

- **Difficulty:** Hard | **Pattern:** Monotonic decreasing deque
- **Why:** (Also in Sliding Window section.) Deque front = current window max. Remove indices outside window from front; remove smaller indices from back before adding new. The key to all "window aggregate in O(n)" problems.

### 91. [Jump Game VI — #1696](https://leetcode.com/problems/jump-game-vi/)

- **Difficulty:** Medium | **Pattern:** DP + Monotonic Deque for window max
- **Why:** `dp[i] = nums[i] + max(dp[i-k..i-1])`. Naive DP is O(nk); deque makes it O(n). The perfect bridge between DP and monotonic deque optimization — a pattern that appears in hard DP problems.

---

# 📂 8 — Trees

> Trees are recursion made visual. Every traversal is a recursion template. Master DFS and BFS here — the same code patterns work on graphs with just a `visited` set added.

---

## 8.1 — DFS: Pre-order (Top-Down)

### 92. [Invert Binary Tree — #226](https://leetcode.com/problems/invert-binary-tree/)

- **Difficulty:** Easy | **Pattern:** Pre-order DFS — swap children, then recurse
- **Why:** The simplest recursive tree problem. Teaches top-down thinking: do the operation at the current node, then recurse. Notoriously used in a famous hiring story.

### 93. [Path Sum — #112](https://leetcode.com/problems/path-sum/)

- **Difficulty:** Easy | **Pattern:** Top-down DFS with running sum (subtract as you go)
- **Why:** Subtracting target as you descend is cleaner than accumulating and comparing at leaves. This "thread state downward" pattern is used in Path Sum II, Path Sum III, and all root-to-leaf path problems.

### 94. [Path Sum II — #113](https://leetcode.com/problems/path-sum-ii/)

- **Difficulty:** Medium | **Pattern:** DFS with path list + backtracking
- **Why:** Adds result collection to #112. The `path.add(node.val); recurse; path.remove(path.size()-1)` backtracking pattern in a tree is a key skill — bridges trees and backtracking.

### 95. [Sum Root to Leaf Numbers — #129](https://leetcode.com/problems/sum-root-to-leaf-numbers/)

- **Difficulty:** Medium | **Pattern:** Top-down DFS accumulating number digit by digit
- **Why:** `currentNum = currentNum * 10 + node.val`. Tests clean pre-order state threading. Models decimal number construction in trees — appears in trie number problems.

---

## 8.2 — DFS: Post-order (Bottom-Up)

### 96. [Maximum Depth of Binary Tree — #104](https://leetcode.com/problems/maximum-depth-of-binary-tree/)

- **Difficulty:** Easy | **Pattern:** Post-order DFS, return `1 + max(left, right)`
- **Why:** The simplest post-order problem. Return value bubbles upward. This bottom-up template is the skeleton for diameter, balance check, path sum, and LCA problems.

### 97. [Diameter of Binary Tree — #543](https://leetcode.com/problems/diameter-of-binary-tree/)

- **Difficulty:** Easy | **Pattern:** Post-order DFS — return height, record global max
- **Why:** What you _return_ (height) is different from what you _record_ (diameter = left+right). This split is the defining characteristic of post-order tree DP and is used in Binary Tree Maximum Path Sum.

### 98. [Balanced Binary Tree — #110](https://leetcode.com/problems/balanced-binary-tree/)

- **Difficulty:** Easy | **Pattern:** Post-order DFS with -1 sentinel for early termination
- **Why:** Return `-1` to propagate "invalid" state without a separate boolean. The sentinel-based early exit avoids redundant computation — a clean coding pattern.

### 99. [Binary Tree Maximum Path Sum — #124](https://leetcode.com/problems/binary-tree-maximum-path-sum/)

- **Difficulty:** Hard | **Pattern:** Post-order DFS — extend to parent OR complete path through node
- **Why:** At each node: return `node.val + max(0, left, right)` to parent; record `left+node+right` as a candidate answer. The "what I return vs what I record" split, at its hardest. A landmark problem.

### 100. [Count Good Nodes in Binary Tree — #1448](https://leetcode.com/problems/count-good-nodes-in-binary-tree/)

- **Difficulty:** Medium | **Pattern:** Pre-order DFS passing running maximum downward
- **Why:** Thread the maximum seen so far from root downward. Node is "good" if its value ≥ running max. Clean combination of top-down state and bottom-up counting.

---

## 8.3 — BFS: Level Order

### 101. [Binary Tree Level Order Traversal — #102](https://leetcode.com/problems/binary-tree-level-order-traversal/)

- **Difficulty:** Medium | **Pattern:** BFS with `int size = queue.size()` level snapshot
- **Why:** The canonical BFS template. `size` captures the level boundary. This loop structure is used in 15+ BFS problems — zigzag traversal, right side view, level averages.

### 102. [Binary Tree Right Side View — #199](https://leetcode.com/problems/binary-tree-right-side-view/)

- **Difficulty:** Medium | **Pattern:** BFS level-order — take last element per level
- **Why:** Two valid approaches: BFS (last element per level) and DFS (right-first, first visit per depth). Great for discussing trade-offs between BFS and DFS.

### 103. [Binary Tree Zigzag Level Order Traversal — #103](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/)

- **Difficulty:** Medium | **Pattern:** BFS with alternating direction flag
- **Why:** Same BFS template as #102 but with a `leftToRight` boolean toggle per level. Tests clean level-order BFS with a state flag.

### 104. [Average of Levels in Binary Tree — #637](https://leetcode.com/problems/average-of-levels-in-binary-tree/)

- **Difficulty:** Easy | **Pattern:** BFS level-order — aggregate per level
- **Why:** Compute sum per level, divide by size. Reinforces BFS level template with a different aggregate. Easy but valuable for solidifying the pattern.

---

## 8.4 — Dual-Tree / Structural

### 105. [Same Tree — #100](https://leetcode.com/problems/same-tree/)

- **Difficulty:** Easy | **Pattern:** Simultaneous DFS on two trees
- **Why:** Base cases — both null (true), one null (false), values differ (false). The template for Subtree of Another Tree and Symmetric Tree.

### 106. [Subtree of Another Tree — #572](https://leetcode.com/problems/subtree-of-another-tree/)

- **Difficulty:** Easy | **Pattern:** DFS outer traversal + isSameTree inner check
- **Why:** Reuse #100 as a subroutine. Outer DFS tries every node as root; isSameTree checks from there. Teaching problem decomposition and function composition.

### 107. [Symmetric Tree — #101](https://leetcode.com/problems/symmetric-tree/)

- **Difficulty:** Easy | **Pattern:** Mirror DFS (left.left vs right.right, left.right vs right.left)
- **Why:** A tree is symmetric if its left subtree mirrors its right. The mirrored recursion pattern tests flexible recursive thinking.

---

## 8.5 — Binary Search Trees

### 108. [Validate Binary Search Tree — #98](https://leetcode.com/problems/validate-binary-search-tree/)

- **Difficulty:** Medium | **Pattern:** DFS with `(min, max)` bounds passed down
- **Why:** Local parent comparison is insufficient — you need global bounds. `dfs(node, min, max)` is the template for all BST validation problems. Very commonly asked.

### 109. [Lowest Common Ancestor of a BST — #235](https://leetcode.com/problems/lowest-common-ancestor-of-a-bst/)

- **Difficulty:** Medium | **Pattern:** BST ordering to navigate without full traversal
- **Why:** Both smaller → go left; both larger → go right; split → current node is LCA. Exploiting BST structure for O(h) traversal. Compare with #236 (general tree) to understand when structure helps.

### 110. [Lowest Common Ancestor of a Binary Tree — #236](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/)

- **Difficulty:** Medium | **Pattern:** Post-order DFS — if both sides return non-null, current is LCA
- **Why:** General LCA without BST structure. If left subtree found p and right found q, current node is LCA. A classic post-order pattern that appears in tree path problems.

### 111. [Kth Smallest Element in a BST — #230](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)

- **Difficulty:** Medium | **Pattern:** In-order traversal = sorted BST output
- **Why:** BST in-order yields elements in sorted order — fundamental BST property. Iterative in-order with an explicit stack is a key Java interview skill for BST iterator problems.

### 112. [Construct Binary Tree from Preorder and Inorder — #105](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)

- **Difficulty:** Medium | **Pattern:** Recursive tree construction using index splits
- **Why:** Preorder[0] = root. Find root in inorder → splits into left/right subtrees. Teaches that preorder+inorder uniquely determine a binary tree. Bridges traversal understanding and construction.

### 113. [Serialize and Deserialize Binary Tree — #297](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)

- **Difficulty:** Hard | **Pattern:** BFS/DFS serialization with null markers
- **Why:** A top backend engineering problem. How do you persist a tree to a string and reconstruct it? Tests both traversal and parsing. Used in distributed systems for tree-structured data serialization (ASTs, config trees).

---

# 📂 9 — Tries

> Tries are the go-to structure for prefix-based string operations — autocomplete, spell check, IP routing, dictionary search.

---

### 114. [Implement Trie (Prefix Tree) — #208](https://leetcode.com/problems/implement-trie-prefix-tree/)

- **Difficulty:** Medium | **Pattern:** TrieNode with `children[26]` + `isEnd` flag
- **Why:** Build this from scratch. The `TrieNode` class with a `children` array and `isEnd` boolean is the foundation of all trie problems. You will implement this in the interview.

### 115. [Design Add and Search Words Data Structure — #211](https://leetcode.com/problems/design-add-and-search-words-data-structure/)

- **Difficulty:** Medium | **Pattern:** Trie + DFS for wildcard matching (`.` = any char)
- **Why:** Adds wildcard search to the trie. When `.` is encountered, recurse into all children. This Trie+DFS combination is used in word games, regex engines, and dictionary lookup.

### 116. [Word Search II — #212](https://leetcode.com/problems/word-search-ii/)

- **Difficulty:** Hard | **Pattern:** Trie + DFS backtracking on 2D grid with pruning
- **Why:** Without Trie, brute force is O(N×M×4^L×W) — too slow. Trie prunes dead paths immediately. Combining Trie prefix pruning with grid backtracking is a top-tier problem that bridges three topics.

---

# 📂 10 — Heaps & Priority Queues

> A heap is the right tool whenever you need the minimum or maximum of a dynamic set. In Java: `PriorityQueue` (min-heap by default).

---

### 117. [Kth Largest Element in an Array — #215](https://leetcode.com/problems/kth-largest-element-in-an-array/)

- **Difficulty:** Medium | **Pattern:** Min-heap of size K / QuickSelect
- **Why:** Min-heap of size K maintains the K largest seen. When heap exceeds K, pop the minimum. QuickSelect is the O(n) average alternative. Both are essential. The heap approach is used for "top K from a stream."

### 118. [K Closest Points to Origin — #973](https://leetcode.com/problems/k-closest-points-to-origin/)

- **Difficulty:** Medium | **Pattern:** Max-heap of size K with custom comparator
- **Why:** Use a max-heap to keep K smallest distances. When heap exceeds K, remove the max (farthest). Teaches custom comparator design: `(a,b) -> dist(b)-dist(a)`. Generalizes to any "K closest by metric" problem.

### 119. [Top K Frequent Words — #692](https://leetcode.com/problems/top-k-frequent-words/)

- **Difficulty:** Medium | **Pattern:** Min-heap with composite comparator (freq desc, alpha asc)
- **Why:** Sorting by frequency AND alphabetical order requires a composite comparator. Tests careful `Comparator` design in Java — a real-world skill for ranking and sorting systems.

### 120. [Find Median from Data Stream — #295](https://leetcode.com/problems/find-median-from-data-stream/)

- **Difficulty:** Hard | **Pattern:** Two heaps — max-heap (lower half) + min-heap (upper half)
- **Why:** The two-heap pattern for streaming median is asked constantly. Balance heaps so sizes differ by at most 1. Median = top of larger heap or average of both tops. Used in monitoring dashboards and SLA percentile tracking.

### 121. [Task Scheduler — #621](https://leetcode.com/problems/task-scheduler/)

- **Difficulty:** Medium | **Pattern:** Greedy + max-heap (most frequent task first)
- **Why:** Always schedule the most frequent remaining task. Max-heap picks it. Models CPU scheduling, job queues, and rate-limited API call ordering — a real backend simulation problem.

### 122. [Reorganize String — #767](https://leetcode.com/problems/reorganize-string/)

- **Difficulty:** Medium | **Pattern:** Greedy + max-heap, place most frequent alternately
- **Why:** Same greedy idea as #621 but applied to string construction. If most frequent char has count > (n+1)/2, it's impossible. Otherwise, greedily alternate. Models distributed write balancing.

### 123. [Merge K Sorted Lists — #23](https://leetcode.com/problems/merge-k-sorted-lists/)

- **Difficulty:** Hard | **Pattern:** Min-heap + dummy head (K-way merge)
- **Why:** (Also in Linked Lists.) The PQ-based K-way merge is the algorithmic core of database merge joins, external sort, and log aggregation systems.

### 124. [Ugly Number II — #264](https://leetcode.com/problems/ugly-number-ii/)

- **Difficulty:** Medium | **Pattern:** Min-heap or 3-pointer DP for ordered generation
- **Why:** Generate ugly numbers in sorted order. The heap approach naturally maintains sorted order; the 3-pointer DP is a beautiful O(n) optimization. Models ordered generation from multiple sorted sequences.

---

# 📂 11 — Graphs: DFS

> Graph DFS = tree DFS + a `visited` set to prevent cycles. Every grid problem is an implicit graph.

---

## 11.1 — Grid DFS (Flood Fill)

### 125. [Number of Islands — #200](https://leetcode.com/problems/number-of-islands/)

- **Difficulty:** Medium | **Pattern:** Grid DFS — visit and mark (flood fill)
- **Why:** The canonical graph/grid problem. The "mark visited then recurse in 4 directions" pattern is the template for all 2D connectivity problems. Non-negotiable.

### 126. [Max Area of Island — #695](https://leetcode.com/problems/max-area-of-island/)

- **Difficulty:** Medium | **Pattern:** Grid DFS — return component size
- **Why:** DFS returns the area of each island component. Teaches that DFS can _return_ values, not just mark visited. The "DFS returns component property" pattern appears in 10+ grid problems.

### 127. [Flood Fill — #733](https://leetcode.com/problems/flood-fill/)

- **Difficulty:** Easy | **Pattern:** DFS with color replacement (handle same-color edge case)
- **Why:** The simplest grid DFS. The edge case: if `oldColor == newColor`, return immediately to avoid infinite loops. Models paint-bucket tool, region recoloring, and network segment updates.

### 128. [Surrounded Regions — #130](https://leetcode.com/problems/surrounded-regions/)

- **Difficulty:** Medium | **Pattern:** Border DFS to mark "safe" cells, then flip the rest
- **Why:** Don't solve the hard direction — find all 'O's connected to the border (easy) and mark them safe. Everything else gets flipped. Teaches solving the _complement_ when that's easier.

### 129. [Number of Enclaves — #1020](https://leetcode.com/problems/number-of-enclaves/)

- **Difficulty:** Medium | **Pattern:** Border DFS to subtract border-connected cells
- **Why:** Extends #130 — count land cells NOT reachable from border. DFS from all border land, mark visited, then count remaining. Reinforces the "border reachability" pattern.

---

## 11.2 — Component & Cycle DFS

### 130. [Clone Graph — #133](https://leetcode.com/problems/clone-graph/)

- **Difficulty:** Medium | **Pattern:** DFS + HashMap (original → clone) for cycle-safe copying
- **Why:** The `HashMap<Node, Node>` maps original to its clone, preventing infinite loops in cyclic graphs. This "visited map" pattern is used in any graph copy/serialization problem.

### 131. [Course Schedule — #207](https://leetcode.com/problems/course-schedule/)

- **Difficulty:** Medium | **Pattern:** DFS cycle detection — 3-color marking (white/gray/black)
- **Why:** White = unvisited, Gray = in current path, Black = fully processed. Gray node encountered → cycle. This is the cleanest cycle detection in directed graphs and is used in build systems, dependency graphs.

### 132. [Path With Maximum Probability — #1514](https://leetcode.com/problems/path-with-maximum-probability/)

- **Difficulty:** Medium | **Pattern:** Modified Dijkstra (maximize product of probabilities)
- **Why:** Instead of minimizing cost, maximize probability. Use max-heap. Shows that shortest-path algorithms are general "optimize along path" tools — the objective function can change.

### 133. [Pacific Atlantic Water Flow — #417](https://leetcode.com/problems/pacific-atlantic-water-flow/)

- **Difficulty:** Medium | **Pattern:** Reverse DFS/BFS from both borders, find intersection
- **Why:** Instead of "can (i,j) reach the ocean?", ask "which cells can the ocean reach going backwards?". Multi-source reverse DFS from both borders. The intersection is the answer. A key problem-reversal insight.

---

# 📂 12 — Graphs: BFS

---

## 12.1 — Grid BFS & Multi-Source BFS

### 134. [01 Matrix — #542](https://leetcode.com/problems/01-matrix/)

- **Difficulty:** Medium | **Pattern:** Multi-source BFS from all 0s simultaneously
- **Why:** Add all 0s to the queue first, then BFS outward — each non-zero cell gets its distance when first visited. This "expand from all sources simultaneously" is the BFS distance-from-source pattern.

### 135. [Rotting Oranges — #994](https://leetcode.com/problems/rotting-oranges/)

- **Difficulty:** Medium | **Pattern:** Multi-source BFS (simultaneous spread) + fresh-count tracking
- **Why:** All rotten oranges spread simultaneously each minute. Level count = minutes. Track fresh count to detect if any are unreachable. Models virus spread, network propagation, and fire simulation.

### 136. [Walls and Gates — #286](https://leetcode.com/problems/walls-and-gates/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Multi-source BFS from all gates
- **Why:** Same as #542 but with named semantics. BFS from all gates fills distances to empty rooms. Reinforces multi-source BFS and handles unreachable cells (`INF` remains).

### 137. [Shortest Path in Binary Matrix — #1091](https://leetcode.com/problems/shortest-path-in-binary-matrix/)

- **Difficulty:** Medium | **Pattern:** BFS on grid (8-directional), shortest path
- **Why:** BFS always finds the shortest unweighted path. This problem adds 8-directional movement, which is a common variant. BFS level count = path length.

---

## 12.2 — Graph BFS & Shortest Path

### 138. [Word Ladder — #127](https://leetcode.com/problems/word-ladder/)

- **Difficulty:** Hard | **Pattern:** BFS on implicit graph (word → neighbor words one char apart)
- **Why:** Each word is a node; edges exist between words that differ by one character. Building the implicit graph and running BFS finds the shortest transformation sequence. Models state-space search — used in NLP, configuration management, and genetic algorithms.

### 139. [Snakes and Ladders — #909](https://leetcode.com/problems/snakes-and-ladders/)

- **Difficulty:** Medium | **Pattern:** BFS on modified graph (teleportation edges)
- **Why:** BFS on a board with teleportation (snakes/ladders). Teaches encoding 2D board index to 1D and handling special "jump" edges in BFS. Models routing with shortcuts.

### 140. [Open the Lock — #752](https://leetcode.com/problems/open-the-lock/)

- **Difficulty:** Medium | **Pattern:** BFS on state space (string states as nodes)
- **Why:** Each lock state is a node; adjacent states differ by one wheel turn. BFS finds minimum turns. State-space BFS is a general technique for puzzle/game problems and config transition problems.

### 141. [Course Schedule II — #210](https://leetcode.com/problems/course-schedule-ii/)

- **Difficulty:** Medium | **Pattern:** Kahn's BFS topological sort (in-degree tracking)
- **Why:** (Also in Topological Sort section.) BFS version of topological sort. Process nodes with in-degree 0 first; decrement neighbors' in-degrees. If all nodes processed → no cycle. Output = topological order.

---

# 📂 13 — Graphs: Topological Sort

> Topological sort orders nodes in a directed acyclic graph such that every edge goes from earlier to later. Used in build systems, task schedulers, and dependency resolution.

---

### 142. [Course Schedule — #207](https://leetcode.com/problems/course-schedule/)

- **Difficulty:** Medium | **Pattern:** Topological sort — cycle detection (DFS 3-color or Kahn's)
- **Why:** The entry-level toposort problem. Learn _both_ DFS (3-color marking) and Kahn's BFS (in-degree). Prerequisite relationships = directed graph = detect if a valid order exists.

### 143. [Course Schedule II — #210](https://leetcode.com/problems/course-schedule-ii/)

- **Difficulty:** Medium | **Pattern:** Kahn's BFS — output topological order
- **Why:** Extends #207 to output the actual order. Kahn's is cleaner here. This is how Maven/Gradle resolve build order, how microservice deployment orders are determined.

### 144. [Alien Dictionary — #269](https://leetcode.com/problems/alien-dictionary/) _(NeetCode free)_

- **Difficulty:** Hard | **Pattern:** Build graph from adjacent word pairs + topological sort
- **Why:** Derive character ordering from sorted word list. For adjacent words, the first differing character gives an edge. Then topological sort the characters. Models deriving constraints from observations — a real-world inference problem.

### 145. [Sequence Reconstruction — #444](https://leetcode.com/problems/sequence-reconstruction/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Topological sort — verify unique ordering
- **Why:** Check if `nums` is the _only_ possible topological order given sequences. At each Kahn's step, if queue has more than one element, the ordering is not unique. Tests deep understanding of when toposort has a unique solution.

---

# 📂 14 — Graphs: Union Find (DSU)

> Union-Find (Disjoint Set Union) is the most elegant data structure for dynamic connectivity. `find(x)` with path compression + `union(x,y)` with rank ≈ O(1) amortized.

---

### 146. [Number of Connected Components — #323](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Union-Find — component count
- **Why:** The entry-level Union-Find problem. Start with N components, decrement on each successful union. This is the cleanest introduction to DSU mechanics.

### 147. [Graph Valid Tree — #261](https://leetcode.com/problems/graph-valid-tree/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Union-Find — detect cycle + check connectivity
- **Why:** A tree = connected + acyclic. During union, if two nodes already share a root → cycle detected. Final check: exactly 1 component. Also teachable via DFS.

### 148. [Redundant Connection — #684](https://leetcode.com/problems/redundant-connection/)

- **Difficulty:** Medium | **Pattern:** Union-Find — find the edge that creates a cycle
- **Why:** Process edges one by one. The first edge where both endpoints already have the same root is the redundant edge. A clean, practical DSU application.

### 149. [Accounts Merge — #721](https://leetcode.com/problems/accounts-merge/)

- **Difficulty:** Medium | **Pattern:** Union-Find to merge sets by shared email
- **Why:** Union all emails in each account. Emails sharing a component belong to the same person. Then group and sort. A real-world problem: user deduplication, identity resolution in backend systems.

### 150. [Most Stones Removed with Same Row or Column — #947](https://leetcode.com/problems/most-stones-removed-with-same-row-or-column/)

- **Difficulty:** Medium | **Pattern:** Union-Find on rows and columns (coordinate compression)
- **Why:** Union stones sharing a row or column. The max removable = total stones − number of components. A clever DSU formulation where the insight (components determine the answer) is non-obvious.

---

# 📂 15 — Graphs: Shortest Path

---

### 151. [Network Delay Time — #743](https://leetcode.com/problems/network-delay-time/)

- **Difficulty:** Medium | **Pattern:** Dijkstra's algorithm (min-heap + dist array)
- **Why:** `PriorityQueue<int[]>` ordered by cost. Relax edges, update `dist[]`. This is the canonical Dijkstra implementation in Java. Models network latency, routing protocols (OSPF), and any minimum-cost-path problem.

### 152. [Cheapest Flights Within K Stops — #787](https://leetcode.com/problems/cheapest-flights-within-k-stops/)

- **Difficulty:** Medium | **Pattern:** Bellman-Ford with K iterations
- **Why:** "At most K edges" breaks Dijkstra — requires Bellman-Ford with K relaxation rounds. Uses a copy of the dist array per iteration to avoid multi-hop updates. Models SLA-constrained routing and hop-limited messaging.

### 153. [Path With Minimum Effort — #1631](https://leetcode.com/problems/path-with-minimum-effort/)

- **Difficulty:** Medium | **Pattern:** Dijkstra with custom edge weight (max height diff along path)
- **Why:** "Minimize the maximum effort along a path" → Dijkstra where the cost function is `max(currentEffort, abs(diff))`. Shows Dijkstra is a general framework — the objective function can be min-max, not just min-sum.

### 154. [Find the City With the Smallest Number of Neighbors — #1334](https://leetcode.com/problems/find-the-city-with-the-smallest-number-of-neighbors-at-a-threshold-distance/)

- **Difficulty:** Medium | **Pattern:** Floyd-Warshall all-pairs shortest path
- **Why:** When you need shortest paths between _all_ pairs, Floyd-Warshall O(V³) is the right tool. `dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])`. Models city reachability, full-mesh network analysis.

### 155. [Swim in Rising Water — #778](https://leetcode.com/problems/swim-in-rising-water/)

- **Difficulty:** Hard | **Pattern:** Dijkstra / Binary search + BFS
- **Why:** Minimize the maximum value encountered along a path. Two approaches: Dijkstra (treat cell value as cost) or binary search on answer + BFS feasibility check. A hard problem that reinforces "binary search on answer" in a graph context.

---

# 📂 16 — Dynamic Programming: 1D

> DP = recursion + memoization, or equivalently, a bottom-up table fill. Every DP problem is: define state → write recurrence → identify base cases → optimize space.

---

## 16.1 — Fibonacci / Linear DP

### 156. [Climbing Stairs — #70](https://leetcode.com/problems/climbing-stairs/)

- **Difficulty:** Easy | **Pattern:** Fibonacci DP (`dp[i] = dp[i-1] + dp[i-2]`)
- **Why:** The gateway DP problem. State → recurrence → base case. Optimize to O(1) space with two variables. Fibonacci-style transitions appear in House Robber, Jump Game, and counting problems.

### 157. [House Robber — #198](https://leetcode.com/problems/house-robber/)

- **Difficulty:** Medium | **Pattern:** "Take or skip" decision DP
- **Why:** `dp[i] = max(dp[i-1], dp[i-2] + nums[i])`. Space-optimize to two variables. The "take or skip" pattern is the most common 1D DP decision. Spawns #213 (circular) and #337 (tree).

### 158. [House Robber II — #213](https://leetcode.com/problems/house-robber-ii/)

- **Difficulty:** Medium | **Pattern:** Circular array DP — solve twice (exclude first OR last)
- **Why:** Circular constraint means first and last can't both be taken. Solve on `[0..n-2]` and `[1..n-1]`, take the max. This "break the circle by solving twice" trick appears in circular interval and circular DP problems.

### 159. [Jump Game — #55](https://leetcode.com/problems/jump-game/)

- **Difficulty:** Medium | **Pattern:** Greedy — track max reachable index
- **Why:** `maxReach = max(maxReach, i + nums[i])`. If `i > maxReach` at any point, return false. The greedy insight is cleaner than DP here. Teaching when greedy suffices over DP is a key meta-skill.

### 160. [Jump Game II — #45](https://leetcode.com/problems/jump-game-ii/)

- **Difficulty:** Medium | **Pattern:** Greedy — BFS-like level jumps
- **Why:** Think of each "range of reachable positions" as a BFS level. `currentEnd` marks the end of the current level; when `i == currentEnd`, increment jumps and extend to `farthest`. Greedy BFS on an implicit graph.

---

## 16.2 — Decision / Path DP

### 161. [Word Break — #139](https://leetcode.com/problems/word-break/)

- **Difficulty:** Medium | **Pattern:** 1D DP on string — `dp[i]` = can we segment `s[0..i-1]`
- **Why:** For each position, check all valid word endings using a HashSet. `dp[i] = true` if `dp[j]` is true and `s[j..i-1]` is in the dictionary. Directly models tokenization, NLP preprocessing, and code parsing.

### 162. [Decode Ways — #91](https://leetcode.com/problems/decode-ways/)

- **Difficulty:** Medium | **Pattern:** 1D DP with conditional transitions (handle '0' carefully)
- **Why:** Two transitions: single digit and two digits. Each has validity conditions (`'0'` is tricky). Tests precision in DP condition handling. Models protocol decoders, base64, and run-length encoding.

### 163. [Coin Change — #322](https://leetcode.com/problems/coin-change/)

- **Difficulty:** Medium | **Pattern:** Unbounded knapsack — minimize count
- **Why:** `dp[i] = min(dp[i], dp[i-coin] + 1)` for each coin. The forward-fill unbounded DP pattern. Foundation for all "minimum cost to reach target with unlimited items" problems.

### 164. [Coin Change II — #518](https://leetcode.com/problems/coin-change-ii/)

- **Difficulty:** Medium | **Pattern:** Unbounded knapsack — count ways
- **Why:** From "minimum count" to "number of ways." Iterate coins in outer loop and amounts in inner loop to avoid counting permutations as different combinations. The ordering of loops matters — a subtle but critical DP insight.

### 165. [Counting Bits — #338](https://leetcode.com/problems/counting-bits/)

- **Difficulty:** Easy | **Pattern:** DP using bit relationship (`dp[i] = dp[i>>1] + (i&1)`)
- **Why:** Derive DP state from mathematical bit structure. The `i >> 1` relationship (right shift removes last bit) gives a recurrence from smaller subproblems. Introduces bitmask DP thinking.

### 166. [Longest Increasing Subsequence — #300](https://leetcode.com/problems/longest-increasing-subsequence/)

- **Difficulty:** Medium | **Pattern:** O(n²) DP or O(n log n) patience sorting
- **Why:** A landmark DP problem. `dp[i]` = LIS ending at index i. The O(n log n) solution using binary search on a patience sort array is a must-know optimization. LIS appears as a subproblem in many advanced DP and greedy problems.

### 167. [Partition Equal Subset Sum — #416](https://leetcode.com/problems/partition-equal-subset-sum/)

- **Difficulty:** Medium | **Pattern:** 0/1 knapsack — boolean subset sum
- **Why:** `dp[j] = dp[j] || dp[j-nums[i]]`. Iterate j _backwards_ to avoid reusing elements. This backward iteration for 0/1 (no-repeat) knapsack vs forward iteration for unbounded knapsack is a critical distinction.

---

# 📂 17 — Dynamic Programming: 2D

---

### 168. [Unique Paths — #62](https://leetcode.com/problems/unique-paths/)

- **Difficulty:** Medium | **Pattern:** 2D DP grid — count paths
- **Why:** `dp[i][j] = dp[i-1][j] + dp[i][j-1]`. The simplest 2D DP problem. Space-optimize to a 1D array. Foundation for obstacle variants and minimum path sum.

### 169. [Minimum Path Sum — #64](https://leetcode.com/problems/minimum-path-sum/)

- **Difficulty:** Medium | **Pattern:** 2D DP grid — minimize cost
- **Why:** Same 2D structure as #62 but minimizing. Models cheapest route through a cost grid — directly applicable to network hop costs, pipeline routing, and game pathfinding.

### 170. [Unique Paths II — #63](https://leetcode.com/problems/unique-paths-ii/)

- **Difficulty:** Medium | **Pattern:** 2D DP with obstacle handling (`dp[i][j]=0` on obstacle)
- **Why:** Extends #62 with obstacles. Tests clean initialization (first row/column handling with obstacles). Builds precision in 2D DP.

### 171. [Longest Common Subsequence — #1143](https://leetcode.com/problems/longest-common-subsequence/)

- **Difficulty:** Medium | **Pattern:** 2D DP on two sequences
- **Why:** If `s1[i]==s2[j]`: `dp[i][j] = dp[i-1][j-1]+1`. Else: `max(dp[i-1][j], dp[i][j-1])`. LCS is the foundation of git diff, DNA alignment, spell correction, and Edit Distance.

### 172. [Edit Distance — #72](https://leetcode.com/problems/edit-distance/)

- **Difficulty:** Medium | **Pattern:** Levenshtein distance DP (insert/delete/replace)
- **Why:** Three-way recurrence. Used in spell checkers, autocorrect, fuzzy search, and NLP similarity. One of the most real-world-relevant DP problems for backend engineers.

### 173. [Interleaving String — #97](https://leetcode.com/problems/interleaving-string/)

- **Difficulty:** Medium | **Pattern:** 2D DP — can s3 be formed by interleaving s1 and s2
- **Why:** `dp[i][j]` = can first `i+j` chars of s3 be formed from s1[0..i-1] and s2[0..j-1]. A clean 2D DP that models string merging — relevant to log interleaving analysis and merge conflict detection.

### 174. [Distinct Subsequences — #115](https://leetcode.com/problems/distinct-subsequences/)

- **Difficulty:** Hard | **Pattern:** 2D DP — count ways to form t as a subsequence of s
- **Why:** `dp[i][j]` = number of ways to form `t[0..i-1]` from `s[0..j-1]`. If chars match: `dp[i][j] = dp[i-1][j-1] + dp[i][j-1]`. Counts embeddings of one string in another — appears in bioinformatics and pattern frequency analysis.

### 175. [Maximal Square — #221](https://leetcode.com/problems/maximal-square/)

- **Difficulty:** Medium | **Pattern:** 2D DP — `dp[i][j]` = side length of largest all-1 square ending here
- **Why:** `dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1`. A beautiful geometric DP. The min-of-three-neighbors formula is non-obvious and highly instructive. Extends to Maximal Rectangle.

---

# 📂 18 — Dynamic Programming: Intervals

> Interval DP: the answer for a range `[i,j]` depends on answers for sub-ranges. Classic for palindromes, matrix chain multiplication, and game theory.

---

### 176. [Longest Palindromic Substring — #5](https://leetcode.com/problems/longest-palindromic-substring/)

- **Difficulty:** Medium | **Pattern:** Expand-around-center or 2D interval DP
- **Why:** (Repeated from Strings.) The expand-around-center O(n²) approach is more elegant than the O(n²) DP table. Knowing both approaches is valuable — the DP table approach is the entry to interval DP.

### 177. [Palindromic Substrings — #647](https://leetcode.com/problems/palindromic-substrings/)

- **Difficulty:** Medium | **Pattern:** Expand-around-center — count all palindromes
- **Why:** (Repeated from Strings.) Together with #5, these two cover all palindrome problem variants.

### 178. [Minimum Cost Tree From Leaf Values — #1130](https://leetcode.com/problems/minimum-cost-tree-from-leaf-values/)

- **Difficulty:** Medium | **Pattern:** Interval DP or monotonic stack
- **Why:** Teaches interval DP where `dp[i][j]` = minimum cost to build a subtree from leaves `[i,j]`. The greedy/stack approach (remove smallest element, cost = product with smaller neighbor) is equally instructive.

### 179. [Burst Balloons — #312](https://leetcode.com/problems/burst-balloons/)

- **Difficulty:** Hard | **Pattern:** Interval DP — think about which balloon to pop LAST
- **Why:** Counterintuitive: instead of which to pop first, think about which to pop last in range `[i,j]`. The last-popped balloon's neighbors are `i-1` and `j+1` (the boundaries). A paradigm-shifting problem that teaches "think in reverse" for interval DP.

---

# 📂 19 — Dynamic Programming: Knapsack

---

### 180. [Partition Equal Subset Sum — #416](https://leetcode.com/problems/partition-equal-subset-sum/)

- **Difficulty:** Medium | **Pattern:** 0/1 Knapsack — boolean (can we form target sum?)
- **Why:** (Repeated from 1D DP.) The canonical 0/1 knapsack. Backward iteration is essential. Must-know.

### 181. [Last Stone Weight II — #1049](https://leetcode.com/problems/last-stone-weight-ii/)

- **Difficulty:** Medium | **Pattern:** 0/1 Knapsack — minimize the difference between two groups
- **Why:** Minimize `|S1 - S2|` = find subset with sum closest to `total/2`. Extends #416 — instead of exact target, find closest achievable sum. Tests flexible application of the 0/1 knapsack.

### 182. [Target Sum — #494](https://leetcode.com/problems/target-sum/)

- **Difficulty:** Medium | **Pattern:** 0/1 Knapsack (count ways) or DFS + memoization
- **Why:** From "can we?" (#416) to "how many ways?" A natural extension. The memoization approach (`HashMap<(index, sum), count>`) is also a great intro to top-down DP. Both approaches tested in interviews.

### 183. [Coin Change II — #518](https://leetcode.com/problems/coin-change-ii/)

- **Difficulty:** Medium | **Pattern:** Unbounded Knapsack — count combinations
- **Why:** (Repeated from 1D DP.) The canonical unbounded knapsack counting problem. Outer loop = coins, inner loop = amounts. Crucial loop ordering distinction vs 0/1.

### 184. [Ones and Zeroes — #474](https://leetcode.com/problems/ones-and-zeroes/)

- **Difficulty:** Medium | **Pattern:** 2D 0/1 Knapsack (two constraints: count of 0s and 1s)
- **Why:** `dp[i][j]` = max strings using at most `i` zeros and `j` ones. A 2D knapsack — two capacity dimensions. Tests generalization of the knapsack pattern beyond a single constraint.

---

# 📂 20 — Intervals & Greedy

> Greedy works when the locally optimal choice leads to the globally optimal solution. Sorting is almost always the first step.

---

### 185. [Meeting Rooms — #252](https://leetcode.com/problems/meeting-rooms/) _(NeetCode free)_

- **Difficulty:** Easy | **Pattern:** Sort by start, check adjacent overlap
- **Why:** Sort by start time. If any `intervals[i].start < intervals[i-1].end` → overlap → return false. The simplest interval problem and the conceptual foundation for all others.

### 186. [Merge Intervals — #56](https://leetcode.com/problems/merge-intervals/)

- **Difficulty:** Medium | **Pattern:** Sort by start + greedy extension
- **Why:** Sort by start. If current overlaps with last merged, extend end. Otherwise, add new interval. Appears in calendar merging, IP range consolidation, and database VACUUM operations.

### 187. [Insert Interval — #57](https://leetcode.com/problems/insert-interval/)

- **Difficulty:** Medium | **Pattern:** 3-phase scan (before / overlap / after)
- **Why:** Already sorted. Three phases: add all intervals ending before new starts, merge all overlapping, add all starting after new ends. A state-machine scan — tests boundary precision.

### 188. [Non-overlapping Intervals — #435](https://leetcode.com/problems/non-overlapping-intervals/)

- **Difficulty:** Medium | **Pattern:** Activity selection — sort by end time, greedy keep
- **Why:** The **Activity Selection Problem** — sort by _end time_, greedily keep intervals finishing earliest. Provably optimal greedy. Used in task scheduling and resource allocation. The "sort by end" vs "sort by start" distinction is critical.

### 189. [Meeting Rooms II — #253](https://leetcode.com/problems/meeting-rooms-ii/) _(NeetCode free)_

- **Difficulty:** Medium | **Pattern:** Min-heap tracking active end times / sweep line
- **Why:** "Minimum rooms needed" = "maximum overlap at any point." Heap approach: sort by start, use min-heap of end times; reuse a room if earliest end ≤ current start. Models database connection pool sizing and server capacity planning.

### 190. [Minimum Number of Arrows to Burst Balloons — #452](https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/)

- **Difficulty:** Medium | **Pattern:** Greedy — sort by end, shoot at each end
- **Why:** An arrow at position `p` bursts all balloons with `start ≤ p ≤ end`. Greedily shoot at the end of each unpopped balloon. Same greedy as Activity Selection (#435) in disguise.

### 191. [Jump Game — #55](https://leetcode.com/problems/jump-game/)

- **Difficulty:** Medium | **Pattern:** Greedy — max reachable index
- **Why:** (Repeated from DP section.) Interval-like reasoning: can we reach the end from the current reachable range? Greedy scan is O(n) vs O(n²) DP.

---

# 📂 21 — Backtracking

> Backtracking = DFS on a decision tree. Template: **choose → recurse → unchoose**. The key variations: subsets (no order), permutations (order matters), constraint satisfaction.

---

### 192. [Subsets — #78](https://leetcode.com/problems/subsets/)

- **Difficulty:** Medium | **Pattern:** Backtracking — generate power set
- **Why:** The purest backtracking problem. `choose(nums[i]); dfs(i+1); unchoose()`. Every combination, permutation, and partition problem uses this skeleton.

### 193. [Subsets II — #90](https://leetcode.com/problems/subsets-ii/)

- **Difficulty:** Medium | **Pattern:** Backtracking with deduplication at same recursion level
- **Why:** Sort + `if(i > start && nums[i] == nums[i-1]) continue`. This single deduplication line appears in Combinations II, Permutations II, and 3Sum. Master it here.

### 194. [Permutations — #46](https://leetcode.com/problems/permutations/)

- **Difficulty:** Medium | **Pattern:** Backtracking with `boolean[] used`
- **Why:** Order matters → use `boolean[] used` instead of `start` index. The distinction between subsets (use `start`) and permutations (use `used[]`) unlocks the entire backtracking problem tree.

### 195. [Permutations II — #47](https://leetcode.com/problems/permutations-ii/)

- **Difficulty:** Medium | **Pattern:** Backtracking with deduplication for permutations
- **Why:** Sort + `if(used[i] || (i>0 && nums[i]==nums[i-1] && !used[i-1])) continue`. The dedup condition for permutations is subtler than for subsets. A complete test of backtracking mastery.

### 196. [Combination Sum — #39](https://leetcode.com/problems/combination-sum/)

- **Difficulty:** Medium | **Pattern:** Backtracking — unlimited reuse (pass `i`, not `i+1`)
- **Why:** Pass `i` (not `i+1`) to allow reuse of the same element. Unbounded backtracking mirrors unbounded knapsack. Models "reach target budget with unlimited items."

### 197. [Combination Sum II — #40](https://leetcode.com/problems/combination-sum-ii/)

- **Difficulty:** Medium | **Pattern:** Backtracking — no reuse + deduplication
- **Why:** Sort + deduplication (same as #90) + pass `i+1`. Combines dedup from #90 with no-reuse rule. Completing both #39 and #40 fully covers the "with/without reuse + with/without duplicates" matrix.

### 198. [Palindrome Partitioning — #131](https://leetcode.com/problems/palindrome-partitioning/)

- **Difficulty:** Medium | **Pattern:** Backtracking with palindrome check
- **Why:** At each step, try all suffixes from current position that are palindromes. Teaches backtracking with a constraint check (is this partition valid?). The palindrome check can be optimized with DP preprocessing.

### 199. [Word Search — #79](https://leetcode.com/problems/word-search/)

- **Difficulty:** Medium | **Pattern:** Backtracking on 2D grid (temp mark visited)
- **Why:** Mark `board[r][c] = '#'` before recursing, restore after. Cleaner than a separate visited matrix. The template for all grid backtracking problems.

### 200. [N-Queens — #51](https://leetcode.com/problems/n-queens/)

- **Difficulty:** Hard | **Pattern:** Backtracking with 3 constraint sets (cols, diag1, diag2)
- **Why:** Three HashSets track attacked columns and both diagonals. O(1) constraint check. The classic constraint-satisfaction backtracking problem. Models placement problems in distributed systems (shard placement, rack-aware scheduling).

### 201. [Letter Combinations of a Phone Number — #17](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

- **Difficulty:** Medium | **Pattern:** Backtracking on a decision map
- **Why:** Maps each digit to its characters; backtracking builds combinations. Models API path generation, feature flag combinations, and config permutation generation.

---

# 📂 22 — Bit Manipulation

> Bit manipulation is O(1) in the most literal sense — a single CPU instruction. Use it for XOR cancellation, space optimization, and subset enumeration.

---

### 202. [Single Number — #136](https://leetcode.com/problems/single-number/)

- **Difficulty:** Easy | **Pattern:** XOR self-cancellation (`a^a=0`, `a^0=a`)
- **Why:** XOR all elements — pairs cancel, unique survives. O(1) space. Gateway to all XOR-based problems. Teach this pattern, and Single Number II/III become approachable.

### 203. [Single Number II — #137](https://leetcode.com/problems/single-number-ii/)

- **Difficulty:** Medium | **Pattern:** Bit counting — find element appearing once among triples
- **Why:** Count each bit modulo 3. The bit that sums to 1 mod 3 is the unique element's bit. This "count bits mod k" pattern is general — works for any frequency except the unique element.

### 204. [Missing Number — #268](https://leetcode.com/problems/missing-number/)

- **Difficulty:** Easy | **Pattern:** XOR with index-value pairs (or Gauss sum)
- **Why:** XOR `0..n` with all elements — the missing number remains. Two clean approaches; XOR avoids overflow concerns.

### 205. [Number of 1 Bits — #191](https://leetcode.com/problems/number-of-1-bits/)

- **Difficulty:** Easy | **Pattern:** `n & (n-1)` clears the lowest set bit
- **Why:** Count iterations until `n == 0`. This trick also answers "is n a power of 2?" (`n & (n-1) == 0`). Appears in Power of Two, Subsets enumeration, and bitmask DP.

### 206. [Counting Bits — #338](https://leetcode.com/problems/counting-bits/)

- **Difficulty:** Easy | **Pattern:** DP with bit structure (`dp[i] = dp[i>>1] + (i&1)`)
- **Why:** (Also in DP section.) The `i >> 1` relationship gives a DP recurrence from bit structure. Teaches deriving DP transitions from mathematical properties.

### 207. [Reverse Bits — #190](https://leetcode.com/problems/reverse-bits/)

- **Difficulty:** Easy | **Pattern:** Extract and place bits
- **Why:** `(n >>> i) & 1` extracts bit i; `bit << (31-i)` places it in the mirror position. Systematic bit manipulation used in network protocol headers and binary encoding.

### 208. [Sum of Two Integers — #371](https://leetcode.com/problems/sum-of-two-integers/)

- **Difficulty:** Medium | **Pattern:** XOR for sum, AND+shift for carry
- **Why:** `a^b` = sum without carry; `(a&b)<<1` = carry. Repeat until carry = 0. Shows how CPUs perform addition. Asked to test understanding of arithmetic at the hardware level.

---

# 📂 23 — Math & Simulation

> Not "obscure math tricks" — these are problems where simulation, modular arithmetic, or number properties provide the cleanest solution. All are frequently asked in backend interviews.

---

### 209. [Happy Number — #202](https://leetcode.com/problems/happy-number/)

- **Difficulty:** Easy | **Pattern:** Fast/slow pointer cycle detection on a number sequence
- **Why:** The sum-of-squares process either reaches 1 or cycles. Fast/slow pointer detects the cycle. Bridges number theory with cycle detection — a creative application of a pointer technique.

### 210. [Reverse Integer — #7](https://leetcode.com/problems/reverse-integer/)

- **Difficulty:** Medium | **Pattern:** Digit extraction + overflow detection
- **Why:** `rev = rev * 10 + digit`. Overflow check: `rev > Integer.MAX_VALUE / 10`. Tests careful integer boundary handling — essential in any backend service handling user-provided numeric input.

### 211. [Pow(x, n) — #50](https://leetcode.com/problems/powx-n/)

- **Difficulty:** Medium | **Pattern:** Fast exponentiation (binary exponentiation)
- **Why:** `power(x, n) = power(x*x, n/2)` if n is even. O(log n) vs O(n) naive. Binary exponentiation is used in cryptography (modular exponentiation), large number multiplication, and matrix exponentiation for DP optimization.

### 212. [Spiral Matrix — #54](https://leetcode.com/problems/spiral-matrix/)

- **Difficulty:** Medium | **Pattern:** Layer-by-layer simulation with boundary tracking
- **Why:** Shrink boundaries (`top`, `bottom`, `left`, `right`) after each direction. A clean simulation problem that tests careful boundary management — the same skill needed in matrix rotation, image processing, and grid traversal problems.

### 213. [Rotate Image — #48](https://leetcode.com/problems/rotate-image/)

- **Difficulty:** Medium | **Pattern:** Transpose + reverse rows (in-place)
- **Why:** Rotate 90° = transpose + reverse each row. O(1) space. A beautiful in-place matrix transformation. Teaches that complex operations can be decomposed into simpler ones.

### 214. [Set Matrix Zeroes — #73](https://leetcode.com/problems/set-matrix-zeroes/)

- **Difficulty:** Medium | **Pattern:** Use first row/column as markers (O(1) space)
- **Why:** Record which rows/cols need zeroing using the matrix itself. O(1) space by using the first row and column as flag arrays. A clean space optimization that tests in-place manipulation thinking.

---

# 📊 Master Statistics

|Topic|Subtopics|Problems|
|---|---|---|
|Arrays|Fundamentals, Prefix Sum, Two Pointers, Sliding Window|28|
|Strings|Manipulation, Palindromes, Pattern Matching|14|
|Hashing|HashMap patterns, Design|10|
|Binary Search|Classic, On Condition, On Answer Space|12|
|Linked Lists|Traversal, Fast/Slow, Reversal, Design|12|
|Stacks|Basics, Monotonic, Expression Parsing|11|
|Queues & Deques|Design, Monotonic Deque|4|
|Trees|Pre/Post/In-order DFS, BFS, BST, Construction|22|
|Tries|Design, Wildcard, Grid|3|
|Heaps|Top-K, Two Heaps, K-way Merge|8|
|Graphs — DFS|Grid, Components, Cycles|9|
|Graphs — BFS|Grid, Multi-source, State Space|8|
|Graphs — Topological Sort|Kahn's, DFS coloring|4|
|Graphs — Union Find|DSU, MST, Merging|5|
|Graphs — Shortest Path|Dijkstra, Bellman-Ford, Floyd-Warshall|5|
|DP — 1D|Fibonacci, Decision, Unbounded|12|
|DP — 2D|Grid, Sequence, String|8|
|DP — Intervals|Range, Palindrome|4|
|DP — Knapsack|0/1, Unbounded, 2D|5|
|Intervals & Greedy|Merge, Schedule, Activity Selection|7|
|Backtracking|Subsets, Permutations, Constraint|10|
|Bit Manipulation|XOR, Counting, Carry|7|
|Math & Simulation|Modular, Exponentiation, Matrix|6|
|**TOTAL**|**23 topics, 50+ subtopics**|**~214 problems**|

---

# 🔑 The 12 Meta-Patterns That Unlock Everything

> See a new problem → run it through this checklist → land on the right approach within 60 seconds.

|#|Meta-Pattern|Trigger Words|Go-To Tool|
|---|---|---|---|
|1|**Reduce to a previous state**|"subarray with sum K", "pair that equals target"|Prefix sum + HashMap|
|2|**Expand/shrink window**|"longest/shortest subarray/substring with constraint"|Sliding window|
|3|**Sort to enable greedy**|"pairs", "intervals", "K closest"|Sort first|
|4|**Reverse the problem**|"which cells can reach border?", "reachability"|DFS/BFS from destination|
|5|**Model as a graph**|"dependencies", "connected", "shortest path"|BFS/DFS/Dijkstra|
|6|**Binary search on answer**|"minimum X such that condition holds", "maximum K days"|BS on answer space|
|7|**Post-order = return value up**|"diameter", "path sum", "LCA"|Post-order DFS + global variable|
|8|**Choose / recurse / unchoose**|"all combinations", "all paths", "generate all"|Backtracking|
|9|**Trade space for time**|"O(n) time", "seen before?", "count of X"|HashMap/HashSet|
|10|**One pass, multiple pointers**|"in-place", "O(1) space", "cycle", "midpoint"|Two/fast-slow pointers|
|11|**Monotonic structure**|"next greater", "visible buildings", "window max"|Monotonic stack/deque|
|12|**Think about the last action**|"burst balloons", "matrix chain", "parenthesization"|Interval DP|

---

# 📋 Suggested Study Order

```
Week 1-2:  Arrays (1.1-1.4) + Hashing (3)
Week 3:    Strings (2) + Binary Search (4)
Week 4:    Linked Lists (5) + Stacks (6) + Queues (7)
Week 5-6:  Trees (8) + Tries (9) + Heaps (10)
Week 7-8:  Graphs DFS (11) + BFS (12) + Toposort (13) + Union Find (14) + Shortest Path (15)
Week 9-10: DP 1D (16) + DP 2D (17) + DP Intervals (18) + DP Knapsack (19)
Week 11:   Intervals & Greedy (20) + Backtracking (21)
Week 12:   Bit Manipulation (22) + Math (23) + Review weak areas
```

---

_Version 2.0 | Updated 2026 | ~214 problems | Free-tier LeetCode + NeetCode.io_ _Problems marked (NeetCode free) are available at neetcode.io at no cost._