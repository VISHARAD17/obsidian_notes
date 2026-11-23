
# 04 - Binary Search

Contents:

- 4.1 Classic Binary Search
  - LeetCode 704: Binary Search
  - LeetCode 35: Search Insert Position
  - LeetCode 278: First Bad Version
  - LeetCode 74: Search a 2D Matrix
  - LeetCode 240: Search a 2D Matrix II
  - LeetCode 69: Sqrt(x)
  - LeetCode 4: Median of Two Sorted Arrays
- 4.2 Binary Search on Condition (Rotated Arrays)
  - LeetCode 153: Find Minimum in Rotated Sorted Array
  - LeetCode 33: Search in Rotated Sorted Array
  - LeetCode 81: Search in Rotated Sorted Array II
  - LeetCode 162: Find Peak Element
- 4.3 Binary Search on Answer Space
  - LeetCode 875: Koko Eating Bananas
  - LeetCode 1011: Capacity To Ship Packages Within D Days
  - LeetCode 410: Split Array Largest Sum
  - LeetCode 981: Time Based Key-Value Store
  - LeetCode 378: Kth Smallest Element in a Sorted Matrix
- 4.4 Ordered Sets and TreeMap
  - LeetCode 729: My Calendar I
  - LeetCode 220: Contains Duplicate III
  - LeetCode 480: Sliding Window Median

---

## LeetCode 704: Binary Search
**Difficulty:** Easy | **Pattern:** `while (lo <= hi)`, overflow-safe mid | **Language:** Java

### 1. Problem
- Given a sorted (ascending, distinct) array `nums` and a `target`, return the index of `target`, or `-1`. Example: `nums = [-1,0,3,5,9,12]`, `target = 9` -> `4`.
- Constraints: `n` up to 10^4, required O(log n). Sorted input plus a log requirement means "halve the search space each step".
- **Key insight:** at any moment the answer, if it exists, lies in the closed range `[lo, hi]`. Comparing `nums[mid]` with the target lets you throw away `mid` and one entire side, so the invariant is preserved and the range shrinks every iteration.

### 2. Solution
- Step 1, brute force: scan left to right, O(n). It ignores the sorted order.
- Step 2: sorted order means one comparison against the middle element eliminates half of the candidates.
- Step 3: keep a closed interval `[lo, hi]`. Because both ends are candidates, the loop runs while `lo <= hi` (a single-element range must still be checked). Because `mid` has just been examined, move to `mid + 1` or `mid - 1`; using `mid` itself would risk an infinite loop.

```java
class Solution {
    public int search(int[] nums, int target) {
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2; // avoids int overflow of (lo + hi)
            if (nums[mid] == target) return mid;
            if (nums[mid] < target) lo = mid + 1;
            else hi = mid - 1;
        }
        return -1;
    }
}
```
Implementation note: `lo + (hi - lo) / 2` is the overflow-safe midpoint; `(lo + hi) >>> 1` is an equivalent idiom.

### 3. Dry Run
`nums = [-1,0,3,5,9,12]`, `target = 9`.

| Step | lo | hi | mid | nums[mid] | Decision |
|---|---|---|---|---|---|
| 1 | 0 | 5 | 2 | 3 | 3 < 9, so lo = 3 |
| 2 | 3 | 5 | 4 | 9 | equal, return 4 |

Answer: `4`.

**Complexity:** Time O(log n), the range halves each step. Space O(1), only indices.

### 4. Takeaway
- **Pattern:** sorted data, exact lookup, log-time requirement.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[5]`, 5 | 0 | single element needs `<=` |
| `[5]`, 3 | -1 | lo > hi after one step |
| target smaller than all | -1 | hi drops to -1 |
| target larger than all | -1 | lo reaches n |

- **Mistakes to avoid:** `while (lo < hi)` with `hi = mid - 1` skips the last candidate; `(lo + hi) / 2` overflows for huge indices; `lo = mid` or `hi = mid` in this closed template loops forever.
- **Related problems:** 35 Search Insert Position (return `lo` when absent), 278 First Bad Version (boundary search, half-open template), 33 Search in Rotated Sorted Array (same loop, harder direction rule).

---

## LeetCode 35: Search Insert Position
**Difficulty:** Easy | **Pattern:** Binary search, leftmost insertion point | **Language:** Java

### 1. Problem
- Given a sorted array of distinct integers and a `target`, return its index if present, otherwise the index where it would be inserted to keep order. Example: `[1,3,5,6]`, `target = 2` -> `1`.
- Constraints: `n` up to 10^4, O(log n) required.
- **Key insight:** run the plain 704 loop, but when the loop ends without a match, `lo` is exactly the insertion index. At exit `lo = hi + 1`, every element left of `lo` is `< target` and every element from `lo` onward is `> target`.

### 2. Solution
- Step 1, brute force: linear scan for the first element `>= target`, O(n).
- Step 2: "first element `>= target`" is a boundary in a monotone predicate (`nums[i] >= target` is false...false true...true), so binary search finds it.
- Step 3: use the 704 template. Each time we move `lo = mid + 1` we have proved `nums[mid] < target`; each time `hi = mid - 1` we have proved `nums[mid] > target`. When the pointers cross, `lo` sits on the first element greater than the target (or `n`).

```java
class Solution {
    public int searchInsert(int[] nums, int target) {
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] == target) return mid;
            if (nums[mid] < target) lo = mid + 1;
            else hi = mid - 1;
        }
        return lo; // insertion point
    }
}
```

### 3. Dry Run
`nums = [1,3,5,6]`, `target = 2`.

| Step | lo | hi | mid | nums[mid] | Decision |
|---|---|---|---|---|---|
| 1 | 0 | 3 | 1 | 3 | 3 > 2, hi = 0 |
| 2 | 0 | 0 | 0 | 1 | 1 < 2, lo = 1 |
| exit | 1 | 0 | - | - | lo > hi, return lo = 1 |

Answer: `1` (insert between 1 and 3).

**Complexity:** Time O(log n). Space O(1).

### 4. Takeaway
- **Pattern:** "where would this go" or "first index with value >= x"; returning `lo` after the loop is the building block of lower-bound searches.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[1,3,5,6]`, 7 | 4 | lo runs off the end |
| `[1,3,5,6]`, 0 | 0 | hi drops to -1, lo stays 0 |
| `[1,3,5,6]`, 5 | 2 | exact match |
| `[1]`, 1 | 0 | single element |

- **Mistakes to avoid:** returning `-1` when not found; returning `hi` (that is the predecessor); initialising `hi = n` with the closed-interval loop (index out of range).
- **Related problems:** 704 Binary Search (exact only), 278 First Bad Version (same boundary idea), 34 Find First and Last Position (lower and upper bound with duplicates).

---

## LeetCode 278: First Bad Version
**Difficulty:** Easy | **Pattern:** Binary search, first true in a boolean sequence | **Language:** Java

### 1. Problem
- Versions `1..n`; once a version is bad, all later ones are bad. With an API `isBadVersion(v)`, find the first bad version using as few calls as possible. Example: `n = 5`, first bad is 4 -> `4`.
- Constraints: `n` up to 2^31 - 1, so `lo + hi` can overflow, and calls are expensive: O(log n) calls.
- **Key insight:** the sequence is `false, false, ..., true, true`. Find the boundary. If `mid` is bad, the answer is `mid` or earlier (keep `mid`); if not, the answer is later (discard `mid`).

### 2. Solution
- Step 1, brute force: call the API for 1, 2, 3, ... until true, O(n) calls.
- Step 2: monotone predicate, so binary search on it.
- Step 3: the answer is guaranteed to exist, so use a half-open style template `while (lo < hi)` with `hi = mid` on true. The range always contains the answer; when `lo == hi` it is the answer. `mid = lo + (hi - lo) / 2` is required for `n` near `Integer.MAX_VALUE`.

```java
public class Solution extends VersionControl {
    public int firstBadVersion(int n) {
        int lo = 1, hi = n;
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2; // floor, so mid < hi and the loop always shrinks
            if (isBadVersion(mid)) hi = mid;
            else lo = mid + 1;
        }
        return lo;
    }
}
```

### 3. Dry Run
`n = 5`, first bad version is 4.

| Step | lo | hi | mid | isBad(mid) | Decision |
|---|---|---|---|---|---|
| 1 | 1 | 5 | 3 | false | lo = 4 |
| 2 | 4 | 5 | 4 | true | hi = 4 |
| exit | 4 | 4 | - | - | lo == hi, return 4 |

Answer: `4`, using 2 API calls.

**Complexity:** Time O(log n) API calls. Space O(1).

