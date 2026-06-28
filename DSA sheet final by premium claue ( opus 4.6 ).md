 
 # 🔥 Ultimate DSA Sheet — FAANG Interview Prep

> 250 problems covering every pattern needed to crack FAANG-level interviews.
> Organized by topic, progressive difficulty, pattern-first approach.

---

## 📂 1 — Arrays

### 1.1 — Array Fundamentals

**1. Contains Duplicate — #217**  ✅
Difficulty: Easy | Pattern: HashSet for O(1) lookup
Why: The simplest trade-space-for-time problem. The set.add() returns false on duplicate patterns and is reused in 40+ problems. Always the first question to warm up.

**2. Move Zeroes — #283**
Difficulty: Easy | Pattern: Read/Write two pointers (in-place partition)
Why: The read-pointer scans, write-pointer places valid elements. This partition mechanic is the foundation of QuickSort, Remove Duplicates, and Dutch National Flag.

**3. Find All Numbers Disappeared in an Array — #448**
Difficulty: Easy | Pattern: Index-as-hash (negation marking), O(1) space
Why: Teaches using the array itself as a hash map. Values bounded by [1,n] → use index nums[i]-1 as the key. This O(1) space trick recurs in #287 and any "bounded value" problem.

**4. Best Time to Buy and Sell Stock — #121**
Difficulty: Easy | Pattern: Running minimum + greedy single pass
Why: Track minPrice and maxProfit in one scan. This "track running optimal" pattern spawns a 6-problem series. The state-machine thinking here is essential before tackling the harder stock variants.

**5. Maximum Subarray — #53**
Difficulty: Medium | Pattern: Kadane's Algorithm
Why: At each index: extend current subarray OR start fresh. dp[i] = max(nums[i], dp[i-1] + nums[i]). A gateway to 1D DP. Interviewers will ask you to modify this — circular variant #918, or return the actual subarray.

**6. Product of Array Except Self — #238**
Difficulty: Medium | Pattern: Prefix product + suffix product, no division
Why: Thinking in two passes — forward and backward — is a recurring trick. The "no division" constraint forces the prefix/suffix pattern that also appears in trapping rain water and histogram problems.

**7. Find the Duplicate Number — #287**
Difficulty: Medium | Pattern: Floyd's cycle detection (array as implicit graph)
Why: The array nums[i] defines a pointer graph. Applying fast/slow pointers on an array is a key meta-skill — learning to model a problem in a different domain. O(1) space with no modification to input.

**8. Maximum Product Subarray — #152**
Difficulty: Medium | Pattern: DP tracking both max and min simultaneously
Why: Negative × negative = positive, so you must track both maxSoFar and minSoFar. The "track both extremes" DP pattern appears wherever sign flips can occur.

**9. Rotate Array — #189**
Difficulty: Medium | Pattern: Triple reverse trick (in-place rotation)
Why: Reverse whole array → reverse first k → reverse rest. This O(1) space rotation is a common follow-up in array manipulation interviews and models circular buffer rotation.

**10. First Missing Positive — #41**
Difficulty: Hard | Pattern: Index-as-hash (cyclic sort / placement)
Why: The hardest "index-as-hash" problem. Place each number at its correct index (nums[i]-1), then scan for the first mismatch. O(n) time, O(1) space. A top-tier interview problem that tests deep array manipulation thinking.

### 1.2 — Prefix Sums

**11. Running Sum of 1D Array — #1480**
Difficulty: Easy | Pattern: Prefix sum in-place
Why: Purest intro. prefix[i] = prefix[i-1] + nums[i]. Internalize this before everything else in this section.

**12. Range Sum Query — Immutable #303**
Difficulty: Easy | Pattern: Precomputed prefix array → O(1) range query
Why: Forces you to think about precomputation. Build once, query many times. This is how backend systems work — cache the expensive computation. Bridges to 2D prefix sums.

**13. Subarray Sum Equals K — #560**
Difficulty: Medium | Pattern: Prefix sum + HashMap (sum → count)
Why: A landmark problem. "Have I seen currentSum - k before?" destroys the O(n²) brute force instinct. This exact pattern appears in subarray divisibility, matrix path sums, and financial ledger problems.

**14. Contiguous Array — #525**
Difficulty: Medium | Pattern: Prefix sum with +1/-1 encoding + HashMap
Why: Convert 0s to -1s. Now "equal 0s and 1s" → "prefix sum = 0" or "two equal prefix sums." The encoding trick (transform the problem domain) is powerful and reusable.

**15. Minimum Size Subarray Sum — #209**
Difficulty: Medium | Pattern: Variable sliding window (shrink when valid)
Why: Paired here because it also touches on prefix sums conceptually, but the sliding window approach is the right tool. "Shrink when valid" vs "shrink when invalid" is the key variable-window distinction.

**🆕 16. XOR Queries of a Subarray — #1310**
Difficulty: Medium | Pattern: Prefix XOR for O(1) range XOR queries
Why: Same concept as prefix sum but with XOR. prefixXOR[i] ^ prefixXOR[j] gives XOR of range [i,j]. Fills the "prefix XOR" gap — appears in competitive rounds and bit manipulation interviews.

### 1.3 — Two Pointers

**17. Two Sum II — Sorted Array #167**
Difficulty: Easy | Pattern: Opposite-end two pointers on sorted array
Why: Left + right converge based on sum comparison. Foundation for 3Sum, 4Sum, Container With Most Water. The simplest possible two-pointer problem.

**18. 3Sum — #15**
Difficulty: Medium | Pattern: Sort + two pointers + deduplication
Why: Sort, fix one element, two-pointer the rest. The while(nums[l]==nums[l-1]) l++ dedup line is a micro-pattern that appears everywhere. Solving this makes all k-Sum trivial.

**19. 3Sum Closest — #16**
Difficulty: Medium | Pattern: Sort + two pointers, track closest sum
Why: A natural extension of #15 — instead of exact match, track minimum difference. Reinforces two-pointer mechanics and teaches "closest value" tracking.

**20. Container With Most Water — #11**
Difficulty: Medium | Pattern: Two pointers — always move the bottleneck
Why: You always move the shorter pointer because that's the limiting factor. This "move the constraint" greedy reasoning appears in interval scheduling and capacity planning problems.

**21. Trapping Rain Water — #42**
Difficulty: Hard | Pattern: Two pointers with running max from both ends
Why: Water at index i = min(maxLeft, maxRight) - height[i]. Two-pointer approach eliminates the need for prefix/suffix arrays. Appears at FAANG onsites. Can also solve with monotonic stack — knowing both approaches is valuable.

**22. Sort Colors — #75**
Difficulty: Medium | Pattern: Dutch National Flag — 3-way partition
Why: low, mid, high three pointers. Partition into 3 groups in one pass. This exact mechanic is QuickSort's 3-way partition and appears in any "categorize in-place" problem.

### 1.4 — Sliding Window

**23. Maximum Average Subarray I — #643**
Difficulty: Easy | Pattern: Fixed-size sliding window
Why: Build first window, then slide: subtract left element, add right element. The simplest possible fixed window. Understand this before any variable window.

**24. Longest Substring Without Repeating Characters — #3**
Difficulty: Medium | Pattern: Variable sliding window + HashSet
Why: int left=0; for(int right=0; right<n; right++) — this skeleton is reused in 20+ problems. "Expand right, shrink left when invalid." Non-negotiable.

**25. Permutation in String — #567**
Difficulty: Medium | Pattern: Fixed window + frequency match counter
Why: Instead of comparing int[26] arrays each step, maintain a matches counter. O(1) window validity check. This optimization technique is used in Minimum Window Substring and Find All Anagrams.

**26. Find All Anagrams in a String — #438**
Difficulty: Medium | Pattern: Fixed window + frequency matching, collect all results
Why: Same as #567 but collects all valid windows. Solidifies the "maintain matches counter" pattern with result collection.

**27. Longest Repeating Character Replacement — #424**
Difficulty: Medium | Pattern: Variable window + lazy maxFreq tracking
Why: Window is valid if windowSize - maxFreq <= k. The trick of not reducing maxFreq when shrinking (lazy update) is non-obvious but critical. This "lazy shrink" pattern recurs in harder problems.

**28. Minimum Window Substring — #76**
Difficulty: Hard | Pattern: Variable window — shrink aggressively once valid
Why: The hardest sliding window problem. Must have correct characters AND correct counts. The "have/need" counter with a required characters map is the full sliding window toolkit. After this, all sliding window problems are in reach.

**29. Sliding Window Maximum — #239**
Difficulty: Hard | Pattern: Monotonic Deque (decreasing)
Why: Deque stores indices of candidates in decreasing value order. Front = current window max. This O(n) pattern solves all "window maximum/minimum aggregate" problems. Placed here as it belongs to the sliding window family, though the data structure is a deque.

---

## 📂 2 — Strings

### 2.1 — String Manipulation

**30. Reverse Words in a String — #151**
Difficulty: Medium | Pattern: Split, trim, reverse
Why: Tests handling edge cases — multiple spaces, leading/trailing spaces. In Java: s.trim().split("\\s+") vs manual two-pointer reverse. Both approaches tested. Classic phone screen.

**31. Longest Common Prefix — #14**
Difficulty: Easy | Pattern: Vertical scanning / horizontal folding
Why: Systematic string comparison across an array. The "fold/reduce" approach mirrors Trie prefix queries conceptually. Gateway to Trie design.

**32. String to Integer (atoi) — #8**
Difficulty: Medium | Pattern: Deterministic parser / state machine
Why: Overflow detection (result > Integer.MAX_VALUE / 10), sign, whitespace. Backend engineers write parsers — this tests rigorous defensive coding. Every edge case matters.

**33. Roman to Integer — #13**
Difficulty: Easy | Pattern: HashMap lookup + lookahead rule
Why: "If current < next, subtract; else add." The lookahead/lookbehind in string traversal is a recurring micro-pattern in parsing problems.

