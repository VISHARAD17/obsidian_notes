# Everything Java

## 1. Language Essentials

### Primitives vs Objects (Autoboxing)

```
Primitive  | Wrapper (Object)  | Size
-----------|-------------------|------
boolean    | Boolean           | 1 bit (JVM-dependent)
byte       | Byte              | 1 byte
char       | Character         | 2 bytes
short      | Short             | 2 bytes
int        | Integer           | 4 bytes
long       | Long              | 8 bytes
float      | Float             | 4 bytes
double     | Double            | 8 bytes
```

- Collections ONLY store objects, not primitives → `ArrayList<Integer>` not `ArrayList<int>`
- Autoboxing: `int` ↔ `Integer` happens automatically
- **TRAP**: `Integer` comparison with `==` checks reference, not value. Use `.equals()` or unbox.

```java
Integer a = 127, b = 127;
a == b;          // true (cached range -128 to 127)
Integer c = 128, d = 128;
c == d;          // FALSE! use c.equals(d)
```

---

### Strings

```java
// Immutable — every operation creates new string
String s = "hello";
s.length();              // 5
s.charAt(0);             // 'h'
s.substring(1, 3);       // "el" (start inclusive, end exclusive)
s.indexOf('l');          // 2 (first occurrence, -1 if not found)
s.contains("ell");       // true
s.equals("hello");       // true — NEVER use == for string comparison
s.compareTo("world");   // negative (lexicographic)
s.toCharArray();         // char[] {'h','e','l','l','o'}
s.split(",");            // String[]
s.trim();                // remove leading/trailing whitespace
s.toLowerCase();
s.toUpperCase();
s.replace('l', 'x');     // "hexxo"
String.valueOf(123);     // "123" (int to string)
Integer.parseInt("123"); // 123 (string to int)
Long.parseLong("123");   // 123L
```

**StringBuilder** — mutable, use for building strings in loops (O(1) append vs O(n) with `+=`):

```java
StringBuilder sb = new StringBuilder();
sb.append("hello");
sb.append(' ');
sb.append("world");
sb.insert(5, ",");       // "hello, world"
sb.deleteCharAt(5);      // "hello world"
sb.reverse();            // "dlrow olleh"
sb.toString();           // convert back to String
sb.length();
sb.charAt(0);
sb.setCharAt(0, 'H');
```

---

### Arrays

```java
// Declaration & initialization
int[] arr = new int[10];           // default 0
int[] arr = {1, 2, 3, 4, 5};
int[][] grid = new int[m][n];      // 2D array
int[][] grid = {{1,2},{3,4}};

// Length
arr.length;       // NOT a method, no ()
grid.length;      // rows
grid[0].length;   // cols

// Fill
Arrays.fill(arr, -1);             // fill entire array
Arrays.fill(arr, 2, 5, -1);      // fill index [2, 5) with -1

// Sort
Arrays.sort(arr);                  // O(n log n) — dual-pivot quicksort for primitives
Arrays.sort(arr, 2, 6);           // sort index [2, 6)

// Copy
int[] copy = Arrays.copyOf(arr, arr.length);
int[] copy = Arrays.copyOfRange(arr, 1, 4); // [1, 4)

// Search (array must be sorted)
int idx = Arrays.binarySearch(arr, target); // negative if not found

// Convert to string (for debugging)
Arrays.toString(arr);              // "[1, 2, 3]"
Arrays.deepToString(grid);        // "[[1, 2], [3, 4]]"

// Equals
Arrays.equals(arr1, arr2);        // element-wise comparison
```

---

### Type Casting & Math

```java
// Casting
int x = (int) 3.7;        // 3 (truncates)
char c = (char) (65);     // 'A'
int n = (int) 'A';        // 65
long l = (long) x;        // widening — implicit, cast optional

// Math class (all static)
Math.max(a, b);
Math.min(a, b);
Math.abs(x);               // works for int, long, float, double
Math.pow(2, 10);           // 1024.0 (returns double)
Math.sqrt(16);             // 4.0
Math.ceil(2.3);            // 3.0
Math.floor(2.7);           // 2.0
Math.log(x);               // natural log
Math.log10(x);
Math.round(2.5);           // 3 (long)

// Integer limits
Integer.MAX_VALUE;         // 2^31 - 1 = 2147483647
Integer.MIN_VALUE;         // -2^31 = -2147483648
Long.MAX_VALUE;            // 2^63 - 1
```

---

### Comparators & Lambdas

```java
// Sort array of Integer in descending order
Integer[] arr = {3, 1, 4};
Arrays.sort(arr, (a, b) -> b - a);         // descending
Arrays.sort(arr, Collections.reverseOrder());

// Sort 2D array by first element
int[][] intervals = {{1,3},{2,4},{0,5}};
Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

// Sort list by custom key
List<int[]> list = new ArrayList<>();
list.sort((a, b) -> a[1] - b[1]);         // sort by second element

// Comparator.comparingInt (cleaner for single key)
list.sort(Comparator.comparingInt(a -> a[0]));

// Multi-key sort
list.sort((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

// TRAP: (a - b) can overflow for large ints. Use Integer.compare(a, b) instead.
Arrays.sort(arr, (a, b) -> Integer.compare(a, b));
```

---

### I/O for Online Judges

