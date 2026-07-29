% Section 6.4

include "globals.mzn";

set of int: TASK = 1..7;
array[TASK] of int: duration = [16,6,13,7,5,18,4];
array[TASK] of int: resource = [2,9,3,7,10,1,11];

int: max_resources = 13;

array[TASK] of var 0..sum(duration): start;
array[TASK] of var 0..sum(duration): end;

constraint forall(t in TASK)(end[t] = start[t] + duration[t]);

%constraint forall(i in 0..obj)(sum(t in TASK where start[t] <= i /\ i < end[t])(resource[t]) <= max_resources);
constraint cumulative(start,duration,resource,max_resources);

var 0..sum(duration): obj = max(end);

solve minimize obj;