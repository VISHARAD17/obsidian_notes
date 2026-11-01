## 📂 1 — Arrays

### 1.1 — Array Fundamentals

**1. Contains Duplicate — #217** ✅
Difficulty: Easy | Pattern: HashSet for O(1) lookup
Why: The simplest trade-space-for-time problem. The set.add() returns false on duplicate pattern is reused in 40+ problems. Always the first question to warm up.

**2. Move Zeroes — #283**
Difficulty: Easy | Pattern: Read/Write two pointers (in-place partition)
Why: The read-pointer scans, write-pointer places valid elements. This partition mechanic is the foundation of QuickSort, Remove Duplicates, and Dutch National Flag.

**3. Find All Numbers Disappeared in an Array — #448**
Difficulty: Easy | Pattern: Index-as-hash (negation marking), O(1) space
Why: Teaches using the array itself as a hash map. Values bounded by [1,n] → use index nums[i]-1 as the key. This O(1) space trick recurs in #287 and any "bounded value" problem.

**4. Best Time to Buy and Sell Stock — #121** ✅
Difficulty: Easy | Pattern: Running minimum + greedy single pass
Why: Track minPrice and maxProfit in one scan. This "track running optimal" pattern spawns a 6-problem series. The state-machine thinking here is essential before tackling the harder stock variants.

**5. Maximum Subarray — #53** ✅
Difficulty: Medium | Pattern: Kadane's Algorithm
Why: At each index: extend current subarray OR start fresh. dp[i] = max(nums[i], dp[i-1] + nums[i]). A gateway to 1D DP. Interviewers will ask you to modify this — circular variant #918, or return the actual subarray.

**6. Product of Array Except Self — #238** ✅
Difficulty: Medium | Pattern: Prefix product + suffix product, no division
Why: Thinking in two passes — forward and backward — is a recurring trick. The "no division" constraint forces the prefix/suffix pattern that also appears in trapping rain water and histogram problems.

**7. Find the Duplicate Number — #287** ✅
Difficulty: Medium | Pattern: Floyd's cycle detection (array as implicit graph)
Why: The array nums[i] defines a pointer graph. Applying fast/slow pointers on an array is a key meta-skill — learning to model a problem in a different domain. O(1) space with no modification to input.

**8. Maximum Product Subarray — #152**
Difficulty: Medium | Pattern: DP tracking both max and min simultaneously
Why: Negative × negative = positive, so you must track both maxSoFar and minSoFar. The "track both extremes" DP pattern appears wherever sign flips can occur.

**9. Rotate Array — #189**
Difficulty: Medium | Pattern: Triple reverse trick (in-place rotation)
Why: Reverse whole array → reverse first k → reverse rest. This O(1) space rotation is a common follow-up in array manipulation interviews and models circular buffer rotation.

**10. Majority Element — #169** 🆕
Difficulty: Easy | Pattern: Boyer-Moore voting algorithm
Why: Maintain a candidate and a count; increment on match, decrement otherwise. O(1) space with no sorting or hashing. A genuinely surprising algorithm that interviewers love because the correctness proof is non-obvious. Fills the voting-algorithm gap.

**11. Majority Element II — #229** 🆕
Difficulty: Medium | Pattern: Generalized Boyer-Moore (two candidates for >n/3)
Why: Extends #169 to find all elements appearing more than n/3 times. At most two can exist → track two candidates simultaneously, then verify in a second pass. Teaches generalizing an algorithm from k=2 to arbitrary k.

**12. First Missing Positive — #41**
Difficulty: Hard | Pattern: Index-as-hash (cyclic sort / placement)
Why: The hardest "index-as-hash" problem. Place each number at its correct index (nums[i]-1), then scan for the first mismatch. O(n) time, O(1) space. A top-tier interview problem that tests deep array manipulation thinking.

### 1.2 — Prefix Sums

**13. Running Sum of 1D Array — #1480**
Difficulty: Easy | Pattern: Prefix sum in-place
Why: Purest intro. prefix[i] = prefix[i-1] + nums[i]. Internalize this before everything else in this section.

**14. Range Sum Query — Immutable #303**
Difficulty: Easy | Pattern: Precomputed prefix array → O(1) range query
Why: Forces you to think about precomputation. Build once, query many times. This is how backend systems work — cache the expensive computation. Bridges to 2D prefix sums.

**15. Subarray Sum Equals K — #560**
Difficulty: Medium | Pattern: Prefix sum + HashMap (sum → count)
Why: A landmark problem. "Have I seen currentSum - k before?" destroys the O(n²) brute force instinct. This exact pattern appears in subarray divisibility, matrix path sums, and financial ledger problems.

**16. Subarray Sums Divisible by K — #974** 🆕
Difficulty: Medium | Pattern: Prefix sum modulo + HashMap (remainder → count)
Why: The modular arithmetic sibling of #560. Two prefix sums with the same remainder mod k bracket a divisible subarray. Handling negative remainders ((r % k + k) % k) is the classic bug here. Completes the prefix-sum-with-hashmap family.

**17. Contiguous Array — #525**
Difficulty: Medium | Pattern: Prefix sum with +1/-1 encoding + HashMap
Why: Convert 0s to -1s. Now "equal 0s and 1s" → "prefix sum = 0" or "two equal prefix sums." The encoding trick (transform the problem domain) is powerful and reusable.

**18. XOR Queries of a Subarray — #1310**
Difficulty: Medium | Pattern: Prefix XOR for O(1) range XOR queries
Why: Same concept as prefix sum but with XOR. prefixXOR[i] ^ prefixXOR[j] gives XOR of range [i,j]. Appears in competitive rounds and bit manipulation interviews.

**19. Range Sum Query 2D — Immutable #304** 🆕
Difficulty: Medium | Pattern: 2D prefix sum (integral image) + inclusion-exclusion
Why: sum(r1,c1,r2,c2) = P[r2][c2] - P[r1-1][c2] - P[r2][c1-1] + P[r1-1][c1-1]. The inclusion-exclusion formula is the single most important 2D precomputation technique. Your 1D prefix sums were covered but 2D was entirely missing — this is a real gap for matrix problems.

**20. Matrix Block Sum — #1314** 🆕
Difficulty: Medium | Pattern: 2D prefix sum with clamped boundaries
Why: Apply #304's formula for every cell with a k-radius window, clamping indices at the matrix edges. The boundary clamping (Math.max/Math.min) is where everyone gets it wrong. Solidifies 2D prefix sums through repetition.

**21. Minimum Size Subarray Sum — #209**
Difficulty: Medium | Pattern: Variable sliding window (shrink when valid)
Why: Conceptually a prefix-sum problem but the sliding window is the right tool. "Shrink when valid" vs "shrink when invalid" is the key variable-window distinction.

### 1.3 — Two Pointers

**22. Two Sum II — Sorted Array #167**
Difficulty: Easy | Pattern: Opposite-end two pointers on sorted array
Why: Left + right converge based on sum comparison. Foundation for 3Sum, 4Sum, Container With Most Water. The simplest possible two-pointer problem.

**23. 3Sum — #15**
Difficulty: Medium | Pattern: Sort + two pointers + deduplication
Why: Sort, fix one element, two-pointer the rest. The while(nums[l]==nums[l-1]) l++ dedup line is a micro-pattern that appears everywhere. Solving this makes all k-Sum trivial.

**24. 3Sum Closest — #16**
Difficulty: Medium | Pattern: Sort + two pointers, track closest sum
Why: A natural extension of #15 — instead of exact match, track minimum difference. Reinforces two-pointer mechanics and teaches "closest value" tracking.

**25. Container With Most Water — #11**
Difficulty: Medium | Pattern: Two pointers — always move the bottleneck
Why: You always move the shorter pointer because that's the limiting factor. This "move the constraint" greedy reasoning appears in interval scheduling and capacity planning problems.

**26. Trapping Rain Water — #42**
Difficulty: Hard | Pattern: Two pointers with running max from both ends
Why: Water at index i = min(maxLeft, maxRight) - height[i]. Two-pointer approach eliminates the need for prefix/suffix arrays. Appears at FAANG onsites. Can also solve with monotonic stack — knowing both approaches is valuable.

**27. Sort Colors — #75**
Difficulty: Medium | Pattern: Dutch National Flag — 3-way partition
Why: low, mid, high three pointers. Partition into 3 groups in one pass. This exact mechanic is QuickSort's 3-way partition and appears in any "categorize in-place" problem.

### 1.4 — Sliding Window

**28. Maximum Average Subarray I — #643**
Difficulty: Easy | Pattern: Fixed-size sliding window
Why: Build first window, then slide: subtract left element, add right element. The simplest possible fixed window. Understand this before any variable window.

**29. Longest Substring Without Repeating Characters — #3**
Difficulty: Medium | Pattern: Variable sliding window + HashSet
Why: int left=0; for(int right=0; right<n; right++) — this skeleton is reused in 20+ problems. "Expand right, shrink left when invalid." Non-negotiable.

**30. Permutation in String — #567**
Difficulty: Medium | Pattern: Fixed window + frequency match counter
Why: Instead of comparing int[26] arrays each step, maintain a matches counter. O(1) window validity check. This optimization technique is used in Minimum Window Substring and Find All Anagrams.

**31. Find All Anagrams in a String — #438**
Difficulty: Medium | Pattern: Fixed window + frequency matching, collect all results
Why: Same as #567 but collects all valid windows. Solidifies the "maintain matches counter" pattern with result collection.

**32. Longest Repeating Character Replacement — #424**
Difficulty: Medium | Pattern: Variable window + lazy maxFreq tracking
Why: Window is valid if windowSize - maxFreq <= k. The trick of not reducing maxFreq when shrinking (lazy update) is non-obvious but critical. This "lazy shrink" pattern recurs in harder problems.

**33. Max Consecutive Ones III — #1004** 🆕
Difficulty: Medium | Pattern: Variable window — "at most k zeros" reframing
Why: "Flip at most k zeros to maximize the ones run" = "longest window containing at most k zeros." The reframing from an operation-count constraint to a window-content constraint is the key insight, and it's the cleanest version of the pattern behind #424.