### 4. Takeaway
- **Pattern:** "find the first index where a monotone predicate flips to true" (feature flags, regressions, `git bisect`). Template: `lo < hi`, `hi = mid` on true, `lo = mid + 1` on false.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `n = 1`, bad = 1 | 1 | loop never runs |
| bad = 1, `n = 10` | 1 | hi keeps collapsing to lo |
| bad = n | n | lo climbs to n |
| `n = 2147483647` | works | needs overflow-safe mid |

- **Mistakes to avoid:** `(lo + hi) / 2` overflow; `hi = mid - 1` on true (loses the answer); `lo < hi` with `lo = mid` (infinite loop).
- **Related problems:** 35 Search Insert Position (boundary in an array), 875 Koko and 1011 Ship (same boundary search over a computed predicate), 153 Find Minimum in Rotated Array (boundary defined by a comparison).

---

## LeetCode 74: Search a 2D Matrix
**Difficulty:** Medium | **Pattern:** Binary search on a flattened 2D index | **Language:** Java

### 1. Problem
- An `m x n` matrix where each row is sorted ascending and the first element of each row is greater than the last element of the previous row. Return whether `target` exists. Example: `[[1,3,5,7],[10,11,16,20],[23,30,34,60]]`, `target = 3` -> `true`.
- Constraints: `m, n <= 100`, required O(log(m*n)).
- **Key insight:** reading the matrix row by row yields one fully sorted sequence of `m*n` values. Binary search over indices `0..m*n-1` and convert an index `k` to `(k / n, k % n)`. No copying is needed.

### 2. Solution
- Step 1, brute force: scan all cells, O(m*n).
- Step 2: search each row's range with binary search after picking the right row by its first and last value: O(log m + log n), but two searches with fiddly row selection.
- Step 3: since the rows chain into one sorted order, treat the matrix as a virtual array and run plain 704 on it. Mapping: row = `mid / cols`, col = `mid % cols`. `m*n <= 10^4` fits in `int`.

```java
class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        int rows = matrix.length, cols = matrix[0].length;
        int lo = 0, hi = rows * cols - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            int value = matrix[mid / cols][mid % cols];
            if (value == target) return true;
            if (value < target) lo = mid + 1;
            else hi = mid - 1;
        }
        return false;
    }
}
```

### 3. Dry Run
Matrix `[[1,3,5,7],[10,11,16,20],[23,30,34,60]]` (3 rows, 4 cols, 12 cells), `target = 3`.

| Step | lo | hi | mid | (row, col) | value | Decision |
|---|---|---|---|---|---|---|
| 1 | 0 | 11 | 5 | (1,1) | 11 | 11 > 3, hi = 4 |
| 2 | 0 | 4 | 2 | (0,2) | 5 | 5 > 3, hi = 1 |
| 3 | 0 | 1 | 0 | (0,0) | 1 | 1 < 3, lo = 1 |
| 4 | 1 | 1 | 1 | (0,1) | 3 | equal, return true |

Answer: `true`.

**Complexity:** Time O(log(m*n)). Space O(1).

### 4. Takeaway
- **Pattern:** a structure that is globally sorted in some traversal order can be binary searched through an index-mapping function.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[[1]]`, 1 | true | single cell |
| `[[1]]`, 2 | false | |
| one row, many columns | works | `mid / cols = 0` |
| one column, many rows | works | `mid % 1 = 0` |

- **Mistakes to avoid:** swapping `rows` and `cols` in the division and modulo (divide by columns); using it on a matrix that is only row- and column-sorted (see 240).
- **Related problems:** 240 Search a 2D Matrix II (flattening is invalid there), 378 Kth Smallest in Sorted Matrix, 704 Binary Search.

---

## LeetCode 240: Search a 2D Matrix II
**Difficulty:** Medium | **Pattern:** Staircase search from the top-right corner | **Language:** Java

### 1. Problem
- An `m x n` matrix where each row is sorted ascending and each column is sorted ascending, but rows do not chain (the row start may be smaller than the previous row's end). Return whether `target` exists. Example: the 5x5 matrix below with `target = 5` -> `true`.
- Constraints: `m, n <= 300`; O(m + n) is expected.
- **Key insight:** flattening (74) breaks because the row-major order is not sorted (for example `15` in row 0 is followed by `2` in row 1). Instead, stand at the top-right corner: it is the largest in its row and the smallest in its column. If it is too big, the whole column below is also too big, so move left; if too small, the whole row to its left is too small, so move down. Every step discards a full row or column.

### 2. Solution
- Step 1, brute force: scan everything, O(m*n).
- Step 2: binary search each row, O(m log n). Better, but it ignores the column ordering.
- Step 3: staircase walk from `(0, n-1)`. Compare, then move left (`value > target`) or down (`value < target`). At most `m + n - 1` steps. (The bottom-left corner works symmetrically; top-left and bottom-right do not, because both moves would increase or decrease the value.)

```java
class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        int row = 0, col = matrix[0].length - 1;
        while (row < matrix.length && col >= 0) {
            int value = matrix[row][col];
            if (value == target) return true;
            if (value > target) col--;
            else row++;
        }
        return false;
    }
}
```

### 3. Dry Run
Matrix:

```
 1  4  7 11 15
 2  5  8 12 19
 3  6  9 16 22
10 13 14 17 24
18 21 23 26 30
```
`target = 5`.

| Step | row | col | value | Decision |
|---|---|---|---|---|
| 1 | 0 | 4 | 15 | 15 > 5, col = 3 |
| 2 | 0 | 3 | 11 | 11 > 5, col = 2 |
| 3 | 0 | 2 | 7 | 7 > 5, col = 1 |
| 4 | 0 | 1 | 4 | 4 < 5, row = 1 |
| 5 | 1 | 1 | 5 | equal, return true |

Answer: `true`.

**Complexity:** Time O(m + n), each step removes a row or column. Space O(1).

### 4. Takeaway
- **Pattern:** two-way monotone grid; pick a corner where the two directions give opposite effects.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[[5]]`, 5 | true | one cell |
| target below top-left | false | col walks to -1 |
| target above bottom-right | false | row walks to m |
| single row | works | degenerates to a scan or binary search |

- **Mistakes to avoid:** starting from top-left or bottom-right (no unambiguous move); trying to flatten the matrix.
- **Related problems:** 74 (fully chained, O(log mn)), 378 (uses this walk as a counting step), 1351 Count Negatives in a Sorted Matrix (same staircase).

---

## LeetCode 69: Sqrt(x)
**Difficulty:** Easy | **Pattern:** Binary search on an integer answer range | **Language:** Java

### 1. Problem
- Return the integer part of the square root of non-negative `x` without using a built-in power or sqrt. Example: `x = 8` -> `2` (since 2.828... is truncated).
- Constraints: `0 <= x <= 2^31 - 1`. `k * k` can overflow `int`, so the arithmetic needs care.
- **Key insight:** the predicate `k * k <= x` is true for small `k` and false for large `k`. We want the largest `k` for which it is true, so binary search the answer range `[1, x]`.

### 2. Solution
- Step 1, brute force: try `k = 1, 2, ...` until `k*k > x`, O(sqrt(x)), up to about 46,000 iterations. Fine here, but wasteful.
- Step 2: the predicate is monotone, so search the range instead.
- Step 3: closed-interval loop. When `mid*mid <= x`, `mid` is a valid candidate, record it and look higher; otherwise look lower. Compute the square in `long` (or compare `mid <= x / mid`) to avoid overflow.

```java
class Solution {
    public int mySqrt(int x) {
        if (x < 2) return x;
        int lo = 1, hi = x / 2; // sqrt(x) <= x/2 for x >= 4; for 2 and 3 the answer 1 is still reached
        int ans = 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if ((long) mid * mid <= x) {
                ans = mid;
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }
        return ans;
    }
}
```
Note: for `x = 2` or `3`, `hi = 1`, the loop checks `1*1 <= x`, and `ans` stays 1. Correct.

### 3. Dry Run
`x = 8`: `lo = 1`, `hi = 4`, `ans = 1`.

| Step | lo | hi | mid | mid*mid | Decision |
|---|---|---|---|---|---|
| 1 | 1 | 4 | 2 | 4 | 4 <= 8, ans = 2, lo = 3 |
| 2 | 3 | 4 | 3 | 9 | 9 > 8, hi = 2 |
| exit | 3 | 2 | - | - | lo > hi, return ans = 2 |

Answer: `2`.

**Complexity:** Time O(log x). Space O(1).