**34. Zigzag Conversion — #6**
Difficulty: Medium | Pattern: Index simulation with direction flag
Why: Simulate row assignment using a direction variable. Tests clean simulation thinking — a common machine-coding round skill.

**35. Count and Say — #38**
Difficulty: Medium | Pattern: Iterative string generation (run-length encoding)
Why: Build each sequence from the previous one by scanning for consecutive characters. Models run-length encoding — directly relevant to compression algorithms.

### 2.2 — Palindromes

**36. Valid Palindrome — #125**
Difficulty: Easy | Pattern: Two pointers + character filtering
Why: Character.isLetterOrDigit() + two pointers from both ends. The entry point to all palindrome problems.

**37. Longest Palindromic Substring — #5**
Difficulty: Medium | Pattern: Expand-around-center (odd and even centers)
Why: Two center types (single char, between chars). Expanding outward is cleaner and more intuitive than 2D DP. Teaches that a mathematical insight can beat a DP table.

**38. Palindromic Substrings — #647**
Difficulty: Medium | Pattern: Expand-around-center, count all
Why: Extends #5 — count all valid palindromes. Solidifies both odd/even center handling. Together, #5 and #647 cover every palindrome interview question variant.

**39. Valid Palindrome II — #680**
Difficulty: Easy | Pattern: Two pointers + one allowed deletion
Why: On mismatch, try skipping left OR right character and check if either is a palindrome. This "try both options on mismatch" pattern appears in several string problems with tolerance.

### 2.3 — Pattern Matching & Encoding

