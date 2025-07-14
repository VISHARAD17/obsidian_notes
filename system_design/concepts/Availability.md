> Availability refers to the proportion of time a system is operation and accessible when required.
> Each request gets a response then system is available

```bash
Availability = [ uptime / total_time(uptime + downtime) ] x 100
```

**Uptime** is when system is functional, **downtime** is when system is unavailable

| Availability | Downtime per year | reference   |
| ------------ | ----------------- | ----------- |
| 99%          | 3.65              | two nines   |
| 99.9%        | 8.76 hours        | three nines |
| 99.999%      | 5..26 mins        | five nines  |
### Strategies to improve availability
#### 1. Redundancy
having a backup, that can take the place of primary when it component fails
- **having multiple servers** to handle requests
- **Replica DBs** to take over incase primary DB fails
- **Distributing resources** across multiple global locations to prevent regional failures
#### 2. Load Balancing
distributing incoming traffic to multiple servers so that no server is overloaded and there is not single point of failure, enhancing performance and availability
- **LB** which distributes based on predefined rules or software solutions like **AWS elastic LB**
#### 3. Failover mechanisms
Failure mechanisms automatically switches to redundant (backup) system when a failure is detected.
- **Active-passive**: when a primary component fails, its place is taken by the secondary(backup) component.
- **Active-active**: All components are active and they share the load, if one of them fails, rest of the components can handle the load, till the failed ones is repaired. 
#### 4. Data Replication
Data is replicated to multiple locations/DBs to ensure data is not lost incase any failure in DB or location cluster.
- **synchronous Replication**: Data is replicated in real time
- **Asynchronous Replication**: Data is replicated with delay or at a perticular time ( when traffic  is the lowest )
