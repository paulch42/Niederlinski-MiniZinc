% Section 2.6.1

int: dimension;
set of int: index = 0..dimension;

% square is the x/y co-ordinate
type square = tuple(index,index);

% a step is two squares, moving from first to second
type step = tuple(square,square);

% sequence of steps in solution
array[int] of step: steps;

% upper limit on number of steps
int: max_steps;

% initial and final squares
square: start;
square: end;

% actual number of steps taken
var 1..max_steps: num_steps;

% the path taken
array[1..max_steps] of var square: path;

% constraint start and end points
constraint path[1] = start;
constraint path[num_steps] = end;

% each step must be a valid move
constraint forall(i in 1..num_steps-1)((path[i],path[i+1]) in steps \/ (path[i+1],path[i]) in steps);

% remain at end once reached
constraint forall(i in num_steps+1..max_steps)(path[i] = (0,0)); % making all subsequent steps 'end' instead of (0,0) takes much longer (?)

solve minimize num_steps;