**40. Encode and Decode Strings — #271 (NeetCode free)**
Difficulty: Medium | Pattern: Length-prefix protocol (len#string)
Why: Delimiter-safe serialization. How do you encode a list of strings containing any character? This is how wire protocols work. Tests real-world engineering thinking over algorithmic tricks.

**41. Find the Index of the First Occurrence in a String — #28**
Difficulty: Easy | Pattern: Sliding window string match / KMP foundation
Why: The brute force teaches the window comparison mechanic. Understanding why it's O(n×m) motivates KMP. Even without KMP, this is the baseline pattern for all substring search.

**42. Repeated Substring Pattern — #459**
Difficulty: Easy | Pattern: String doubling trick / KMP failure function
Why: (s + s).substring(1, 2n-1).contains(s) — the string doubling trick is elegant and instructive. Teaches creative problem reformulation.

**43. Group Anagrams — #49**
Difficulty: Medium | Pattern: HashMap with canonical key (sorted string or char-count)
Why: Design a hashing key that captures equivalence. Sorted string key vs int[26] char-count key — knowing both and their trade-offs is a strong signal. "Canonical form as key" appears in many grouping problems.

**🆕 44. Implement strStr() / Rabin-Karp — #28 (Advanced)**
Difficulty: Medium | Pattern: Rolling hash for O(n) average substring search
Why: Rabin-Karp uses polynomial rolling hash to compare substrings in O(1). Essential for Google-level interviews. The rolling hash technique also appears in plagiarism detection, DNA matching, and distributed deduplication.

---

## 📂 3 — Hashing

### 3.1 — Core HashMap Patterns

**45. Two Sum — #1**
Difficulty: Easy | Pattern: HashMap (value → index), complement lookup
Why: Problem #1 for a reason. map.containsKey(target - nums[i]) is the most reused snippet in DSA. Every "find pair with constraint" problem is a Two Sum variant.

**46. Valid Anagram — #242**
Difficulty: Easy | Pattern: int[26] character frequency comparison
Why: Teaches the int[26] trick as a fast O(1)-space alternative to HashMap<Character, Integer>. This frequency-comparison pattern is used in all sliding window anagram problems.

**47. Top K Frequent Elements — #347**
Difficulty: Medium | Pattern: HashMap + bucket sort (or min-heap)
Why: Bucket sort: index = frequency, value = list of elements. O(n) solution. Also solvable with min-heap O(n log k). Teaches thinking about the frequency of frequencies.

**48. Longest Consecutive Sequence — #128**
Difficulty: Medium | Pattern: HashSet + sequence-start detection
Why: Only start counting from sequence starts (!set.contains(n-1)). Converts O(n log n) sort into O(n). Teaches using a HashSet to simulate sorted order without sorting.

**49. Valid Sudoku — #36**
Difficulty: Medium | Pattern: Multi-dimensional HashSet constraint validation
Why: Three sets — rows, columns, boxes. Box index formula: (r/3)*3 + c/3. Systematic constraint validation across multiple dimensions. Models backend rule-engine validation.

### 3.2 — HashMap Design Problems

**50. LRU Cache — #146**
Difficulty: Medium | Pattern: HashMap + Doubly Linked List, O(1) get & put
Why: The most important data structure design problem for backend engineers. LRU is used in Redis, database buffer pools, and CDN eviction. HashMap gives O(1) lookup; DLL gives O(1) eviction. A career-defining problem.

**51. Insert Delete GetRandom O(1) — #380**
Difficulty: Medium | Pattern: HashMap + ArrayList for O(1) random access
Why: Delete in O(1) from an array by swapping with the last element then removing. HashMap tracks indices. This "swap-with-last-delete" pattern is used in dynamic random sampling — relevant to load balancers and A/B testing systems.

**52. First Unique Character in a String — #387**
Difficulty: Easy | Pattern: Frequency array + second pass
Why: Simple two-pass problem: count frequencies, then find first with count=1. Teaches that two passes at O(n) each is still O(n) total — a common optimization mindset.

**53. Ransom Note — #383**
Difficulty: Easy | Pattern: Character frequency difference check
Why: Check if one string's character counts are a subset of another's. Foundation for all "can we form X from Y?" problems.

**54. Word Pattern — #290**
Difficulty: Easy | Pattern: Bijection mapping (two-way HashMap)
Why: Both pattern → word AND word → pattern mappings must be consistent. The bijection (one-to-one mapping) check with two HashMaps is a recurring pattern in isomorphism problems (#205).

**🆕 55. LFU Cache — #460**
Difficulty: Hard | Pattern: HashMap + frequency map + doubly linked list per frequency
Why: Extends LRU with frequency-based eviction. On tie, evict least recently used among least frequent. Tests multi-level data structure design. Asked at Google and Amazon for senior roles.

---

## 📂 4 — Binary Search

### 4.1 — Classic Binary Search

**56. Binary Search — #704**
Difficulty: Easy | Pattern: while(left<=right), overflow-safe mid
Why: Get the template exactly right. mid = left + (right-left)/2. The <= vs <, and left=mid+1 vs left=mid distinctions are critical. Every other BS problem is a variation.

**57. Search Insert Position — #35**
Difficulty: Easy | Pattern: Binary search — leftmost insertion point
Why: When the loop ends, left is always the insertion position. This property of binary search (left = answer when element not found) is used in 90% of advanced BS problems.

**58. First Bad Version — #278**
Difficulty: Easy | Pattern: Binary search — find first true in boolean sequence
Why: The condition switches from false to true at one point — find that boundary. This "find the boundary between false/true" is the most common BS pattern in real-world code (version control, feature flags, A/B tests).

**59. Search a 2D Matrix — #74**
Difficulty: Medium | Pattern: Binary search on flattened 2D index
Why: mid maps to (mid/cols, mid%cols). Treats the 2D matrix as a 1D sorted array. This index-mapping trick appears in all matrix binary search problems.

**60. Sqrt(x) — #69**
Difficulty: Easy | Pattern: Binary search on integer answer range
Why: Find largest k such that k*k <= x. A gentle intro to binary searching on an answer range (not an array). Gateway to the "binary search on answer" family.

**🆕 61. Median of Two Sorted Arrays — #4**
Difficulty: Hard | Pattern: Binary search on partition point of two arrays
Why: The hardest binary search problem. Binary search on the smaller array's partition; the other partition is derived. O(log(min(m,n))). A top-5 FAANG hard problem — tests deep binary search mastery and edge case handling.

### 4.2 — Binary Search on Condition (Rotated Arrays)

**62. Find Minimum in Rotated Sorted Array — #153**
Difficulty: Medium | Pattern: BS on condition — find inflection point
Why: No target needed. nums[mid] > nums[right] tells you which half has the minimum. Teaches BS on a property, not equality.

**63. Search in Rotated Sorted Array — #33**
Difficulty: Medium | Pattern: BS — identify sorted half, check if target is in it
Why: One half is always sorted. Check if target falls in the sorted half; go there if yes, else go opposite. Classic FAANG phone-screen.

**64. Search in Rotated Sorted Array II — #81**
Difficulty: Medium | Pattern: Rotated BS with duplicates — handle nums[left]==nums[mid]
Why: Duplicates make the sorted-half check ambiguous. The fix: left++ to skip. Tests robustness of your BS reasoning under edge cases.

**65. Find Peak Element — #162**
Difficulty: Medium | Pattern: BS on local property (move toward the rising slope)
Why: If nums[mid] < nums[mid+1], the peak is to the right; else to the left. Teaching BS on a non-sorted array where a local condition guides direction.

### 4.3 — Binary Search on Answer Space

**66. Koko Eating Bananas — #875**
Difficulty: Medium | Pattern: BS on answer — find minimum k satisfying condition
Why: The most important BS insight: binary search on the answer itself. "Find minimum X such that f(X) is true and f is monotonic." This template solves #1011, #410, #1231, and many more.

**67. Capacity to Ship Packages Within D Days — #1011**
Difficulty: Medium | Pattern: BS on answer — minimum capacity
Why: Same template as #875. Binary search on capacity; simulate to check feasibility. Reinforces the "answer space BS" template on a slightly harder feasibility function.

**68. Time Based Key-Value Store — #981**
Difficulty: Medium | Pattern: HashMap + BS on timestamps (floor value)
Why: A real-world system design problem — versioned key-value stores, audit logs, event sourcing. BS finds the largest timestamp ≤ query. Bridges data structures and binary search.

**🆕 69. Split Array Largest Sum — #410**
Difficulty: Hard | Pattern: BS on answer — minimize the maximum subarray sum
Why: Binary search on the answer (max sum allowed), greedy check if we can split into ≤ k subarrays. The "minimize the maximum" pattern is a FAANG favorite — appears in painter's partition, book allocation, and load balancing.

---

## 📂 5 — Linked Lists

### 5.1 — Traversal & Manipulation

**70. Reverse Linked List — #206**
Difficulty: Easy | Pattern: Iterative pointer reversal (prev/curr/next)
Why: The prev=null; while(curr!=null){next=curr.next; curr.next=prev; prev=curr; curr=next;} skeleton is the most reused LL snippet. Also learn the recursive version for call-stack thinking.

**71. Merge Two Sorted Lists — #21**
Difficulty: Easy | Pattern: Dummy head + two-pointer merge
Why: The dummy head node eliminates head-node edge cases entirely. This is one of the most important LL tricks. The merge logic is used in Merge K Sorted Lists and Merge Sort.

**72. Remove Nth Node From End — #19**
Difficulty: Medium | Pattern: N-gap two pointers + dummy head
Why: Fast pointer advances N steps, then both move together. When fast hits null, slow is at the target. Dummy head handles removing the head node. Tests precise off-by-one reasoning.

**73. Swap Nodes in Pairs — #24**
Difficulty: Medium | Pattern: Iterative pointer re-wiring
Why: Teaches careful prev → second → first → next re-wiring. Builds the pointer manipulation precision needed for Reverse Nodes in K-Group (#25), a common hard follow-up.

**74. Reverse Nodes in k-Group — #25**
Difficulty: Hard | Pattern: Reversal in segments + connection
Why: Combines #206 (reverse a sublist) with careful segment boundary tracking. A top-tier pointer manipulation problem. Tests whether you can compose linked list operations cleanly.

### 5.2 — Fast & Slow Pointers

**75. Linked List Cycle — #141**
Difficulty: Easy | Pattern: Floyd's fast/slow pointer (cycle detection)
Why: slow=slow.next; fast=fast.next.next — they meet if and only if there's a cycle. The canonical fast/slow problem. O(n) time, O(1) space.

**76. Linked List Cycle II — #142**
Difficulty: Medium | Pattern: Floyd's — find cycle entry point
Why: After meeting, reset one pointer to head. Both advance at speed 1 — they meet at the cycle entry. Understanding why this works builds mathematical reasoning. Used in #287 (array duplicate).

**77. Middle of the Linked List — #876**
Difficulty: Easy | Pattern: Fast/slow — midpoint
Why: When fast reaches end, slow is at mid. This midpoint subroutine is used in Merge Sort on LL, Palindrome LL, and Reorder List.

**78. Palindrome Linked List — #234**
Difficulty: Easy | Pattern: Find middle + reverse second half + compare
Why: Composes three separate patterns: #876 + #206 + two-pointer compare. A multi-step composition problem — the skill of combining patterns cleanly is what separates strong from average candidates.

**🆕 79. Intersection of Two Linked Lists — #160**
Difficulty: Easy | Pattern: Two pointers with path-length equalization
Why: Pointer A traverses listA then listB; pointer B traverses listB then listA. They meet at the intersection (or both reach null). Elegant O(1) space solution. Frequently asked at Amazon and Microsoft.

### 5.3 — Design

**80. Reorder List — #143**
Difficulty: Medium | Pattern: Find mid + reverse second half + merge alternating
Why: The ultimate LL composition problem — three algorithms in sequence, zero extra space. Clean implementation here signals mastery.

**81. Merge K Sorted Lists — #23**
Difficulty: Hard | Pattern: Min-heap (PriorityQueue) + dummy head
Why: PriorityQueue<ListNode>((a,b)->a.val-b.val) — custom comparator on a node. Models K-way merge used in databases, log aggregation, and distributed sort. Divide-and-conquer alternative teaches Merge Sort thinking.

**82. LRU Cache — #146**
Difficulty: Medium | Pattern: HashMap + Doubly Linked List
Why: (Repeated from Hashing section — it belongs in both.) The DLL gives O(1) move-to-front / evict-last. The most backend-relevant data structure design problem in all of LeetCode.

**🆕 83. Copy List with Random Pointer — #138**
Difficulty: Medium | Pattern: HashMap (original → clone) or interleaving trick
Why: Deep copy a linked list where each node has a random pointer. The O(1) space interleaving approach (weave clones between originals) is a beautiful technique. Tests pointer manipulation at its finest. Common at Facebook/Meta.

---

## 📂 6 — Stacks

### 6.1 — Stack Basics

**84. Valid Parentheses — #20**
Difficulty: Easy | Pattern: Stack for bracket matching
Why: The canonical stack problem. Push opens, pop on close and verify match. Edge cases: empty stack on close, non-empty stack at end. This pattern is the foundation of all expression parsing.

**85. Min Stack — #155**
Difficulty: Medium | Pattern: Auxiliary stack tracking running minimum
Why: A parallel minStack stores the minimum at each level. O(1) getMin(). The "augmented stack" pattern — storing metadata alongside data — appears in stock span, histogram, and monotonic stack problems.

**86. Implement Stack using Queues — #225**
Difficulty: Easy | Pattern: Simulate stack with queue rotation
Why: Teaches deep understanding of LIFO vs FIFO by forcing you to simulate one with the other. Pairs with #232 (queue using stacks). Both are classic amortized complexity questions.

### 6.2 — Monotonic Stack

**87. Daily Temperatures — #739**
Difficulty: Medium | Pattern: Monotonic decreasing stack (Next Greater Element)
Why: The gateway to monotonic stacks. Stack stores indices waiting for their "next greater" answer. When we find it, pop and record distance. This skeleton solves every "next greater/smaller element" problem.

**88. Next Greater Element I — #496**
Difficulty: Easy | Pattern: Monotonic stack + HashMap for cross-array lookup
Why: Precompute NGE for nums2 into a HashMap, then answer queries for nums1 in O(1). Bridges monotonic stacks with hashing — a combo that appears in many interview problems.

**89. Next Greater Element II — #503**
Difficulty: Medium | Pattern: Monotonic stack on circular array (modular index)
Why: Process array twice using i % n. Teaching circular array handling with a monotonic stack — the same modular trick appears in circular DP and queue problems.

**90. Car Fleet — #853**
Difficulty: Medium | Pattern: Sort + stack to simulate merging events
Why: Sort by position descending, compute arrival time. If a car arrives before the car ahead, it merges into that fleet. Stack represents current fleets. Models real-world event merging (network packets, process batches).

**91. Largest Rectangle in Histogram — #84**
Difficulty: Hard | Pattern: Monotonic increasing stack (prev/next smaller element)
Why: For each bar, the stack finds nearest smaller bar on both sides, determining max width. This is the most instructive hard stack problem — it teaches both "previous smaller" and "next smaller" in one pass. Unlocks Maximal Rectangle (#85).

**🆕 92. Sum of Subarray Minimums — #907**
Difficulty: Medium | Pattern: Monotonic stack — contribution technique
Why: For each element, calculate how many subarrays it's the minimum of using previous-less and next-less-or-equal. The "contribution" technique (how much does each element contribute to the total?) is a powerful pattern for sum-of-subarray-X problems. FAANG favorite.

**🆕 93. Maximal Rectangle — #85**
Difficulty: Hard | Pattern: Histogram per row + Largest Rectangle in Histogram
Why: Build a histogram for each row, then apply #91. Reduces a 2D problem to repeated 1D problems. This "reduce dimension" technique is a key problem-solving meta-skill. Directly extends #91.

### 6.3 — Expression Parsing

**94. Evaluate Reverse Polish Notation — #150**
Difficulty: Medium | Pattern: Stack-based RPN evaluation
Why: Push numbers, pop two on operator. The cleanest expression-evaluation problem. Backend engineers build calculators, rule engines, and query parsers — this is the algorithmic core.

**95. Basic Calculator II — #227**
Difficulty: Medium | Pattern: Stack with operator precedence (no parentheses)
Why: Handle * and / before + and - using a stack. On +/-, push; on *//, pop and compute. A realistic parser that models how compilers handle operator precedence.

**96. Decode String — #394**
Difficulty: Medium | Pattern: Two stacks (count stack + string stack) for nested decoding
Why: Nested brackets require unwinding. Two stacks — one for multipliers, one for string segments. The nested-structure decoding pattern is how you'd parse JSON, XML, or recursive data formats.

---

## 📂 7 — Queues & Deques

### 7.1 — Queue Design

**97. Implement Queue using Stacks — #232**
Difficulty: Easy | Pattern: Amortized O(1) queue via lazy transfer
Why: Pour from inbox to outbox only when outbox is empty. Total pours = total pushes → amortized O(1). Tests understanding of amortized complexity — a common interview topic.

**98. Design Circular Queue — #622**
Difficulty: Medium | Pattern: Circular buffer with head/tail and modular arithmetic
Why: (tail+1) % capacity for circular indexing. Ring buffers are everywhere in backend systems: Kafka partitions, OS I/O buffers, producer-consumer implementations.

### 7.2 — Monotonic Deque

**99. Sliding Window Maximum — #239**
Difficulty: Hard | Pattern: Monotonic decreasing deque
Why: (Also in Sliding Window section.) Deque front = current window max. Remove indices outside window from front; remove smaller indices from back before adding new. The key to all "window aggregate in O(n)" problems.

**100. Jump Game VI — #1696**
Difficulty: Medium | Pattern: DP + Monotonic Deque for window max
Why: dp[i] = nums[i] + max(dp[i-k..i-1]). Naive DP is O(nk); deque makes it O(n). The perfect bridge between DP and monotonic deque optimization — a pattern that appears in hard DP problems.

---

## 📂 8 — Trees

### 8.1 — DFS: Pre-order (Top-Down)

**101. Invert Binary Tree — #226**
Difficulty: Easy | Pattern: Pre-order DFS — swap children, then recurse
Why: The simplest recursive tree problem. Teaches top-down thinking: do the operation at the current node, then recurse. Notoriously used in a famous hiring story.

**102. Path Sum — #112**
Difficulty: Easy | Pattern: Top-down DFS with running sum (subtract as you go)
Why: Subtracting target as you descend is cleaner than accumulating and comparing at leaves. This "thread state downward" pattern is used in Path Sum II, Path Sum III, and all root-to-leaf path problems.

**103. Path Sum II — #113**
Difficulty: Medium | Pattern: DFS with path list + backtracking
Why: Adds result collection to #112. The path.add(node.val); recurse; path.remove(path.size()-1) backtracking pattern in a tree is a key skill — bridges trees and backtracking.

**104. Sum Root to Leaf Numbers — #129**
Difficulty: Medium | Pattern: Top-down DFS accumulating number digit by digit
Why: currentNum = currentNum * 10 + node.val. Tests clean pre-order state threading. Models decimal number construction in trees — appears in trie number problems.

### 8.2 — DFS: Post-order (Bottom-Up)

**105. Maximum Depth of Binary Tree — #104**
Difficulty: Easy | Pattern: Post-order DFS, return 1 + max(left, right)
Why: The simplest post-order problem. Return value bubbles upward. This bottom-up template is the skeleton for diameter, balance check, path sum, and LCA problems.

**106. Diameter of Binary Tree — #543**
Difficulty: Easy | Pattern: Post-order DFS — return height, record global max
Why: What you return (height) is different from what you record (diameter = left+right). This split is the defining characteristic of post-order tree DP and is used in Binary Tree Maximum Path Sum.

**107. Balanced Binary Tree — #110**
Difficulty: Easy | Pattern: Post-order DFS with -1 sentinel for early termination
Why: Return -1 to propagate "invalid" state without a separate boolean. The sentinel-based early exit avoids redundant computation — a clean coding pattern.

**108. Binary Tree Maximum Path Sum — #124**
Difficulty: Hard | Pattern: Post-order DFS — extend to parent OR complete path through node
Why: At each node: return node.val + max(0, left, right) to parent; record left+node+right as a candidate answer. The "what I return vs what I record" split, at its hardest. A landmark problem.

**109. Count Good Nodes in Binary Tree — #1448**
Difficulty: Medium | Pattern: Pre-order DFS passing running maximum downward
Why: Thread the maximum seen so far from root downward. Node is "good" if its value ≥ running max. Clean combination of top-down state and bottom-up counting.

### 8.3 — BFS: Level Order

**110. Binary Tree Level Order Traversal — #102**
Difficulty: Medium | Pattern: BFS with int size = queue.size() level snapshot
Why: The canonical BFS template. size captures the level boundary. This loop structure is used in 15+ BFS problems — zigzag traversal, right side view, level averages.

**111. Binary Tree Right Side View — #199**
Difficulty: Medium | Pattern: BFS level-order — take last element per level
Why: Two valid approaches: BFS (last element per level) and DFS (right-first, first visit per depth). Great for discussing trade-offs between BFS and DFS.

**112. Binary Tree Zigzag Level Order Traversal — #103**
Difficulty: Medium | Pattern: BFS with alternating direction flag
Why: Same BFS template as #102 but with a leftToRight boolean toggle per level. Tests clean level-order BFS with a state flag.

**113. Average of Levels in Binary Tree — #637**
Difficulty: Easy | Pattern: BFS level-order — aggregate per level
Why: Compute sum per level, divide by size. Reinforces BFS level template with a different aggregate. Easy but valuable for solidifying the pattern.

### 8.4 — Dual-Tree / Structural

**114. Same Tree — #100**
Difficulty: Easy | Pattern: Simultaneous DFS on two trees
Why: Base cases — both null (true), one null (false), values differ (false). The template for Subtree of Another Tree and Symmetric Tree.

**115. Subtree of Another Tree — #572**
Difficulty: Easy | Pattern: DFS outer traversal + isSameTree inner check
Why: Reuse #100 as a subroutine. Outer DFS tries every node as root; isSameTree checks from there. Teaching problem decomposition and function composition.

**116. Symmetric Tree — #101**
Difficulty: Easy | Pattern: Mirror DFS (left.left vs right.right, left.right vs right.left)
Why: A tree is symmetric if its left subtree mirrors its right. The mirrored recursion pattern tests flexible recursive thinking.

### 8.5 — Binary Search Trees

**117. Validate Binary Search Tree — #98**
Difficulty: Medium | Pattern: DFS with (min, max) bounds passed down
Why: Local parent comparison is insufficient — you need global bounds. dfs(node, min, max) is the template for all BST validation problems. Very commonly asked.

**118. Lowest Common Ancestor of a BST — #235**
Difficulty: Medium | Pattern: BST ordering to navigate without full traversal
Why: Both smaller → go left; both larger → go right; split → current node is LCA. Exploiting BST structure for O(h) traversal. Compare with #236 (general tree) to understand when structure helps.

**119. Lowest Common Ancestor of a Binary Tree — #236**
Difficulty: Medium | Pattern: Post-order DFS — if both sides return non-null, current is LCA
Why: General LCA without BST structure. If left subtree found p and right found q, current node is LCA. A classic post-order pattern that appears in tree path problems.

**120. Kth Smallest Element in a BST — #230**
Difficulty: Medium | Pattern: In-order traversal = sorted BST output
Why: BST in-order yields elements in sorted order — fundamental BST property. Iterative in-order with an explicit stack is a key Java interview skill for BST iterator problems.

**121. Construct Binary Tree from Preorder and Inorder — #105**
Difficulty: Medium | Pattern: Recursive tree construction using index splits
Why: Preorder[0] = root. Find root in inorder → splits into left/right subtrees. Teaches that preorder+inorder uniquely determine a binary tree. Bridges traversal understanding and construction.

**122. Serialize and Deserialize Binary Tree — #297**
Difficulty: Hard | Pattern: BFS/DFS serialization with null markers
Why: A top backend engineering problem. How do you persist a tree to a string and reconstruct it? Tests both traversal and parsing. Used in distributed systems for tree-structured data serialization (ASTs, config trees).

**🆕 123. Flatten Binary Tree to Linked List — #114**
Difficulty: Medium | Pattern: Reverse post-order (right → left → root) with prev pointer
Why: Process right subtree first, then left, then set current.right = prev. The reverse post-order trick avoids overwriting pointers you still need. Tests deep understanding of traversal order and pointer management.

**🆕 124. Binary Tree Vertical Order Traversal — #314 / #987**
Difficulty: Medium | Pattern: BFS + column tracking with TreeMap
Why: Assign column indices (root=0, left=col-1, right=col+1). BFS ensures top-to-bottom order within each column. TreeMap sorts columns. A frequently asked tree problem at Facebook/Meta and Amazon.

---

## 📂 9 — Tries

**125. Implement Trie (Prefix Tree) — #208**
Difficulty: Medium | Pattern: TrieNode with children[26] + isEnd flag
Why: Build this from scratch. The TrieNode class with a children array and isEnd boolean is the foundation of all trie problems. You will implement this in the interview.

**126. Design Add and Search Words Data Structure — #211**
Difficulty: Medium | Pattern: Trie + DFS for wildcard matching (. = any char)
Why: Adds wildcard search to the trie. When . is encountered, recurse into all children. This Trie+DFS combination is used in word games, regex engines, and dictionary lookup.

**127. Word Search II — #212**
Difficulty: Hard | Pattern: Trie + DFS backtracking on 2D grid with pruning
Why: Without Trie, brute force is O(N×M×4^L×W) — too slow. Trie prunes dead paths immediately. Combining Trie prefix pruning with grid backtracking is a top-tier problem that bridges three topics.

---

## 📂 10 — Heaps & Priority Queues

**128. Kth Largest Element in an Array — #215**
Difficulty: Medium | Pattern: Min-heap of size K / QuickSelect
Why: Min-heap of size K maintains the K largest seen. When heap exceeds K, pop the minimum. QuickSelect is the O(n) average alternative. Both are essential. The heap approach is used for "top K from a stream."

**129. K Closest Points to Origin — #973**
Difficulty: Medium | Pattern: Max-heap of size K with custom comparator
Why: Use a max-heap to keep K smallest distances. When heap exceeds K, remove the max (farthest). Teaches custom comparator design: (a,b) -> dist(b)-dist(a). Generalizes to any "K closest by metric" problem.

**130. Top K Frequent Words — #692**
Difficulty: Medium | Pattern: Min-heap with composite comparator (freq desc, alpha asc)
Why: Sorting by frequency AND alphabetical order requires a composite comparator. Tests careful Comparator design in Java — a real-world skill for ranking and sorting systems.

**131. Find Median from Data Stream — #295**
Difficulty: Hard | Pattern: Two heaps — max-heap (lower half) + min-heap (upper half)
Why: The two-heap pattern for streaming median is asked constantly. Balance heaps so sizes differ by at most 1. Median = top of larger heap or average of both tops. Used in monitoring dashboards and SLA percentile tracking.

**132. Task Scheduler — #621**
Difficulty: Medium | Pattern: Greedy + max-heap (most frequent task first)
Why: Always schedule the most frequent remaining task. Max-heap picks it. Models CPU scheduling, job queues, and rate-limited API call ordering — a real backend simulation problem.

**133. Reorganize String — #767**
Difficulty: Medium | Pattern: Greedy + max-heap, place most frequent alternately
Why: Same greedy idea as #621 but applied to string construction. If most frequent char has count > (n+1)/2, it's impossible. Otherwise, greedily alternate. Models distributed write balancing.

**134. Merge K Sorted Lists — #23**
Difficulty: Hard | Pattern: Min-heap + dummy head (K-way merge)
Why: (Also in Linked Lists.) The PQ-based K-way merge is the algorithmic core of database merge joins, external sort, and log aggregation systems.

**135. Ugly Number II — #264**
Difficulty: Medium | Pattern: Min-heap or 3-pointer DP for ordered generation
Why: Generate ugly numbers in sorted order. The heap approach naturally maintains sorted order; the 3-pointer DP is a beautiful O(n) optimization. Models ordered generation from multiple sorted sequences.

**🆕 136. Smallest Range Covering Elements from K Lists — #632**
Difficulty: Hard | Pattern: Min-heap + sliding window across K sorted lists
Why: Maintain one element from each list in a min-heap, track the current max. The range is [heap.min, currentMax]. Advance the min pointer. Models multi-stream synchronization — relevant to distributed log merging and real-time data fusion.

---

## 📂 11 — Graphs: DFS

### 11.1 — Grid DFS (Flood Fill)

**137. Number of Islands — #200**
Difficulty: Medium | Pattern: Grid DFS — visit and mark (flood fill)
Why: The canonical graph/grid problem. The "mark visited then recurse in 4 directions" pattern is the template for all 2D connectivity problems. Non-negotiable.

**138. Max Area of Island — #695**
Difficulty: Medium | Pattern: Grid DFS — return component size
Why: DFS returns the area of each island component. Teaches that DFS can return values, not just mark visited. The "DFS returns component property" pattern appears in 10+ grid problems.

**139. Flood Fill — #733**
Difficulty: Easy | Pattern: DFS with color replacement (handle same-color edge case)
Why: The simplest grid DFS. The edge case: if oldColor == newColor, return immediately to avoid infinite loops. Models paint-bucket tool, region recoloring, and network segment updates.

**140. Surrounded Regions — #130**
Difficulty: Medium | Pattern: Border DFS to mark "safe" cells, then flip the rest
Why: Don't solve the hard direction — find all 'O's connected to the border (easy) and mark them safe. Everything else gets flipped. Teaches solving the complement when that's easier.

**141. Number of Enclaves — #1020**
Difficulty: Medium | Pattern: Border DFS to subtract border-connected cells
Why: Extends #130 — count land cells NOT reachable from border. DFS from all border land, mark visited, then count remaining. Reinforces the "border reachability" pattern.

### 11.2 — Component & Cycle DFS

**142. Clone Graph — #133**
Difficulty: Medium | Pattern: DFS + HashMap (original → clone) for cycle-safe copying
Why: The HashMap<Node, Node> maps original to its clone, preventing infinite loops in cyclic graphs. This "visited map" pattern is used in any graph copy/serialization problem.

**143. Course Schedule — #207**
Difficulty: Medium | Pattern: DFS cycle detection — 3-color marking (white/gray/black)
Why: White = unvisited, Gray = in current path, Black = fully processed. Gray node encountered → cycle. This is the cleanest cycle detection in directed graphs and is used in build systems, dependency graphs.

**144. Path With Maximum Probability — #1514**
Difficulty: Medium | Pattern: Modified Dijkstra (maximize product of probabilities)
Why: Instead of minimizing cost, maximize probability. Use max-heap. Shows that shortest-path algorithms are general "optimize along path" tools — the objective function can change.

**145. Pacific Atlantic Water Flow — #417**
Difficulty: Medium | Pattern: Reverse DFS/BFS from both borders, find intersection
Why: Instead of "can (i,j) reach the ocean?", ask "which cells can the ocean reach going backwards?". Multi-source reverse DFS from both borders. The intersection is the answer. A key problem-reversal insight.

**🆕 146. Graph Valid Tree (Undirected Cycle Detection) — #261 (NeetCode free)**
Difficulty: Medium | Pattern: DFS/Union-Find — connected + acyclic = tree
Why: A tree has exactly n-1 edges and is connected. DFS with parent tracking detects cycles in undirected graphs (if neighbor ≠ parent and is visited → cycle). Fills the undirected cycle detection gap. Also solvable with Union-Find.

---

## 📂 12 — Graphs: BFS

### 12.1 — Grid BFS & Multi-Source BFS

**147. 01 Matrix — #542**
Difficulty: Medium | Pattern: Multi-source BFS from all 0s simultaneously
Why: Add all 0s to the queue first, then BFS outward — each non-zero cell gets its distance when first visited. This "expand from all sources simultaneously" is the BFS distance-from-source pattern.

**148. Rotting Oranges — #994**
Difficulty: Medium | Pattern: Multi-source BFS (simultaneous spread) + fresh-count tracking
Why: All rotten oranges spread simultaneously each minute. Level count = minutes. Track fresh count to detect if any are unreachable. Models virus spread, network propagation, and fire simulation.

**149. Walls and Gates — #286 (NeetCode free)**
Difficulty: Medium | Pattern: Multi-source BFS from all gates
Why: Same as #542 but with named semantics. BFS from all gates fills distances to empty rooms. Reinforces multi-source BFS and handles unreachable cells (INF remains).

**150. Shortest Path in Binary Matrix — #1091**
Difficulty: Medium | Pattern: BFS on grid (8-directional), shortest path
Why: BFS always finds the shortest unweighted path. This problem adds 8-directional movement, which is a common variant. BFS level count = path length.

### 12.2 — Graph BFS & Shortest Path

**151. Word Ladder — #127**
Difficulty: Hard | Pattern: BFS on implicit graph (word → neighbor words one char apart)
Why: Each word is a node; edges exist between words that differ by one character. Building the implicit graph and running BFS finds the shortest transformation sequence. Models state-space search — used in NLP, configuration management, and genetic algorithms.

**152. Snakes and Ladders — #909**
Difficulty: Medium | Pattern: BFS on modified graph (teleportation edges)
Why: BFS on a board with teleportation (snakes/ladders). Teaches encoding 2D board index to 1D and handling special "jump" edges in BFS. Models routing with shortcuts.

**153. Open the Lock — #752**
Difficulty: Medium | Pattern: BFS on state space (string states as nodes)
Why: Each lock state is a node; adjacent states differ by one wheel turn. BFS finds minimum turns. State-space BFS is a general technique for puzzle/game problems and config transition problems.

**154. Course Schedule II — #210**
Difficulty: Medium | Pattern: Kahn's BFS topological sort (in-degree tracking)
Why: (Also in Topological Sort section.) BFS version of topological sort. Process nodes with in-degree 0 first; decrement neighbors' in-degrees. If all nodes processed → no cycle. Output = topological order.

---

## 📂 13 — Graphs: Topological Sort

**155. Course Schedule — #207**
Difficulty: Medium | Pattern: Topological sort — cycle detection (DFS 3-color or Kahn's)
Why: The entry-level toposort problem. Learn both DFS (3-color marking) and Kahn's BFS (in-degree). Prerequisite relationships = directed graph = detect if a valid order exists.

**156. Course Schedule II — #210**
Difficulty: Medium | Pattern: Kahn's BFS — output topological order
Why: Extends #207 to output the actual order. Kahn's is cleaner here. This is how Maven/Gradle resolve build order, how microservice deployment orders are determined.

**157. Alien Dictionary — #269 (NeetCode free)**
Difficulty: Hard | Pattern: Build graph from adjacent word pairs + topological sort
Why: Derive character ordering from sorted word list. For adjacent words, the first differing character gives an edge. Then topological sort the characters. Models deriving constraints from observations — a real-world inference problem.

**158. Sequence Reconstruction — #444 (NeetCode free)**
Difficulty: Medium | Pattern: Topological sort — verify unique ordering
Why: Check if nums is the only possible topological order given sequences. At each Kahn's step, if queue has more than one element, the ordering is not unique. Tests deep understanding of when toposort has a unique solution.

---

## 📂 14 — Graphs: Union Find (DSU)

**159. Number of Connected Components — #323 (NeetCode free)**
Difficulty: Medium | Pattern: Union-Find — component count
Why: The entry-level Union-Find problem. Start with N components, decrement on each successful union. This is the cleanest introduction to DSU mechanics.

**160. Graph Valid Tree — #261 (NeetCode free)**
Difficulty: Medium | Pattern: Union-Find — detect cycle + check connectivity
Why: A tree = connected + acyclic. During union, if two nodes already share a root → cycle detected. Final check: exactly 1 component. Also teachable via DFS.

**161. Redundant Connection — #684**
Difficulty: Medium | Pattern: Union-Find — find the edge that creates a cycle
Why: Process edges one by one. The first edge where both endpoints already have the same root is the redundant edge. A clean, practical DSU application.

**162. Accounts Merge — #721**
Difficulty: Medium | Pattern: Union-Find to merge sets by shared email
Why: Union all emails in each account. Emails sharing a component belong to the same person. Then group and sort. A real-world problem: user deduplication, identity resolution in backend systems.

**163. Most Stones Removed with Same Row or Column — #947**
Difficulty: Medium | Pattern: Union-Find on rows and columns (coordinate compression)
Why: Union stones sharing a row or column. The max removable = total stones − number of components. A clever DSU formulation where the insight (components determine the answer) is non-obvious.

---

## 📂 15 — Graphs: Shortest Path

**164. Network Delay Time — #743**
Difficulty: Medium | Pattern: Dijkstra's algorithm (min-heap + dist array)
Why: PriorityQueue<int[]> ordered by cost. Relax edges, update dist[]. This is the canonical Dijkstra implementation in Java. Models network latency, routing protocols (OSPF), and any minimum-cost-path problem.

**165. Cheapest Flights Within K Stops — #787**
Difficulty: Medium | Pattern: Bellman-Ford with K iterations
Why: "At most K edges" breaks Dijkstra — requires Bellman-Ford with K relaxation rounds. Uses a copy of the dist array per iteration to avoid multi-hop updates. Models SLA-constrained routing and hop-limited messaging.

**166. Path With Minimum Effort — #1631**
Difficulty: Medium | Pattern: Dijkstra with custom edge weight (max height diff along path)
Why: "Minimize the maximum effort along a path" → Dijkstra where the cost function is max(currentEffort, abs(diff)). Shows Dijkstra is a general framework — the objective function can be min-max, not just min-sum.

**167. Find the City With the Smallest Number of Neighbors — #1334**
Difficulty: Medium | Pattern: Floyd-Warshall all-pairs shortest path
Why: When you need shortest paths between all pairs, Floyd-Warshall O(V³) is the right tool. dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j]). Models city reachability, full-mesh network analysis.

**168. Swim in Rising Water — #778**
Difficulty: Hard | Pattern: Dijkstra / Binary search + BFS
Why: Minimize the maximum value encountered along a path. Two approaches: Dijkstra (treat cell value as cost) or binary search on answer + BFS feasibility check. A hard problem that reinforces "binary search on answer" in a graph context.

**🆕 169. Min Cost to Connect All Points — #1584**
Difficulty: Medium | Pattern: Prim's / Kruskal's Minimum Spanning Tree
Why: The canonical MST problem on LeetCode. Prim's with a min-heap or Kruskal's with Union-Find. MST is asked at Google and Amazon — models network design, cable routing, and cluster connectivity. Fills the MST gap entirely.

---

## 📂 16 — Dynamic Programming: 1D

### 16.1 — Fibonacci / Linear DP

**170. Climbing Stairs — #70**
Difficulty: Easy | Pattern: Fibonacci DP (dp[i] = dp[i-1] + dp[i-2])
Why: The gateway DP problem. State → recurrence → base case. Optimize to O(1) space with two variables. Fibonacci-style transitions appear in House Robber, Jump Game, and counting problems.

**171. House Robber — #198**
Difficulty: Medium | Pattern: "Take or skip" decision DP
Why: dp[i] = max(dp[i-1], dp[i-2] + nums[i]). Space-optimize to two variables. The "take or skip" pattern is the most common 1D DP decision. Spawns #213 (circular) and #337 (tree).

**172. House Robber II — #213**
Difficulty: Medium | Pattern: Circular array DP — solve twice (exclude first OR last)
Why: Circular constraint means first and last can't both be taken. Solve on [0..n-2] and [1..n-1], take the max. This "break the circle by solving twice" trick appears in circular interval and circular DP problems.

**173. Jump Game — #55**
Difficulty: Medium | Pattern: Greedy — track max reachable index
Why: maxReach = max(maxReach, i + nums[i]). If i > maxReach at any point, return false. The greedy insight is cleaner than DP here. Teaching when greedy suffices over DP is a key meta-skill.

**174. Jump Game II — #45**
Difficulty: Medium | Pattern: Greedy — BFS-like level jumps
Why: Think of each "range of reachable positions" as a BFS level. currentEnd marks the end of the current level; when i == currentEnd, increment jumps and extend to farthest. Greedy BFS on an implicit graph.

### 16.2 — Decision / Path DP

**175. Word Break — #139**
Difficulty: Medium | Pattern: 1D DP on string — dp[i] = can we segment s[0..i-1]
Why: For each position, check all valid word endings using a HashSet. dp[i] = true if dp[j] is true and s[j..i-1] is in the dictionary. Directly models tokenization, NLP preprocessing, and code parsing.

**176. Decode Ways — #91**
Difficulty: Medium | Pattern: 1D DP with conditional transitions (handle '0' carefully)
Why: Two transitions: single digit and two digits. Each has validity conditions ('0' is tricky). Tests precision in DP condition handling. Models protocol decoders, base64, and run-length encoding.

**177. Coin Change — #322**
Difficulty: Medium | Pattern: Unbounded knapsack — minimize count
Why: dp[i] = min(dp[i], dp[i-coin] + 1) for each coin. The forward-fill unbounded DP pattern. Foundation for all "minimum cost to reach target with unlimited items" problems.

**178. Coin Change II — #518**
Difficulty: Medium | Pattern: Unbounded knapsack — count ways
Why: From "minimum count" to "number of ways." Iterate coins in outer loop and amounts in inner loop to avoid counting permutations as different combinations. The ordering of loops matters — a subtle but critical DP insight.

**179. Counting Bits — #338**
Difficulty: Easy | Pattern: DP using bit relationship (dp[i] = dp[i>>1] + (i&1))
Why: Derive DP state from mathematical bit structure. The i >> 1 relationship (right shift removes last bit) gives a recurrence from smaller subproblems. Introduces bitmask DP thinking.

**180. Longest Increasing Subsequence — #300**
Difficulty: Medium | Pattern: O(n²) DP or O(n log n) patience sorting
Why: A landmark DP problem. dp[i] = LIS ending at index i. The O(n log n) solution using binary search on a patience sort array is a must-know optimization. LIS appears as a subproblem in many advanced DP and greedy problems.

**181. Partition Equal Subset Sum — #416**
Difficulty: Medium | Pattern: 0/1 knapsack — boolean subset sum
Why: dp[j] = dp[j] || dp[j-nums[i]]. Iterate j backwards to avoid reusing elements. This backward iteration for 0/1 (no-repeat) knapsack vs forward iteration for unbounded knapsack is a critical distinction.

**🆕 182. Best Time to Buy and Sell Stock with Cooldown — #309**
Difficulty: Medium | Pattern: State-machine DP (hold / sold / rest states)
Why: Three states: holding stock, just sold, resting. Transitions: hold = max(hold, rest-price), sold = hold+price, rest = max(rest, sold). The state-machine DP pattern is the cleanest way to model multi-state decisions. Extends the stock series from #121 into proper DP territory.

**🆕 183. Best Time to Buy and Sell Stock IV — #188**
Difficulty: Hard | Pattern: State-machine DP with k transactions
Why: Generalized stock problem with at most k transactions. dp[k][0] = not holding, dp[k][1] = holding. When k ≥ n/2, reduce to unlimited transactions (greedy). The "generalize then optimize" approach is a key DP meta-skill.

**🆕 184. Longest Increasing Path in a Matrix — #329**
Difficulty: Hard | Pattern: DFS + memoization on 2D grid (DAG DP)
Why: Each cell's longest path depends on neighbors with smaller values — forming a DAG. DFS with memo[i][j] caching avoids recomputation. This "grid as DAG" + memoization pattern is asked at Google and Apple. Bridges grid DFS with DP.

---

## 📂 17 — Dynamic Programming: 2D

**185. Unique Paths — #62**
Difficulty: Medium | Pattern: 2D DP grid — count paths
Why: dp[i][j] = dp[i-1][j] + dp[i][j-1]. The simplest 2D DP problem. Space-optimize to a 1D array. Foundation for obstacle variants and minimum path sum.

**186. Minimum Path Sum — #64**
Difficulty: Medium | Pattern: 2D DP grid — minimize cost
Why: Same 2D structure as #62 but minimizing. Models cheapest route through a cost grid — directly applicable to network hop costs, pipeline routing, and game pathfinding.

**187. Unique Paths II — #63**
Difficulty: Medium | Pattern: 2D DP with obstacle handling (dp[i][j]=0 on obstacle)
Why: Extends #62 with obstacles. Tests clean initialization (first row/column handling with obstacles). Builds precision in 2D DP.

**188. Longest Common Subsequence — #1143**
Difficulty: Medium | Pattern: 2D DP on two sequences
Why: If s1[i]==s2[j]: dp[i][j] = dp[i-1][j-1]+1. Else: max(dp[i-1][j], dp[i][j-1]). LCS is the foundation of git diff, DNA alignment, spell correction, and Edit Distance.

**189. Edit Distance — #72**
Difficulty: Medium | Pattern: Levenshtein distance DP (insert/delete/replace)
Why: Three-way recurrence. Used in spell checkers, autocorrect, fuzzy search, and NLP similarity. One of the most real-world-relevant DP problems for backend engineers.

**190. Interleaving String — #97**
Difficulty: Medium | Pattern: 2D DP — can s3 be formed by interleaving s1 and s2
Why: dp[i][j] = can first i+j chars of s3 be formed from s1[0..i-1] and s2[0..j-1]. A clean 2D DP that models string merging — relevant to log interleaving analysis and merge conflict detection.

**191. Distinct Subsequences — #115**
Difficulty: Hard | Pattern: 2D DP — count ways to form t as a subsequence of s
Why: dp[i][j] = number of ways to form t[0..i-1] from s[0..j-1]. If chars match: dp[i][j] = dp[i-1][j-1] + dp[i][j-1]. Counts embeddings of one string in another — appears in bioinformatics and pattern frequency analysis.

**192. Maximal Square — #221**
Difficulty: Medium | Pattern: 2D DP — dp[i][j] = side length of largest all-1 square ending here
Why: dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1. A beautiful geometric DP. The min-of-three-neighbors formula is non-obvious and highly instructive. Extends to Maximal Rectangle.

**🆕 193. Regular Expression Matching — #10**
Difficulty: Hard | Pattern: 2D DP — match string against pattern with . and *
Why: dp[i][j] = does s[0..i-1] match p[0..j-1]. The * case branches: zero occurrences (dp[i][j-2]) or one+ (dp[i-1][j] if chars match). A top-5 hard DP problem. Tests precise state transition reasoning. Asked at Google and Facebook.

**🆕 194. Wildcard Matching — #44**
Difficulty: Hard | Pattern: 2D DP — match string against pattern with ? and *
Why: Similar to #10 but * matches any sequence (not "zero or more of preceding"). dp[i][j] = dp[i-1][j] (extend *) or dp[i][j-1] (empty *). Pairs with #10 to cover all pattern matching DP.

---

## 📂 18 — Dynamic Programming: Intervals

**195. Longest Palindromic Substring — #5**
Difficulty: Medium | Pattern: Expand-around-center or 2D interval DP
Why: (Repeated from Strings.) The expand-around-center O(n²) approach is more elegant than the O(n²) DP table. Knowing both approaches is valuable — the DP table approach is the entry to interval DP.

**196. Palindromic Substrings — #647**
Difficulty: Medium | Pattern: Expand-around-center — count all palindromes
Why: (Repeated from Strings.) Together with #5, these two cover all palindrome problem variants.

**197. Minimum Cost Tree From Leaf Values — #1130**
Difficulty: Medium | Pattern: Interval DP or monotonic stack
Why: Teaches interval DP where dp[i][j] = minimum cost to build a subtree from leaves [i,j]. The greedy/stack approach (remove smallest element, cost = product with smaller neighbor) is equally instructive.

**198. Burst Balloons — #312**
Difficulty: Hard | Pattern: Interval DP — think about which balloon to pop LAST
Why: Counterintuitive: instead of which to pop first, think about which to pop last in range [i,j]. The last-popped balloon's neighbors are i-1 and j+1 (the boundaries). A paradigm-shifting problem that teaches "think in reverse" for interval DP.

---

## 📂 19 — Dynamic Programming: Knapsack

**199. Partition Equal Subset Sum — #416**
Difficulty: Medium | Pattern: 0/1 Knapsack — boolean (can we form target sum?)
Why: (Repeated from 1D DP.) The canonical 0/1 knapsack. Backward iteration is essential. Must-know.

**200. Last Stone Weight II — #1049**
Difficulty: Medium | Pattern: 0/1 Knapsack — minimize the difference between two groups
Why: Minimize |S1 - S2| = find subset with sum closest to total/2. Extends #416 — instead of exact target, find closest achievable sum. Tests flexible application of the 0/1 knapsack.

**201. Target Sum — #494**
Difficulty: Medium | Pattern: 0/1 Knapsack (count ways) or DFS + memoization
Why: From "can we?" (#416) to "how many ways?" A natural extension. The memoization approach (HashMap<(index, sum), count>) is also a great intro to top-down DP. Both approaches tested in interviews.

**202. Coin Change II — #518**
Difficulty: Medium | Pattern: Unbounded Knapsack — count combinations
Why: (Repeated from 1D DP.) The canonical unbounded knapsack counting problem. Outer loop = coins, inner loop = amounts. Crucial loop ordering distinction vs 0/1.

**203. Ones and Zeroes — #474**
Difficulty: Medium | Pattern: 2D 0/1 Knapsack (two constraints: count of 0s and 1s)
Why: dp[i][j] = max strings using at most i zeros and j ones. A 2D knapsack — two capacity dimensions. Tests generalization of the knapsack pattern beyond a single constraint.

---

## 📂 20 — Dynamic Programming: Trees & Advanced

**🆕 204. House Robber III — #337**
Difficulty: Medium | Pattern: DP on trees — rob or skip each node
Why: At each node, return [robThis, skipThis]. robThis = node.val + skipLeft + skipRight. skipThis = max(robLeft, skipLeft) + max(robRight, skipRight). The canonical "DP on trees" problem. Directly extends the House Robber series (#198, #213) into tree structure.

**🆕 205. Cherry Pickup II — #1463**
Difficulty: Hard | Pattern: 3D DP — two agents on a grid simultaneously
Why: Two robots collect cherries moving downward. dp[row][col1][col2] = max cherries. The "two agents" DP pattern models parallel resource collection — relevant to multi-robot coordination and parallel processing optimization.

---

## 📂 21 — Intervals & Greedy

**206. Meeting Rooms — #252 (NeetCode free)**
Difficulty: Easy | Pattern: Sort by start, check adjacent overlap
Why: Sort by start time. If any intervals[i].start < intervals[i-1].end → overlap → return false. The simplest interval problem and the conceptual foundation for all others.

**207. Merge Intervals — #56**
Difficulty: Medium | Pattern: Sort by start + greedy extension
Why: Sort by start. If current overlaps with last merged, extend end. Otherwise, add new interval. Appears in calendar merging, IP range consolidation, and database VACUUM operations.

**208. Insert Interval — #57**
Difficulty: Medium | Pattern: 3-phase scan (before / overlap / after)
Why: Already sorted. Three phases: add all intervals ending before new starts, merge all overlapping, add all starting after new ends. A state-machine scan — tests boundary precision.

**209. Non-overlapping Intervals — #435**
Difficulty: Medium | Pattern: Activity selection — sort by end time, greedy keep
Why: The Activity Selection Problem — sort by end time, greedily keep intervals finishing earliest. Provably optimal greedy. Used in task scheduling and resource allocation. The "sort by end" vs "sort by start" distinction is critical.

**210. Meeting Rooms II — #253 (NeetCode free)**
Difficulty: Medium | Pattern: Min-heap tracking active end times / sweep line
Why: "Minimum rooms needed" = "maximum overlap at any point." Heap approach: sort by start, use min-heap of end times; reuse a room if earliest end ≤ current start. Models database connection pool sizing and server capacity planning.

**211. Minimum Number of Arrows to Burst Balloons — #452**
Difficulty: Medium | Pattern: Greedy — sort by end, shoot at each end
Why: An arrow at position p bursts all balloons with start ≤ p ≤ end. Greedily shoot at the end of each unpopped balloon. Same greedy as Activity Selection (#435) in disguise.

**212. Jump Game — #55**
Difficulty: Medium | Pattern: Greedy — max reachable index
Why: (Repeated from DP section.) Interval-like reasoning: can we reach the end from the current reachable range? Greedy scan is O(n) vs O(n²) DP.

---

## 📂 22 — Backtracking

**213. Subsets — #78**
Difficulty: Medium | Pattern: Backtracking — generate power set
Why: The purest backtracking problem. choose(nums[i]); dfs(i+1); unchoose(). Every combination, permutation, and partition problem uses this skeleton.

**214. Subsets II — #90**
Difficulty: Medium | Pattern: Backtracking with deduplication at same recursion level
Why: Sort + if(i > start && nums[i] == nums[i-1]) continue. This single deduplication line appears in Combinations II, Permutations II, and 3Sum. Master it here.

**215. Permutations — #46**
Difficulty: Medium | Pattern: Backtracking with boolean[] used
Why: Order matters → use boolean[] used instead of start index. The distinction between subsets (use start) and permutations (use used[]) unlocks the entire backtracking problem tree.

**216. Permutations II — #47**
Difficulty: Medium | Pattern: Backtracking with deduplication for permutations
Why: Sort + if(used[i] || (i>0 && nums[i]==nums[i-1] && !used[i-1])) continue. The dedup condition for permutations is subtler than for subsets. A complete test of backtracking mastery.

**217. Combination Sum — #39**
Difficulty: Medium | Pattern: Backtracking — unlimited reuse (pass i, not i+1)
Why: Pass i (not i+1) to allow reuse of the same element. Unbounded backtracking mirrors unbounded knapsack. Models "reach target budget with unlimited items."

**218. Combination Sum II — #40**
Difficulty: Medium | Pattern: Backtracking — no reuse + deduplication
Why: Sort + deduplication (same as #90) + pass i+1. Combines dedup from #90 with no-reuse rule. Completing both #39 and #40 fully covers the "with/without reuse + with/without duplicates" matrix.

**219. Palindrome Partitioning — #131**
Difficulty: Medium | Pattern: Backtracking with palindrome check
Why: At each step, try all suffixes from current position that are palindromes. Teaches backtracking with a constraint check (is this partition valid?). The palindrome check can be optimized with DP preprocessing.

**220. Word Search — #79**
Difficulty: Medium | Pattern: Backtracking on 2D grid (temp mark visited)
Why: Mark board[r][c] = '#' before recursing, restore after. Cleaner than a separate visited matrix. The template for all grid backtracking problems.

**221. N-Queens — #51**
Difficulty: Hard | Pattern: Backtracking with 3 constraint sets (cols, diag1, diag2)
Why: Three HashSets track attacked columns and both diagonals. O(1) constraint check. The classic constraint-satisfaction backtracking problem. Models placement problems in distributed systems (shard placement, rack-aware scheduling).

**222. Letter Combinations of a Phone Number — #17**
Difficulty: Medium | Pattern: Backtracking on a decision map
Why: Maps each digit to its characters; backtracking builds combinations. Models API path generation, feature flag combinations, and config permutation generation.

**🆕 223. Generate Parentheses — #22**
Difficulty: Medium | Pattern: Backtracking with open/close count constraints
Why: At each step: add '(' if open < n, add ')' if close < open. The constraint-based branching is a clean model for any "generate all valid structures" problem. Frequently asked at every FAANG company. Models balanced delimiter generation.

---

## 📂 23 — Bit Manipulation

**224. Single Number — #136**
Difficulty: Easy | Pattern: XOR self-cancellation (a^a=0, a^0=a)
Why: XOR all elements — pairs cancel, unique survives. O(1) space. Gateway to all XOR-based problems. Teach this pattern, and Single Number II/III become approachable.

**225. Single Number II — #137**
Difficulty: Medium | Pattern: Bit counting — find element appearing once among triples
Why: Count each bit modulo 3. The bit that sums to 1 mod 3 is the unique element's bit. This "count bits mod k" pattern is general — works for any frequency except the unique element.

**226. Missing Number — #268**
Difficulty: Easy | Pattern: XOR with index-value pairs (or Gauss sum)
Why: XOR 0..n with all elements — the missing number remains. Two clean approaches; XOR avoids overflow concerns.

**227. Number of 1 Bits — #191**
Difficulty: Easy | Pattern: n & (n-1) clears the lowest set bit
Why: Count iterations until n == 0. This trick also answers "is n a power of 2?" (n & (n-1) == 0). Appears in Power of Two, Subsets enumeration, and bitmask DP.

**228. Counting Bits — #338**
Difficulty: Easy | Pattern: DP with bit structure (dp[i] = dp[i>>1] + (i&1))
Why: (Also in DP section.) The i >> 1 relationship gives a DP recurrence from bit structure. Teaches deriving DP transitions from mathematical properties.

**229. Reverse Bits — #190**
Difficulty: Easy | Pattern: Extract and place bits
Why: (n >>> i) & 1 extracts bit i; bit << (31-i) places it in the mirror position. Systematic bit manipulation used in network protocol headers and binary encoding.

**230. Sum of Two Integers — #371**
Difficulty: Medium | Pattern: XOR for sum, AND+shift for carry
Why: a^b = sum without carry; (a&b)<<1 = carry. Repeat until carry = 0. Shows how CPUs perform addition. Asked to test understanding of arithmetic at the hardware level.

---

## 📂 24 — Math & Simulation

**231. Happy Number — #202**
Difficulty: Easy | Pattern: Fast/slow pointer cycle detection on a number sequence
Why: The sum-of-squares process either reaches 1 or cycles. Fast/slow pointer detects the cycle. Bridges number theory with cycle detection — a creative application of a pointer technique.

**232. Reverse Integer — #7**
Difficulty: Medium | Pattern: Digit extraction + overflow detection
Why: rev = rev * 10 + digit. Overflow check: rev > Integer.MAX_VALUE / 10. Tests careful integer boundary handling — essential in any backend service handling user-provided numeric input.

**233. Pow(x, n) — #50**
Difficulty: Medium | Pattern: Fast exponentiation (binary exponentiation)
Why: power(x, n) = power(x*x, n/2) if n is even. O(log n) vs O(n) naive. Binary exponentiation is used in cryptography (modular exponentiation), large number multiplication, and matrix exponentiation for DP optimization.

**234. Spiral Matrix — #54**
Difficulty: Medium | Pattern: Layer-by-layer simulation with boundary tracking
Why: Shrink boundaries (top, bottom, left, right) after each direction. A clean simulation problem that tests careful boundary management — the same skill needed in matrix rotation, image processing, and grid traversal problems.

**235. Rotate Image — #48**
Difficulty: Medium | Pattern: Transpose + reverse rows (in-place)
Why: Rotate 90° = transpose + reverse each row. O(1) space. A beautiful in-place matrix transformation. Teaches that complex operations can be decomposed into simpler ones.

**236. Set Matrix Zeroes — #73**
Difficulty: Medium | Pattern: Use first row/column as markers (O(1) space)
Why: Record which rows/cols need zeroing using the matrix itself. O(1) space by using the first row and column as flag arrays. A clean space optimization that tests in-place manipulation thinking.

**🆕 237. Game of Life — #289**
Difficulty: Medium | Pattern: In-place state encoding (encode next state in unused bits)
Why: Use bit encoding: 2 = was dead, now alive; 3 = was alive, still alive. First pass encodes, second pass extracts. The "encode multiple states in one cell" technique is a powerful O(1) space trick for cellular automata and simulation problems.

---

## 📂 25 — Advanced Data Structures

**🆕 238. Range Sum Query — Mutable #307**
Difficulty: Medium | Pattern: Segment Tree or Binary Indexed Tree (Fenwick Tree)
Why: Point update + range query in O(log n). The Segment Tree is the most versatile range query structure. BIT is simpler for sum queries. Asked at Google for senior roles. Essential for competitive programming and real-time analytics systems.

**🆕 239. Count of Smaller Numbers After Self — #315**
Difficulty: Hard | Pattern: Merge sort with inversion counting / BIT / Segment Tree
Why: Count inversions using modified merge sort (count how many elements from right half are merged before left half elements). Also solvable with BIT on value space. Tests advanced data structure application. A Google/Apple favorite.

---

## 📂 26 — Design Problems

**🆕 240. Design Twitter — #355**
Difficulty: Medium | Pattern: HashMap + PriorityQueue + OOP design
Why: Combines multiple data structures: HashMap<userId, Set<followeeId>>, HashMap<userId, List<Tweet>>, and a merge-K-sorted-lists pattern for the news feed. Tests system design thinking at the algorithm level. Models social media feed generation.

**🆕 241. Design HashMap — #706**
Difficulty: Easy | Pattern: Array of buckets + linked list chaining
Why: Implement the data structure you've been using all along. Teaches hashing, collision resolution (chaining vs open addressing), and load factor concepts. Builds deep understanding of HashMap internals.

**🆕 242. Implement Stack using Queues — #225**
Difficulty: Easy | Pattern: Queue rotation to simulate LIFO
Why: (Also in Stacks section.) Understanding how to simulate one ADT with another tests fundamental CS knowledge. Pairs with #232.

---

## 📂 27 — Bonus: Critical Patterns Often Missed

**🆕 243. Longest Substring with At Most K Distinct Characters — #340**
Difficulty: Medium | Pattern: Variable sliding window + HashMap (char → count)
Why: Shrink window when distinct count > k. The "at most K distinct" sliding window is a high-frequency pattern at Google and Amazon. Generalizes to Fruit Into Baskets (#904) and Subarrays with K Different Integers (#992).

**🆕 244. Minimum Remove to Make Valid Parentheses — #1249**
Difficulty: Medium | Pattern: Stack for index tracking + string rebuild
Why: Stack tracks indices of unmatched parentheses. Remove them in a second pass. A practical string + stack problem asked frequently at Facebook/Meta. Models input sanitization and validation.

**🆕 245. Subarray Product Less Than K — #713**
Difficulty: Medium | Pattern: Sliding window with product tracking
Why: Maintain a running product; shrink window when product ≥ k. Count subarrays ending at each right pointer. The "count subarrays" variant of sliding window is a distinct sub-pattern from "find longest/shortest."

**🆕 246. Maximum XOR of Two Numbers in Array — #421**
Difficulty: Medium | Pattern: Trie on binary representation (bit-by-bit greedy)
Why: Build a bitwise trie, then for each number greedily choose the opposite bit at each level. Bridges Tries and Bit Manipulation — two topics that rarely intersect. Asked at Google and Amazon.

**🆕 247. Critical Connections in a Network — #1192**
Difficulty: Hard | Pattern: Tarjan's bridge-finding algorithm (DFS + low-link values)
Why: Find all bridges in an undirected graph using DFS discovery time and low-link values. Models network reliability — finding single points of failure. A hard graph problem asked at Amazon. Fills the "bridges and articulation points" gap.

**🆕 248. Longest Valid Parentheses — #32**
Difficulty: Hard | Pattern: Stack-based or DP — find longest valid bracket substring
Why: Stack stores indices of unmatched brackets; the gap between current index and stack top gives valid length. Also solvable with DP. A hard string problem that combines stack mastery with careful index tracking. Top FAANG hard problem.

**🆕 249. Number of Longest Increasing Subsequence — #673**
Difficulty: Medium | Pattern: DP tracking both LIS length AND count at each index
Why: Extends #300 (LIS) — track count[i] = number of LIS ending at i. When dp[j]+1 == dp[i], add count[j] to count[i]. The "count of optimal solutions" DP extension is a pattern that applies to many DP problems.

**🆕 250. Design Circular Deque — #641**
Difficulty: Medium | Pattern: Circular buffer with front/rear pointers
Why: Extends #622 (Circular Queue) with both-end operations. Models double-ended buffers used in work-stealing schedulers, browser history, and undo/redo systems. Completes the queue design family.

---

## 📊 Summary

| Section | Problems | New |
|---|---|---|
| 1. Arrays (Fundamentals, Prefix, Two Pointers, Sliding Window) | 29 | +1 |
| 2. Strings | 15 | +1 |
| 3. Hashing | 11 | +1 |
| 4. Binary Search | 14 | +2 |
| 5. Linked Lists | 15 | +2 |
| 6. Stacks | 13 | +2 |
| 7. Queues & Deques | 4 | — |
| 8. Trees | 24 | +2 |
| 9. Tries | 3 | — |
| 10. Heaps | 9 | +1 |
| 11. Graphs: DFS | 10 | +1 |
| 12. Graphs: BFS | 8 | — |
| 13. Topological Sort | 4 | — |
| 14. Union Find | 5 | — |
| 15. Shortest Path | 6 | +1 |
| 16. DP: 1D | 15 | +3 |
| 17. DP: 2D | 10 | +2 |
| 18. DP: Intervals | 4 | — |
| 19. DP: Knapsack | 5 | — |
| 20. DP: Trees & Advanced | 2 | +2 |
| 21. Intervals & Greedy | 7 | — |
| 22. Backtracking | 11 | +1 |
| 23. Bit Manipulation | 7 | — |
| 24. Math & Simulation | 7 | +1 |
| 25. Advanced Data Structures | 2 | +2 |
| 26. Design Problems | 3 | +3 |
| 27. Bonus: Critical Patterns | 8 | +8 |
| **Total** | **250** | **+36 new** |

---

## 🎯 Study Plan

| Phase | Duration | Focus |
|---|---|---|
| **Phase 1: Foundations** | Weeks 1-3 | Arrays, Strings, Hashing, Two Pointers, Sliding Window, Binary Search |
| **Phase 2: Data Structures** | Weeks 4-6 | Linked Lists, Stacks, Queues, Trees, Tries, Heaps |
| **Phase 3: Graphs** | Weeks 7-8 | DFS, BFS, Topological Sort, Union Find, Shortest Path, MST |
| **Phase 4: Dynamic Programming** | Weeks 9-11 | 1D, 2D, Intervals, Knapsack, Trees, State Machine |
| **Phase 5: Advanced** | Weeks 12-13 | Backtracking, Bit Manipulation, Design, Segment Trees |
| **Phase 6: Review** | Weeks 14-16 | Revisit weak areas, timed practice, mock interviews |

**Daily target:** 3-5 problems/day
**For each problem:** Brute force → Optimize → Code → Dry run → Edge cases

---

> 🆕 = New additions to reach 99% FAANG coverage. Original 214 problems preserved in full.

 