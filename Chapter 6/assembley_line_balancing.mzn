% Section 6.10

include "globals.mzn";

int: num_workstations;
set of int: WKS = 1..num_workstations;
enum job;
array[job] of int: duration;
array[job] of int: resource;
array[job] of WKS: workstation;

set of int: TIME = 0..sum(duration)*2;

array[job] of var TIME: start;
array[job] of var TIME: end = [start[j]+duration[j] | j in job];

constraint diffn(start,workstation,duration,resource);

% symmetry breaking
constraint forall(w in WKS)(strictly_increasing([start[j] | j in job where workstation[j] = w]));

var int: obj = max(end);

solve minimize obj;