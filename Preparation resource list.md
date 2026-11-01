
Here is your consolidated **Watch & Prepare Roadmap** structured specifically for cracking SDE-2/SDE-3 System Design and High-Throughput Backend interviews (targeting ₹35L+ base in Pune).

  

## 🛠️ Module 1: Rate Limiting & Sliding Windows

### **Core Focus Areas**

- Token Bucket vs. Leaky Bucket vs. Sliding Window Log vs. Sliding Window Counter.
    
      
    
- Concurrency issues in Redis: Handling race conditions using **Atomic Increments (`INCR`) and Lua Scripts**.
    
      
    
- Multi-datacenter rate limiting & synchronization overhead.
    
      
    

### **Watch List**

1. **ByteByteGo (Alex Xu)** — _"Design a Rate Limiter"_
    
      
    - _Key Takeaway:_ Visualizing all 5 rate-limiting algorithms, memory footprint, and HTTP 429 header handling.
        
          
        
2. **Arpit Bhayani** — _"Designing an API Rate Limiter"_
    
      
    - _Key Takeaway:_ Low-level memory calculations, implementing sliding windows with Redis Sorted Sets (ZSET), and race condition prevention.
        
          
        
3. **Gaurav Sen** — _"System Design: Rate Limiting"_
    
      
    - _Key Takeaway:_ Trade-offs between client-side vs. gateway vs. service-level rate limiting.
        
          
        

## 🔒 Module 2: Distributed Locks & Concurrency

### **Core Focus Areas**

- Simple Redis Locking (`SETNX` with TTL) vs. Redlock Algorithm vs. Zookeeper/Etcd Leases.
    
      
    
- Why Redis locks fail: **Clock drift, Stop-the-World (STW) Garbage Collection pauses, and network partitions**.
    
      
    
- Optimistic Locking vs. Pessimistic Locking in relational databases vs. Distributed Lock Managers (DLM).
    
      
    

### **Watch List**

1. **Hussein Nasser** — _"Distributed Locking with Redis (Redlock)"_
    
      
    - _Key Takeaway:_ How Redlock works across multiple independent Redis nodes and where it fails.
        
          
        
2. **Jordan Has No Life** — _"Distributed Systems / Redlock vs. Zookeeper"_
    
      
    - _Key Takeaway:_ Deep dive into fencing tokens and Martin Kleppmann's critique of Redlock.
        
          
        
3. **Arpit Bhayani** — _"Distributed Locks using Redis"_
    
      
    - _Key Takeaway:_ How to write idempotent, fault-tolerant distributed locking logic with auto-renewal timers.
        
          
        

## 📬 Module 3: Event Streams, Kafka & Message Queues

### **Core Focus Areas**

- **Kafka vs. RabbitMQ vs. SQS:** When to use message queues (task processing) vs. event streams (log-centric).
    
      
    
- **Kafka Architecture:** Topic partitions, Consumer Groups, Offsets, Rebalancing, and In-Sync Replicas (ISR).
    
      
    
- **Guarantees:** At-most-once, At-least-once, and **Exactly-Once Semantics (EOS)** using transactional producers and idempotent consumers.
    
      
    

### **Watch List**

1. **Confluent Developer Channel** — _"Apache Kafka Architecture & Internals"_ (by Jun Rao)
    
      
    - _Key Takeaway:_ Straight from the co-founders of Kafka on storage layout, zero-copy reads, and partition assignment.
        
          
        
2. **Stephane Maarek** — _"Kafka Consumer Groups & Partition Rebalancing"_
    
      
    - _Key Takeaway:_ Understanding how Kafka handles scaling out consumers and managing rebalance storms.
        
          
        
3. **Hussein Nasser** — _"Kafka vs RabbitMQ vs AWS SQS"_
    
      
    - _Key Takeaway:_ Architectural trade-offs, ordering guarantees, and Dead Letter Queue (DLQ) implementations.
        
          
        

## ⚙️ Module 4: Uber Cadence & Stateful Orchestration

### **Core Focus Areas**

- **Event Sourcing:** How Cadence/Temporal reconstructs state by replaying workflow history.
    
      
    
- **Architecture:** Workflows vs. Activities, Task Queues, History Service, and Matching Service.
    
      
    
- **Failure Handling:** Handling long-running transactions, deterministic workflow code, and automatic activity retries.
    
      
    

### **Watch List**

1. **Uber Engineering Channel** — _"Uber Cadence: Fault Tolerant Actor Framework"_ (by Maxim Fateev)
    
      
    - _Key Takeaway:_ The original architecture explanation of Cadence by its core creator.
        
          
        
2. **Temporal / Data Guy** — _"What is Temporal? Durable Execution Explained"_
    
      
    - _Key Takeaway:_ A high-level, clear breakdown of durable execution vs. state machines vs. traditional cron jobs/orchestrators.
        
          
        

## 🏗️ Module 5: End-to-End System Design (HLD & LLD)

### **Core Focus Areas**

- Structuring your 45-minute HLD interview: Requirements -> API Spec -> Data Schema -> Scale Calculation -> High-Level Architecture -> Bottlenecks & Failure Modes.
    
      
    
- Machine Coding (LLD): Writing clean, extensible Object-Oriented Code using Design Patterns (Strategy, Factory, State Machine, Observer).
    
      
    

### **Watch List**

1. **System Design Interview (by Alex Xu / ByteByteGo)** — Master playlist covering Notification Systems, Payment Gateways, and Distributed Caching.
    
      
    
2. **Sandeep Maity (Concept & Coding)** — Java LLD and Machine Coding playlist covering Design Patterns and state machine problems.
    

## 🗓️ Suggested 7-Day Execution Plan

```
Day 1 - 2 : Rate Limiting (ByteByteGo + Arpit Bhayani)
Day 3 - 4 : Distributed Locks & Concurrency (Hussein Nasser + Jordan Has No Life)
Day 5 - 6 : Kafka Internals & EOS (Confluent + Hussein Nasser)
Day 7     : Cadence Architecture Review & System Design Mock Framing
```