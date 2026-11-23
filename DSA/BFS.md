**BFS** --> Breadth first search

- BFS is a level by level traversal. It Explores all the nodes of the current level before moving to the next level. 
- It uses queue to keep track of nodes at each level

![[BFS_1excalidraw|400|center]]

**Steps**:
- start with root node and add it to the queue
- while queue is not empty print the latest node and add its neighbours
- keep iterating until queue is empty

**Code**:
```java
void bfs(TreeNode node){
	if(node == null){
		return;
	}

	Queue<TreeNode> q = new ArrayDeque<>();
	q.add(node); // insert root node

	while(!q.isEmpty()){
		TreeNode frontEle = q.poll(); 
		System.out.println(frontEle.val); // print

		if(frontEle.leftNode != null){
			q.add(frontEle.leftNode);
		}

		if(frontEle.rightNode != null){
			q.add(frontEle.rightNode);
		}
	}
}
```


##### Level order traversal Level by Level

```java
public List<List<Integer>> levelOrder(TreeNode root) {
    if (root == null) {
        return new ArrayList<>();
    }

    List<List<Integer>> result = new ArrayList<>();
    Queue<TreeNode> queue = new LinkedList<>();
    queue.offer(root);

    while (!queue.isEmpty()) {
        // number of nodes at the current level
        int levelSize = queue.size();
        List<Integer> currentLevel = new ArrayList<>();
        
        for (int i = 0; i < levelSize; i++) {
            TreeNode curr = queue.poll();
            currentLevel.add(curr.val);
            
            if (curr.left != null) {
                queue.offer(curr.left);
            }
            if (curr.right != null) {
                queue.offer(curr.right);
            }
        }
        
        // IMPORTANT
        // we have finished processing all nodes at the current level
        result.add(currentLevel);
    }
    
    return result;
}
```