### 4. Takeaway
- **Pattern:** "largest value satisfying a monotone condition" over a numeric range, with a candidate variable updated on success.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| 0 | 0 | early return |
| 1 | 1 | early return |
| 2147483647 | 46340 | needs `long` square |
| perfect square 16 | 4 | `<=` keeps equality as valid |

- **Mistakes to avoid:** `mid * mid` in `int` overflows; using `<` instead of `<=` for the predicate; returning `hi` without reasoning (it works at exit, but only because `hi` ends on the last true value).
- **Related problems:** 367 Valid Perfect Square (same search, equality check), 875 Koko (binary search on answer with a heavier predicate), 278 First Bad Version (boundary, opposite direction).

---

## LeetCode 4: Median of Two Sorted Arrays
**Difficulty:** Hard | **Pattern:** Binary search on the partition point of the smaller array | **Language:** Java

### 1. Problem
- Given sorted arrays `nums1` (size m) and `nums2` (size n), return the median of the merged data in O(log(min(m, n))). Example: `[1,3]` and `[2]` -> `2.0`.
- Constraints: `m + n >= 1`, each up to 1000, values within int range. The log requirement forbids merging.
- **Key insight:** the median splits the combined data into a left half and a right half (left has `(m+n+1)/2` items). Choosing how many items `i` come from `A` determines `j = half - i` from `B`. A split is correct exactly when `A[i-1] <= B[j]` and `B[j-1] <= A[i]`. Binary search `i`.

### 2. Solution
- Step 1, brute force: merge both arrays and pick the middle, O(m+n) time and space.
- Step 2: no need to build the merge; walk two pointers to the middle, O(m+n) time, O(1) space. Still linear.
- Step 3: think of cutting each array. Left parts together hold `half` elements. Only the four boundary values matter: `aL = A[i-1]`, `aR = A[i]`, `bL = B[j-1]`, `bR = B[j]`, using -infinity or +infinity when the cut is at an end.
  - If `aL > bR`: too many from `A`, so `hi = i - 1`.
  - If `bL > aR`: too few from `A`, so `lo = i + 1`.
  - Otherwise the cut is valid: odd total -> `max(aL, bL)`; even -> average of `max(aL, bL)` and `min(aR, bR)`.
- Always search the shorter array, which guarantees `0 <= j <= n` for every `i` in `[0, m]` and gives the log(min) bound.

```java
class Solution {
    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        if (nums1.length > nums2.length) return findMedianSortedArrays(nums2, nums1);
        int m = nums1.length, n = nums2.length;
        int half = (m + n + 1) / 2;
        int lo = 0, hi = m;
        while (lo <= hi) {
            int i = lo + (hi - lo) / 2; // items taken from nums1
            int j = half - i;           // items taken from nums2
            int aL = i == 0 ? Integer.MIN_VALUE : nums1[i - 1];
            int aR = i == m ? Integer.MAX_VALUE : nums1[i];
            int bL = j == 0 ? Integer.MIN_VALUE : nums2[j - 1];
            int bR = j == n ? Integer.MAX_VALUE : nums2[j];
            if (aL <= bR && bL <= aR) {
                if (((m + n) & 1) == 1) return Math.max(aL, bL);
                return (Math.max(aL, bL) + (double) Math.min(aR, bR)) / 2.0;
            } else if (aL > bR) {
                hi = i - 1;
            } else {
                lo = i + 1;
            }
        }
        throw new IllegalArgumentException("inputs are not sorted");
    }
}
```
Notes: sentinels are only compared, never added (the even-case sum is done in `double`), so there is no overflow.

### 3. Dry Run
`nums1 = [1,3]`, `nums2 = [2]`. Swap so the shorter array is searched: `A = [2]` (m = 1), `B = [1,3]` (n = 2), `half = (3+1)/2 = 2`, `lo = 0`, `hi = 1`.

| Step | lo | hi | i | j | aL | aR | bL | bR | Decision |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 0 | 1 | 0 | 2 | -inf | 2 | 3 | +inf | aL<=bR yes, bL=3 > aR=2, so lo = 1 |
| 2 | 1 | 1 | 1 | 1 | 2 | +inf | 1 | 3 | 2<=3 and 1<=inf: valid cut |

Total length 3 is odd, so the answer is `max(aL, bL) = max(2, 1) = 2`. Result `2.0`.

**Complexity:** Time O(log(min(m, n))). Space O(1) (the swap is a single recursive call that does not repeat).

### 4. Takeaway
- **Pattern:** when two sorted sources must be combined at a rank, binary search on how many items each contributes, validating with the four cut-boundary values.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[]`, `[1]` | 1.0 | `m = 0`, i is always 0, aL = -inf |
| `[1,2]`, `[3,4]` | 2.5 | even total, cut at array ends |
| `[1,1]`, `[1,1]` | 1.0 | equal values; `<=` comparisons keep cut valid |
| `[2]`, `[]` | 2.0 | swap puts the empty array first |
| values near `Integer.MAX_VALUE` | ok | average computed in `double` |

- **Mistakes to avoid:** searching the longer array (j goes out of range); using `(m + n) / 2` instead of `(m + n + 1) / 2` for odd totals; strict `<` in the validity check on duplicates; summing two ints for the average.
- **Related problems:** 295 Find Median from Data Stream (two heaps, online), 215 Kth Largest Element (selection), 378 Kth Smallest in Sorted Matrix (rank by counting).

---

## LeetCode 153: Find Minimum in Rotated Sorted Array
**Difficulty:** Medium | **Pattern:** Binary search on a condition (inflection point) | **Language:** Java

### 1. Problem
- A sorted array of distinct values was rotated between 1 and n times. Return its minimum in O(log n). Example: `[3,4,5,1,2]` -> `1`.
- Constraints: `n` up to 5000, distinct values.
- **Key insight:** compare `nums[mid]` with `nums[hi]`. If `nums[mid] > nums[hi]`, the drop (the minimum) is strictly to the right of `mid`. Otherwise the right part `mid..hi` is increasing, so the minimum is at `mid` or to its left. There is no target; the condition itself guides the search.

### 2. Solution
- Step 1, brute force: scan for the minimum, O(n).
- Step 2: the array is two sorted runs; the minimum is the start of the second run, i.e. the first element smaller than its predecessor, which needs a monotone predicate to search.
- Step 3: compare against `nums[hi]` (not `nums[lo]`, which is ambiguous when the range is not rotated). Use `while (lo < hi)`; when `nums[mid] <= nums[hi]` keep `mid` with `hi = mid`; otherwise `lo = mid + 1`. The loop ends with `lo == hi` on the minimum.

```java
class Solution {
    public int findMin(int[] nums) {
        int lo = 0, hi = nums.length - 1;
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] > nums[hi]) lo = mid + 1; // min is right of mid
            else hi = mid;                          // mid could be the min
        }
        return nums[lo];
    }
}
```

### 3. Dry Run
`nums = [3,4,5,1,2]`.

| Step | lo | hi | mid | nums[mid] | nums[hi] | Decision |
|---|---|---|---|---|---|---|
| 1 | 0 | 4 | 2 | 5 | 2 | 5 > 2, lo = 3 |
| 2 | 3 | 4 | 3 | 1 | 2 | 1 <= 2, hi = 3 |
| exit | 3 | 3 | - | - | - | return nums[3] = 1 |

Answer: `1`.

**Complexity:** Time O(log n). Space O(1).

### 4. Takeaway
- **Pattern:** binary search on a property without a target; compare the middle with an endpoint to know which side holds the pivot.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[1]` | 1 | loop skipped |
| `[1,2,3]` (not rotated) | 1 | mid <= hi always, hi shrinks to 0 |
| `[2,1]` | 1 | mid = 0, 2 > 1, lo = 1 |
| `[4,5,6,7,0,1,2]` | 0 | standard |

- **Mistakes to avoid:** comparing with `nums[lo]` (breaks when already sorted); `hi = mid - 1` (may discard the minimum); using this code with duplicates (see 154).
- **Related problems:** 154 Find Minimum II (duplicates, `hi--` when equal), 33 Search in Rotated Sorted Array (needs a target), 162 Find Peak Element (another local-condition search).

---

## LeetCode 33: Search in Rotated Sorted Array
**Difficulty:** Medium | **Pattern:** Binary search, identify the sorted half | **Language:** Java

### 1. Problem
- A sorted array of distinct values was rotated at an unknown pivot. Find the index of `target` or return `-1`, in O(log n). Example: `[4,5,6,7,0,1,2]`, `target = 0` -> `4`.
- Constraints: `n` up to 5000, distinct values.
- **Key insight:** whichever way you split at `mid`, at least one of `[lo, mid]` and `[mid, hi]` is sorted. Check whether the target lies inside the sorted half using its endpoints; if so go there, otherwise go to the other half.