```java
// Quick & simple — Scanner (slow but easy)
import java.util.*;
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
long l = sc.nextLong();
String s = sc.next();          // single word
String line = sc.nextLine();   // full line (watch for leftover newline after nextInt)

// Fast I/O — BufferedReader (use for large inputs)
import java.io.*;
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
int n = Integer.parseInt(br.readLine().trim());
String[] parts = br.readLine().split(" ");
int a = Integer.parseInt(parts[0]);

// Fast output
PrintWriter out = new PrintWriter(new BufferedOutputStream(System.out));
out.println(answer);
out.flush();    // don't forget!
```

---

## 2. Data Structures

### ArrayList (C++ `vector`)

```java
import java.util.*;

ArrayList<Integer> list = new ArrayList<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `add(val)` | Append to end | O(1) amortized |
| `add(idx, val)` | Insert at index | O(n) |
| `get(idx)` | Access by index | O(1) |
| `set(idx, val)` | Replace at index | O(1) |
| `remove(idx)` | Remove by index | O(n) |
| `remove(Integer.valueOf(val))` | Remove by value (first occurrence) | O(n) |
| `size()` | Length | O(1) |
| `isEmpty()` | Check empty | O(1) |
| `contains(val)` | Search | O(n) |
| `indexOf(val)` | First index of val (-1 if absent) | O(n) |
| `clear()` | Remove all | O(n) |
| `Collections.sort(list)` | Sort | O(n log n) |
| `Collections.reverse(list)` | Reverse | O(n) |

```java
// Initialize with values
ArrayList<Integer> list = new ArrayList<>(Arrays.asList(1, 2, 3));
List<Integer> list = new ArrayList<>(List.of(1, 2, 3));

// Iterate
for (int val : list) { }
for (int i = 0; i < list.size(); i++) { }

// Sort descending
list.sort(Collections.reverseOrder());
list.sort((a, b) -> b - a);

// Sublist (returns view, not copy)
List<Integer> sub = list.subList(1, 3); // [1, 3)
```

**TRAP**: `remove(1)` removes at INDEX 1, not value 1. Use `remove(Integer.valueOf(1))` to remove by value.

---

### LinkedList (C++ `list`)

```java
LinkedList<Integer> ll = new LinkedList<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `addFirst(val)` / `addLast(val)` | Insert at head/tail | O(1) |
| `removeFirst()` / `removeLast()` | Remove from head/tail | O(1) |
| `getFirst()` / `getLast()` | Peek head/tail | O(1) |
| `get(idx)` | Access by index | O(n) |
| `add(idx, val)` | Insert at index | O(n) |
| `remove(idx)` | Remove at index | O(n) |
| `size()` | Length | O(1) |

- Implements both `List` and `Deque` interfaces
- Rarely used directly in DSA — usually `ArrayDeque` is better for stack/queue

---

### Stack (C++ `stack`)

**Use `ArrayDeque` as stack** (not `Stack` class — it's legacy & synchronized):

```java
Deque<Integer> stack = new ArrayDeque<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `push(val)` | Push to top | O(1) |
| `pop()` | Remove & return top | O(1) |
| `peek()` | View top without removing | O(1) |
| `isEmpty()` | Check empty | O(1) |
| `size()` | Size | O(1) |

```java
Deque<Integer> stack = new ArrayDeque<>();
stack.push(10);
stack.push(20);
stack.peek();   // 20
stack.pop();    // 20
```

---

### Queue (C++ `queue`)

```java
Queue<Integer> queue = new LinkedList<>();
// OR (faster)
Queue<Integer> queue = new ArrayDeque<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `offer(val)` | Enqueue (add to back) | O(1) |
| `poll()` | Dequeue (remove from front), null if empty | O(1) |
| `peek()` | View front, null if empty | O(1) |
| `isEmpty()` | Check empty | O(1) |
| `size()` | Size | O(1) |

**Note**: `add()` / `remove()` / `element()` throw exceptions on failure. Prefer `offer()` / `poll()` / `peek()` which return null.

---

### Deque — Double-ended Queue (C++ `deque`)

```java
Deque<Integer> deque = new ArrayDeque<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `offerFirst(val)` | Add to front | O(1) |
| `offerLast(val)` | Add to back | O(1) |
| `pollFirst()` | Remove from front | O(1) |
| `pollLast()` | Remove from back | O(1) |
| `peekFirst()` | View front | O(1) |
| `peekLast()` | View back | O(1) |
| `size()` | Size | O(1) |

- **ArrayDeque** = go-to for stack AND queue (faster than LinkedList, no null elements)
- Use as stack: `push/pop/peek` (operates on front)
- Use as queue: `offerLast/pollFirst/peekFirst`

---

### PriorityQueue — Heap (C++ `priority_queue`)

```java
// Min-heap (default)
PriorityQueue<Integer> minHeap = new PriorityQueue<>();

// Max-heap
PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
// OR
PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
```

| Method | Description | Time |
|--------|-------------|------|
| `offer(val)` / `add(val)` | Insert | O(log n) |
| `poll()` | Remove & return min/max | O(log n) |
| `peek()` | View min/max | O(1) |
| `remove(val)` | Remove specific element | O(n) |
| `contains(val)` | Check existence | O(n) |
| `size()` | Size | O(1) |

```java
// Custom comparator — sort by second element of int[]
PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
pq.offer(new int[]{1, 5});
pq.offer(new int[]{2, 3});
pq.poll(); // {2, 3} (smallest second element)

// Heapify from collection — O(n)
PriorityQueue<Integer> pq = new PriorityQueue<>(Arrays.asList(5, 2, 8, 1));
```

**C++ difference**: C++ `priority_queue` is max-heap by default. Java `PriorityQueue` is MIN-heap by default.

---

### HashMap (C++ `unordered_map`)

```java
HashMap<String, Integer> map = new HashMap<>();
```

| Method | Description | Time (avg) |
|--------|-------------|------|
| `put(key, val)` | Insert/update | O(1) |
| `get(key)` | Get value (null if absent) | O(1) |
| `getOrDefault(key, default)` | Get value or default | O(1) |
| `containsKey(key)` | Check key exists | O(1) |
| `containsValue(val)` | Check value exists | O(n) |
| `remove(key)` | Delete entry | O(1) |
| `size()` | Number of entries | O(1) |
| `isEmpty()` | Check empty | O(1) |
| `keySet()` | Set of all keys | O(1) |
| `values()` | Collection of all values | O(1) |
| `entrySet()` | Set of key-value pairs | O(1) |

```java
// Frequency count pattern
Map<Integer, Integer> freq = new HashMap<>();
for (int x : arr) {
    freq.put(x, freq.getOrDefault(x, 0) + 1);
}
// OR with merge
freq.merge(x, 1, Integer::sum);

// Iterate
for (Map.Entry<String, Integer> entry : map.entrySet()) {
    entry.getKey();
    entry.getValue();
}
for (String key : map.keySet()) { }
for (int val : map.values()) { }

// putIfAbsent — only insert if key not present
map.putIfAbsent(key, 0);

// computeIfAbsent — great for adjacency list / grouping
Map<Integer, List<Integer>> graph = new HashMap<>();
graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);
```

---

### HashSet (C++ `unordered_set`)

```java
HashSet<Integer> set = new HashSet<>();
```

| Method | Description | Time (avg) |
|--------|-------------|------|
| `add(val)` | Insert (returns false if exists) | O(1) |
| `remove(val)` | Delete | O(1) |
| `contains(val)` | Check existence | O(1) |
| `size()` | Size | O(1) |
| `isEmpty()` | Check empty | O(1) |
| `clear()` | Remove all | O(n) |

```java
// Initialize from list
Set<Integer> set = new HashSet<>(Arrays.asList(1, 2, 3));
Set<Integer> set = new HashSet<>(list);

