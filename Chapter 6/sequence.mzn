enum job;
array[job] of int: duration;
array[job] of int: resource;
array[_,1..2] of job: precede;

set of int: TIME = 0..sum(duration)*2;

array[job] of var TIME: start;
array[job] of var TIME: end = [start[j]+duration[j] | j in job];

constraint forall(p in index_set_1of2(precede))(end[precede[p,1]] <= start[precede[p,2]]);

% using cumulative in this manner ensures all jobs are sequential
include "globals.mzn";
constraint cumulative(start,duration,resource,1);

var int: obj = max(end);

solve minimize(obj);