### 2. Solution
- Step 1, brute force: linear scan, O(n).
- Step 2: find the pivot with 153, then binary search the correct half: O(log n) but two passes.
- Step 3: single pass. If `nums[lo] <= nums[mid]`, the left half is sorted. Then if `nums[lo] <= target < nums[mid]` set `hi = mid - 1`, else `lo = mid + 1`. Otherwise the right half is sorted: if `nums[mid] < target <= nums[hi]` set `lo = mid + 1`, else `hi = mid - 1`. The `<=` in `nums[lo] <= nums[mid]` covers a one-element left half (`lo == mid`).

```java
class Solution {
    public int search(int[] nums, int target) {
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] == target) return mid;
            if (nums[lo] <= nums[mid]) {              // left half sorted
                if (nums[lo] <= target && target < nums[mid]) hi = mid - 1;
                else lo = mid + 1;
            } else {                                  // right half sorted
                if (nums[mid] < target && target <= nums[hi]) lo = mid + 1;
                else hi = mid - 1;
            }
        }
        return -1;
    }
}
```

### 3. Dry Run
`nums = [4,5,6,7,0,1,2]`, `target = 0`.

| Step | lo | hi | mid | nums[mid] | Sorted half | Decision |
|---|---|---|---|---|---|---|
| 1 | 0 | 6 | 3 | 7 | left (4 <= 7) | is 4 <= 0 < 7? no, lo = 4 |
| 2 | 4 | 6 | 5 | 1 | left (0 <= 1) | is 0 <= 0 < 1? yes, hi = 4 |
| 3 | 4 | 4 | 4 | 0 | - | equal, return 4 |

Answer: `4`.

**Complexity:** Time O(log n). Space O(1).

### 4. Takeaway
- **Pattern:** rotated or "broken" order where one side is always clean; decide using the clean side.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[1]`, 0 | -1 | single element, absent |
| `[3,1]`, 1 | 1 | `nums[lo] <= nums[mid]` with lo == mid |
| `[1,3]`, 3 | 1 | not rotated |
| target absent | -1 | pointers cross |

- **Mistakes to avoid:** using `<` in `nums[lo] <= nums[mid]` (fails when lo == mid); testing the target against the wrong endpoint (strict on the `mid` side since mid was already checked); applying it to duplicates (see 81).
- **Related problems:** 81 (duplicates), 153 (no target), 704 (unrotated).

---

## LeetCode 81: Search in Rotated Sorted Array II
**Difficulty:** Medium | **Pattern:** Rotated binary search with duplicates | **Language:** Java

### 1. Problem
- Same as 33 but the array may contain duplicates; return `true` if `target` is present, else `false`. Example: `[2,5,6,0,0,1,2]`, `target = 0` -> `true`.
- Constraints: `n` up to 5000. Worst case degrades to O(n), unavoidable (see below).
- **Key insight:** if `nums[lo] == nums[mid] == nums[hi]`, we cannot tell which half is sorted (`[1,1,1,0,1]` versus `[1,0,1,1,1]`). Since `nums[mid]` is not the target, the two end values are also not the target, so shrink both ends by one and retry.

### 2. Solution
- Step 1, brute force: linear scan, O(n). It is also the worst-case bound of the optimal approach.
- Step 2: reuse 33. It fails only when the equal-endpoint ambiguity appears.
- Step 3: add one branch before the sorted-half check: when `nums[lo] == nums[mid] && nums[mid] == nums[hi]`, do `lo++; hi--`. The rest is identical to 33. With all-equal arrays this is O(n), but average cases stay logarithmic.

```java
class Solution {
    public boolean search(int[] nums, int target) {
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] == target) return true;
            if (nums[lo] == nums[mid] && nums[mid] == nums[hi]) {
                lo++;
                hi--;                                  // ends are not the target either
            } else if (nums[lo] <= nums[mid]) {        // left half sorted
                if (nums[lo] <= target && target < nums[mid]) hi = mid - 1;
                else lo = mid + 1;
            } else {                                   // right half sorted
                if (nums[mid] < target && target <= nums[hi]) lo = mid + 1;
                else hi = mid - 1;
            }
        }
        return false;
    }
}
```

### 3. Dry Run
`nums = [1,0,1,1,1]`, `target = 0`.

| Step | lo | hi | mid | nums[lo], nums[mid], nums[hi] | Decision |
|---|---|---|---|---|---|
| 1 | 0 | 4 | 2 | 1, 1, 1 | all equal, ambiguous: lo = 1, hi = 3 |
| 2 | 1 | 3 | 2 | 0, 1, 1 | left sorted (0 <= 1); is 0 <= 0 < 1? yes, hi = 1 |
| 3 | 1 | 1 | 1 | 0, 0, 0 | nums[mid] == target, return true |

Answer: `true`.

**Complexity:** Time O(log n) typical, O(n) worst case (all equal). Space O(1).

### 4. Takeaway
- **Pattern:** a binary search relying on a comparison that duplicates can make uninformative; peel off the uninformative elements.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[1,1,1,1]`, 2 | false | O(n) shrink |
| `[1]`, 1 | true | found at mid |
| `[1,0,1,1,1]`, 0 | true | traced above |
| `[3,1]`, 1 | true | lo == mid case |

- **Mistakes to avoid:** shrinking only when `nums[lo] == nums[mid]` (if `nums[hi]` differs, the right half is known to be sorted, so this is wasteful but the check of all three is the safe form); forgetting to check `nums[mid] == target` first, which makes discarding the ends unsound.
- **Related problems:** 33 (distinct), 154 Find Minimum II (same duplicate problem for the minimum), 153.

---

## LeetCode 162: Find Peak Element
**Difficulty:** Medium | **Pattern:** Binary search on a local property (follow the rising slope) | **Language:** Java

### 1. Problem
- Find any index `i` with `nums[i] > nums[i-1]` and `nums[i] > nums[i+1]`, treating out-of-range neighbours as negative infinity. Adjacent elements are never equal. Example: `[1,2,1,3,5,6,4]` -> `5` (or `1`; any peak is valid).
- Constraints: `n` up to 1000, required O(log n). The array is not sorted, so the search must be guided by a local test.
- **Key insight:** if `nums[mid] < nums[mid+1]`, the slope rises to the right; since the right end is effectively negative infinity, a peak must exist in `[mid+1, hi]`. Otherwise `nums[mid] > nums[mid+1]` and a peak exists in `[lo, mid]` (the left boundary is also negative infinity).

### 2. Solution
- Step 1, brute force: scan for an element larger than both neighbours, O(n).
- Step 2: the global maximum is a peak, but finding it is O(n).
- Step 3: climb. Compare `mid` with `mid + 1`. Rising -> `lo = mid + 1`; falling -> `hi = mid`. The invariant "a peak lies in `[lo, hi]`" always holds. With `lo < hi` we have `mid < hi`, so `mid + 1` is always in range.

```java
class Solution {
    public int findPeakElement(int[] nums) {
        int lo = 0, hi = nums.length - 1;
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] < nums[mid + 1]) lo = mid + 1;
            else hi = mid;
        }
        return lo;
    }
}
```

### 3. Dry Run
`nums = [1,2,1,3,5,6,4]`.

| Step | lo | hi | mid | nums[mid] vs nums[mid+1] | Decision |
|---|---|---|---|---|---|
| 1 | 0 | 6 | 3 | 3 < 5 | rising, lo = 4 |
| 2 | 4 | 6 | 5 | 6 > 4 | falling, hi = 5 |
| 3 | 4 | 5 | 4 | 5 < 6 | rising, lo = 5 |
| exit | 5 | 5 | - | - | return 5 |

Answer: index `5` (value 6).

**Complexity:** Time O(log n). Space O(1).

