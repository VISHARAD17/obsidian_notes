### **Introduction**
- Program is something that resides on the hardware ( ex. code file ) and compiler converts it into  binary program - this file ( a.out for c++ ) also exists on hard disk. This binary program is then loaded into the ram and then run by the processor. So, **process is a program is execution**.
- this is how `program` looks in memory :
![[memory_stack.excalidraw | 150 | center]]
- `Data` - stores static and global variables
- `text/code` - binary code to be executed
- `heap` - Dynamatically allocated memory( grows upwords)
- `stack` - stores functions calls and their local variables( grows downwards)
- when we run the program it becomes a process

### **Process State**
- **Single tasking systems**: After finishing one command only we can run the next command
- **Multiprogramming System - `5 state model`**
![[5_state_model.excalidraw| 1000|center]]
- Multi-tasking is doing processes within give time slots, process waits when its time slot is over, then resumes again when given a time slot
- `New` - just clicked on the file and process control information is created by the OS but not loaded into the RAM 
- `Ready` : Once process is loaded in the memory, it is in ready state. It is ready to picked by the processor.it is assigned by to a processor by a dispatcher.
- `Running` : Once the process is dispatched it is running state means it is assigned to CPU ( processor ) and now it is doing its computations. when a higher priority tasks comes to the CPU then the current process goes to `ready` State or when there is a timeout i.e. the assigned time to the process is over and process is still not finished then again it goes to `Ready` state.
- `Waiting`: this state happens when IO is requested during execution, then it goes back to `ready` state 

- **Mutiprogramming system - `7 state model`:**

![[7_state_model.excalidraw | 1000 | center]]
- `Suspend / Block` - when CPU is ideal when all process are waiting for IO then it suspends few ( sends back to hard disk)
and brings more process in RAM for better efficiency
- `Suspend/ Ready` - when suspened process in hard disk complets I/O then it goes into suspend/ready
state. ( This is also in hard disk). This is hard disk space 
is called swap space. Then it goes to ready state with CPU is free otherwise if a high-priority tasks comes up 
then it gets suspended back to suspend/ready state.

### **Process Control Block**
- A process can be moved from ready to running state and vice versa. It has to moved from running to ready when time allocated to it expires or a high priority task comes into memory. Hence, in order to resume  the previous task from the same state where it was stoped OS must store all the information related to the process. The process should feel like it is continuing from the same spot. All this information is stored in a data structure called Process control block. It is stored in a very secured place in a memory as to be not corrupted by any user process.
- **Contents of Process control block**:
    - process ID : unique identifier assigned to every process by OS 
    - process state : state of the process ex. ready, running, etc.
    - CPU registers : process uses mutiple CPU registers to perform its operation. One of them is 
    program counter which tells next intruction to be executed. Hence, they are also stored in order 
    to run the process form the previous state where it was stopeed.
    - Accounts information : CPU time consumed so far, any systerm specific information 
    - I/O information : what I/Os process was using and what was there states. 
    - CPU scheduling information : priority of the process 
    - memory information : what all memory blocks were allocated to this process.
- these are generic fields stored in a control block, there are many more fields in today's modern complex OS.
- It is the most central data structure of the OS and used by almost all modules( ex. I/O module ) of OS

### Process Schedulars :
- schedulars are used by OS to move process from one state to other state.
- **Long term schedular** : brings processes from disk to ram i.e. in ready state. Long term schedular
controlls the degree of multiprogramming. Ideally a long term schedular should bring a good mix of I/O 
bound and CPU bound processors. a process is I/O bound if it does I/O most of the time and CPU bound 
if it uses CPU most of the time. Need a good mix of both cause if only I/O process are there then 
CPU might sit ideal or if only CPU processes are there then CPU might not have time for other processes
The decisions made by long term schedular happen after a long interval.
- **short term schedular**: Moves process from ready state to running state whichi means it assgins a processor 
to the process. Runs actively by the OS. It actively decides which one to assign CPU next, hence the name 
short term schedular. It also called dispatcher ( does process control switch )
- **medium term schedular**: It moves the process from waiting state to suspend state. Also, moves processes from 
ready state to suspend ready state because of a high priority task

### Backgroud for scheduling algorithms
- most of the studies on scheduling algorithms in OS are for short term schedular
- Different queues are there in OS 
    - `ready` queue : Since there are mutiple processes in ready state, so they must be kept in a queue
    - `job` queue : Queue of jobs that want to go into memory to be a process
    - `I/O`queue: queue of I/O operations
- When talking about scheduling algorithms focus is mainly of ready queue
- incidents on which short term schedular is called :
    - when some other process moves from running to waiting
    - when some other process moves from running to ready
    - when a new/existing process moves to ready state 
    - when a process terminates
- Different times in scheduling algorithm, ex. times for process `P_0`
![Process time diagram](./diagrams/process_time_diagram.png)
    - Arrival time : 1
    - Completion time : 6 
    - Burst time ( total time consumed by CPU ) : 2+1 = 3
    - turn arround time : 6-1 = 5 ( completion time - arrival time)
    - waiting time : 2
    - Response time : ( Arrival time - time at when CPU was alloted) 1-1 = 0
- Expectations / Goals of scheduling algorithms :
    - max CPU utilization
    - max throughput : throughput is no. of jobs finished per unit time
    - Min turnarround time
    - Min waiting time 
    - Min response time 
    - Fair CPU allocation ( no starvation ) : scheduling should not allow starvation

### FCFS scheduling algorithm
- First come first serve. The process that comes first is scheduled first
- non-preemptive : Once CPU is assigne to a process its not take back from it

