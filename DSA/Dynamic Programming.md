
Dynamic programming is memoisation over recursion. The signal to reach DP is overlapping problems - the same subproblems getting solved multiple times. Memoisation stores those results so the work is not repeated.

---
# 1D DP Problems
1D DP problems can be solved by memoizing all the repeating subProblems in a 1D Array or potentially just couple of constants.

#### 1. Climbing stairs

>Min ways to climb `n` stairs. At a time, either 1 step or 2 steps are allowed. 

- **Base cases:** 0 stairs --> 0 ways, 1 stair --> 1 Way `dp[0] = 0, dp[1] = 1`
- `i_th` step can be reached from `(i-1)_th` or `(i_2)_th` stair.
- `dp[i]`  --> minimum ways to climb `i` stairs.

```java
// base cases
dp[0] = 0;
dp[1] = 1;

for(int i=2; i<=n; i++){
	dp[i] = 1 + Math.min(dp[i-1], dp[i-2]);
}
return dp[n];
```

#### 2. 

---

# 2D DP Problems