### 4. Takeaway
- **Pattern:** no global order, but a local rule that always points toward a guaranteed solution; binary search on direction.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[1]` | 0 | loop skipped |
| `[1,2]` | 1 | rising, lo = 1 |
| `[2,1]` | 0 | falling, hi = 0 |
| strictly increasing | n - 1 | always go right |
| strictly decreasing | 0 | always go left |

- **Mistakes to avoid:** `hi = mid - 1` when falling (mid may be the peak); comparing with `mid - 1` in a way that can index -1; using `lo <= hi` here (mid + 1 can overflow the array).
- **Related problems:** 852 Peak Index in a Mountain Array (single peak), 153 Find Minimum (valley instead), 1901 Find a Peak Element II (2D).

---

## LeetCode 875: Koko Eating Bananas
**Difficulty:** Medium | **Pattern:** Binary search on the answer, minimum `k` satisfying a condition | **Language:** Java

### 1. Problem
- `piles[i]` bananas per pile, `h` hours. Each hour Koko picks one pile and eats up to `k` bananas from it (leftovers of that hour are wasted). Return the minimum integer `k` that finishes within `h` hours. Example: `piles = [3,6,7,11]`, `h = 8` -> `4`.
- Constraints: up to 10^4 piles, each up to 10^9, `piles.length <= h <= 10^9`. Trying every `k` is far too slow, so search the value of `k`.
- **Key insight:** if speed `k` works, any faster speed works too. So "can finish at speed k" is `false...false true...true` over `k`, and we want the first true. Binary search the answer, with a linear feasibility check.

### 2. Solution
- Step 1, brute force: try `k = 1, 2, 3, ...` and simulate, O(max(piles) * n), up to about 10^13 operations.
- Step 2: feasibility is monotone in `k`, so the answer is a boundary.
- Step 3: the range is `[1, max(piles)]`: below 1 is impossible, and above the largest pile no extra speed helps (each pile already takes exactly one hour, and `h >= n`). For a candidate `k`, hours needed = sum of `ceil(pile / k)`. Use `(pile - 1) / k + 1` (no overflow, pile >= 1) and a `long` sum. Boundary template: `hi = mid` if feasible, else `lo = mid + 1`.

```java
class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int lo = 1, hi = 0;
        for (int p : piles) hi = Math.max(hi, p);
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (hoursNeeded(piles, mid) <= h) hi = mid;
            else lo = mid + 1;
        }
        return lo;
    }

    private long hoursNeeded(int[] piles, int speed) {
        long hours = 0;
        for (int p : piles) hours += (p - 1) / speed + 1; // ceil(p / speed)
        return hours;
    }
}
```

### 3. Dry Run
`piles = [3,6,7,11]`, `h = 8`. Initial `lo = 1`, `hi = 11`.

| Step | lo | hi | mid | hours (per pile) | Total | Decision |
|---|---|---|---|---|---|---|
| 1 | 1 | 11 | 6 | 1,1,2,2 | 6 | 6 <= 8, hi = 6 |
| 2 | 1 | 6 | 3 | 1,2,3,4 | 10 | 10 > 8, lo = 4 |
| 3 | 4 | 6 | 5 | 1,2,2,3 | 8 | 8 <= 8, hi = 5 |
| 4 | 4 | 5 | 4 | 1,2,2,3 | 8 | 8 <= 8, hi = 4 |
| exit | 4 | 4 | - | - | - | return 4 |

Answer: `4`.

**Complexity:** Time O(n log M), where M = max pile. Space O(1).

### 4. Takeaway
- **Pattern:** "minimum X such that feasible(X)" with feasibility monotone in X. Define the range, write `feasible`, run the first-true boundary search.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[5]`, h = 5 | 1 | one pile, 5 hours at speed 1 |
| `piles.length == h` | max(piles) | every pile needs its own hour |
| `[1000000000]`, h = 2 | 500000000 | big values, `long` total |
| `[30,11,23,4,20]`, h = 6 | 23 | each pile (nearly) separate hour |

- **Mistakes to avoid:** `lo = 0` (division by zero); using `Math.ceil` on integer division; summing hours in `int`; setting `hi = mid - 1` on feasible (loses the answer).
- **Related problems:** 1011 Ship Packages (same template, different check), 410 Split Array Largest Sum (minimise the maximum), 1482 Minimum Days to Make Bouquets, 278 First Bad Version (the underlying boundary search).

---

## LeetCode 1011: Capacity To Ship Packages Within D Days
**Difficulty:** Medium | **Pattern:** Binary search on the answer, minimum capacity | **Language:** Java

### 1. Problem
- `weights[i]` are loaded onto a conveyor in the given order; each day you load consecutive packages without exceeding the ship's capacity. Return the least capacity that ships everything within `days`. Example: `weights = [1,2,3,4,5,6,7,8,9,10]`, `days = 5` -> `15`.
- Constraints: up to 5 * 10^4 packages, each up to 500, `days <= n`.
- **Key insight:** a bigger ship never hurts, so feasibility is monotone in capacity. The answer lies in `[max(weights), sum(weights)]`: at least the heaviest package (must fit alone), at most everything in one day.

### 2. Solution
- Step 1, brute force: try capacities from `max` upward, simulate, O(n * sum).
- Step 2: monotone feasibility -> binary search the capacity.
- Step 3: the check is a greedy simulation: fill the current day until the next package would overflow, then start a new day. Because order is fixed, greedy filling uses the fewest days. Feasible if `daysUsed <= days`.

```java
class Solution {
    public int shipWithinDays(int[] weights, int days) {
        int lo = 0, hi = 0;
        for (int w : weights) {
            lo = Math.max(lo, w);
            hi += w;               // max 5 * 10^4 * 500 = 2.5 * 10^7, fits int
        }
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (daysNeeded(weights, mid) <= days) hi = mid;
            else lo = mid + 1;
        }
        return lo;
    }

    private int daysNeeded(int[] weights, int capacity) {
        int used = 1, load = 0;
        for (int w : weights) {
            if (load + w > capacity) {
                used++;
                load = 0;
            }
            load += w;
        }
        return used;
    }
}
```

### 3. Dry Run
`weights = [1..10]`, `days = 5`. `lo = 10`, `hi = 55`.

| Step | lo | hi | mid | Daily loads | Days | Decision |
|---|---|---|---|---|---|---|
| 1 | 10 | 55 | 32 | 28 (1-7), 27 (8-10) | 2 | 2 <= 5, hi = 32 |
| 2 | 10 | 32 | 21 | 21 (1-6), 15 (7-8), 19 (9-10) | 3 | 3 <= 5, hi = 21 |
| 3 | 10 | 21 | 15 | 15 (1-5), 13 (6-7), 8, 9, 10 | 5 | 5 <= 5, hi = 15 |
| 4 | 10 | 15 | 12 | 10 (1-4), 11 (5-6), 7, 8, 9, 10 | 6 | 6 > 5, lo = 13 |
| 5 | 13 | 15 | 14 | 10 (1-4), 11 (5-6), 7, 8, 9, 10 | 6 | 6 > 5, lo = 15 |
| exit | 15 | 15 | - | - | - | return 15 |

Answer: `15`.

**Complexity:** Time O(n log(sum)). Space O(1).