| Process | arrival time  | Burst time | Completion time | Turn arround time | Waiting time |
| --- | --- | --- | --- | --- | --- |
| `P_0` | 0 | 2 | 2 | 2 | 0 |
| `P_1` | 1 | 6 | 8 | 7 | 1 |
| `P_2` | 2 | 4 | 12 | 10 |6 |
| `P_3` | 3 | 9 | 21 | 18 | 9 |
| `P_4` | 3 | 12 | 33 | 29 | 17 |

Avg. waiting time :  $\frac{( 0 + 1 + 6 + 9 + 17 )}{5} = 33/5 = 6.6$

Avg. turnarround time : $\frac{( 2+7+10+18+29)}{5} = 74/5 = 14.8$

Gantt chart : 
![Gantt chart](./diagrams/giantt.png)
- simple and easy to implement 
- non-preemptive
- convoy effect - If one CPU bound process is running and lot of IO processes are waiting for it to finished.
one fished I/O bound process will quickly finish their I/O and they will try to accquire I/O devices 
this creates a long I/O quees. This effect is called convoy effect. and I/O bound process have to wait longer 
for CPU
- Avg. waiting time: when CPU bound process comes first it increses waiting time

### Shorted jop first algorithm:
- consider the jobs in increasing order of their CPU busrt time. 
- this algorithm is both non-preemptive and non-preemptive
- **non-preemptive** :
 given three 4 processes `P_0`, `P_1`, `P_2` and `P_3` arrives at time 0, 1, 2 and 3 sec respectively.
 Their CPU burst times are 5, 4, 3, and 8 respec. since it a non-preemptive algo. we cannot take back 
 the CPU once assigned. So, for first 5 seconds `P_0` will be assigned the CPU, by the 5th second all remaining 
 three tasks will be in the queue. 
 ```
Giant chart :
|----------------------------------------
| P_0    |  P_2   |  P_1    |    P_3    |
|----------------------------------------
0        5        8         12          20
```
- Preemtive algorithm :
 given three 4 processes `P_0`, `P_1`, `P_2` and `P_3` arrives at time 0, 1, 2 and 3 sec respectively.
 Their CPU burst times are 8, 4, 9, and 5 respec. At the 0th second only `P_0` has their in the queue but 
 while it is being executed, at the 1st sec `P_1` arrive with 4 sec of burst time while for `P_0` 7 sec 
 of burst time is required to perform the remaining execution. Since, the current burst time is 
less more the burst time of incomming one hence incomming one i.e. `P_1` is given priority.
Similary, it is done for scheduling remaining taks
 ```
Giant chart :
|-----------------------------------------------------
| P_0 |    P_1   |  P_3    |    P_0    |      P_2    |
|-----------------------------------------------------
0     1          5         10          17           26 
```
- main points for Preemtive shorted job first algorithm:
    - Minimum average waiting time among all the scheduling algorithm ( gives priority to I/O bound 
    taks which has less CPU busrt time compared to CPU bound taks)
    - May cause high waiting time and response time for CPU bound tasks
    - Impractical ( OS might not know the burst time of taks in adavance)

### Priority Scheduling 
- Priority scheduling can be Preemtive or non-preemptive
- processes are selected based on their priority, if same priority then one with lessor burst time is 
selected.

| Process  | arrival time | priority | burst time |
|---|---|---|---|
|`P_0`|0|5|3|
|`P_1`|1|3|5|
|`P_2`|2|15|8|
|`P_3`|3|12|6|

`P_2` is the highest priority
```
Giantt chart for Preemtive scheduling :
|----------------------------------
|  P_0 |    P_2    |   P_3  | P_1 |
|----------------------------------
0     3            11      13     22
```


```
Giantt chart for non-preemptive scheduling:
|---------------------------------------------
|  P_0 |    P_2    |   P_3     | P_0 |  P_1  |
|---------------------------------------------
0     2            10          16    17      22
```
- problem in priority scheduling is that if a low priority tasks comes in ready state and highi priority 
tasks keep comming then low priority task never gets CPU, this situation is called starvation. to avoid this 
Aging methos is used which is if a taks is waiting for so long its priority increasises.


### Round robin Scheduling algorithm
- it uses time quantam and circular queue ( ready queue ), Preemtive in nature.
- Average waiting time is higher but good response time 
- maintain a time quantam say 2 units, we pick one by one task from the queue in circular manner, give then 2 units of time ( time quantam ), 
if process is going to take less than 2 units then it finishes, otherwise it preemp this process and move to next one. This repeats in circular
manner
- sensitive to time quantam
    - higher : becomes FCFS 
    - smaller : context switch overload

| Process  | arrival time | burst time |
|---|---|---|
|`P_0`|0|3|
|`P_1`|1|1|
|`P_2`|1|5|

```
Giantt chart:

|----------------------------------------
|  P_0 | P_1 |   P_2    | P_0 |  P_2    |
|----------------------------------------
0     2      3         5      6         9
```

### Multilevel queue scheduling
- Divide ready queue into multiple queue and based on nature of processes apply algorithm. For ex. 
some processes need quick response so put them in a queue and apply round robin. Some processes might 
required to apply FCFS algorithm ( they might be dependent on each other), so put them in a diff. queue 
and apply FCFS. 
- queues are sorted based on priority, highest one goes on top.
- there is a problem of starvation if high priority queues keep coming then the one with lowest priority 
queue might not get the CPU resulting in starvation
- flexibility of using different scheduling algorithms
- ex. foreground process (high priority ) and Backgroud process ( low priority ) ( 2 queues )

### Multilevel queue with feedback scheduling 
- most used scheduling algorithm in Operating systems
- avoids starvation using feedback ( drawback of executing process queue based on priority)
- adds a aging factor to the lower priority processes if they are waiting for long time and move them 
up to higher priority queues
- 

