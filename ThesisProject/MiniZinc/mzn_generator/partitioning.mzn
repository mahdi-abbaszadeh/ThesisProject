
include "globals.mzn"; 

int: NUM_OF_NODES; % number of nodes(tasks)  
int: NUM_OF_PARTS; % number of partitions(processors)
int: MAX_PARTS_DIFF; % maximum difference between two partitions
int: MAX_NET_WEIGHT; % maximum wieght of each net(edge) between two nodes
int: MAX_PROCESS_METRIC; % maximum amount of defined metric for each node
array[1..NUM_OF_NODES, 1..NUM_OF_NODES] of 0..MAX_NET_WEIGHT: nodes_matrix; % nodes weighted adjacency communication matrix
array[1..NUM_OF_NODES] of 1..MAX_PROCESS_METRIC: process_metric; % nodes metrics vector
array[1..NUM_OF_NODES] of set of 1..NUM_OF_NODES: next; % precedence of tasks' vector


array[1..NUM_OF_NODES] of var 1..NUM_OF_NODES: schedules; % schedules for tasks
array[1..NUM_OF_PARTS] of var set of 1..NUM_OF_NODES: partitions; % output partitions variable
var 0..NUM_OF_NODES * NUM_OF_NODES: edges_between; % edges between nodes variable

% there is no empty partition
constraint forall(i in 1..NUM_OF_PARTS) (
              card(partitions[i]) != 0
           );

% partition the nodes
constraint partition_set(partitions, 1..NUM_OF_NODES);

% difference between partitions is MAX_PARTS_DIFF nodes or less
constraint forall(i in 2..NUM_OF_PARTS) (
              abs(card(partitions[i-1]) - card(partitions[i])) <= MAX_PARTS_DIFF 
           );

% each node's metric should be less or equal to MAX_PROCESS_METRIC
constraint forall(i in 1..NUM_OF_PARTS)(
              sum(j in 1..NUM_OF_NODES)(bool2int(j in partitions[i]) * process_metric[j]) <= MAX_PROCESS_METRIC
           );
  
constraint edges_between = sum(i in 1..NUM_OF_NODES) (
                              sum(p1, p2 in 1..NUM_OF_PARTS where p1 < p2) (
                                bool2int(i in partitions[p1]) * sum(j in 1..NUM_OF_NODES) (bool2int(j in partitions[p2]) * nodes_matrix[i, j] )
                              )
                           );
% check the precedence of tasks                           
constraint forall(it1, it2 in 1..NUM_OF_NODES where it1 < it2, k in 1..NUM_OF_NODES) (
                schedules[it1] != bool2int(k in next[schedules[it2]]) * k
           );

% there should schedule a task just once           
constraint alldifferent(schedules);                           
                           

%****************************
solve minimize edges_between;
%****************************
                           
     
output [
  "edges_between:" ++ show(edges_between) ++ "\n"
] ++
[
    show(partitions[i]) ++ "\n"
  | i in 1..NUM_OF_PARTS
]
 ++ ["\n"]
 ++
[
    show(schedules[i]) ++ "\n"
  | i in 1..NUM_OF_NODES
] ++ ["\n"]
;         