// Set operations
set1.retainAll(set2);  // intersection (modifies set1)
set1.addAll(set2);     // union
set1.removeAll(set2);  // difference
```

---

### TreeMap (C++ `map` — ordered, Red-Black Tree)

```java
TreeMap<Integer, String> map = new TreeMap<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `put(key, val)` | Insert/update | O(log n) |
| `get(key)` | Get value | O(log n) |
| `remove(key)` | Delete | O(log n) |
| `containsKey(key)` | Check key | O(log n) |
| `firstKey()` / `lastKey()` | Min/max key | O(log n) |
| `floorKey(k)` | Largest key ≤ k (null if none) | O(log n) |
| `ceilingKey(k)` | Smallest key ≥ k (null if none) | O(log n) |
| `lowerKey(k)` | Largest key < k | O(log n) |
| `higherKey(k)` | Smallest key > k | O(log n) |
| `subMap(from, to)` | View of keys [from, to) | O(log n) |
| `headMap(to)` | View of keys < to | O(log n) |
| `tailMap(from)` | View of keys ≥ from | O(log n) |

```java
TreeMap<Integer, Integer> tm = new TreeMap<>();
tm.put(1, 10);
tm.put(5, 50);
tm.put(3, 30);

tm.firstKey();      // 1
tm.lastKey();       // 5
tm.floorKey(4);     // 3 (largest key ≤ 4)
tm.ceilingKey(4);   // 5 (smallest key ≥ 4)

// Descending order
NavigableMap<Integer, Integer> desc = tm.descendingMap();
```

**Use when**: you need sorted keys, range queries, floor/ceiling operations (interval problems, sliding window).

---

### TreeSet (C++ `set` — ordered, Red-Black Tree)

```java
TreeSet<Integer> ts = new TreeSet<>();
```

| Method | Description | Time |
|--------|-------------|------|
| `add(val)` | Insert | O(log n) |
| `remove(val)` | Delete | O(log n) |
| `contains(val)` | Check | O(log n) |
| `first()` / `last()` | Min/max | O(log n) |
| `floor(val)` | Largest element ≤ val | O(log n) |
| `ceiling(val)` | Smallest element ≥ val | O(log n) |
| `lower(val)` | Largest element < val | O(log n) |
| `higher(val)` | Smallest element > val | O(log n) |
| `pollFirst()` / `pollLast()` | Remove & return min/max | O(log n) |
| `subSet(from, to)` | View [from, to) | O(log n) |
| `size()` | Size | O(1) |

```java
TreeSet<Integer> ts = new TreeSet<>();
ts.add(5); ts.add(1); ts.add(8); ts.add(3);

ts.first();      // 1
ts.last();       // 8
ts.floor(4);     // 3
ts.ceiling(4);   // 5
ts.lower(5);     // 3 (strictly less)
ts.higher(5);    // 8 (strictly greater)
```

---

### LinkedHashMap & LinkedHashSet (Insertion-ordered)

