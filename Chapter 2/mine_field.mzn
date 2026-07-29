% Section 2.6.2

int: dimension;
set of int: index = 0..dimension;
type square = tuple(index,index);
array[1..dimension+1,1..dimension+1] of int: cost;
type step = tuple(square,square);
array[int] of step: steps;
int: max_steps;
square: start;
square: end;

var 1..max_steps: num_steps;
array[1..max_steps] of var square: path;

function var int: cost_of(var square: sq) = cost[sq.1+1,sq.2+1];

constraint path[1] = start;
constraint path[num_steps] = end;
constraint forall(i in 1..num_steps-1)((path[i],path[i+1]) in steps \/ (path[i+1],path[i]) in steps);
constraint forall(i in num_steps+1..max_steps)(path[i] = (0,0));

var int: path_cost;
constraint path_cost = sum(i in 1..num_steps)(cost_of(path[i]));
solve minimize path_cost;