**34. Longest Substring with At Most K Distinct Characters — #340**
Difficulty: Medium | Pattern: Variable sliding window + HashMap (char → count)
Why: Shrink window when distinct count > k. The "at most K distinct" sliding window is a high-frequency pattern at Google and Amazon. Generalizes to Fruit Into Baskets (#904).

**35. Subarrays with K Different Integers — #992** 🆕
Difficulty: Hard | Pattern: "Exactly K" = atMost(K) − atMost(K−1)
Why: **The single most important sliding-window meta-trick.** You cannot directly slide a window for "exactly K" — but exactly(K) = atMost(K) − atMost(K−1), and atMost is a standard window. This decomposition was completely missing from your sheet and it unlocks an entire problem class.

**36. Binary Subarrays With Sum — #930** 🆕
Difficulty: Medium | Pattern: "Exactly K" decomposition (atMost) or prefix-sum HashMap
Why: The easier drill for #992's trick — apply exactly(S) = atMost(S) − atMost(S−1) on a binary array. Also solvable with #560's prefix-sum map, so it directly connects the two "count subarrays" toolkits.

**37. Subarray Product Less Than K — #713**
Difficulty: Medium | Pattern: Sliding window with product tracking, count subarrays
Why: Maintain a running product; shrink window when product ≥ k. Count subarrays ending at each right pointer (`right - left + 1`). The "count subarrays" variant is a distinct sub-pattern from "find longest/shortest."

**38. Minimum Window Substring — #76**
Difficulty: Hard | Pattern: Variable window — shrink aggressively once valid
Why: The hardest sliding window problem. Must have correct characters AND correct counts. The "have/need" counter with a required characters map is the full sliding window toolkit. After this, all sliding window problems are in reach.

**39. Sliding Window Maximum — #239**
Difficulty: Hard | Pattern: Monotonic Deque (decreasing)
Why: Deque stores indices of candidates in decreasing value order. Front = current window max. This O(n) pattern solves all "window maximum/minimum aggregate" problems.
↪ Also the anchor problem for §7.2 Monotonic Deque.

---

## 📂 2 — Strings

### 2.1 — String Manipulation

**40. Reverse Words in a String — #151**
Difficulty: Medium | Pattern: Split, trim, reverse
Why: Tests handling edge cases — multiple spaces, leading/trailing spaces. In Java: s.trim().split("\\s+") vs manual two-pointer reverse. Both approaches tested. Classic phone screen.

**41. Longest Common Prefix — #14**
Difficulty: Easy | Pattern: Vertical scanning / horizontal folding
Why: Systematic string comparison across an array. The "fold/reduce" approach mirrors Trie prefix queries conceptually. Gateway to Trie design.

**42. String to Integer (atoi) — #8**
Difficulty: Medium | Pattern: Deterministic parser / state machine
Why: Overflow detection (result > Integer.MAX_VALUE / 10), sign, whitespace. Backend engineers write parsers — this tests rigorous defensive coding. Every edge case matters.

**43. Roman to Integer — #13**
Difficulty: Easy | Pattern: HashMap lookup + lookahead rule
Why: "If current < next, subtract; else add." The lookahead/lookbehind in string traversal is a recurring micro-pattern in parsing problems.

**44. Zigzag Conversion — #6**
Difficulty: Medium | Pattern: Index simulation with direction flag
Why: Simulate row assignment using a direction variable. Tests clean simulation thinking — a common machine-coding round skill.

**45. Count and Say — #38**
Difficulty: Medium | Pattern: Iterative string generation (run-length encoding)
Why: Build each sequence from the previous one by scanning for consecutive characters. Models run-length encoding — directly relevant to compression algorithms.

**46. String Compression — #443** 🆕
Difficulty: Medium | Pattern: In-place run-length encoding with read/write pointers
Why: The in-place version of #38's idea, combined with #283's read/write pointer partition. Writing multi-digit counts back into the same array in O(1) space is a precision test that interviewers use to separate careful coders from sloppy ones.

**47. Sort Characters By Frequency — #451** 🆕
Difficulty: Medium | Pattern: Frequency map + bucket sort / heap on counts
Why: Count, then order by count descending, then rebuild. Directly reuses #347's bucket-sort-on-frequency machinery in a string context, which is exactly the kind of pattern transfer interviews probe.

### 2.2 — Palindromes

**48. Valid Palindrome — #125**
Difficulty: Easy | Pattern: Two pointers + character filtering
Why: Character.isLetterOrDigit() + two pointers from both ends. The entry point to all palindrome problems.

**49. Longest Palindromic Substring — #5**
Difficulty: Medium | Pattern: Expand-around-center (odd and even centers)
Why: Two center types (single char, between chars). Expanding outward is cleaner and more intuitive than 2D DP. Teaches that a mathematical insight can beat a DP table.
↪ Also the entry point to §18 Interval DP via its O(n²) table formulation.

**50. Palindromic Substrings — #647**
Difficulty: Medium | Pattern: Expand-around-center, count all
Why: Extends #5 — count all valid palindromes. Solidifies both odd/even center handling. Together, #5 and #647 cover every palindrome interview question variant.

**51. Valid Palindrome II — #680**
Difficulty: Easy | Pattern: Two pointers + one allowed deletion
Why: On mismatch, try skipping left OR right character and check if either is a palindrome. This "try both options on mismatch" pattern appears in several string problems with tolerance.

### 2.3 — Pattern Matching & Encoding

**52. Encode and Decode Strings — #271**
Difficulty: Medium | Pattern: Length-prefix protocol (len#string)
Why: Delimiter-safe serialization. How do you encode a list of strings containing any character? This is how wire protocols work. Tests real-world engineering thinking over algorithmic tricks.

**53. Find the Index of the First Occurrence in a String — #28**
Difficulty: Easy | Pattern: Sliding window string match → Rabin-Karp rolling hash → KMP
Why: Do this problem **three ways**. (1) Brute force teaches the window comparison mechanic and why it's O(n×m). (2) Rabin-Karp's polynomial rolling hash compares substrings in O(1) — used in plagiarism detection, DNA matching, and distributed deduplication. (3) KMP in true O(n+m). Google-level interviews expect at least two of these.

**54. Longest Happy Prefix — #1392** 🆕
Difficulty: Hard | Pattern: KMP prefix function (failure array) — build it explicitly
Why: **Your sheet mentioned KMP three times but never made you build the failure function.** This problem is *nothing but* the prefix function — the answer is `pi[n-1]`. Implement it standalone here and #28's KMP variant becomes trivial. Non-negotiable for closing the string-matching gap.

**55. Shortest Palindrome — #214** 🆕
Difficulty: Hard | Pattern: KMP prefix function on s + '#' + reverse(s)
Why: The clever application of #1392's machinery: the longest palindromic prefix equals the prefix function of the concatenation. Teaches that KMP is a general "longest border" tool, not just a substring searcher. Cements the technique.

**56. Repeated Substring Pattern — #459**
Difficulty: Easy | Pattern: String doubling trick / KMP failure function
Why: (s + s).substring(1, 2n-1).contains(s) — the string doubling trick is elegant and instructive. Also solvable via the prefix function (n % (n - pi[n-1]) == 0), which connects it to #1392.

**57. Group Anagrams — #49**
Difficulty: Medium | Pattern: HashMap with canonical key (sorted string or char-count)
Why: Design a hashing key that captures equivalence. Sorted string key vs int[26] char-count key — knowing both and their trade-offs is a strong signal. "Canonical form as key" appears in many grouping problems.

---

## 📂 3 — Hashing

### 3.1 — Core HashMap Patterns

**58. Two Sum — #1**
Difficulty: Easy | Pattern: HashMap (value → index), complement lookup
Why: Problem #1 for a reason. map.containsKey(target - nums[i]) is the most reused snippet in DSA. Every "find pair with constraint" problem is a Two Sum variant.

**59. Valid Anagram — #242**
Difficulty: Easy | Pattern: int[26] character frequency comparison
Why: Teaches the int[26] trick as a fast O(1)-space alternative to HashMap<Character, Integer>. This frequency-comparison pattern is used in all sliding window anagram problems.

**60. Top K Frequent Elements — #347**
Difficulty: Medium | Pattern: HashMap + bucket sort (or min-heap)
Why: Bucket sort: index = frequency, value = list of elements. O(n) solution. Also solvable with min-heap O(n log k). Teaches thinking about the frequency of frequencies.

**61. Longest Consecutive Sequence — #128**
Difficulty: Medium | Pattern: HashSet + sequence-start detection
Why: Only start counting from sequence starts (!set.contains(n-1)). Converts O(n log n) sort into O(n). Teaches using a HashSet to simulate sorted order without sorting.

**62. Valid Sudoku — #36**
Difficulty: Medium | Pattern: Multi-dimensional HashSet constraint validation
Why: Three sets — rows, columns, boxes. Box index formula: (r/3)*3 + c/3. Systematic constraint validation across multiple dimensions. Models backend rule-engine validation.

**63. First Unique Character in a String — #387**
Difficulty: Easy | Pattern: Frequency array + second pass
Why: Simple two-pass problem: count frequencies, then find first with count=1. Teaches that two passes at O(n) each is still O(n) total — a common optimization mindset.

**64. Ransom Note — #383**
Difficulty: Easy | Pattern: Character frequency difference check
Why: Check if one string's character counts are a subset of another's. Foundation for all "can we form X from Y?" problems.

**65. Word Pattern — #290**
Difficulty: Easy | Pattern: Bijection mapping (two-way HashMap)
Why: Both pattern → word AND word → pattern mappings must be consistent. The bijection check with two HashMaps is a recurring pattern in isomorphism problems (#205).

### 3.2 — HashMap Design Problems

**66. LRU Cache — #146**
Difficulty: Medium | Pattern: HashMap + Doubly Linked List, O(1) get & put
Why: The most important data structure design problem for backend engineers. LRU is used in Redis, database buffer pools, and CDN eviction. HashMap gives O(1) lookup; DLL gives O(1) move-to-front and evict-last. A career-defining problem.
↪ Also belongs to §5 Linked Lists (the DLL half) and §26 Design.

**67. LFU Cache — #460**
Difficulty: Hard | Pattern: HashMap + frequency map + doubly linked list per frequency
Why: Extends LRU with frequency-based eviction. On tie, evict least recently used among least frequent. Tests multi-level data structure design. Asked at Google and Amazon for senior roles.

**68. Insert Delete GetRandom O(1) — #380**
Difficulty: Medium | Pattern: HashMap + ArrayList for O(1) random access
Why: Delete in O(1) from an array by swapping with the last element then removing. HashMap tracks indices. This "swap-with-last-delete" pattern is used in dynamic random sampling — relevant to load balancers and A/B testing systems.

---

## 📂 4 — Binary Search

### 4.1 — Classic Binary Search

**69. Binary Search — #704**
Difficulty: Easy | Pattern: while(left<=right), overflow-safe mid
Why: Get the template exactly right. mid = left + (right-left)/2. The <= vs <, and left=mid+1 vs left=mid distinctions are critical. Every other BS problem is a variation.

**70. Search Insert Position — #35**
Difficulty: Easy | Pattern: Binary search — leftmost insertion point
Why: When the loop ends, left is always the insertion position. This property (left = answer when element not found) is used in 90% of advanced BS problems.

**71. First Bad Version — #278** ✅
Difficulty: Easy | Pattern: Binary search — find first true in boolean sequence
Why: The condition switches from false to true at one point — find that boundary. This "find the boundary between false/true" is the most common BS pattern in real-world code (version control, feature flags, A/B tests).

**72. Search a 2D Matrix — #74** 🔄
Difficulty: Medium | Pattern: Binary search on flattened 2D index
Why: mid maps to (mid/cols, mid%cols). Treats the 2D matrix as a 1D sorted array. This index-mapping trick appears in all matrix binary search problems.

**73. Search a 2D Matrix II — #240** 🆕
Difficulty: Medium | Pattern: Staircase search from top-right corner
Why: When rows and columns are each sorted but the matrix isn't globally sorted, #74's flattening **fails**. Start top-right: move left if too big, down if too small — O(m+n). Knowing *why* the flattening breaks here is the whole lesson, and it's a very common follow-up to #74.

**74. Sqrt(x) — #69**
Difficulty: Easy | Pattern: Binary search on integer answer range
Why: Find largest k such that k*k <= x. A gentle intro to binary searching on an answer range (not an array). Gateway to the "binary search on answer" family.

**75. Median of Two Sorted Arrays — #4**
Difficulty: Hard | Pattern: Binary search on partition point of two arrays
Why: The hardest binary search problem. Binary search on the smaller array's partition; the other partition is derived. O(log(min(m,n))). A top-5 FAANG hard problem — tests deep binary search mastery and edge case handling.

### 4.2 — Binary Search on Condition (Rotated Arrays)

**76. Find Minimum in Rotated Sorted Array — #153**
Difficulty: Medium | Pattern: BS on condition — find inflection point
Why: No target needed. nums[mid] > nums[right] tells you which half has the minimum. Teaches BS on a property, not equality.

**77. Search in Rotated Sorted Array — #33**
Difficulty: Medium | Pattern: BS — identify sorted half, check if target is in it
Why: One half is always sorted. Check if target falls in the sorted half; go there if yes, else go opposite. Classic FAANG phone-screen.

**78. Search in Rotated Sorted Array II — #81**
Difficulty: Medium | Pattern: Rotated BS with duplicates — handle nums[left]==nums[mid]
Why: Duplicates make the sorted-half check ambiguous. The fix: left++ to skip. Tests robustness of your BS reasoning under edge cases.

**79. Find Peak Element — #162**
Difficulty: Medium | Pattern: BS on local property (move toward the rising slope)
Why: If nums[mid] < nums[mid+1], the peak is to the right; else to the left. Teaches BS on a non-sorted array where a local condition guides direction.

### 4.3 — Binary Search on Answer Space

**80. Koko Eating Bananas — #875**
Difficulty: Medium | Pattern: BS on answer — find minimum k satisfying condition
Why: The most important BS insight: binary search on the answer itself. "Find minimum X such that f(X) is true and f is monotonic." This template solves #1011, #410, #1231, and many more.

**81. Capacity to Ship Packages Within D Days — #1011**
Difficulty: Medium | Pattern: BS on answer — minimum capacity
Why: Same template as #875. Binary search on capacity; simulate to check feasibility. Reinforces the "answer space BS" template on a slightly harder feasibility function.

**82. Split Array Largest Sum — #410**
Difficulty: Hard | Pattern: BS on answer — minimize the maximum subarray sum
Why: Binary search on the answer (max sum allowed), greedy check if we can split into ≤ k subarrays. The "minimize the maximum" pattern is a FAANG favorite — appears in painter's partition, book allocation, and load balancing.

**83. Time Based Key-Value Store — #981**
Difficulty: Medium | Pattern: HashMap + BS on timestamps (floor value)
Why: A real-world system design problem — versioned key-value stores, audit logs, event sourcing. BS finds the largest timestamp ≤ query. Bridges data structures and binary search.

### 4.4 — Ordered Sets & TreeMap (Balanced BST as a tool)

**84. My Calendar I — #729** 🆕
Difficulty: Medium | Pattern: TreeMap floorKey/ceilingKey for interval overlap
Why: **Your sheet had no TreeMap/ordered-set problems at all** — a significant gap, because "query the nearest key ≤ x" is a primitive you can't build from HashMap. floorEntry/ceilingEntry checks make overlap detection O(log n). This is the gateway to the ordered-set toolkit.

**85. Contains Duplicate III — #220** 🆕
Difficulty: Hard | Pattern: TreeSet within a sliding window (value-range + index-range)
Why: Two constraints at once: indices within k, values within t. A TreeSet holds the window and `subSet`/`ceiling` answers the value-range query. The fusion of sliding window with an ordered set is a genuinely hard technique combination — and it completes the #217/#219/#220 family you'd only half-covered.

**86. Sliding Window Median — #480** 🆕
Difficulty: Hard | Pattern: Two heaps with lazy deletion, or TreeSet of indices
Why: The streaming median (#295) but with **removal** — which naive heaps can't do. Forces you to learn lazy deletion or an indexed ordered set. This "supporting deletion" problem is the natural hard follow-up to #295 and was missing entirely.

---

## 📂 5 — Linked Lists

### 5.1 — Traversal & Manipulation

**87. Reverse Linked List — #206**
Difficulty: Easy | Pattern: Iterative pointer reversal (prev/curr/next)
Why: The prev=null; while(curr!=null){next=curr.next; curr.next=prev; prev=curr; curr=next;} skeleton is the most reused LL snippet. Also learn the recursive version for call-stack thinking.

**88. Merge Two Sorted Lists — #21**
Difficulty: Easy | Pattern: Dummy head + two-pointer merge
Why: The dummy head node eliminates head-node edge cases entirely. This is one of the most important LL tricks. The merge logic is used in Merge K Sorted Lists and Merge Sort.

**89. Remove Nth Node From End — #19**
Difficulty: Medium | Pattern: N-gap two pointers + dummy head
Why: Fast pointer advances N steps, then both move together. When fast hits null, slow is at the target. Dummy head handles removing the head node. Tests precise off-by-one reasoning.

**90. Swap Nodes in Pairs — #24**
Difficulty: Medium | Pattern: Iterative pointer re-wiring
Why: Teaches careful prev → second → first → next re-wiring. Builds the pointer manipulation precision needed for Reverse Nodes in K-Group (#25), a common hard follow-up.

**91. Reverse Nodes in k-Group — #25**
Difficulty: Hard | Pattern: Reversal in segments + connection
Why: Combines #206 (reverse a sublist) with careful segment boundary tracking. A top-tier pointer manipulation problem. Tests whether you can compose linked list operations cleanly.

**92. Sort List — #148** 🆕
Difficulty: Medium | Pattern: Merge sort on a linked list (find mid + merge), O(1) extra space
Why: **The only place you actually implement a sorting algorithm end-to-end.** Composes #876 (find middle) with #21 (merge) into full merge sort. Merge sort is the natural LL sort because it needs no random access — understanding *why* QuickSort is wrong here is the interview discussion.

### 5.2 — Fast & Slow Pointers

**93. Linked List Cycle — #141**
Difficulty: Easy | Pattern: Floyd's fast/slow pointer (cycle detection)
Why: slow=slow.next; fast=fast.next.next — they meet if and only if there's a cycle. The canonical fast/slow problem. O(n) time, O(1) space.

**94. Linked List Cycle II — #142**
Difficulty: Medium | Pattern: Floyd's — find cycle entry point
Why: After meeting, reset one pointer to head. Both advance at speed 1 — they meet at the cycle entry. Understanding why this works builds mathematical reasoning. Used in #287 (array duplicate).

**95. Middle of the Linked List — #876**
Difficulty: Easy | Pattern: Fast/slow — midpoint
Why: When fast reaches end, slow is at mid. This midpoint subroutine is used in Merge Sort on LL (#148), Palindrome LL, and Reorder List.

**96. Palindrome Linked List — #234**
Difficulty: Easy | Pattern: Find middle + reverse second half + compare
Why: Composes three separate patterns: #876 + #206 + two-pointer compare. A multi-step composition problem — the skill of combining patterns cleanly is what separates strong from average candidates.

**97. Intersection of Two Linked Lists — #160**
Difficulty: Easy | Pattern: Two pointers with path-length equalization
Why: Pointer A traverses listA then listB; pointer B traverses listB then listA. They meet at the intersection (or both reach null). Elegant O(1) space solution. Frequently asked at Amazon and Microsoft.

### 5.3 — Composition & Design

**98. Reorder List — #143**
Difficulty: Medium | Pattern: Find mid + reverse second half + merge alternating
Why: The ultimate LL composition problem — three algorithms in sequence, zero extra space. Clean implementation here signals mastery.

**99. Merge K Sorted Lists — #23**
Difficulty: Hard | Pattern: Min-heap (PriorityQueue) + dummy head
Why: `PriorityQueue<ListNode>((a,b)->a.val-b.val)` — custom comparator on a node. Models K-way merge used in databases, log aggregation, and distributed sort. The divide-and-conquer alternative teaches Merge Sort thinking.
↪ Also the anchor K-way-merge problem for §10 Heaps.

**100. Copy List with Random Pointer — #138**
Difficulty: Medium | Pattern: HashMap (original → clone) or O(1)-space interleaving
Why: Deep copy a linked list where each node has a random pointer. The interleaving approach (weave clones between originals, then split) is a beautiful technique. Tests pointer manipulation at its finest. Common at Meta.
↪ 3.2 #66 LRU Cache is also a core linked-list design problem (HashMap + DLL).

## 📂 6 — Stacks

### 6.1 — Stack Basics

**101. Valid Parentheses — #20**✅ 
Difficulty: Easy | Pattern: Stack for bracket matching
Why: The canonical stack problem. Push opens, pop on close and verify match. Edge cases: empty stack on close, non-empty stack at end. This pattern is the foundation of all expression parsing.

**102. Min Stack — #155**.✅ 
Difficulty: Medium | Pattern: Auxiliary stack tracking running minimum
Why: A parallel minStack stores the minimum at each level. O(1) getMin(). The "augmented stack" pattern — storing metadata alongside data — appears in stock span, histogram, and monotonic stack problems.

**103. Implement Stack using Queues — #225**.  ✅ 
Difficulty: Easy | Pattern: Simulate stack with queue rotation
Why: Teaches deep understanding of LIFO vs FIFO by forcing you to simulate one with the other. Pairs with #232 (queue using stacks). Both are classic amortized complexity questions.
↪ Also a §26 Design problem.

**104. Minimum Remove to Make Valid Parentheses — #1249**.  ✅ 
Difficulty: Medium | Pattern: Stack for index tracking + string rebuild
Why: Stack tracks indices of unmatched parentheses. Remove them in a second pass. A practical string + stack problem asked frequently at Meta. Models input sanitization and validation.

**105. Longest Valid Parentheses — #32** ✅ 
Difficulty: Hard | Pattern: Stack of indices with a −1 sentinel, or DP
Why: Stack stores indices of unmatched brackets; the gap between the current index and the stack top gives valid length. Also solvable with DP. Combines stack mastery with careful index tracking. Top FAANG hard problem, and the natural culmination of #20 → #1249 → #32.

### 6.2 — Monotonic Stack

**106. Daily Temperatures — #739** ✅ 
Difficulty: Medium | Pattern: Monotonic decreasing stack (Next Greater Element)
Why: The gateway to monotonic stacks. Stack stores indices waiting for their "next greater" answer. When we find it, pop and record distance. This skeleton solves every "next greater/smaller element" problem.

**107. Next Greater Element I — #496**
Difficulty: Easy | Pattern: Monotonic stack + HashMap for cross-array lookup
Why: Precompute NGE for nums2 into a HashMap, then answer queries for nums1 in O(1). Bridges monotonic stacks with hashing — a combo that appears in many interview problems.

**108. Next Greater Element II — #503**
Difficulty: Medium | Pattern: Monotonic stack on circular array (modular index)
Why: Process array twice using i % n. Teaching circular array handling with a monotonic stack — the same modular trick appears in circular DP and queue problems.

**109. Car Fleet — #853**
Difficulty: Medium | Pattern: Sort + stack to simulate merging events
Why: Sort by position descending, compute arrival time. If a car arrives before the car ahead, it merges into that fleet. Stack represents current fleets. Models real-world event merging (network packets, process batches).

**110. Largest Rectangle in Histogram — #84**
Difficulty: Hard | Pattern: Monotonic increasing stack (prev/next smaller element)
Why: For each bar, the stack finds the nearest smaller bar on both sides, determining max width. The most instructive hard stack problem — it teaches both "previous smaller" and "next smaller" in one pass. Unlocks #85.

**111. Sum of Subarray Minimums — #907**
Difficulty: Medium | Pattern: Monotonic stack — contribution technique
Why: For each element, calculate how many subarrays it's the minimum of using previous-less and next-less-or-equal. The "contribution" technique (how much does each element contribute to the total?) is a powerful pattern for sum-of-subarray-X problems. FAANG favorite.

**112. Maximal Rectangle — #85**
Difficulty: Hard | Pattern: Histogram per row + Largest Rectangle in Histogram
Why: Build a histogram for each row, then apply #110. Reduces a 2D problem to repeated 1D problems. This "reduce dimension" technique is a key problem-solving meta-skill.

### 6.3 — Expression Parsing

**113. Evaluate Reverse Polish Notation — #150**
Difficulty: Medium | Pattern: Stack-based RPN evaluation
Why: Push numbers, pop two on operator. The cleanest expression-evaluation problem. Backend engineers build calculators, rule engines, and query parsers — this is the algorithmic core.

**114. Basic Calculator II — #227**
Difficulty: Medium | Pattern: Stack with operator precedence (no parentheses)
Why: Handle * and / before + and - using a stack. On +/-, push; on *//, pop and compute. A realistic parser that models how compilers handle operator precedence.

**115. Decode String — #394**
Difficulty: Medium | Pattern: Two stacks (count stack + string stack) for nested decoding
Why: Nested brackets require unwinding. Two stacks — one for multipliers, one for string segments. The nested-structure decoding pattern is how you'd parse JSON, XML, or recursive data formats.

---

## 📂 7 — Queues & Deques

### 7.1 — Queue Design

**116. Implement Queue using Stacks — #232**
Difficulty: Easy | Pattern: Amortized O(1) queue via lazy transfer
Why: Pour from inbox to outbox only when outbox is empty. Total pours = total pushes → amortized O(1). Tests understanding of amortized complexity — a common interview topic.

**117. Design Circular Queue — #622**
Difficulty: Medium | Pattern: Circular buffer with head/tail and modular arithmetic
Why: (tail+1) % capacity for circular indexing. Ring buffers are everywhere in backend systems: Kafka partitions, OS I/O buffers, producer-consumer implementations.

**118. Design Circular Deque — #641**
Difficulty: Medium | Pattern: Circular buffer with front/rear pointers, both-end ops
Why: Extends #622 with insertion and deletion at both ends. Models double-ended buffers used in work-stealing schedulers, browser history, and undo/redo systems. Completes the queue design family.

### 7.2 — Monotonic Deque

**119. Jump Game VI — #1696**
Difficulty: Medium | Pattern: DP + Monotonic Deque for window max
Why: dp[i] = nums[i] + max(dp[i-k..i-1]). Naive DP is O(nk); the deque makes it O(n). The perfect bridge between DP and monotonic deque optimization — a pattern that appears in hard DP problems.
↪ §1.4 #39 Sliding Window Maximum (#239) is the foundational monotonic-deque problem — do it first.

---

## 📂 8 — Trees

### 8.1 — DFS: Pre-order (Top-Down)

**120. Invert Binary Tree — #226**
Difficulty: Easy | Pattern: Pre-order DFS — swap children, then recurse
Why: The simplest recursive tree problem. Teaches top-down thinking: do the operation at the current node, then recurse. Notoriously used in a famous hiring story.

**121. Path Sum — #112**
Difficulty: Easy | Pattern: Top-down DFS with running sum (subtract as you go)
Why: Subtracting target as you descend is cleaner than accumulating and comparing at leaves. This "thread state downward" pattern is used in Path Sum II, Path Sum III, and all root-to-leaf path problems.

**122. Path Sum II — #113**
Difficulty: Medium | Pattern: DFS with path list + backtracking
Why: Adds result collection to #112. The path.add(node.val); recurse; path.remove(path.size()-1) backtracking pattern in a tree is a key skill — bridges trees and backtracking.

**123. Sum Root to Leaf Numbers — #129**
Difficulty: Medium | Pattern: Top-down DFS accumulating number digit by digit
Why: currentNum = currentNum * 10 + node.val. Tests clean pre-order state threading. Models decimal number construction in trees — appears in trie number problems.

**124. Count Good Nodes in Binary Tree — #1448**
Difficulty: Medium | Pattern: Pre-order DFS passing running maximum downward
Why: Thread the maximum seen so far from root downward. Node is "good" if its value ≥ running max. Clean combination of top-down state and bottom-up counting.

### 8.2 — DFS: Post-order (Bottom-Up)

**125. Maximum Depth of Binary Tree — #104**
Difficulty: Easy | Pattern: Post-order DFS, return 1 + max(left, right)
Why: The simplest post-order problem. Return value bubbles upward. This bottom-up template is the skeleton for diameter, balance check, path sum, and LCA problems.

**126. Diameter of Binary Tree — #543**
Difficulty: Easy | Pattern: Post-order DFS — return height, record global max
Why: What you return (height) is different from what you record (diameter = left+right). This split is the defining characteristic of post-order tree DP and is used in Binary Tree Maximum Path Sum.

**127. Balanced Binary Tree — #110**
Difficulty: Easy | Pattern: Post-order DFS with -1 sentinel for early termination
Why: Return -1 to propagate "invalid" state without a separate boolean. The sentinel-based early exit avoids redundant computation — a clean coding pattern.

**128. Binary Tree Maximum Path Sum — #124**
Difficulty: Hard | Pattern: Post-order DFS — extend to parent OR complete path through node
Why: At each node: return node.val + max(0, left, right) to parent; record left+node+right as a candidate answer. The "what I return vs what I record" split, at its hardest. A landmark problem.

### 8.3 — BFS: Level Order

**129. Binary Tree Level Order Traversal — #102**
Difficulty: Medium | Pattern: BFS with int size = queue.size() level snapshot
Why: The canonical BFS template. size captures the level boundary. This loop structure is used in 15+ BFS problems — zigzag traversal, right side view, level averages.

**130. Binary Tree Right Side View — #199**
Difficulty: Medium | Pattern: BFS level-order — take last element per level
Why: Two valid approaches: BFS (last element per level) and DFS (right-first, first visit per depth). Great for discussing trade-offs between BFS and DFS.

**131. Binary Tree Zigzag Level Order Traversal — #103**
Difficulty: Medium | Pattern: BFS with alternating direction flag
Why: Same BFS template as #102 but with a leftToRight boolean toggle per level. Tests clean level-order BFS with a state flag.

**132. Average of Levels in Binary Tree — #637**
Difficulty: Easy | Pattern: BFS level-order — aggregate per level
Why: Compute sum per level, divide by size. Reinforces BFS level template with a different aggregate. Easy but valuable for solidifying the pattern.

**133. Binary Tree Vertical Order Traversal — #987**
Difficulty: Medium | Pattern: BFS + column tracking with TreeMap
Why: Assign column indices (root=0, left=col-1, right=col+1). BFS ensures top-to-bottom order within each column. TreeMap sorts columns. A frequently asked tree problem at Meta and Amazon.

### 8.4 — Dual-Tree / Structural

**134. Same Tree — #100**
Difficulty: Easy | Pattern: Simultaneous DFS on two trees
Why: Base cases — both null (true), one null (false), values differ (false). The template for Subtree of Another Tree and Symmetric Tree.

**135. Subtree of Another Tree — #572**
Difficulty: Easy | Pattern: DFS outer traversal + isSameTree inner check
Why: Reuse #100 as a subroutine. Outer DFS tries every node as root; isSameTree checks from there. Teaching problem decomposition and function composition.

**136. Symmetric Tree — #101**
Difficulty: Easy | Pattern: Mirror DFS (left.left vs right.right, left.right vs right.left)
Why: A tree is symmetric if its left subtree mirrors its right. The mirrored recursion pattern tests flexible recursive thinking.

**137. Flatten Binary Tree to Linked List — #114**
Difficulty: Medium | Pattern: Reverse post-order (right → left → root) with prev pointer
Why: Process right subtree first, then left, then set current.right = prev. The reverse post-order trick avoids overwriting pointers you still need. Tests deep understanding of traversal order and pointer management.

### 8.5 — Binary Search Trees: Query

**138. Validate Binary Search Tree — #98**
Difficulty: Medium | Pattern: DFS with (min, max) bounds passed down
Why: Local parent comparison is insufficient — you need global bounds. dfs(node, min, max) is the template for all BST validation problems. Very commonly asked.

**139. Lowest Common Ancestor of a BST — #235**
Difficulty: Medium | Pattern: BST ordering to navigate without full traversal
Why: Both smaller → go left; both larger → go right; split → current node is LCA. Exploiting BST structure for O(h) traversal. Compare with #236 to understand when structure helps.

**140. Lowest Common Ancestor of a Binary Tree — #236**
Difficulty: Medium | Pattern: Post-order DFS — if both sides return non-null, current is LCA
Why: General LCA without BST structure. If left subtree found p and right found q, current node is LCA. A classic post-order pattern that appears in tree path problems.

**141. Kth Smallest Element in a BST — #230**
Difficulty: Medium | Pattern: In-order traversal = sorted BST output
Why: BST in-order yields elements in sorted order — the fundamental BST property. Iterative in-order with an explicit stack is a key skill for BST iterator problems.

**142. Binary Search Tree Iterator — #173** 🆕
Difficulty: Medium | Pattern: Controlled iterative in-order with an explicit stack
Why: #141 taught in-order traversal; this forces you to **pause it mid-flight**. You must maintain the stack as persistent object state between next() calls, achieving O(h) space and amortized O(1) next(). Converting a recursive traversal into a resumable iterator is a genuinely different skill and a common design question.

### 8.6 — Binary Search Trees: Mutation & Construction

**143. Insert into a Binary Search Tree — #701** 🆕
Difficulty: Medium | Pattern: BST descent to a null leaf position
Why: The gentle introduction to BST mutation — descend by comparison, attach at the empty slot. Your sheet had five BST *query* problems and **zero mutation problems**, which is a real gap since insert/delete is what makes a BST a data structure rather than a puzzle.

**144. Delete Node in a BST — #450** 🆕
Difficulty: Medium | Pattern: Three-case deletion (leaf / one child / two children + successor)
Why: **The hardest fundamental BST operation.** The two-children case requires finding the in-order successor, copying its value, then recursively deleting it. This is textbook CS that interviewers use to check whether you actually understand BSTs or just memorized traversals. Pairs with #701.

**145. Convert Sorted Array to Binary Search Tree — #108** 🆕
Difficulty: Easy | Pattern: Recursive mid-point selection (build balanced BST)
Why: Pick the middle as root, recurse on halves — the inverse of binary search, and it produces a height-balanced tree by construction. Teaches the relationship between sorted arrays and balanced BSTs, which is the conceptual basis for AVL/Red-Black balancing.

**146. Construct Binary Tree from Preorder and Inorder — #105**
Difficulty: Medium | Pattern: Recursive tree construction using index splits + HashMap for O(1) index lookup
Why: Preorder[0] = root. Find root in inorder → splits into left/right subtrees. Teaches that preorder+inorder uniquely determine a binary tree. Bridges traversal understanding and construction.

**147. Serialize and Deserialize Binary Tree — #297**
Difficulty: Hard | Pattern: BFS/DFS serialization with null markers
Why: A top backend engineering problem. How do you persist a tree to a string and reconstruct it? Tests both traversal and parsing. Used in distributed systems for tree-structured data serialization (ASTs, config trees).
↪ House Robber III (#337) in §20 is the canonical DP-on-trees problem.

---

## 📂 9 — Tries

**148. Implement Trie (Prefix Tree) — #208**
Difficulty: Medium | Pattern: TrieNode with children[26] + isEnd flag
Why: Build this from scratch. The TrieNode class with a children array and isEnd boolean is the foundation of all trie problems. You will implement this in the interview.

**149. Design Add and Search Words Data Structure — #211**
Difficulty: Medium | Pattern: Trie + DFS for wildcard matching (. = any char)
Why: Adds wildcard search to the trie. When . is encountered, recurse into all children. This Trie+DFS combination is used in word games, regex engines, and dictionary lookup.

**150. Replace Words — #648** 🆕
Difficulty: Medium | Pattern: Trie for shortest-prefix lookup
Why: Insert all roots, then for each word walk the trie and stop at the first isEnd. The "find the shortest matching prefix" query is what tries are genuinely *for* in production — URL routing tables, IP prefix matching (CIDR), and autocomplete all do exactly this. A practical counterweight to the puzzle-flavored trie problems.

**151. Implement Magic Dictionary — #676** 🆕
Difficulty: Medium | Pattern: Trie + DFS with an exact-one-mismatch budget
Why: Search allowing exactly one character substitution — carry a "changes used" counter through the DFS. Generalizes #211's wildcard into a *budgeted* mismatch, which is the same idea behind fuzzy search and spell correction. Completes the trie-search family.

**152. Maximum XOR of Two Numbers in Array — #421**
Difficulty: Medium | Pattern: Binary trie on bit representation (bit-by-bit greedy)
Why: Build a bitwise trie, then for each number greedily choose the opposite bit at each level. Bridges Tries and Bit Manipulation — two topics that rarely intersect. Asked at Google and Amazon.

**153. Word Search II — #212**
Difficulty: Hard | Pattern: Trie + DFS backtracking on 2D grid with pruning
Why: Without a Trie, brute force is O(N×M×4^L×W) — too slow. The Trie prunes dead paths immediately. Combining Trie prefix pruning with grid backtracking is a top-tier problem that bridges three topics.

---

## 📂 10 — Heaps & Priority Queues

**154. Last Stone Weight — #1046** 🆕
Difficulty: Easy | Pattern: Max-heap simulation
Why: The simplest possible heap problem — repeatedly pull the two largest, push the difference. Your heap section started at Medium; this gives you a place to internalize PriorityQueue mechanics and reverse-order comparators before the harder problems.

**155. Kth Largest Element in an Array — #215**
Difficulty: Medium | Pattern: Min-heap of size K / QuickSelect
Why: Min-heap of size K maintains the K largest seen. When heap exceeds K, pop the minimum. QuickSelect is the O(n) average alternative. Both are essential. The heap approach is used for "top K from a stream."

**156. Kth Largest Element in a Stream — #703** 🆕
Difficulty: Easy | Pattern: Bounded min-heap as persistent object state
Why: The streaming version of #215 — the heap becomes a long-lived field rather than a local variable. Makes concrete *why* "min-heap of size K" is the right structure: it's the only one that handles unbounded input in O(log k) per element. The design framing is what gets asked.

**157. K Closest Points to Origin — #973**
Difficulty: Medium | Pattern: Max-heap of size K with custom comparator
Why: Use a max-heap to keep K smallest distances. When heap exceeds K, remove the max (farthest). Teaches custom comparator design: (a,b) -> dist(b)-dist(a). Generalizes to any "K closest by metric" problem.

**158. Top K Frequent Words — #692**
Difficulty: Medium | Pattern: Min-heap with composite comparator (freq desc, alpha asc)
Why: Sorting by frequency AND alphabetical order requires a composite comparator. Tests careful Comparator design — a real-world skill for ranking and sorting systems.

**159. Task Scheduler — #621**
Difficulty: Medium | Pattern: Greedy + max-heap (most frequent task first)
Why: Always schedule the most frequent remaining task. Max-heap picks it. Models CPU scheduling, job queues, and rate-limited API call ordering — a real backend simulation problem.

**160. Reorganize String — #767**
Difficulty: Medium | Pattern: Greedy + max-heap, place most frequent alternately
Why: Same greedy idea as #621 but applied to string construction. If the most frequent char has count > (n+1)/2, it's impossible. Otherwise, greedily alternate. Models distributed write balancing.

**161. Ugly Number II — #264**
Difficulty: Medium | Pattern: Min-heap or 3-pointer DP for ordered generation
Why: Generate ugly numbers in sorted order. The heap approach naturally maintains sorted order; the 3-pointer DP is a beautiful O(n) optimization. Models ordered generation from multiple sorted sequences.

**162. Find Median from Data Stream — #295**
Difficulty: Hard | Pattern: Two heaps — max-heap (lower half) + min-heap (upper half)
Why: The two-heap pattern for streaming median is asked constantly. Balance heaps so sizes differ by at most 1. Median = top of larger heap or average of both tops. Used in monitoring dashboards and SLA percentile tracking.
↪ §4.4 #86 Sliding Window Median (#480) is the hard follow-up that adds deletion.

**163. Smallest Range Covering Elements from K Lists — #632**
Difficulty: Hard | Pattern: Min-heap + sliding window across K sorted lists
Why: Maintain one element from each list in a min-heap, track the current max. The range is [heap.min, currentMax]. Advance the min pointer. Models multi-stream synchronization — distributed log merging and real-time data fusion.
↪ §5.3 #99 Merge K Sorted Lists (#23) is the canonical K-way-merge heap problem.

---

## 📂 11 — Graphs: DFS

### 11.1 — Grid DFS (Flood Fill)

**164. Number of Islands — #200**
Difficulty: Medium | Pattern: Grid DFS — visit and mark (flood fill)
Why: The canonical graph/grid problem. The "mark visited then recurse in 4 directions" pattern is the template for all 2D connectivity problems. Non-negotiable.

**165. Max Area of Island — #695**
Difficulty: Medium | Pattern: Grid DFS — return component size
Why: DFS returns the area of each island component. Teaches that DFS can return values, not just mark visited. The "DFS returns component property" pattern appears in 10+ grid problems.

**166. Flood Fill — #733**
Difficulty: Easy | Pattern: DFS with color replacement (handle same-color edge case)
Why: The simplest grid DFS. The edge case: if oldColor == newColor, return immediately to avoid infinite loops. Models paint-bucket tool, region recoloring, and network segment updates.

**167. Surrounded Regions — #130**
Difficulty: Medium | Pattern: Border DFS to mark "safe" cells, then flip the rest
Why: Don't solve the hard direction — find all 'O's connected to the border (easy) and mark them safe. Everything else gets flipped. Teaches solving the complement when that's easier.

**168. Number of Enclaves — #1020**
Difficulty: Medium | Pattern: Border DFS to subtract border-connected cells
Why: Extends #130 — count land cells NOT reachable from the border. DFS from all border land, mark visited, then count remaining. Reinforces the "border reachability" pattern.

**169. Pacific Atlantic Water Flow — #417**
Difficulty: Medium | Pattern: Reverse DFS/BFS from both borders, find intersection
Why: Instead of "can (i,j) reach the ocean?", ask "which cells can the ocean reach going backwards?". Multi-source reverse DFS from both borders. The intersection is the answer. A key problem-reversal insight.

### 11.2 — Graph Coloring (Bipartite)

**170. Is Graph Bipartite? — #785** 🆕
Difficulty: Medium | Pattern: 2-coloring via DFS/BFS — conflict detection
Why: **A completely missing topic on your old sheet.** Color each node opposite to its neighbors; a conflict means an odd-length cycle exists and the graph isn't bipartite. Handle disconnected components by looping over all nodes. Bipartite checking underlies matching problems, conflict scheduling, and two-team partitioning — and it's asked constantly.

**171. Possible Bipartition — #886** 🆕
Difficulty: Medium | Pattern: Build graph from dislike pairs → 2-coloring
Why: The applied version of #785 — the graph is implicit in a list of "these two can't be together" constraints. Recognizing "split into two groups with conflicts" as bipartite checking is the entire skill. Also solvable with Union-Find, which makes a good comparison.

### 11.3 — Cycles, Bridges & Eulerian Paths

**172. Clone Graph — #133**
Difficulty: Medium | Pattern: DFS + HashMap (original → clone) for cycle-safe copying
Why: The HashMap<Node, Node> maps original to its clone, preventing infinite loops in cyclic graphs. This "visited map" pattern is used in any graph copy/serialization problem.

**173. Reconstruct Itinerary — #332** 🆕
Difficulty: Hard | Pattern: Hierholzer's algorithm (Eulerian path) — post-order edge consumption
Why: **Eulerian paths were entirely absent.** Use every edge exactly once. The trick: greedily consume edges in lexical order and append the node to the result *after* recursion (post-order), then reverse. Fundamentally different from vertex-visiting DFS — this is edge-visiting DFS. Models route reconstruction and DNA fragment assembly.

**174. Critical Connections in a Network — #1192**
Difficulty: Hard | Pattern: Tarjan's bridge-finding (DFS discovery time + low-link values)
Why: Find all bridges in an undirected graph using discovery times and low-link values. Models network reliability — single points of failure. The low-link technique also gives you articulation points and strongly connected components.
↪ Course Schedule (#207) in §13 is the canonical DFS cycle-detection problem (3-color marking).
↪ Graph Valid Tree (#261) in §14 covers undirected cycle detection via parent tracking.
↪ Longest Increasing Path in a Matrix (#329) in §16 is DFS + memoization on an implicit DAG.

---

## 📂 12 — Graphs: BFS

### 12.1 — Grid BFS & Multi-Source BFS

**175. 01 Matrix — #542**
Difficulty: Medium | Pattern: Multi-source BFS from all 0s simultaneously
Why: Add all 0s to the queue first, then BFS outward — each non-zero cell gets its distance when first visited. This "expand from all sources simultaneously" is the BFS distance-from-source pattern.

**176. Rotting Oranges — #994**
Difficulty: Medium | Pattern: Multi-source BFS (simultaneous spread) + fresh-count tracking
Why: All rotten oranges spread simultaneously each minute. Level count = minutes. Track fresh count to detect if any are unreachable. Models virus spread, network propagation, and fire simulation.

**177. Walls and Gates — #286**
Difficulty: Medium | Pattern: Multi-source BFS from all gates
Why: Same as #542 but with named semantics. BFS from all gates fills distances to empty rooms. Reinforces multi-source BFS and handles unreachable cells (INF remains).

**178. Shortest Path in Binary Matrix — #1091**
Difficulty: Medium | Pattern: BFS on grid (8-directional), shortest path
Why: BFS always finds the shortest unweighted path. This problem adds 8-directional movement, a common variant. BFS level count = path length.

### 12.2 — State-Space BFS

**179. Word Ladder — #127**
Difficulty: Hard | Pattern: BFS on implicit graph (word → neighbor words one char apart)
Why: Each word is a node; edges exist between words differing by one character. Building the implicit graph and running BFS finds the shortest transformation. Models state-space search — used in NLP, configuration management, and genetic algorithms.

**180. Open the Lock — #752**
Difficulty: Medium | Pattern: BFS on state space (string states as nodes)
Why: Each lock state is a node; adjacent states differ by one wheel turn. BFS finds minimum turns. State-space BFS is a general technique for puzzle/game problems and config transition problems. Bidirectional BFS is the optimization discussion.

**181. Snakes and Ladders — #909**
Difficulty: Medium | Pattern: BFS on modified graph (teleportation edges)
Why: BFS on a board with teleportation. Teaches encoding a 2D board index to 1D and handling special "jump" edges in BFS. Models routing with shortcuts.
↪ Course Schedule II (#210) in §13 is BFS-based topological sort (Kahn's algorithm).
↪ §11.2 #170 Is Graph Bipartite (#785) is equally natural as a BFS coloring problem.

---

## 📂 13 — Graphs: Topological Sort

**182. Course Schedule — #207**
Difficulty: Medium | Pattern: Topological sort — cycle detection (DFS 3-color or Kahn's)
Why: The entry-level toposort problem. Learn **both** DFS (3-color marking: white unvisited, gray in-path, black done — gray means cycle) and Kahn's BFS (in-degree). Prerequisite relationships = directed graph = detect if a valid order exists. Used in build systems and dependency resolution.

**183. Course Schedule II — #210**
Difficulty: Medium | Pattern: Kahn's BFS — output topological order
Why: Extends #207 to output the actual order. Process nodes with in-degree 0; decrement neighbors. If all nodes processed → no cycle. This is how Maven/Gradle resolve build order and how microservice deployment orders are determined.

**184. Alien Dictionary — #269**
Difficulty: Hard | Pattern: Build graph from adjacent word pairs + topological sort
Why: Derive character ordering from a sorted word list. For adjacent words, the first differing character gives an edge. Then toposort the characters. Models deriving constraints from observations — a real inference problem. The prefix edge case ("abc" before "ab" is invalid) is where people fail.

**185. Sequence Reconstruction — #444**
Difficulty: Medium | Pattern: Topological sort — verify unique ordering
Why: Check if nums is the *only* possible topological order. At each Kahn's step, if the queue has more than one element, the ordering isn't unique. Tests deep understanding of when toposort has a unique solution.

---

## 📂 14 — Graphs: Union Find (DSU)

**186. Number of Connected Components — #323**
Difficulty: Medium | Pattern: Union-Find — component count
Why: The entry-level Union-Find problem. Start with N components, decrement on each successful union. The cleanest introduction to DSU mechanics. **Implement path compression + union by rank here** — you'll reuse this class in every DSU problem.

**187. Graph Valid Tree — #261**
Difficulty: Medium | Pattern: Union-Find — detect cycle + check connectivity
Why: A tree = connected + acyclic (exactly n-1 edges). During union, if two nodes already share a root → cycle. Final check: exactly 1 component. Also teachable via DFS with parent tracking, which is the standard way to detect cycles in *undirected* graphs.

**188. Redundant Connection — #684**
Difficulty: Medium | Pattern: Union-Find — find the edge that creates a cycle
Why: Process edges one by one. The first edge where both endpoints already share a root is the redundant edge. A clean, practical DSU application.

**189. Accounts Merge — #721**
Difficulty: Medium | Pattern: Union-Find to merge sets by shared email
Why: Union all emails in each account. Emails sharing a component belong to the same person. Then group and sort. A real-world problem: user deduplication and identity resolution in backend systems.

**190. Most Stones Removed with Same Row or Column — #947**
Difficulty: Medium | Pattern: Union-Find on rows and columns (coordinate mapping)
Why: Union stones sharing a row or column. Max removable = total stones − number of components. A clever DSU formulation where the insight (components determine the answer) is non-obvious.

---

## 📂 15 — Graphs: Shortest Path & MST

**191. Network Delay Time — #743**
Difficulty: Medium | Pattern: Dijkstra's algorithm (min-heap + dist array)
Why: PriorityQueue<int[]> ordered by cost. Relax edges, update dist[]. This is the canonical Dijkstra implementation. Models network latency, routing protocols (OSPF), and any minimum-cost-path problem. **Master this template — four problems below are variations of it.**

**192. Cheapest Flights Within K Stops — #787**
Difficulty: Medium | Pattern: Bellman-Ford with K iterations
Why: "At most K edges" **breaks Dijkstra** — requires Bellman-Ford with K relaxation rounds, using a copy of the dist array per iteration to avoid multi-hop updates within one round. Understanding *why* Dijkstra fails here is the lesson. Models SLA-constrained routing and hop-limited messaging.

**193. Path With Minimum Effort — #1631**
Difficulty: Medium | Pattern: Dijkstra with a min-max objective
Why: "Minimize the maximum effort along a path" → Dijkstra where cost = max(currentEffort, abs(diff)). Shows Dijkstra is a general framework — the objective can be min-max, not just min-sum. Also solvable with binary search + BFS, or Union-Find on sorted edges.

**194. Path With Maximum Minimum Value — #1102** 🆕
Difficulty: Medium | Pattern: "Maximize the minimum" — max-heap Dijkstra / binary search + BFS
Why: The mirror image of #1631, and putting them side by side is the point: min-max and max-min are the same technique with flipped comparators. Recognizing this symmetry means you'll never be stuck on a bottleneck-path problem again.

**195. Path With Maximum Probability — #1514**
Difficulty: Medium | Pattern: Modified Dijkstra (maximize a product)
Why: Instead of minimizing a sum, maximize a product of probabilities → use a max-heap. Shows that Dijkstra's relaxation works for any objective that's monotonic along a path. Reinforces the "Dijkstra is a framework" lesson from a third angle.

**196. Minimum Cost to Make at Least One Valid Path — #1368** 🆕
Difficulty: Hard | Pattern: 0-1 BFS with a deque (edges of weight 0 or 1)
Why: When all edge weights are 0 or 1, you don't need a heap — a **deque** suffices: push weight-0 moves to the front, weight-1 moves to the back. O(V+E) instead of O(E log V). 0-1 BFS is a genuinely distinct algorithm that most candidates have never seen, and it's the perfect bridge between plain BFS and Dijkstra.

**197. Find the City With the Smallest Number of Neighbors — #1334**
Difficulty: Medium | Pattern: Floyd-Warshall all-pairs shortest path
Why: When you need shortest paths between *all* pairs, Floyd-Warshall O(V³) is the right tool. dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j]) — and the k-loop must be outermost. Models city reachability and full-mesh network analysis.

**198. Swim in Rising Water — #778**
Difficulty: Hard | Pattern: Dijkstra / binary search + BFS / Union-Find
Why: Minimize the maximum value along a path — the hard version of #1631. Three valid approaches, and being able to discuss all three (heap-based, answer-space BS, incremental DSU) is a strong senior signal.

**199. Min Cost to Connect All Points — #1584**
Difficulty: Medium | Pattern: Prim's / Kruskal's Minimum Spanning Tree
Why: The canonical MST problem. Prim's with a min-heap or Kruskal's with Union-Find — learn both, since Kruskal's reuses your DSU class from §14. MST models network design, cable routing, and cluster connectivity.

---

## 📂 16 — Dynamic Programming: 1D

### 16.1 — Fibonacci / Linear DP

**200. Climbing Stairs — #70**
Difficulty: Easy | Pattern: Fibonacci DP (dp[i] = dp[i-1] + dp[i-2])
Why: The gateway DP problem. State → recurrence → base case. Optimize to O(1) space with two variables. Fibonacci-style transitions appear in House Robber, Jump Game, and counting problems.

**201. House Robber — #198**
Difficulty: Medium | Pattern: "Take or skip" decision DP
Why: dp[i] = max(dp[i-1], dp[i-2] + nums[i]). Space-optimize to two variables. The "take or skip" pattern is the most common 1D DP decision. Spawns #213 (circular) and #337 (tree).

**202. House Robber II — #213**
Difficulty: Medium | Pattern: Circular array DP — solve twice (exclude first OR last)
Why: The circular constraint means first and last can't both be taken. Solve on [0..n-2] and [1..n-1], take the max. This "break the circle by solving twice" trick appears in circular interval and circular DP problems.

**203. Jump Game — #55**
Difficulty: Medium | Pattern: Greedy — track max reachable index
Why: maxReach = max(maxReach, i + nums[i]). If i > maxReach at any point, return false. The greedy insight is cleaner than DP here. Teaching *when greedy suffices over DP* is a key meta-skill.
↪ Also belongs conceptually to §21 Greedy — the reachable-range reasoning is interval-flavored.

**204. Jump Game II — #45**
Difficulty: Medium | Pattern: Greedy — BFS-like level jumps
Why: Think of each "range of reachable positions" as a BFS level. currentEnd marks the end of the current level; when i == currentEnd, increment jumps and extend to farthest. Greedy BFS on an implicit graph.

### 16.2 — Decision / Counting DP

**205. Word Break — #139**
Difficulty: Medium | Pattern: 1D DP on string — dp[i] = can we segment s[0..i-1]
Why: For each position, check all valid word endings using a HashSet. dp[i] = true if dp[j] is true and s[j..i-1] is in the dictionary. Directly models tokenization, NLP preprocessing, and code parsing.

**206. Decode Ways — #91**
Difficulty: Medium | Pattern: 1D DP with conditional transitions (handle '0' carefully)
Why: Two transitions: single digit and two digits. Each has validity conditions ('0' is tricky). Tests precision in DP condition handling. Models protocol decoders and run-length encoding.

**207. Coin Change — #322**
Difficulty: Medium | Pattern: Unbounded knapsack — minimize count
Why: dp[i] = min(dp[i], dp[i-coin] + 1) for each coin. The forward-fill unbounded DP pattern. Foundation for all "minimum cost to reach target with unlimited items" problems.

**208. Coin Change II — #518**
Difficulty: Medium | Pattern: Unbounded knapsack — count combinations
Why: From "minimum count" to "number of ways." Iterate coins in the **outer** loop and amounts inner to count combinations rather than permutations. The loop ordering is the entire lesson.
↪ Also the canonical unbounded-knapsack counting problem for §19.

**209. Combination Sum IV — #377** 🆕
Difficulty: Medium | Pattern: Counting **permutations** — amount outer, coins inner
Why: **The exact mirror of #518, and the reason to do them back-to-back.** Same recurrence, swapped loop order, completely different answer — here order matters, so (1,2) and (2,1) count separately. Nothing teaches "loop order encodes meaning in DP" more sharply than seeing these two side by side.

**210. Unique Binary Search Trees — #96** 🆕
Difficulty: Medium | Pattern: Catalan number DP — sum over root choices
Why: dp[n] = Σ dp[i-1] × dp[n-i] for each choice of root. The "split at every possible pivot and multiply subproblem counts" structure is the Catalan recurrence, and it also underlies valid-parentheses counting, polygon triangulation, and #312's interval DP. A pure counting-DP shape your sheet was missing.

**211. Counting Bits — #338**
Difficulty: Easy | Pattern: DP using bit relationship (dp[i] = dp[i>>1] + (i&1))
Why: Derive a DP state from mathematical bit structure. The i >> 1 relationship (right shift removes the last bit) gives a recurrence from smaller subproblems. Introduces bitmask DP thinking.
↪ Also a §23 Bit Manipulation problem — it sits on the boundary deliberately.

**212. Longest Increasing Subsequence — #300**
Difficulty: Medium | Pattern: O(n²) DP, then O(n log n) patience sorting
Why: A landmark DP problem. dp[i] = LIS ending at index i. The O(n log n) solution (binary search on a tails array) is a must-know optimization. LIS appears as a subproblem in many advanced DP and greedy problems.

**213. Number of Longest Increasing Subsequence — #673**
Difficulty: Medium | Pattern: DP tracking both LIS length AND count at each index
Why: Extends #300 — track count[i] = number of LIS ending at i. When dp[j]+1 == dp[i], add count[j]; when dp[j]+1 > dp[i], reset. The "count of optimal solutions" DP extension applies to many DP problems and the reset-vs-accumulate distinction is where people get it wrong.

### 16.3 — State-Machine DP (Stock Series)

**214. Best Time to Buy and Sell Stock with Cooldown — #309**
Difficulty: Medium | Pattern: State-machine DP (hold / sold / rest states)
Why: Three states: holding, just sold, resting. hold = max(hold, rest-price), sold = hold+price, rest = max(rest, sold). The state-machine DP pattern is the cleanest way to model multi-state decisions. Extends the stock series from #121 into proper DP territory.

**215. Best Time to Buy and Sell Stock IV — #188**
Difficulty: Hard | Pattern: State-machine DP with k transactions
Why: The generalized stock problem. dp[k][0] = not holding, dp[k][1] = holding. When k ≥ n/2, reduce to unlimited transactions (greedy). The "generalize then special-case the optimization" approach is a key DP meta-skill, and this problem subsumes #121, #122, #123, and #309.

### 16.4 — DP on Grids as DAGs

**216. Longest Increasing Path in a Matrix — #329**
Difficulty: Hard | Pattern: DFS + memoization on a 2D grid (implicit DAG DP)
Why: Each cell's longest path depends on neighbors with larger values — forming a DAG, so no visited-set is needed and memo[i][j] is safe. This "grid as DAG" + memoization pattern is asked at Google and Apple. Bridges grid DFS with DP.

---

## 📂 17 — Dynamic Programming: 2D

**217. Unique Paths — #62**
Difficulty: Medium | Pattern: 2D DP grid — count paths
Why: dp[i][j] = dp[i-1][j] + dp[i][j-1]. The simplest 2D DP problem. Space-optimize to a 1D rolling array. Foundation for obstacle variants and minimum path sum.

**218. Unique Paths II — #63**
Difficulty: Medium | Pattern: 2D DP with obstacle handling (dp[i][j]=0 on obstacle)
Why: Extends #62 with obstacles. Tests clean initialization (first row/column handling, where an obstacle zeroes everything after it). Builds precision in 2D DP.

**219. Minimum Path Sum — #64**
Difficulty: Medium | Pattern: 2D DP grid — minimize cost
Why: Same 2D structure as #62 but minimizing. Models the cheapest route through a cost grid — applicable to network hop costs, pipeline routing, and game pathfinding.

**220. Longest Common Subsequence — #1143**
Difficulty: Medium | Pattern: 2D DP on two sequences
Why: If s1[i]==s2[j]: dp[i][j] = dp[i-1][j-1]+1. Else: max(dp[i-1][j], dp[i][j-1]). **LCS is the parent of an entire family** — git diff, DNA alignment, spell correction, and Edit Distance all descend from it. Learn to reconstruct the actual subsequence, not just its length.

**221. Edit Distance — #72**
Difficulty: Medium | Pattern: Levenshtein distance DP (insert/delete/replace)
Why: A three-way recurrence. Used in spell checkers, autocorrect, fuzzy search, and NLP similarity. One of the most real-world-relevant DP problems for backend engineers.

**222. Interleaving String — #97**
Difficulty: Medium | Pattern: 2D DP — can s3 be formed by interleaving s1 and s2
Why: dp[i][j] = can the first i+j chars of s3 be formed from s1[0..i-1] and s2[0..j-1]. A clean 2D DP that models string merging — relevant to log interleaving and merge conflict detection.

**223. Distinct Subsequences — #115**
Difficulty: Hard | Pattern: 2D DP — count ways to form t as a subsequence of s
Why: dp[i][j] = number of ways to form t[0..i-1] from s[0..j-1]. If chars match: dp[i-1][j-1] + dp[i][j-1]. Counts *embeddings* of one string in another — the counting variant of LCS. Appears in bioinformatics and pattern frequency analysis.

**224. Maximal Square — #221**
Difficulty: Medium | Pattern: 2D DP — dp[i][j] = side of largest all-1 square ending here
Why: dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1. A beautiful geometric DP. The min-of-three-neighbors formula is non-obvious and highly instructive.
↪ Maximal Rectangle (#85) in §6.2 is the harder sibling, solved with a monotonic stack instead.

**225. Regular Expression Matching — #10**
Difficulty: Hard | Pattern: 2D DP — match string against pattern with `.` and `*`
Why: dp[i][j] = does s[0..i-1] match p[0..j-1]. The `*` case branches: zero occurrences (dp[i][j-2]) or one-plus (dp[i-1][j] if chars match). A top-5 hard DP problem. Tests precise state transition reasoning. Asked at Google and Meta.

**226. Wildcard Matching — #44**
Difficulty: Hard | Pattern: 2D DP — match string against pattern with `?` and `*`
Why: Similar to #10 but `*` matches any sequence rather than "zero or more of the preceding char" — so dp[i][j] = dp[i-1][j] (extend `*`) or dp[i][j-1] (empty `*`). Pairs with #10 to cover all pattern-matching DP. The semantic difference between the two `*`s is the lesson.

---

## 📂 18 — Dynamic Programming: Intervals

**227. Minimum Cost Tree From Leaf Values — #1130**
Difficulty: Medium | Pattern: Interval DP or monotonic stack
Why: dp[i][j] = minimum cost to build a subtree from leaves [i,j]. The greedy/stack approach (repeatedly remove the smallest element, cost = product with its smaller neighbor) is equally instructive and connects interval DP back to §6.2.

**228. Burst Balloons — #312**
Difficulty: Hard | Pattern: Interval DP — think about which balloon to pop **LAST**
Why: Counterintuitive: instead of which to pop first, think about which to pop *last* in range [i,j] — because then its neighbors are exactly the boundaries i-1 and j+1, which makes subproblems independent. A paradigm-shifting problem that teaches "think in reverse" for interval DP.

**229. Longest Palindromic Subsequence — #516** 🆕
Difficulty: Medium | Pattern: Interval DP on a single string (or LCS with its reverse)
Why: **Your interval-DP section was only 2 problems and jumped straight to hard.** This is the missing bridge: dp[i][j] over substrings with the classic "expand the interval outward" iteration order. Two solutions — interval DP, or LCS(s, reverse(s)) — and seeing that they're equivalent is a real insight. Note this is *subsequence*, distinct from the *substring* problem #5.
↪ Longest Palindromic Substring (#5) and Palindromic Substrings (#647) in §2.2 also have interval-DP table formulations — worth re-deriving them that way once.

---

## 📂 19 — Dynamic Programming: Knapsack

**230. Partition Equal Subset Sum — #416**
Difficulty: Medium | Pattern: 0/1 knapsack — boolean subset sum
Why: **The canonical 0/1 knapsack.** dp[j] = dp[j] || dp[j-nums[i]], iterating j **backwards** so each item is used at most once. The backward iteration for 0/1 vs forward for unbounded is the single most important distinction in knapsack DP. Must-know.

**231. Last Stone Weight II — #1049**
Difficulty: Medium | Pattern: 0/1 knapsack — minimize the difference between two groups
Why: Minimize |S1 − S2| = find the achievable subset sum closest to total/2. Extends #416 from "exact target" to "closest achievable" — a reframing that shows up constantly once you recognize it.

**232. Target Sum — #494**
Difficulty: Medium | Pattern: 0/1 knapsack (count ways) or DFS + memoization
Why: From "can we?" (#416) to "how many ways?" The algebraic reduction (assigning ± signs → find a subset summing to (total+target)/2) is the key move. The memoized-DFS approach is also a great intro to top-down DP.

**233. Ones and Zeroes — #474**
Difficulty: Medium | Pattern: 2D 0/1 knapsack (two capacity constraints)
Why: dp[i][j] = max strings using at most i zeros and j ones. A knapsack with **two** capacity dimensions. Tests whether you can generalize the pattern beyond a single constraint — and both dimensions still iterate backwards.
↪ Coin Change (#322) and Coin Change II (#518) in §16.2 are the unbounded-knapsack half of this topic.
↪ Combination Sum (#39) in §22 is the backtracking mirror of unbounded knapsack.

---

## 📂 20 — Dynamic Programming: Trees & Multi-Agent

**234. House Robber III — #337**
Difficulty: Medium | Pattern: DP on trees — return a pair [rob, skip] per node
Why: **The canonical "DP on trees" problem.** At each node return [robThis, skipThis] where robThis = node.val + skipLeft + skipRight and skipThis = max(robLeft, skipLeft) + max(robRight, skipRight). Returning a tuple from post-order DFS instead of a single value is the technique — and it completes the House Robber arc (#198 linear → #213 circular → #337 tree).

**235. Cherry Pickup II — #1463**
Difficulty: Hard | Pattern: 3D DP — two agents traversing a grid simultaneously
Why: Two robots collect cherries moving downward together. dp[row][col1][col2] = max cherries, stepping both agents in lockstep so time stays a single dimension. The "two agents, shared clock" DP pattern models parallel resource collection and multi-robot coordination.

**236. Minimum Falling Path Sum — #931** 🆕
Difficulty: Medium | Pattern: Grid DP with three-way transitions and boundary clamping
Why: A gentle on-ramp to this section — dp[i][j] = matrix[i][j] + min of three cells above. Your DP-trees-and-advanced section had only two problems, both jumping straight to hard/tuple-returning DP. This gives you a place to get the three-way transition and edge clamping right before #1463's 3D state.

---

## 📂 21 — Intervals & Greedy

### 21.1 — Interval Scheduling

**237. Meeting Rooms — #252**
Difficulty: Easy | Pattern: Sort by start, check adjacent overlap
Why: Sort by start time. If intervals[i].start < intervals[i-1].end → overlap. The simplest interval problem and the conceptual foundation for all others.

**238. Merge Intervals — #56**
Difficulty: Medium | Pattern: Sort by start + greedy extension
Why: Sort by start. If the current overlaps the last merged, extend the end; otherwise append. Appears in calendar merging, IP range consolidation, and database VACUUM operations.

**239. Insert Interval — #57**
Difficulty: Medium | Pattern: 3-phase scan (before / overlap / after)
Why: Already sorted. Three phases: add all intervals ending before the new one starts, merge all overlapping, add all starting after it ends. A state-machine scan — tests boundary precision.

**240. Interval List Intersections — #986** 🆕
Difficulty: Medium | Pattern: Two-pointer merge over two sorted interval lists
Why: Intersection is `[max(starts), min(ends)]` — valid when non-empty — then advance whichever interval ends first. This is the interval analogue of merging two sorted arrays, and "intersect two sorted interval lists" is a distinct primitive from merging one list. Common at Meta.

**241. Remove Covered Intervals — #1288** 🆕
Difficulty: Medium | Pattern: Sort by start asc, end **desc**; count non-covered
Why: The tie-breaking rule is the whole problem: when starts are equal, the longer interval must come first or you'll miscount. Teaches that **composite sort keys encode the greedy invariant** — a transferable lesson for every sort-then-greedy problem.

**242. Non-overlapping Intervals — #435**
Difficulty: Medium | Pattern: Activity selection — sort by **end** time, greedy keep
Why: The Activity Selection Problem — sort by end time and greedily keep intervals finishing earliest. Provably optimal (exchange argument). The "sort by end" vs "sort by start" distinction is critical: sort by end when *maximizing count*, by start when *merging*.

**243. Minimum Number of Arrows to Burst Balloons — #452**
Difficulty: Medium | Pattern: Greedy — sort by end, shoot at each end
Why: Same greedy as #435 in disguise — recognizing that "minimum arrows" and "maximum non-overlapping intervals" are the same problem is the point. Practice in seeing through problem framing.

### 21.2 — Sweep Line

**244. Meeting Rooms II — #253**
Difficulty: Medium | Pattern: Min-heap of end times / sweep line over start+end events
Why: "Minimum rooms needed" = "maximum overlap at any point." Two approaches: min-heap of end times (reuse a room if earliest end ≤ current start), or a sweep line over sorted +1/−1 events. Models connection pool sizing and server capacity planning.

**245. Car Pooling — #1094** 🆕
Difficulty: Medium | Pattern: Difference array / sweep line over a bounded coordinate space
Why: When coordinates are small and bounded, a **difference array** beats sorting events: +passengers at start, −passengers at end, then prefix-sum and check the capacity. This is the cheapest sweep-line variant and it connects directly back to your prefix-sum work in §1.2.

**246. The Skyline Problem — #218** 🆕
Difficulty: Hard | Pattern: Sweep line + max-heap (or multiset) with lazy deletion
Why: **The definitive sweep-line problem.** Process building edges left to right, maintaining a max-heap of active heights; a key point is emitted whenever the max changes. Combines sweep line, heaps, lazy deletion, and careful tie-breaking on event ordering. Genuinely hard and Google/Bloomberg-favored — the payoff is that every other sweep-line problem feels easy afterward.

### 21.3 — Greedy Classics

**247. Gas Station — #134** 🆕
Difficulty: Medium | Pattern: Greedy — total feasibility + reset the start on deficit
Why: If total gas ≥ total cost a solution *must* exist; and any prefix that goes negative means the start must be after it. **Two independent insights that combine into an O(n) one-pass solution** — a beautiful greedy proof that interviewers use to test whether you can *argue* correctness rather than just code a loop.

**248. Partition Labels — #763** 🆕
Difficulty: Medium | Pattern: Greedy — precompute last occurrence, extend the partition end
Why: Record each character's last index, then sweep while extending the current partition's end to max(end, last[c]); cut when i == end. The "extend the boundary as you scan" greedy is the same shape as #45 Jump Game II, and seeing that connection across problem domains is exactly the transfer skill you're building.

**249. Candy — #135** 🆕
Difficulty: Hard | Pattern: Two-pass greedy (left-to-right, then right-to-left, take max)
Why: A single pass cannot satisfy both neighbor constraints — so satisfy each direction independently, then combine with max. **The two-pass greedy is a genuinely distinct technique** from anything else on this sheet, and it recurs in #42-style problems and rating/ranking systems.

**250. Valid Parenthesis String — #678** 🆕
Difficulty: Medium | Pattern: Greedy with a range [minOpen, maxOpen] of possible open counts
Why: With wildcards, you can't track one counter — so track the *interval* of possible open-paren counts, clamping minOpen at 0. **Tracking a range instead of a value** when the state is uncertain is a powerful and underrated greedy technique. A strong Meta/Google question and the natural capstone of your parentheses arc (#20 → #1249 → #32 → #678).
↪ Jump Game (#55) and Jump Game II (#45) in §16.1 are greedy problems filed under DP for contrast.
↪ Task Scheduler (#621) and Reorganize String (#767) in §10 are greedy + heap problems.

---

## 📂 22 — Backtracking

**251. Subsets — #78**
Difficulty: Medium | Pattern: Backtracking — generate the power set
Why: The purest backtracking problem. choose(nums[i]); dfs(i+1); unchoose(). Every combination, permutation, and partition problem uses this skeleton. Also learn the bitmask iteration version — it's the bridge to §29.

**252. Subsets II — #90**
Difficulty: Medium | Pattern: Backtracking with deduplication at the same recursion level
Why: Sort + `if (i > start && nums[i] == nums[i-1]) continue`. This single dedup line appears in Combination Sum II, Permutations II, and 3Sum. Master it here.

**253. Permutations — #46**
Difficulty: Medium | Pattern: Backtracking with boolean[] used
Why: Order matters → use boolean[] used instead of a start index. The distinction between subsets (start index) and permutations (used array) unlocks the entire backtracking problem tree.

**254. Permutations II — #47**
Difficulty: Medium | Pattern: Backtracking with dedup for permutations
Why: Sort + `if (used[i] || (i>0 && nums[i]==nums[i-1] && !used[i-1])) continue`. The dedup condition for permutations is subtler than for subsets — `!used[i-1]` enforces that duplicates are consumed in order. A complete test of backtracking mastery.

**255. Combination Sum — #39**
Difficulty: Medium | Pattern: Backtracking — unlimited reuse (pass i, not i+1)
Why: Pass i (not i+1) to allow reusing an element. Unbounded backtracking mirrors unbounded knapsack. Models "reach a target budget with unlimited items."

**256. Combination Sum II — #40**
Difficulty: Medium | Pattern: Backtracking — no reuse + deduplication
Why: Sort + dedup (as in #90) + pass i+1. Together #39 and #40 complete the with/without-reuse × with/without-duplicates matrix — four problems' worth of understanding in two.

**257. Generate Parentheses — #22**
Difficulty: Medium | Pattern: Backtracking with open/close count constraints
Why: Add '(' if open < n, add ')' if close < open. Constraint-based branching (prune invalid states instead of generating-then-filtering) is the model for any "generate all valid structures" problem. Asked at every FAANG company.

**258. Letter Combinations of a Phone Number — #17**
Difficulty: Medium | Pattern: Backtracking on a decision map
Why: Maps each digit to its characters; backtracking builds combinations. Models API path generation, feature flag combinations, and config permutation generation.

**259. Palindrome Partitioning — #131**
Difficulty: Medium | Pattern: Backtracking + palindrome check (optionally DP-precomputed)
Why: At each step, try every prefix that's a palindrome. Teaches backtracking with a *validity constraint*. Precomputing an isPalindrome[i][j] table with interval DP is the optimization — connecting §18 to backtracking.

**260. Word Search — #79**
Difficulty: Medium | Pattern: Backtracking on a 2D grid (temporarily mark visited)
Why: Set board[r][c] = '#' before recursing, restore after. Cleaner than a separate visited matrix. The template for all grid backtracking, and the prerequisite for #212.

**261. N-Queens — #51**
Difficulty: Hard | Pattern: Backtracking with 3 constraint sets (cols, diag1, diag2)
Why: Three HashSets track attacked columns and both diagonals (r-c and r+c identify diagonals). O(1) constraint checking. The classic constraint-satisfaction problem — models shard placement and rack-aware scheduling.

---

## 📂 23 — Bit Manipulation

**262. Single Number — #136**
Difficulty: Easy | Pattern: XOR self-cancellation (a^a=0, a^0=a)
Why: XOR everything — pairs cancel, the unique element survives. O(1) space. The gateway to all XOR problems.

**263. Single Number II — #137**
Difficulty: Medium | Pattern: Bit counting mod 3
Why: Count each bit position modulo 3; bits summing to 1 mod 3 belong to the unique element. This "count bits mod k" pattern generalizes to any frequency, which is why it's worth learning beyond the trick.

**264. Missing Number — #268**
Difficulty: Easy | Pattern: XOR with index-value pairs (or Gauss sum)
Why: XOR 0..n with all elements — the missing number remains. Two clean approaches; XOR avoids the overflow concern that the sum formula has.

**265. Number of 1 Bits — #191**
Difficulty: Easy | Pattern: n & (n-1) clears the lowest set bit
Why: Count iterations until n == 0. The same trick answers "is n a power of two?" (n & (n-1)) == 0. Appears in subset enumeration and bitmask DP.

**266. Reverse Bits — #190**
Difficulty: Easy | Pattern: Extract and place bits
Why: (n >>> i) & 1 extracts bit i; `bit << (31-i)` places it in the mirror position. Note the unsigned shift `>>>` — using `>>` here is a classic bug. Used in network protocol headers and binary encoding.

**267. Sum of Two Integers — #371**
Difficulty: Medium | Pattern: XOR for sum, AND+shift for carry
Why: a^b = sum without carry; (a&b)<<1 = carry. Repeat until carry is 0. This is literally how a CPU's adder works — asked to test understanding of arithmetic at the hardware level.
↪ Counting Bits (#338) in §16.2 derives a DP recurrence from bit structure.
↪ Maximum XOR of Two Numbers (#421) in §9 combines bit manipulation with a trie.
↪ Subsets (#78) in §22 has a bitmask-enumeration solution worth writing.

---

## 📂 24 — Math & Simulation

**268. Happy Number — #202**
Difficulty: Easy | Pattern: Fast/slow cycle detection on a number sequence
Why: The sum-of-squares process either reaches 1 or cycles. Floyd's pointers detect the cycle. Bridges number theory with cycle detection — a creative reuse of a linked-list technique.

**269. Reverse Integer — #7**
Difficulty: Medium | Pattern: Digit extraction + overflow detection
Why: rev = rev * 10 + digit, with an overflow check *before* multiplying (rev > MAX/10). Tests careful integer boundary handling — essential in any service parsing user-supplied numbers.

**270. Pow(x, n) — #50**
Difficulty: Medium | Pattern: Fast (binary) exponentiation
Why: pow(x, n) = pow(x*x, n/2) for even n. O(log n) vs O(n). Binary exponentiation underlies modular exponentiation in cryptography and matrix exponentiation for DP optimization. Watch the n = Integer.MIN_VALUE edge case.

**271. Spiral Matrix — #54**
Difficulty: Medium | Pattern: Layer-by-layer simulation with boundary tracking
Why: Shrink top/bottom/left/right after each direction. A clean simulation that tests careful boundary management — the same skill needed in matrix rotation and image processing.

**272. Rotate Image — #48**
Difficulty: Medium | Pattern: Transpose + reverse rows (in-place)
Why: Rotate 90° = transpose then reverse each row. O(1) space. Teaches that a complex transformation can decompose into two simple ones — a genuinely useful decomposition habit.

**273. Set Matrix Zeroes — #73**
Difficulty: Medium | Pattern: Use the first row/column as marker storage (O(1) space)
Why: Record which rows/cols need zeroing inside the matrix itself, with separate flags for row 0 and column 0. A clean space optimization that tests in-place manipulation thinking.

**274. Game of Life — #289**
Difficulty: Medium | Pattern: In-place state encoding (two states per cell in unused bits)
Why: Encode next-state alongside current-state (e.g. 2 = was dead now alive, 3 = was alive still alive), then extract in a second pass. The "pack multiple states into one cell" trick is the standard O(1)-space approach for cellular automata and simultaneous-update simulations.

### 24.1 — Randomized Algorithms

**275. Shuffle an Array — #384** 🆕
Difficulty: Medium | Pattern: Fisher-Yates shuffle
Why: **Randomized algorithms were entirely absent from your sheet.** Iterate from the end, swapping each element with a random index in [0, i]. The naive "swap with any random index" is subtly *not* uniformly random, and being able to explain why is the interview. Used in card shuffling, A/B test assignment, and dataset randomization.

**276. Random Pick Index — #398** 🆕
Difficulty: Medium | Pattern: Reservoir sampling (k=1)
Why: Pick uniformly among matching indices in **one pass with O(1) space** — replace the current pick with probability 1/count. Reservoir sampling is how you sample from a stream of unknown length: log sampling, telemetry, and rate-limited monitoring all use it. A technique with genuinely surprising correctness.

---

## 📂 25 — Advanced Data Structures

**277. Range Sum Query — Mutable #307**
Difficulty: Medium | Pattern: Segment Tree or Binary Indexed Tree (Fenwick)
Why: Point update + range query in O(log n) — the structure that exists because prefix sums (§1.2) break under updates. **Implement both:** the BIT is ~10 lines and perfect for sums; the Segment Tree is more verbose but generalizes to min/max/gcd and lazy propagation. Asked at Google for senior roles.

**278. Count of Smaller Numbers After Self — #315**
Difficulty: Hard | Pattern: Merge sort inversion counting / BIT over value space
Why: Count inversions via modified merge sort (count how many right-half elements merge before each left-half element), or with a BIT indexed by *value* rather than position. The "BIT over value space" idea is a major technique unlock. A Google/Apple favorite.

**279. Range Minimum / Sparse Table — via #1793 Maximum Score of a Good Subarray** 🆕
Difficulty: Hard | Pattern: Range queries on an immutable array — two pointers, or sparse table
Why: A practical closer for this section: expand from a pivot while greedily tracking the range minimum. Worth also solving with a **sparse table** (O(n log n) build, O(1) query) to complete your range-query toolkit — prefix sums for immutable sums, BIT/segment tree for mutable, sparse table for immutable min/max.

---

## 📂 26 — Design Problems

**280. Design HashMap — #706**
Difficulty: Easy | Pattern: Array of buckets + linked-list chaining
Why: Implement the structure you've used in 60 other problems. Teaches hashing, collision resolution (chaining vs open addressing), and load factor / resizing. Builds the mental model that makes "O(1) average" meaningful rather than magical.

**281. Design Underground System — #1512** 🆕
Difficulty: Medium | Pattern: Two HashMaps — in-flight state + aggregated running averages
Why: A realistic "track events and report aggregates" design: one map for active check-ins, another keyed by route holding (totalTime, count). Storing running aggregates instead of raw event lists is the correct engineering instinct, and this is a clean, low-trick problem to practice API design under.

**282. Design Twitter — #355**
Difficulty: Medium | Pattern: HashMap + PriorityQueue + K-way merge for the feed
Why: Combines HashMap<userId, Set<followeeId>>, HashMap<userId, List<Tweet>>, and a merge-K-sorted-lists pattern to build the news feed. Tests system design thinking at the algorithm level — models social feed generation and the fan-out-on-read pattern.
↪ LRU Cache (#146) and LFU Cache (#460) in §3.2 are the highest-value design problems on this sheet.
↪ #380, #208, #211, #297, #622, #641, #225, #232, #703, #729, #295, #981 are all design problems filed under their techniques.

---

## 📂 27 — Number Theory & Combinatorics

**283. Count Primes — #204** 🆕
Difficulty: Medium | Pattern: Sieve of Eratosthenes
Why: **Number theory was completely absent.** Mark multiples of each prime starting from p*p, stepping by p. O(n log log n). The sieve is the single most reusable number-theory routine — any problem involving primes, factorization, or divisor counting starts here.

**284. Greatest Common Divisor of Strings — #1071** 🆕
Difficulty: Easy | Pattern: Euclidean algorithm applied to a non-numeric domain
Why: If two strings have a common divisor string, then `s1+s2 == s2+s1`, and the answer has length gcd(len1, len2). **Recognizing gcd structure in a string problem** is exactly the kind of transfer that separates people who memorize from people who understand. Teaches Euclid's algorithm with a memorable hook.

**285. Super Pow — #372** 🆕
Difficulty: Medium | Pattern: Modular exponentiation with a huge exponent given as an array
Why: Extends #50's binary exponentiation into **modular** arithmetic, decomposing a[0..n] digit by digit: pow(x, 10*rest + d) = pow(pow(x,rest),10) * pow(x,d). Modular exponentiation is the backbone of RSA, hashing, and every "answer mod 1e9+7" problem. Fills the modular-arithmetic gap.

**286. Numbers At Most N Given Digit Set — #902** 🆕
Difficulty: Hard | Pattern: Digit DP — count numbers under a bound, digit by digit
Why: Count valid numbers ≤ N by processing digits left to right, tracking whether the prefix is still "tight" against N. **Digit DP is a full technique class your sheet had zero coverage of.** Lower interview frequency than most of this sheet, but when it appears there is no way to improvise it — and the tight/free state idea generalizes to every bounded-counting problem.

**287. Number of Digit One — #233** 🆕
Difficulty: Hard | Pattern: Digit-position contribution counting (or digit DP)
Why: Count how many times '1' appears across 1..n by computing each digit position's contribution with divide/mod arithmetic. Pairs with #902: one solves digit problems by DP over states, the other by direct combinatorial counting — and knowing both means you can pick whichever the problem admits.
↪ Unique Binary Search Trees (#96) in §16.2 is the Catalan-number counting problem.
↪ Pow(x,n) (#50) in §24 is the non-modular binary exponentiation prerequisite for #372.

---

## 📂 28 — Game Theory & Bitmask DP

**288. Nim Game — #292** 🆕
Difficulty: Easy | Pattern: Game theory — find the losing-position invariant
Why: **Game theory was absent.** The answer is `n % 4 != 0`, but the *point* is deriving it: positions 1-3 win, 4 loses, and every position is a win iff some move reaches a loss. Learning to reason backwards from losing states is the foundational game-theory skill, and it's a common warm-up before harder minimax problems.

**289. Predict the Winner — #486** 🆕
Difficulty: Medium | Pattern: Minimax interval DP — score differential
Why: dp[i][j] = the best score *difference* the current player can achieve on [i,j]. Encoding minimax as a single differential (rather than tracking both players' scores) is the trick that makes two-player DP tractable. Also solvable top-down with memoization, and it doubles as interval-DP practice. Stone Game (#877) is the same recurrence with a greedy shortcut.

**290. Partition to K Equal Sum Subsets — #698** 🆕
Difficulty: Medium | Pattern: Bitmask DP / backtracking over subset states
Why: **Bitmask DP was a total gap.** Represent "which elements are used" as an integer bitmask and memoize over 2^n states. Learning to treat a *set* as an integer index is the entire technique, and it's the prerequisite for every exponential-but-feasible problem (n ≤ 20).

**291. Shortest Path Visiting All Nodes — #847** 🆕
Difficulty: Hard | Pattern: BFS over (node, visitedMask) state space — Held-Karp / TSP flavor
Why: The definitive bitmask problem: state = (current node, set of visited nodes), and BFS over it gives the shortest walk covering all nodes. **This is the Travelling Salesman structure**, and it fuses §12's state-space BFS with bitmask state. Once you see (position, mask) as a state, an entire class of "visit everything optimally" problems opens up.

**292. Smallest Sufficient Team — #1125** 🆕
Difficulty: Hard | Pattern: Bitmask DP over required skills (set cover)
Why: dp[mask] = the smallest team covering that skill set; each person is themselves a bitmask OR-ed into the state. This is **set cover** — NP-hard in general but exact via bitmask DP for small skill counts. Reconstructing the actual team (not just its size) is the extra rep, and it's the most realistic application of bitmask DP on this list.

---

## 📊 Summary

| § | Section | Problems | Range |
|---|---|---|---|
| 1 | Arrays (Fundamentals, Prefix, Two Pointers, Sliding Window) | 39 | 1–39 |
| 2 | Strings | 18 | 40–57 |
| 3 | Hashing | 11 | 58–68 |
| 4 | Binary Search (incl. Ordered Sets) | 18 | 69–86 |
| 5 | Linked Lists | 14 | 87–100 |
| 6 | Stacks | 15 | 101–115 |
| 7 | Queues & Deques | 4 | 116–119 |
| 8 | Trees (incl. BST mutation) | 28 | 120–147 |
| 9 | Tries | 6 | 148–153 |
| 10 | Heaps & Priority Queues | 10 | 154–163 |
| 11 | Graphs: DFS (incl. Bipartite, Euler, Bridges) | 11 | 164–174 |
| 12 | Graphs: BFS | 7 | 175–181 |
| 13 | Graphs: Topological Sort | 4 | 182–185 |
| 14 | Graphs: Union Find | 5 | 186–190 |
| 15 | Graphs: Shortest Path & MST | 9 | 191–199 |
| 16 | DP: 1D (incl. State Machine, Grid-DAG) | 17 | 200–216 |
| 17 | DP: 2D | 10 | 217–226 |
| 18 | DP: Intervals | 3 | 227–229 |
| 19 | DP: Knapsack | 4 | 230–233 |
| 20 | DP: Trees & Multi-Agent | 3 | 234–236 |
| 21 | Intervals & Greedy (incl. Sweep Line) | 14 | 237–250 |
| 22 | Backtracking | 11 | 251–261 |
| 23 | Bit Manipulation | 6 | 262–267 |
| 24 | Math & Simulation (incl. Randomized) | 9 | 268–276 |
| 25 | Advanced Data Structures | 3 | 277–279 |
| 26 | Design Problems | 3 | 280–282 |
| 27 | Number Theory & Combinatorics | 5 | 283–287 |
| 28 | Game Theory & Bitmask DP | 5 | 288–292 |
| | **Total** | **292** | |

**Budget: 292 / 300.** 8 slots deliberately left free — add problems you personally get stuck on, which is better signal than anything a generic list can predict.

---

## 🧭 Techniques Covered — Self-Audit Checklist

Use this to verify you can *name the technique* before solving. If you can't explain one, that's your next study target.

**Arrays/Strings:** two pointers (same & opposite direction) · fixed & variable sliding window · **exactly-K = atMost(K) − atMost(K−1)** · prefix sum · prefix XOR · **2D prefix sum + inclusion-exclusion** · difference array · index-as-hash · cyclic sort · Dutch National Flag · **Boyer-Moore voting** · **KMP prefix function** · **Rabin-Karp rolling hash** · expand-around-center

**Data Structures:** HashMap/HashSet · frequency arrays · monotonic stack (next greater/smaller, contribution) · monotonic deque · heap (top-K, two-heap median, K-way merge, lazy deletion) · **TreeMap/ordered set (floor/ceiling)** · trie (prefix, wildcard, budgeted mismatch, binary/XOR) · Union-Find (path compression + union by rank) · **BIT/Fenwick** · **segment tree** · **sparse table** · LRU/LFU · circular buffer

**Trees:** pre-order top-down state threading · post-order bottom-up ("return vs record") · BFS level snapshot · mirror/dual traversal · BST bounds validation · in-order = sorted · **resumable iterator (explicit stack)** · **BST insert/delete** · construction from traversals · serialization · DP on trees (tuple return)

**Graphs:** grid flood fill · multi-source BFS · reverse/complement thinking · state-space BFS · **bipartite 2-coloring** · DFS cycle detection (3-color) · undirected cycle detection · **Tarjan bridges/low-link** · **Hierholzer Eulerian path** · topological sort (DFS + Kahn's) · unique-ordering verification · Dijkstra (+ min-max, max-min, product variants) · Bellman-Ford (hop-limited) · **0-1 BFS (deque)** · Floyd-Warshall · **MST (Prim's + Kruskal's)**

**DP:** linear/Fibonacci · take-or-skip · circular (solve twice) · **combinations vs permutations (loop order)** · **Catalan** · LIS (O(n²) + O(n log n)) · count-of-optimal-solutions · state machine · grid paths · LCS family · edit distance · pattern matching (`*` semantics) · interval DP (**think last**) · 0/1 knapsack (backward) · unbounded knapsack (forward) · 2D-constraint knapsack · **DP on trees** · multi-agent 3D DP · **digit DP (tight/free)** · **bitmask DP (set as integer)** · memoized DFS on DAGs

**Greedy/Other:** activity selection (sort by end) · merge (sort by start) · **composite sort keys** · sweep line + heap · **two-pass greedy** · **range-tracking greedy** · exchange-argument proofs · binary search on answer space · backtracking (subsets/permutations/dedup/constraints) · **Fisher-Yates** · **reservoir sampling** · **sieve** · **Euclid's gcd** · **modular exponentiation** · **minimax score differential**

---

## 🎯 Study Plan

| Phase | Weeks | Focus |
|---|---|---|
| **1 — Foundations** | 1–3 | §1 Arrays, §2 Strings, §3 Hashing, §4 Binary Search |
| **2 — Linear Structures** | 4–5 | §5 Linked Lists, §6 Stacks, §7 Queues, §10 Heaps |
| **3 — Trees & Tries** | 6–7 | §8 Trees, §9 Tries, §25 Advanced DS |
| **4 — Graphs** | 8–10 | §11 DFS, §12 BFS, §13 Toposort, §14 Union Find, §15 Shortest Path & MST |
| **5 — Dynamic Programming** | 11–13 | §16 1D, §17 2D, §18 Intervals, §19 Knapsack, §20 Trees |
| **6 — Advanced & Niche** | 14–15 | §21 Greedy & Sweep Line, §22 Backtracking, §23 Bits, §27 Number Theory, §28 Game Theory & Bitmask |
| **7 — Consolidation** | 16–18 | §24 Math, §26 Design, weak-area review, timed mocks |

**Daily target:** 3–5 problems.
**Per problem:** state the pattern → brute force → optimize → code → dry run → edge cases.
**Weekly:** re-solve 3 problems from 2+ weeks ago *from scratch*. Recognition ≠ recall.

**Ordering rule:** follow section order *within* a topic — the sheet is sequenced so each problem's technique is a prerequisite for the next. Sections themselves can be reordered freely.