```java
// Maintains insertion order (unlike HashMap which is unordered)
LinkedHashMap<String, Integer> lhm = new LinkedHashMap<>();
LinkedHashSet<Integer> lhs = new LinkedHashSet<>();
```

- Same API as HashMap/HashSet
- Same O(1) operations
- Extra: maintains insertion order during iteration
- **LRU Cache trick**: `LinkedHashMap` with access-order constructor

```java
// LRU Cache using LinkedHashMap
LinkedHashMap<Integer, Integer> lru = new LinkedHashMap<>(16, 0.75f, true) {
    @Override
    protected boolean removeEldestEntry(Map.Entry<Integer, Integer> eldest) {
        return size() > capacity;
    }
};
```

---

### BitSet

```java
BitSet bs = new BitSet(100); // 100 bits, all 0
```

| Method | Description |
|--------|-------------|
| `set(idx)` | Set bit to 1 |
| `set(from, to)` | Set bits [from, to) to 1 |
| `clear(idx)` | Set bit to 0 |
| `get(idx)` | Get bit value (boolean) |
| `flip(idx)` | Toggle bit |
| `and(other)` | Bitwise AND (modifies this) |
| `or(other)` | Bitwise OR |
| `xor(other)` | Bitwise XOR |
| `cardinality()` | Count of set bits |
| `isEmpty()` | All bits are 0? |
| `nextSetBit(from)` | Next set bit from index |
| `nextClearBit(from)` | Next clear bit from index |

```java
BitSet bs = new BitSet();
bs.set(3);        // bit 3 = 1
bs.set(7);        // bit 7 = 1
bs.get(3);        // true
bs.cardinality(); // 2
bs.flip(3);       // bit 3 = 0 now
```

- Use when you need a memory-efficient boolean array for large ranges
- Better than `boolean[]` when you need bitwise operations across sets

---

## 3. Common Conversions & Idioms

### Array ↔ List

```java
// int[] → ArrayList<Integer>
int[] arr = {1, 2, 3};
List<Integer> list = new ArrayList<>();
for (int x : arr) list.add(x);
// OR (Java 8+)
List<Integer> list = Arrays.stream(arr).boxed().collect(Collectors.toList());

// Integer[] → ArrayList<Integer>
Integer[] arr = {1, 2, 3};
List<Integer> list = new ArrayList<>(Arrays.asList(arr));

// ArrayList<Integer> → int[]
int[] arr = list.stream().mapToInt(Integer::intValue).toArray();

// ArrayList<Integer> → Integer[]
Integer[] arr = list.toArray(new Integer[0]);

// String[] → ArrayList<String>
String[] arr = {"a", "b", "c"};
List<String> list = new ArrayList<>(Arrays.asList(arr));

// ArrayList<String> → String[]
String[] arr = list.toArray(new String[0]);
```

### String ↔ char[]

```java
// String → char[]
char[] chars = str.toCharArray();

// char[] → String
String str = new String(chars);
String str = String.valueOf(chars);
```

### int ↔ String

```java
// int → String
String s = String.valueOf(42);
String s = Integer.toString(42);
String s = "" + 42;

// String → int
int n = Integer.parseInt("42");
long l = Long.parseLong("42");

// int → char (digit)
char c = (char) ('0' + digit);  // digit 0-9

// char → int (digit)
int d = c - '0';               // c is '0'-'9'
```

### int[] ↔ Integer[] (boxing/unboxing)

```java
// int[] → Integer[]
int[] arr = {1, 2, 3};
Integer[] boxed = Arrays.stream(arr).boxed().toArray(Integer[]::new);

// Integer[] → int[]
Integer[] boxed = {1, 2, 3};
int[] arr = Arrays.stream(boxed).mapToInt(Integer::intValue).toArray();
```

---

### Pair / Tuple Workaround

Java has NO built-in Pair. Options:

```java
// Option 1: int[] (simplest for 2 ints)
int[] pair = {x, y};
queue.offer(new int[]{row, col});

// Option 2: Map.Entry (for key-value)
Map.Entry<Integer, Integer> entry = Map.entry(1, 2);
entry.getKey();   // 1
entry.getValue(); // 2

// Option 3: Custom class (when you need clarity)
class Pair {
    int first, second;
    Pair(int f, int s) { first = f; second = s; }
}

// Option 4: Record (Java 16+, clean)
record Pair(int x, int y) {}
Pair p = new Pair(1, 2);
p.x(); p.y();
```

---

### Iteration Patterns

```java
// For-each (collections)
for (int val : list) { }
for (Map.Entry<K, V> e : map.entrySet()) { }

// Index-based
for (int i = 0; i < list.size(); i++) { }

// Iterator (safe removal during iteration)
Iterator<Integer> it = set.iterator();
while (it.hasNext()) {
    int val = it.next();
    if (condition) it.remove(); // safe!
}

// TRAP: Modifying collection during for-each → ConcurrentModificationException
// Use iterator.remove() or collect-then-remove pattern
```

---

### Useful One-liners

```java
// Swap two elements in array
int temp = arr[i]; arr[i] = arr[j]; arr[j] = temp;

// Swap in list
Collections.swap(list, i, j);

// Max/min of collection
Collections.max(list);
Collections.min(list);

// Frequency of element
Collections.frequency(list, target);

// Reverse array (no direct method — reverse manually or use Collections on List)
Collections.reverse(Arrays.asList(arr)); // only works for Integer[], not int[]

// Fill list with value
Collections.fill(list, 0);

// Unmodifiable list
List<Integer> fixed = Collections.unmodifiableList(list);

// N copies
List<Integer> zeros = new ArrayList<>(Collections.nCopies(10, 0));
```

