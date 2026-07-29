% Section 5.10.1

array[_] of int: duration;
set of int: ACTIVITY = index_set(duration);
set of int: LENGTH = 0..sum(duration);
array[_,1..2] of ACTIVITY: precede;
set of int: PRECEDE = index_set_1of2(precede);
array[ACTIVITY] of var LENGTH: start;
array[ACTIVITY] of var LENGTH: end = [start[a]+duration[a] | a in ACTIVITY];

constraint forall(i in PRECEDE)(start[precede[i,1]]+duration[precede[i,1]] <= start[precede[i,2]]);

predicate followed(ACTIVITY: a) = exists(p in PRECEDE where precede[p,1] = a)(end[precede[p,1]] = start[precede[p,2]]);

var int: obj;
array[ACTIVITY] of var bool: critical;

constraint obj = max(end);
constraint critical = [followed(a) \/ end[a] = obj| a in ACTIVITY]; % only guaranteed to be a superset of the critical path

solve minimize obj;