### 4. Takeaway
- **Pattern:** minimise a capacity or limit subject to a greedy, order-preserving feasibility check.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[5]`, days = 1 | 5 | lo = hi = 5 |
| days = 1 | sum | one ship loads everything |
| days = n | max(weights) | one package per day |
| `[1,2,3,1,1]`, days = 4 | 3 | answer between max and sum |

- **Mistakes to avoid:** starting `lo` at 1 or 0 (a package that cannot fit makes the check wrong); resetting `load = 0` without adding the current package; reordering packages (order is fixed).
- **Related problems:** 875 Koko (same template, simpler check), 410 Split Array Largest Sum (identical structure), 1231 Divide Chocolate (maximise the minimum).

---

## LeetCode 410: Split Array Largest Sum
**Difficulty:** Hard | **Pattern:** Binary search on the answer, minimise the maximum | **Language:** Java

### 1. Problem
- Split `nums` into `k` non-empty contiguous subarrays so that the largest subarray sum is as small as possible; return that sum. Example: `nums = [7,2,5,10,8]`, `k = 2` -> `18` (split `[7,2,5]` and `[10,8]`).
- Constraints: `n <= 1000`, values up to 10^6, `1 <= k <= min(50, n)`. Total sum up to 10^9 fits in `int`.
- **Key insight:** ask the reverse question: "given a cap on piece sums, how many pieces do I need?" Greedy filling gives the minimum count. If the count is `<= k`, the cap is feasible (extra pieces can always be split further since `k <= n`). Feasibility is monotone in the cap, so binary search the cap.

### 2. Solution
- Step 1, brute force: try all ways to place `k - 1` cuts, exponential (C(n-1, k-1)).
- Step 2: DP `dp[i][j]` = best answer for the first `i` elements in `j` pieces, O(n^2 k). Correct but heavy.
- Step 3: binary search the answer in `[max(nums), sum(nums)]`. The lower bound is the largest element (it must sit in some piece), the upper bound is `k = 1`. Greedy check: extend the current piece until adding the next element would exceed the cap, then start a new piece.

```java
class Solution {
    public int splitArray(int[] nums, int k) {
        int lo = 0, hi = 0;
        for (int x : nums) {
            lo = Math.max(lo, x);
            hi += x;
        }
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (piecesNeeded(nums, mid) <= k) hi = mid;
            else lo = mid + 1;
        }
        return lo;
    }

    private int piecesNeeded(int[] nums, int cap) {
        int pieces = 1, sum = 0;
        for (int x : nums) {
            if (sum + x > cap) {
                pieces++;
                sum = 0;
            }
            sum += x;
        }
        return pieces;
    }
}
```

### 3. Dry Run
`nums = [7,2,5,10,8]`, `k = 2`. `lo = 10`, `hi = 32`.

| Step | lo | hi | mid | Pieces formed | Count | Decision |
|---|---|---|---|---|---|---|
| 1 | 10 | 32 | 21 | [7,2,5]=14, [10,8]=18 | 2 | 2 <= 2, hi = 21 |
| 2 | 10 | 21 | 15 | [7,2,5]=14, [10]=10, [8]=8 | 3 | 3 > 2, lo = 16 |
| 3 | 16 | 21 | 18 | [7,2,5]=14, [10,8]=18 | 2 | 2 <= 2, hi = 18 |
| 4 | 16 | 18 | 17 | [7,2,5]=14, [10]=10, [8]=8 | 3 | 3 > 2, lo = 18 |
| exit | 18 | 18 | - | - | - | return 18 |

Answer: `18`.

**Complexity:** Time O(n log(sum)). Space O(1).

### 4. Takeaway
- **Pattern:** "minimise the maximum" or "maximise the minimum" over partitions -> binary search the bound, greedy check. Same family as painter's partition, book allocation, and load balancing.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `k = 1` | sum | one piece |
| `k = n` | max(nums) | each element alone |
| `[1,2,3,4,5]`, k = 2 | 9 | [1,2,3,4] vs [5] is 10, [1,2,3] vs [4,5] is 9 |
| all zeros | 0 | lo = hi = 0 |

- **Mistakes to avoid:** lower bound of 0 (check would build pieces that can never fit the largest element); using `<` instead of `<=` when comparing piece count to `k`; forgetting that the check must be greedy, not "balanced".
- **Related problems:** 1011 Ship Packages (same code shape), 875 Koko, 1231 Divide Chocolate (reverse direction), 1043 Partition Array for Maximum Sum (DP).

---

## LeetCode 981: Time Based Key-Value Store
**Difficulty:** Medium | **Pattern:** HashMap + binary search on timestamps (floor value) | **Language:** Java

### 1. Problem
- Design `TimeMap` with `set(key, value, timestamp)` and `get(key, timestamp)`; `get` returns the value stored with the largest timestamp `<= timestamp`, or `""` if none. Example: `set("love","high",10)`, `set("love","low",20)`; `get("love",15)` -> `"high"`, `get("love",25)` -> `"low"`, `get("love",5)` -> `""`.
- Constraints: up to 2 * 10^5 calls; `set` timestamps for a key are strictly increasing, so each key's history is already sorted.
- **Key insight:** because timestamps arrive in increasing order, append to a per-key list and answer `get` with a binary search for the last entry with time `<= timestamp` (floor).

### 2. Solution
- Step 1, brute force: on `get`, scan the key's history backward, O(h) per query. Slow for long histories.
- Step 2: the history is sorted, so binary search it: O(log h).
- Step 3: `Map<String, List<Entry>>`. The floor search uses the "record candidate and go right" template: when `time <= timestamp`, remember the index and move `lo = mid + 1`; else `hi = mid - 1`. A `record` keeps the pair compact with no extra boxing of values.

```java
import java.util.*;

class TimeMap {
    private record Entry(int time, String value) {}

    private final Map<String, List<Entry>> store = new HashMap<>();

    public void set(String key, String value, int timestamp) {
        store.computeIfAbsent(key, k -> new ArrayList<>()).add(new Entry(timestamp, value));
    }

    public String get(String key, int timestamp) {
        List<Entry> history = store.get(key);
        if (history == null) return "";
        int lo = 0, hi = history.size() - 1, ans = -1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if (history.get(mid).time() <= timestamp) {
                ans = mid;          // candidate floor, look for a later one
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }
        return ans == -1 ? "" : history.get(ans).value();
    }
}
```

### 3. Dry Run
After `set("love","high",10)` and `set("love","low",20)`, history = `[(10,high), (20,low)]`.

`get("love", 15)`:

| Step | lo | hi | mid | time[mid] | Decision | ans |
|---|---|---|---|---|---|---|
| 1 | 0 | 1 | 0 | 10 | 10 <= 15, ans = 0, lo = 1 | 0 |
| 2 | 1 | 1 | 1 | 20 | 20 > 15, hi = 0 | 0 |
| exit | 1 | 0 | - | - | lo > hi | 0 |

Result: `history[0].value = "high"`.

`get("love", 5)`: `mid = 0`, time 10 > 5, `hi = -1`, `ans` stays -1 -> `""`.

**Complexity:** `set` O(1) amortised. `get` O(log h) for the key's history length h. Space O(total sets).

### 4. Takeaway
- **Pattern:** versioned or time-travel lookups (audit logs, MVCC, event sourcing): append-only sorted history + floor search.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| unknown key | `""` | null history |
| timestamp before first set | `""` | ans stays -1 |
| timestamp equal to a set time | that value | `<=` includes equality |
| timestamp beyond last | last value | lo runs to end |

- **Mistakes to avoid:** returning the ceiling (next larger time) instead of the floor; using `<` so exact matches are skipped; sorting on each `get`; using a `TreeMap` per key when the append-only order already gives a sorted list (works, but O(log h) insert and more memory). `TreeMap.floorEntry` is the simpler alternative.
- **Related problems:** 729 My Calendar I (floor/ceiling on an ordered map), 35 Search Insert Position (the insertion-point form), 146 LRU Cache (another design problem).

---

## LeetCode 378: Kth Smallest Element in a Sorted Matrix
**Difficulty:** Medium | **Pattern:** Binary search on the value space with a counting predicate | **Language:** Java

### 1. Problem
- An `n x n` matrix with rows and columns each sorted ascending. Return the `k`th smallest element in sorted order (duplicates counted). Example: `[[1,5,9],[10,11,13],[12,13,15]]`, `k = 8` -> `13`.
- Constraints: `n <= 300`, values in `[-10^9, 10^9]`, `1 <= k <= n^2`. Aim for better than a full sort.
- **Key insight:** do not search positions; search values. `count(x)` = number of matrix cells `<= x` is non-decreasing in `x`. The answer is the smallest `x` with `count(x) >= k`, and that `x` is guaranteed to be a value in the matrix. `count(x)` is computed in O(n) with the staircase walk from 240.

### 2. Solution
- Step 1, brute force: flatten and sort, O(n^2 log n) time, O(n^2) space.
- Step 2: min-heap seeded with the first column, pop `k` times pushing the right neighbour, O(k log n). With `k` up to `n^2` this becomes O(n^2 log n). A good comparison point in interviews.
- Step 3: binary search the value range `[matrix[0][0], matrix[n-1][n-1]]`. For candidate `mid`, walk from the bottom-left: if `cell <= mid`, the whole column above (rows `0..row`) is `<= mid`, so add `row + 1` and move right; else move up. Total O(n) per count. If `count >= k`, answer is `mid` or smaller (`hi = mid`), else `lo = mid + 1`. The loop ends at the smallest value with `count >= k`, which must exist in the matrix.

```java
class Solution {
    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        int lo = matrix[0][0], hi = matrix[n - 1][n - 1];
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2; // safe for values near +-10^9
            if (countAtMost(matrix, mid) >= k) hi = mid;
            else lo = mid + 1;
        }
        return lo;
    }

    private int countAtMost(int[][] matrix, int x) {
        int n = matrix.length, row = n - 1, col = 0, count = 0;
        while (row >= 0 && col < n) {
            if (matrix[row][col] <= x) {
                count += row + 1;  // whole column segment above is <= x
                col++;
            } else {
                row--;
            }
        }
        return count;
    }
}
```

### 3. Dry Run
Matrix `[[1,5,9],[10,11,13],[12,13,15]]`, `k = 8`. `lo = 1`, `hi = 15`.

| Step | lo | hi | mid | count(<= mid) | Decision |
|---|---|---|---|---|---|
| 1 | 1 | 15 | 8 | 2 (1,5) | 2 < 8, lo = 9 |
| 2 | 9 | 15 | 12 | 6 (1,5,9,10,11,12) | 6 < 8, lo = 13 |
| 3 | 13 | 15 | 14 | 8 (adds 13,13) | 8 >= 8, hi = 14 |
| 4 | 13 | 14 | 13 | 8 | 8 >= 8, hi = 13 |
| exit | 13 | 13 | - | - | return 13 |

Count walk for `mid = 8`: start (2,0)=12 > 8, up to (1,0)=10 > 8, up to (0,0)=1 <= 8 add 1, right (0,1)=5 <= 8 add 1, right (0,2)=9 > 8, up, stop: total 2. Matches the table.

Answer: `13`.

**Complexity:** Time O(n log(max - min)). Space O(1).

### 4. Takeaway
- **Pattern:** "kth smallest" over a structure that has a cheap `count <= x`; binary search the value, not the index. Fuses answer-space search (875) with the staircase walk (240).
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `[[-5]]`, 1 | -5 | single cell |
| `k = 1` | matrix[0][0] | smallest |
| `k = n*n` | matrix[n-1][n-1] | largest |
| many duplicates | the repeated value | `count >= k` uses duplicates correctly |

- **Mistakes to avoid:** using `hi = mid - 1` (the answer may equal `mid`); returning the last `mid` instead of `lo`; computing `(lo + hi) / 2` with large negatives/positives; searching index space.
- **Related problems:** 240 (the counting walk), 875 Koko (value-space binary search), 373 Find K Pairs with Smallest Sums and 23 Merge k Sorted Lists (heap-based), 719 Find K-th Smallest Pair Distance.

---

## LeetCode 729: My Calendar I
**Difficulty:** Medium | **Pattern:** TreeMap `floorEntry` / `ceilingKey` for interval overlap | **Language:** Java

### 1. Problem
- Implement `book(start, end)` for half-open intervals `[start, end)`. Return `true` and store the event if it does not overlap any existing event, else `false`. Example: `book(10,20)` -> true, `book(15,25)` -> false, `book(20,30)` -> true.
- Constraints: up to 1000 calls, times up to 10^9. A list scan is O(n) per call; an ordered structure gives O(log n).
- **Key insight:** in a sorted collection of disjoint intervals, a new interval can only collide with its two neighbours: the event starting at or before `start` (floor) and the event starting at or after `start` (ceiling). Check just those two.

### 2. Solution
- Step 1, brute force: keep a list, compare against every event, O(n) per booking, O(n^2) overall.
- Step 2: events are disjoint, so sorting by start also sorts by end; only neighbours matter. That needs an ordered map, since a HashMap cannot answer "nearest key".
- Step 3: `TreeMap<Integer, Integer>` mapping start -> end. Let `prev = floorEntry(start)` and `next = ceilingKey(start)`. Overlap if `prev != null && prev.end > start`, or `next != null && next < end`. Otherwise insert. Half-open intervals mean touching endpoints (`prev.end == start`, `next == end`) are allowed.

```java
import java.util.*;