---

## 4. Sorting

### Arrays.sort()

```java
// Primitives — dual-pivot quicksort — O(n log n) avg, O(n²) worst
int[] arr = {5, 2, 8, 1};
Arrays.sort(arr);                    // ascending
Arrays.sort(arr, 1, 4);             // sort index [1, 4)

// Objects — TimSort (merge sort variant) — O(n log n) guaranteed, stable
Integer[] arr = {5, 2, 8, 1};
Arrays.sort(arr, Collections.reverseOrder());  // descending
Arrays.sort(arr, (a, b) -> b - a);             // descending with lambda

// TRAP: Cannot use Comparator with primitive arrays (int[]).
// Must use Integer[] for custom sort order.
```

### Collections.sort()

```java
List<Integer> list = new ArrayList<>(Arrays.asList(5, 2, 8, 1));
Collections.sort(list);                         // ascending
Collections.sort(list, Collections.reverseOrder()); // descending

// OR (preferred)
list.sort(Comparator.naturalOrder());           // ascending
list.sort(Comparator.reverseOrder());           // descending
list.sort((a, b) -> a - b);                     // ascending with lambda
```

### Sort 2D Array

```java
int[][] intervals = {{1,3},{2,4},{0,5}};

// By first element
Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

// By first element, then by second if tie
Arrays.sort(intervals, (a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

// By second element descending
Arrays.sort(intervals, (a, b) -> b[1] - a[1]);
```

### Sort List of int[]

```java
List<int[]> list = new ArrayList<>();
list.add(new int[]{1, 3});
list.add(new int[]{2, 1});

list.sort((a, b) -> a[0] - b[0]);  // by first element
list.sort(Comparator.comparingInt(a -> a[1])); // by second element
```

### Sort String Array

```java
String[] words = {"banana", "apple", "cherry"};
Arrays.sort(words);                             // lexicographic
Arrays.sort(words, (a, b) -> a.length() - b.length()); // by length
Arrays.sort(words, Comparator.comparingInt(String::length)); // cleaner
```

### Sort with Comparator.comparing (Multi-key)

```java
// Sort objects by multiple keys
List<int[]> list = ...;
list.sort(Comparator.comparingInt((int[] a) -> a[0])
                    .thenComparingInt(a -> a[1]));

// Reverse one key
list.sort(Comparator.comparingInt((int[] a) -> a[0])
                    .thenComparing(Comparator.comparingInt((int[] a) -> a[1]).reversed()));
```

### Custom Object Sorting

```java
// Implementing Comparable (natural ordering)
class Edge implements Comparable<Edge> {
    int u, v, weight;
    Edge(int u, int v, int w) { this.u = u; this.v = v; this.weight = w; }

    @Override
    public int compareTo(Edge other) {
        return Integer.compare(this.weight, other.weight);
    }
}
List<Edge> edges = ...;
Collections.sort(edges); // uses compareTo

// OR just use Comparator externally
edges.sort((a, b) -> Integer.compare(a.weight, b.weight));
```

### Stability & Algorithm Notes

| Method | Algorithm | Stable? | Worst Case |
|--------|-----------|---------|------------|
| `Arrays.sort(int[])` | Dual-pivot Quicksort | No | O(n²) |
| `Arrays.sort(Object[])` | TimSort | Yes | O(n log n) |
| `Collections.sort()` | TimSort | Yes | O(n log n) |

- **Stable** = equal elements maintain relative order
- For primitives where O(n²) matters (adversarial input), shuffle first or use `Integer[]` with TimSort

### Overflow-safe Comparison

```java
// BAD — can overflow
(a, b) -> a - b

// GOOD — always safe
(a, b) -> Integer.compare(a, b)
Comparator.comparingInt(a -> a[0])

// When do you care? When values are near Integer.MAX_VALUE / MIN_VALUE
```

---

## 5. Graph & Tree

### Adjacency List Representation

```java
// Option 1: ArrayList of ArrayLists (most common)
int n = 5; // number of nodes
List<List<Integer>> graph = new ArrayList<>();
for (int i = 0; i < n; i++) graph.add(new ArrayList<>());

// Add edges
graph.get(u).add(v);   // directed
graph.get(v).add(u);   // undirected (add both)

// Iterate neighbors
for (int neighbor : graph.get(node)) { }

// Option 2: HashMap (when nodes aren't 0-indexed or are sparse)
Map<Integer, List<Integer>> graph = new HashMap<>();
graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);
graph.computeIfAbsent(v, k -> new ArrayList<>()).add(u);

// Iterate (safe — node might not be in map)
for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) { }

// Option 3: Weighted graph
List<List<int[]>> graph = new ArrayList<>();
for (int i = 0; i < n; i++) graph.add(new ArrayList<>());
graph.get(u).add(new int[]{v, weight});
```

---

### BFS Template

```java
// Standard BFS — shortest path in unweighted graph
public int bfs(List<List<Integer>> graph, int start, int target) {
    Queue<Integer> queue = new ArrayDeque<>();
    boolean[] visited = new boolean[graph.size()];

    queue.offer(start);
    visited[start] = true;
    int level = 0;

    while (!queue.isEmpty()) {
        int size = queue.size(); // process level by level
        for (int i = 0; i < size; i++) {
            int node = queue.poll();
            if (node == target) return level;

            for (int neighbor : graph.get(node)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }
        level++;
    }
    return -1; // not reachable
}
```

