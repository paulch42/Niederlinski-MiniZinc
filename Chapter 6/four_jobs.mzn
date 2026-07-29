include "globals.mzn";

int: num_jobs = 4;
set of int: JOB = 1..num_jobs;
array[JOB] of int: duration = [6,4,5,8];
array[JOB] of int: due = [8,4,12,16];

set of int: TIME = 0..sum(duration);

array[JOB] of var TIME: end;
array[JOB] of var TIME: start = [end[j]-duration[j] | j in JOB];

constraint disjunctive(start,duration);

var int: obj = sum(j in JOB)(if end[j] < due[j] then 0 else end[j]-due[j] endif);

solve minimize(obj);