class MyCalendar {
    private final TreeMap<Integer, Integer> events = new TreeMap<>(); // start -> end

    public boolean book(int startTime, int endTime) {
        Map.Entry<Integer, Integer> prev = events.floorEntry(startTime);
        if (prev != null && prev.getValue() > startTime) return false;
        Integer next = events.ceilingKey(startTime);
        if (next != null && next < endTime) return false;
        events.put(startTime, endTime);
        return true;
    }
}
```
Note: if an event with exactly the same start exists, `floorEntry` returns it, and its end is `> start`, so it is correctly rejected.

### 3. Dry Run
Sequence: `book(10,20)`, `book(15,25)`, `book(20,30)`.

| Call | floorEntry(start) | ceilingKey(start) | Checks | Result | Map after |
|---|---|---|---|---|---|
| book(10,20) | none | none | nothing to compare | true | {10:20} |
| book(15,25) | 10->20 | none | prev.end 20 > 15 | false | {10:20} |
| book(20,30) | 10->20 | none | prev.end 20 > 20? no; no next | true | {10:20, 20:30} |

Answer: `true, false, true`.

**Complexity:** Time O(log n) per booking. Space O(n).

### 4. Takeaway
- **Pattern:** disjoint intervals under insertion; ordered map with nearest-neighbour queries. Comparable to the "floor" idea in 981.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| first booking | true | empty map |
| touching `[10,20)` then `[20,30)` | true | half-open |
| identical interval | false | floor has same start |
| new event wraps an existing one | false | ceiling start < end |

- **Mistakes to avoid:** using `>=` for the touching check (rejects valid adjacent bookings); checking only the floor (misses an event that starts inside the new one); using `lowerKey` and missing the same-start collision.
- **Related problems:** 731 My Calendar II (double booking allowed, difference map), 732 My Calendar III (max overlap), 56 Merge Intervals, 981 Time Based Key-Value Store.

---

## LeetCode 220: Contains Duplicate III
**Difficulty:** Hard | **Pattern:** TreeSet inside a sliding window (index range + value range) | **Language:** Java

### 1. Problem
- Return true if there exist `i != j` with `|i - j| <= indexDiff` and `|nums[i] - nums[j]| <= valueDiff`. Example: `nums = [1,2,3,1]`, `indexDiff = 3`, `valueDiff = 0` -> `true`.
- Constraints: `n` up to 10^5, values up to 10^9 in magnitude (differences overflow `int`), so a quadratic scan is too slow.
- **Key insight:** slide a window of the last `indexDiff` elements. For the new value `x`, we need any window value in `[x - valueDiff, x + valueDiff]`. A `TreeSet` answers it with one call: `ceiling(x - valueDiff)` is the smallest window value that is `>= x - valueDiff`; if it is also `<= x + valueDiff`, we have a match.

### 2. Solution
- Step 1, brute force: for each `i`, check the next `indexDiff` elements, O(n * indexDiff).
- Step 2: sliding window, but the value condition still needs a scan of the window.
- Step 3: keep the window in a `TreeSet<Long>`. For each element: `ceiling(x - valueDiff)`; if non-null and `<= x + valueDiff`, return true. Then add `x`, and if the set holds more than `indexDiff` elements, remove `nums[i - indexDiff]`. Use `long` to avoid overflow in `x - valueDiff` and `x + valueDiff`. Checking before inserting means a value never matches itself. Duplicates inside the window are fine: a duplicate would have been caught as a match (difference 0 <= valueDiff) before insertion, so the set never loses a distinct element.

```java
import java.util.*;

class Solution {
    public boolean containsNearbyAlmostDuplicate(int[] nums, int indexDiff, int valueDiff) {
        TreeSet<Long> window = new TreeSet<>();
        for (int i = 0; i < nums.length; i++) {
            long x = nums[i];
            Long candidate = window.ceiling(x - valueDiff);
            if (candidate != null && candidate <= x + valueDiff) return true;
            window.add(x);
            if (window.size() > indexDiff) window.remove((long) nums[i - indexDiff]);
        }
        return false;
    }
}
```

### 3. Dry Run
`nums = [1,5,9,1,5,9]`, `indexDiff = 2`, `valueDiff = 3`.

| i | x | Range [x-3, x+3] | ceiling(x-3) | Match? | Window after |
|---|---|---|---|---|---|
| 0 | 1 | [-2, 4] | none | no | {1} |
| 1 | 5 | [2, 8] | none (1 < 2) | no | {1,5} |
| 2 | 9 | [6, 12] | none (max is 5) | no | {1,5,9} -> size 3 > 2, remove nums[0] = 1 -> {5,9} |
| 3 | 1 | [-2, 4] | 5 | 5 > 4, no | {5,9,1} -> remove nums[1] = 5 -> {1,9} |
| 4 | 5 | [2, 8] | 9 | 9 > 8, no | {1,9,5} -> remove nums[2] = 9 -> {1,5} |
| 5 | 9 | [6, 12] | none | no | {1,5,9} -> remove nums[3] = 1 -> {5,9} |

Answer: `false`.

Quick positive check: `[1,2,3,1]`, k = 3, t = 0: at i = 3, window {1,2,3}, `ceiling(1)` = 1 <= 1, return true.

**Complexity:** Time O(n log k) where k = indexDiff. Space O(k).

### 4. Takeaway
- **Pattern:** window by index + range query by value -> sliding window with an ordered set. Bucket hashing (bucket width `valueDiff + 1`) gives O(n) as an alternative.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `indexDiff = 0` ... not allowed (>= 1) | - | by constraint |
| `valueDiff = 0` | true if a duplicate within k | ceiling equals x |
| `[-2147483648, 2147483647]`, 1, 1 | false | needs `long` arithmetic |
| single element | false | nothing to compare |

- **Mistakes to avoid:** `int` overflow in `x - valueDiff`; removing the wrong element (it is `nums[i - indexDiff]`, after the add); using `floor` only or `ceiling` only without bounds-checking the other side; inserting before the check.
- **Related problems:** 217 Contains Duplicate (any), 219 Contains Duplicate II (index window with a set), 480 Sliding Window Median (window with order statistics).

---

## LeetCode 480: Sliding Window Median
**Difficulty:** Hard | **Pattern:** Two heaps with lazy deletion (or an indexed ordered set) | **Language:** Java

### 1. Problem
- For each window of size `k` in `nums`, output the median (average of the two middle values when `k` is even). Example: `nums = [1,3,-1,-3,5,3,6,7]`, `k = 3` -> `[1,-1,-1,3,5,6]`.
- Constraints: `n` up to 10^5, values in the full `int` range, so sums need `long`/`double`. O(n log k) is the target.
- **Key insight:** the streaming median uses a max-heap for the lower half and a min-heap for the upper half. A heap cannot remove an arbitrary element cheaply, so mark the outgoing value as deleted (`delayed` count) and only discard it when it reaches a heap top. Track the logical sizes of both halves separately from the physical heap sizes.

### 2. Solution
- Step 1, brute force: sort each window, O(n k log k).
- Step 2: maintain a sorted window with insertion/removal, O(n k) due to shifting.
- Step 3: two heaps (`lo` max-heap, `hi` min-heap) with the invariant: `lo` holds the smaller half and has size `loSize == hiSize` or `hiSize + 1` (logical sizes). Operations:
  - `add(x)`: push to `lo` if `x <= lo.peek()`, else `hi`; then rebalance.
  - `remove(x)`: `delayed[x]++`; decrement the logical size of whichever half `x` belongs to (`x <= lo.peek()` -> `lo`); then rebalance and prune tops.
  - `rebalance`: move a top element across if one half is too big, then prune.
  - `prune`: while the heap top has `delayed > 0`, pop it and decrement `delayed`.
  - median: odd `k` -> `lo.peek()`; even -> average of both tops, summed in `double` to avoid overflow.
  Comparators use `Integer.compare` (never subtraction).

```java
import java.util.*;

