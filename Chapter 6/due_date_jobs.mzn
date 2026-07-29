include "globals.mzn";

int: num_jobs = 3;
set of int: JOB = 1..num_jobs;
array[JOB] of int: duration = [5,20,15];
array[JOB] of int: due = [25,20,35];
array[JOB] of int: penalty = [19,12,34];

set of int: TIME = 0..sum(duration);

array[JOB] of var TIME: end;
array[JOB] of var TIME: start = [end[j]-duration[j] | j in JOB];

constraint disjunctive(start,duration);

var int: obj = sum(j in JOB)(if end[j] < due[j] then 0 else (end[j]-due[j])*penalty[j] endif);

solve minimize(obj);