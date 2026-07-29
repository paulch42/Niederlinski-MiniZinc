% Section 6.15

% Doesn't address constraint "each docker to be employed no more than 8 hours"
% There are 12 dockers, so total available time is 96 hours, but the total time required for all tasks is 393 - "sum(hours)"

include "globals.mzn";

int: num_tasks = 34;
set of int: TASK = 1..num_tasks;
array[TASK] of int: hours = [12,16,12,24,25,10,12,12,12,16,12,10,4,15,6,9,12,14,4,4,4,8,28,40,16,3,3,12,8,9,6,3,6,6];
set of int: TIME = 0..sum(hours);
array[_,1..2] of TASK: precede = [| 1,2 | 1,4 |2,3 | 3,5 | 3,7 | 4,5 | 5,6 |6,8 | 7,8 | 8,9 | 9,10 | 9,14 | 10,11 | 10,12
                                  | 11,13 | 12,13 | 13,15 | 13,16 | 14,15 | 15,18 | 16,17 | 17,18 | 18,19 | 18,20 | 18,21
                                  | 19,23 | 20,23 | 21,22 | 22,23 | 23,24 | 24,25 | 25,26 | 25,30 | 25,31 | 25,32 | 26,27
                                  | 27,28 | 28,29 | 30,28 | 31,28 | 32,28 | 33,34 |];

int: num_dockers = 12;
set of int: DOCKER = 1..num_dockers;

array[TASK] of var TIME: start;
array[TASK] of var TIME: length;
array[TASK] of var DOCKER: width;
array[TASK] of var TIME: end = [start[t] + length[t] | t in TASK];

constraint forall(p in index_set_1of2(precede))(end[precede[p,1]] <= start[precede[p,2]]);

constraint forall(t in TASK)(hours[t] = length[t] * width[t]);

constraint cumulative(start,length,width,12);

var int: obj = max(end);

solve minimize obj;