### BFS on Grid

```java
int[][] dirs = {{0,1},{0,-1},{1,0},{-1,0}};

public int bfsGrid(int[][] grid, int[] start, int[] target) {
    int m = grid.length, n = grid[0].length;
    Queue<int[]> queue = new ArrayDeque<>();
    boolean[][] visited = new boolean[m][n];

    queue.offer(start);
    visited[start[0]][start[1]] = true;
    int steps = 0;

    while (!queue.isEmpty()) {
        int size = queue.size();
        for (int i = 0; i < size; i++) {
            int[] curr = queue.poll();
            if (curr[0] == target[0] && curr[1] == target[1]) return steps;

            for (int[] dir : dirs) {
                int nr = curr[0] + dir[0], nc = curr[1] + dir[1];
                if (nr >= 0 && nr < m && nc >= 0 && nc < n
                    && !visited[nr][nc] && grid[nr][nc] != 1) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc});
                }
            }
        }
        steps++;
    }
    return -1;
}
```

---

### DFS Template (Recursive)

```java
// Standard DFS
boolean[] visited;

public void dfs(List<List<Integer>> graph, int node) {
    visited[node] = true;
    for (int neighbor : graph.get(node)) {
        if (!visited[neighbor]) {
            dfs(graph, neighbor);
        }
    }
}

// Count connected components
int components = 0;
visited = new boolean[n];
for (int i = 0; i < n; i++) {
    if (!visited[i]) {
        dfs(graph, i);
        components++;
    }
}
```

### DFS Template (Iterative — using stack)

```java
public void dfsIterative(List<List<Integer>> graph, int start) {
    Deque<Integer> stack = new ArrayDeque<>();
    boolean[] visited = new boolean[graph.size()];

    stack.push(start);
    while (!stack.isEmpty()) {
        int node = stack.pop();
        if (visited[node]) continue;
        visited[node] = true;

        // process node

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                stack.push(neighbor);
            }
        }
    }
}
```

---

### Topological Sort (Kahn's BFS)

```java
public List<Integer> topologicalSort(int n, List<List<Integer>> graph) {
    int[] indegree = new int[n];
    for (int u = 0; u < n; u++)
        for (int v : graph.get(u))
            indegree[v]++;

    Queue<Integer> queue = new ArrayDeque<>();
    for (int i = 0; i < n; i++)
        if (indegree[i] == 0) queue.offer(i);

    List<Integer> order = new ArrayList<>();
    while (!queue.isEmpty()) {
        int node = queue.poll();
        order.add(node);
        for (int neighbor : graph.get(node)) {
            if (--indegree[neighbor] == 0)
                queue.offer(neighbor);
        }
    }

    // if order.size() != n → cycle exists
    return order.size() == n ? order : new ArrayList<>();
}
```

---

### Dijkstra's Algorithm

```java
// Shortest path from source — O((V + E) log V)
public int[] dijkstra(List<List<int[]>> graph, int src, int n) {
    int[] dist = new int[n];
    Arrays.fill(dist, Integer.MAX_VALUE);
    dist[src] = 0;

    // {distance, node}
    PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
    pq.offer(new int[]{0, src});

    while (!pq.isEmpty()) {
        int[] curr = pq.poll();
        int d = curr[0], u = curr[1];

        if (d > dist[u]) continue; // skip outdated entries

        for (int[] edge : graph.get(u)) {
            int v = edge[0], w = edge[1];
            if (dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                pq.offer(new int[]{dist[v], v});
            }
        }
    }
    return dist;
}
```

---

### Union-Find (Disjoint Set Union)

```java
class UnionFind {
    int[] parent, rank;

    UnionFind(int n) {
        parent = new int[n];
        rank = new int[n];
        for (int i = 0; i < n; i++) parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]); // path compression
        return parent[x];
    }

    boolean union(int x, int y) {
        int px = find(x), py = find(y);
        if (px == py) return false; // already connected
        if (rank[px] < rank[py]) { int temp = px; px = py; py = temp; }
        parent[py] = px;
        if (rank[px] == rank[py]) rank[px]++;
        return true;
    }

    boolean connected(int x, int y) {
        return find(x) == find(y);
    }
}
```

---

### Binary Tree — TreeNode

```java
// Typical LeetCode definition
class TreeNode {
    int val;
    TreeNode left, right;
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}
```

### Tree Traversals

```java
// Inorder (Left, Root, Right)
public void inorder(TreeNode root) {
    if (root == null) return;
    inorder(root.left);
    // process root.val
    inorder(root.right);
}

// Preorder (Root, Left, Right)
public void preorder(TreeNode root) {
    if (root == null) return;
    // process root.val
    preorder(root.left);
    preorder(root.right);
}

// Postorder (Left, Right, Root)
public void postorder(TreeNode root) {
    if (root == null) return;
    postorder(root.left);
    postorder(root.right);
    // process root.val
}

// Level-order (BFS)
public List<List<Integer>> levelOrder(TreeNode root) {
    List<List<Integer>> result = new ArrayList<>();
    if (root == null) return result;

    Queue<TreeNode> queue = new ArrayDeque<>();
    queue.offer(root);

    while (!queue.isEmpty()) {
        int size = queue.size();
        List<Integer> level = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            TreeNode node = queue.poll();
            level.add(node.val);
            if (node.left != null) queue.offer(node.left);
            if (node.right != null) queue.offer(node.right);
        }
        result.add(level);
    }
    return result;
}
```

