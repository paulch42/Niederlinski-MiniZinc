array[_] of int: duration;
set of int: ACTIVITY = index_set(duration);
array[_,1..2] of ACTIVITY: precede;

set of int: PRECEDE = index_set_1of2(precede);
int: max_time = sum(duration);
set of int: TIME = 0..max_time;

array[ACTIVITY] of var TIME: start;
array[ACTIVITY] of var TIME: end;

constraint forall(a in ACTIVITY)(end[a] = start[a] + duration[a]);
constraint forall(p in PRECEDE)(end[precede[p,1]] <= start[precede[p,2]]);

solve minimize max(end);