Pre-requisites : [[DSA/BFS|BFS]],[[DSA/DFS|DFS]]

# Graphs Basics

Graphs are typically represented in two ways: 
- Adjacency List
- 2D matrix

![[graph_1|500|center]]

Graphs can contain cycles. Graphs can be connected where there is a path between every pair of nodes. Graphs can also be disconnected where at least two nodes are not connected. In disconnected graph, connected components are referred to as connected components of that graph.

![[graph_2|500|center]]

### Graph Representations
Most of the time in the problem we will be given a list of pairs where each pair represents an edge in graph, where nodes ranges from `0` to `n-1`
We need to build the graph out of it. 
`edge[i] = [u_i, v_i]` , edge between `u` and `v` can be directed or undirected.

input :
```
n = 5      int[][] edges = {{0,1}, {1,2}, {2,3}, {1,3}, {1,4}};
```

![[graph_3|500|center]]

**1. Adjacency List**
In this representation each list contains the neighbouring nodes of the index node
ex. adj[1] = {2, 3, 4}

```java
public static ArrayList<ArrayList<Integer>> buildGraph(int n, int[][] edges){
	ArrayList<ArrayList<Integer>> adj = new ArrayList<>();

	for(int i=0; i<n; i++){
		adj.add(new ArrayList<>());
	}

	// add each edge to the list
	for(int i=0; i<edges.length; i++){
		int u = edges[i][0];
		int v = edges[i][1];

		adj.get(u).add(v);
	}
	return adj;
}
```

Adjacency list :
```cmd
[0] --> {1}
[1] --> {0,2,3,4}
[2] --> {3, 1}
[3] --> {1, 2}
[4] --> {1}
```

**2.Adjacency Matrix**
An adjacency matrix is a way of representing a graph as a boolean matrix of 0s and 1s.
For `edge[u][v]` in matrix --> `adjMatrix[i][j] = 1`

```java
public static boolean[][] buildGraphAdj(int n, int[][] edges){
	boolean[][] graph = new boolean[n][n];

	for(int[] e: edges){
		int u = e[0];
		int v = e[1];
		graph[u][v] = true;
		graph[v][u] = true;
	}

	return graph;
}
```

Adjacency Matrix: 
```cmd
0 1 0 0 0 
1 0 1 1 1
0 1 0 1 0
0 1 1 0 0
1 0 0 0 0
```

Adjacency Matrix is more preferred for DFS whereas Adjacency List is preferred for BFS level order traversal.
### DFS on a Graph

Given a graph of `n` nodes and a list of edges where `edge[u][v]` represents an edge. Print DFS 
```java
    static void dfs(int n, int[][] edges){
                // adjacency list representation
        ArrayList<ArrayList<Integer>> graph = new ArrayList<>();

        // build adjacency list
        for(int i=0; i<n; i++){
            graph.add(new ArrayList<>());
        }
        for(int[] edge:edges){
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
        }
        boolean[] visited = new boolean[n];
        dfsRec(graph, 0, visited);
    }

    static void dfsRec(ArrayList<ArrayList<Integer>> graph, int curNode, boolean[] visited){
        if(visited[curNode]) return;

        System.out.print(curNode + " ");
        visited[curNode] = true;
        for(int u: graph.get(curNode)){
            if(!visited[u]) {
                dfsRec(graph, u, visited);
            }
        }
    }
```

Output:
```
res = {0,1,2,3,4}
```

### BFS on Graph

```java
static void bfs(int n, int[][] edges){
	// adjacency list representation
	ArrayList<ArrayList<Integer>> graph = new ArrayList<>();

	// build adjacency list
	for(int i=0; i<n; i++){
		graph.add(new ArrayList<>());
	}

	for(int[] edge:edges){
		int u = edge[0];
		int v = edge[1];

		graph.get(u).add(v);
	}

	boolean[] visited = new boolean[n];

	int src = 0;
	Queue<Integer> q = new LinkedList<>();
	visited[src] = true;
	q.add(src);

	while(!q.isEmpty()){
		int cur = q.poll();
		System.out.print(cur + " ");

		// visit neighbours
		for(int x: graph.get(cur)){
			if(!visited[x]){
				// mark them as visited and add to the queue
				visited[x] = true;
				q.add(x);
			}
		}
	}
}
```