### Iterative Inorder (with Stack)

```java
public List<Integer> inorderIterative(TreeNode root) {
    List<Integer> result = new ArrayList<>();
    Deque<TreeNode> stack = new ArrayDeque<>();
    TreeNode curr = root;

    while (curr != null || !stack.isEmpty()) {
        while (curr != null) {
            stack.push(curr);
            curr = curr.left;
        }
        curr = stack.pop();
        result.add(curr.val);
        curr = curr.right;
    }
    return result;
}
```

---

### Trie (Prefix Tree)

```java
class Trie {
    Trie[] children = new Trie[26];
    boolean isEnd = false;

    void insert(String word) {
        Trie node = this;
        for (char c : word.toCharArray()) {
            int idx = c - 'a';
            if (node.children[idx] == null)
                node.children[idx] = new Trie();
            node = node.children[idx];
        }
        node.isEnd = true;
    }

    boolean search(String word) {
        Trie node = searchPrefix(word);
        return node != null && node.isEnd;
    }

    boolean startsWith(String prefix) {
        return searchPrefix(prefix) != null;
    }

    private Trie searchPrefix(String s) {
        Trie node = this;
        for (char c : s.toCharArray()) {
            int idx = c - 'a';
            if (node.children[idx] == null) return null;
            node = node.children[idx];
        }
        return node;
    }
}
```

---

## 6. Bit Manipulation

### Operators (Same as C++)

```java
&    // AND
|    // OR
^    // XOR
~    // NOT (bitwise complement)
<<   // Left shift
>>   // Right shift (signed — fills with sign bit)
>>>  // Unsigned right shift (fills with 0) — JAVA ONLY, C++ doesn't have this
```

### Common Bit Tricks

```java
// Check if ith bit is set
(n >> i) & 1            // returns 0 or 1
(n & (1 << i)) != 0    // boolean

// Set ith bit
n | (1 << i)

// Clear ith bit
n & ~(1 << i)

// Toggle ith bit
n ^ (1 << i)

// Clear lowest set bit
n & (n - 1)

// Isolate lowest set bit
n & (-n)

// Check if power of 2
n > 0 && (n & (n - 1)) == 0

// Count set bits (popcount)
Integer.bitCount(n)         // built-in, O(1)
Long.bitCount(n)

// Number of leading/trailing zeros
Integer.numberOfLeadingZeros(n)
Integer.numberOfTrailingZeros(n)

// Highest/lowest one bit
Integer.highestOneBit(n)    // e.g., 12 → 8
Integer.lowestOneBit(n)     // e.g., 12 → 4

// Reverse bits
Integer.reverse(n)

// Convert to binary string
Integer.toBinaryString(n)   // "1010"
Integer.toString(n, 2)      // same
```

### Bitmask Patterns (Subset iteration)

```java
// Iterate all subsets of a bitmask
for (int sub = mask; sub > 0; sub = (sub - 1) & mask) {
    // sub is a subset of mask
}
// Don't forget the empty subset (0) if needed

// Iterate all masks of size n
for (int mask = 0; mask < (1 << n); mask++) {
    for (int i = 0; i < n; i++) {
        if ((mask >> i & 1) == 1) {
            // bit i is set in mask
        }
    }
}
```

### XOR Properties (same as C++)

```java
a ^ a = 0       // self-cancel
a ^ 0 = a       // identity
a ^ b ^ a = b   // find missing / single number

// Swap without temp
a ^= b; b ^= a; a ^= b;
```

### Java-specific Bit Notes

```java
// int is 32-bit signed, long is 64-bit signed
// No unsigned types in Java!
// Use >>> for unsigned right shift
// Use long when you need > 32 bits for bitmask

// TRAP: (1 << 32) == 1 in Java (shifts are mod 32 for int)
// Use (1L << 32) for longs

// TRAP: ~ on an int flips ALL 32 bits
// ~0 = -1 (all 1s in two's complement)
```

---

## 7. Utilities & Gotchas

### Collections Utility Class

```java
Collections.sort(list);
Collections.reverse(list);
Collections.swap(list, i, j);
Collections.min(list);
Collections.max(list);
Collections.frequency(list, target);
Collections.fill(list, val);
Collections.nCopies(n, val);          // returns immutable list
Collections.binarySearch(list, key);  // list must be sorted
Collections.unmodifiableList(list);   // read-only view
Collections.singletonList(val);      // immutable single-element list
Collections.emptyList();             // immutable empty list
```

### Overflow Handling

```java
// int range: -2^31 to 2^31-1 (~2.1 billion)
// long range: -2^63 to 2^63-1

// TRAP: intermediate overflow
int a = Integer.MAX_VALUE;
int b = a + 1;  // -2147483648 (wraps silently — no exception!)

// Use long for sums, products that might overflow
long sum = 0;
for (int x : arr) sum += x;

// Use long for multiplication
long product = (long) a * b;  // cast BEFORE multiply

// Modular arithmetic (common in contest problems)
int MOD = 1_000_000_007;
long result = ((long) a * b) % MOD;
result = (result + MOD) % MOD; // ensure positive after subtraction
```

