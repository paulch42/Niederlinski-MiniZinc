% Section 2.6.2
% A more direct model than mine_field that avoids ther need to input cell information
% (assumption is path can always move between adjacent cells).

% the cost of passing through a square
array[int,int] of int: cost;

% index sets for the maze grid
set of int: X = 0..card(index_set_2of2(cost))-1;
set of int: Y = 0..card(index_set_1of2(cost))-1;

% width and height of the maze grid
int: width = card(X);
int: height = card(Y);

% cell given by x/y co-ordinates
type Cell = tuple(X,Y);

% start and end point
Cell: start;
Cell: end;

% upper limit on allowed number of steps in the solution
int: max_steps;
set of int: STEP = 1..max_steps;

% the actual number of steps in the solution
var STEP: num_steps;

% the sequence of cells in the solution
array[1..max_steps] of var Cell: path;

% cost of transiting a cell (convert from 0-based to 1-based co-ordinates)
function var int: cost_of(var Cell: sq) = cost[sq.1+1,sq.2+1];

% are two cells adjacent?
predicate adjacent(var Cell: from, var Cell: to) = abs(from.1-to.1)+abs(from.2-to.2) = 1;

% fix start and end points
constraint path[1] = start;
constraint path[num_steps] = end;

% consecutive cells in the path must be adjacent
constraint forall(i in 1..num_steps-1)(adjacent(path[i],path[i+1]));

% after reaching end, default remaining squares to (0,0)
constraint forall(i in num_steps+1..max_steps)(path[i] = (0,0));

var int: path_cost;
constraint path_cost = sum(i in 1..num_steps)(cost_of(path[i]));
solve minimize path_cost;