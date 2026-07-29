include "globals.mzn";

int: num_machines = 4;
int: num_tasks = 7;
array[1..num_tasks] of int: duration = [3,3,3,1,1,1,4];
set of int: TIME = 0..sum(duration);

array[1..num_tasks] of var TIME: start;

constraint cumulative(start,duration,[1|i in 1..num_tasks],4);

var int: makespan = max(t in 1..num_tasks)(start[t]+duration[t]);

solve minimize makespan;