### Null & NPE Awareness

```java
// HashMap.get() returns null if key absent
// TRAP: unboxing null Integer → NullPointerException
Map<Integer, Integer> map = new HashMap<>();
int val = map.get(key);  // NPE if key not in map!

// Safe patterns:
int val = map.getOrDefault(key, 0);
if (map.containsKey(key)) { int val = map.get(key); }
Integer val = map.get(key); if (val != null) { ... }

// Queue/Deque: poll() returns null if empty, pop() throws exception
Integer val = queue.poll(); // null if empty
// vs
int val = queue.poll(); // NPE if queue empty (unboxing null)

// Always check before unboxing
```

### Random

```java
Random rand = new Random();
rand.nextInt(n);         // [0, n)
rand.nextInt(max - min + 1) + min; // [min, max]
rand.nextDouble();       // [0.0, 1.0)
rand.nextBoolean();

// Shuffle array (Fisher-Yates via Collections)
List<Integer> list = new ArrayList<>(Arrays.asList(arr));
Collections.shuffle(list);
```

### String Hashing (Rolling Hash)

```java
// Rabin-Karp style
long hash = 0;
long base = 31;
long mod = 1_000_000_007;
for (char c : s.toCharArray()) {
    hash = (hash * base + (c - 'a' + 1)) % mod;
}
```

### Infinity Values

```java
// For Dijkstra / DP initialization
Integer.MAX_VALUE      // 2147483647 — TRAP: adding 1 overflows!
Integer.MAX_VALUE / 2  // safe "infinity" for distances
Long.MAX_VALUE

// For double
Double.POSITIVE_INFINITY
Double.NEGATIVE_INFINITY
```

---

## C++ → Java Quick Reference

| C++ | Java | Notes |
|-----|------|-------|
| `vector<int>` | `ArrayList<Integer>` | Object only, autoboxing |
| `array<int,N>` / `int[]` | `int[]` | Same concept |
| `pair<int,int>` | `int[]` or custom class | No built-in Pair |
| `stack<int>` | `Deque<Integer>` (ArrayDeque) | Don't use Stack class |
| `queue<int>` | `Queue<Integer>` (ArrayDeque) | Use offer/poll/peek |
| `deque<int>` | `Deque<Integer>` (ArrayDeque) | |
| `priority_queue<int>` | `PriorityQueue<Integer>` | **Java = min-heap!** (C++ = max) |
| `priority_queue<int,vec,greater>` | `PriorityQueue<>()` (default) | Java default is min |
| `unordered_map<K,V>` | `HashMap<K,V>` | |
| `map<K,V>` | `TreeMap<K,V>` | Red-black tree, sorted |
| `unordered_set<T>` | `HashSet<T>` | |
| `set<T>` | `TreeSet<T>` | Sorted |
| `multiset<T>` | `TreeMap<T, Integer>` (count) | No direct equivalent |
| `string` | `String` (immutable) | Use StringBuilder for mutation |
| `sort(v.begin(), v.end())` | `Collections.sort(list)` / `Arrays.sort(arr)` | |
| `reverse(v.begin(), v.end())` | `Collections.reverse(list)` | |
| `lower_bound(v, x)` | `TreeSet.ceiling(x)` / `Arrays.binarySearch` | Slightly different semantics |
| `upper_bound(v, x)` | `TreeSet.higher(x)` | Strictly greater |
| `v.push_back(x)` | `list.add(x)` | |
| `v.pop_back()` | `list.remove(list.size()-1)` | |
| `v.size()` | `list.size()` | |
| `v.empty()` | `list.isEmpty()` | |
| `sizeof(arr)/sizeof(arr[0])` | `arr.length` | |
| `INT_MAX` / `INT_MIN` | `Integer.MAX_VALUE` / `MIN_VALUE` | |
| `LLONG_MAX` | `Long.MAX_VALUE` | |
| `to_string(n)` | `String.valueOf(n)` | |
| `stoi(s)` | `Integer.parseInt(s)` | |
| `__builtin_popcount(n)` | `Integer.bitCount(n)` | |
| `__builtin_clz(n)` | `Integer.numberOfLeadingZeros(n)` | |
| `__builtin_ctz(n)` | `Integer.numberOfTrailingZeros(n)` | |
| `memset(arr, 0, sizeof(arr))` | `Arrays.fill(arr, 0)` | |
| `nullptr` | `null` | |
| `cout << x` | `System.out.println(x)` | |

---

### Key Mindset Shifts from C++

1. **No pointers** — everything is references (objects) or values (primitives)
2. **No operator overloading** — use Comparator for custom ordering
3. **No pass-by-reference for primitives** — wrap in array `int[] count = {0}` for mutable pass
4. **Garbage collection** — no `delete`, no memory leaks (but still watch object creation in tight loops)
5. **Everything is a class** — even your solution on LeetCode is inside `class Solution {}`
6. **String is immutable** — use StringBuilder for O(1) append
7. **No unsigned types** — use `long` when you need more range, `>>>` for unsigned shift
8. **Array bounds checking** — throws ArrayIndexOutOfBoundsException (not silent corruption like C++)
9. **Default values** — `int[]` defaults to 0, `boolean[]` to false, `Object[]` to null (same as C++ value-init)
10. **No STL algorithms like next_permutation** — you write them manually or use library workarounds

---
