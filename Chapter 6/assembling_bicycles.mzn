% Section 6.14

include "globals.mzn";

enum task = {A,B,C,D,E,F,G,H,I,J};
array[task] of int: duration = [7,7,7,2,2,2,2,8,8,18];
array[task] of 1..1: resource = [1,1,1,1,1,1,1,1,1,1];
array[_,1..2] of task: precede = [| A,J | B,J | C,J | D,J | E,J | A,C | D,C | E,C | D,E | D,F | E,H | F,H | G,H | E,I | F,I | G,I | F,G | A,B |];
set of int: TIME = 0..sum(duration);

array[task] of var TIME: start;
array[task] of var TIME: end = [start[t]+duration[t] | t in task];

constraint forall(p in index_set_1of2(precede))(end[precede[p,1]] <= start[precede[p,2]]);
constraint cumulative(start,duration,resource,4);

var int: max_end = max(end);

solve minimize max_end;