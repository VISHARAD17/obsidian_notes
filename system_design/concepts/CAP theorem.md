> Explains the tradeoffs when designing distributed system. When designing a system it is impossible to guaranty all three behaviours. We have to choose any two of them depending on our requirements.

**CAP** : Consistency, Availability, Partition tolerance
#### **Consistency**
- Every reads receives the most recent write. In a consistent distributed system if I write to a node A, and read from node B, it will reflect the latest write done on node A.
- Crucial for financial systems where most upto date data is crucial.
#### **Availability**
Every request receives a non error response
- Partition tolerance: The system continues to operate despite arbitrary number of messages beings dropped by the network between nodes.
#### **Partition tolerance**
