% Section 2.6.2
% This model adapts the model for a_simple_maze.

int: dimension;
set of int: index = 0..dimension;

% square given by x/y co-ordinates
type square = tuple(index,index);

% the cost of passing through a square
array[1..dimension+1,1..dimension+1] of int: cost;

% a step moves from one square to another
type step = tuple(square,square);

% the valid steps in the maze
array[int] of step: steps;

% upper limit on allowed number of steps in the solution
int: max_steps;
set of int: STEP = 1..max_steps;

% start and end point
square: start;
square: end;

% the actual number of steps in the solution
var STEP: num_steps;

% validate input steps
constraint forall(s in steps)(assert(abs(s.1.1-s.2.1)+abs(s.1.2-s.2.2) = 1, "Invalid step \(s)"));

% the sequence of squares in the path
array[STEP] of var square: path;

function var int: cost_of(var square: sq) = cost[sq.1+1,sq.2+1];

% fix start and end points
constraint path[1] = start;
constraint path[num_steps] = end;

% each step in the path must be allowed
constraint forall(i in 1..num_steps-1)((path[i],path[i+1]) in steps \/ (path[i+1],path[i]) in steps);

% after reaching end, default remaining squares to (0,0)
constraint forall(i in num_steps+1..max_steps)(path[i] = (0,0));

var int: path_cost;
constraint path_cost = sum(i in 1..num_steps)(cost_of(path[i]));
solve minimize path_cost;