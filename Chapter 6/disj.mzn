include "globals.mzn";

enum job;
array[job] of int: duration;
array[job] of int: resource;
array[_,1..2] of job: precede;

set of int: TIME = 0..sum(duration)*2;

array[job] of var TIME: start;
array[job] of var TIME: end = [start[j]+duration[j] | j in job];

constraint disjunctive(start,duration);

var int: obj = max(end);

solve minimize(obj);