class Solution {
    private final PriorityQueue<Integer> lo = new PriorityQueue<>(Comparator.reverseOrder()); // max-heap
    private final PriorityQueue<Integer> hi = new PriorityQueue<>();                          // min-heap
    private final Map<Integer, Integer> delayed = new HashMap<>();
    private int loSize = 0, hiSize = 0; // logical sizes, excluding delayed deletions

    public double[] medianSlidingWindow(int[] nums, int k) {
        double[] result = new double[nums.length - k + 1];
        for (int i = 0; i < k; i++) add(nums[i]);
        result[0] = median(k);
        for (int i = k; i < nums.length; i++) {
            add(nums[i]);
            remove(nums[i - k]);
            result[i - k + 1] = median(k);
        }
        return result;
    }

    private void add(int x) {
        if (lo.isEmpty() || x <= lo.peek()) {
            lo.offer(x);
            loSize++;
        } else {
            hi.offer(x);
            hiSize++;
        }
        rebalance();
    }

    private void remove(int x) {
        delayed.merge(x, 1, Integer::sum);
        if (x <= lo.peek()) {
            loSize--;
            if (x == lo.peek()) prune(lo);
        } else {
            hiSize--;
            if (!hi.isEmpty() && x == hi.peek()) prune(hi);
        }
        rebalance();
    }

    private void rebalance() {
        if (loSize > hiSize + 1) {
            hi.offer(lo.poll());
            loSize--;
            hiSize++;
            prune(lo);
        } else if (loSize < hiSize) {
            lo.offer(hi.poll());
            hiSize--;
            loSize++;
            prune(hi);
        }
    }

    private void prune(PriorityQueue<Integer> heap) {
        while (!heap.isEmpty()) {
            int top = heap.peek();
            Integer count = delayed.get(top);
            if (count == null) break;
            if (count == 1) delayed.remove(top);
            else delayed.put(top, count - 1);
            heap.poll();
        }
    }

    private double median(int k) {
        if ((k & 1) == 1) return lo.peek();
        return ((double) lo.peek() + (double) hi.peek()) / 2.0;
    }
}
```
Notes: counts are tracked per value, so duplicates work. A deleted value may sit deep in a heap for a while; it is only ever consulted when it reaches a top, and `prune` is called after every operation that can expose a new top. The class stores per-call state in fields, so create a fresh `Solution` per test (LeetCode does).

### 3. Dry Run
`nums = [1,3,-1,-3,5,3,6,7]`, `k = 3`. Notation: `lo` = lower half (max on the right in text), logical sizes in brackets.

| Step | Action | lo (logical) | hi (logical) | Median |
|---|---|---|---|---|
| add 1 | lo empty -> lo | {1} | {} | - |
| add 3 | 3 > 1 -> hi; sizes 1,1 ok | {1} | {3} | - |
| add -1 | -1 <= 1 -> lo; loSize 2 <= hiSize+1 ok | {-1,1} | {3} | window [1,3,-1] -> lo top 1 |
| i=3 add -3 | -3 <= 1 -> lo; loSize 3 > 2: move 1 to hi | {-3,-1} | {1,3} | - |
| i=3 remove 1 | delayed{1:1}; 1 > lo top (-1) -> hi side, hiSize 1; 1 == hi top -> prune: pop 1 | {-3,-1} | {3} | window [3,-1,-3] -> -1 |
| i=4 add 5 | 5 > -1 -> hi; sizes 2,2 | {-3,-1} | {3,5} | - |
| i=4 remove 3 | delayed{3:1}; 3 > -1 -> hi side, hiSize 1; 3 == hi top -> pop 3 | {-3,-1} | {5} | window [-1,-3,5] -> -1 |
| i=5 add 3 | 3 > -1 -> hi; hiSize 2 | {-3,-1} | {3,5} | - |
| i=5 remove -1 | -1 <= -1 -> lo side, loSize 1; top equals -1 -> pop it, lo = {-3}; rebalance: loSize 1 < hiSize 2 -> move 3 to lo | {-3,3} | {5} | window [-3,5,3] -> 3 |
| i=6 add 6 | 6 > 3 -> hi; sizes 2,2 | {-3,3} | {5,6} | - |
| i=6 remove -3 | -3 <= 3 -> lo side, loSize 1; top is 3, not -3, so it is delayed{-3:1} | {3} (+ hidden -3) | {5,6} | - |
| i=6 rebalance | loSize 1 < hiSize 2 -> move 5 to lo; hiSize 1, loSize 2 | {3,5} (+ hidden -3) | {6} | window [5,3,6] -> 5 |
| i=7 add 7 | 7 > 5 -> hi; sizes 2,2 | {3,5} | {6,7} | - |
| i=7 remove 5 | 5 <= 5 -> lo side, loSize 1; top equals 5 -> pop, then top is 3; -3 is still deeper | {3} | {6,7} | - |
| i=7 rebalance | loSize 1 < hiSize 2 -> move 6 to lo | {3,6} | {7} | window [3,6,7] -> 6 |

Medians in order: `1, -1, -1, 3, 5, 6`. This matches the expected output. (The hidden `-3` is never exposed at a top before the end; if it were, `prune` would pop it using the `delayed` counter.)

**Complexity:** Time O(n log k) amortised, each element is pushed once and popped at most once, plus HashMap updates. Space O(k) for the heaps plus the delayed map (bounded by the number of pending deletions, at most O(n) worst case but typically O(k)).

### 4. Takeaway
- **Pattern:** "streaming statistic plus removal" -> two heaps with lazy deletion, or `TreeSet` of indices ordered by `(value, index)` with a moving middle pointer. Say that adding deletion to a structure is the usual hard follow-up.
- **Edge cases:**

| Input | Result | Note |
|---|---|---|
| `k = 1` | the array itself | median is the lone value |
| `k = n` | one value | |
| `[2147483647, 2147483647]`, k = 2 | 2147483647.0 | `double` average avoids overflow |
| duplicates `[1,1,1,1]`, k = 2 | all 1.0 | delayed counts per value |
| negative values | fine | comparators use `reverseOrder()` / natural, not subtraction |

- **Mistakes to avoid:** using sizes of the heaps (they include deleted items) instead of logical sizes; forgetting to `prune` after a move or removal; deciding the side of the removed element with `<` instead of `<=` against `lo.peek()`; `(a + b) / 2` in `int`; a comparator like `(a, b) -> b - a` (overflows).
- **Related problems:** 295 Find Median from Data Stream (no removal, same two heaps), 239 Sliding Window Maximum (monotonic deque), 220 Contains Duplicate III (ordered set in a window), 1825 Finding MK Average.
