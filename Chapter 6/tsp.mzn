include "globals.mzn";

int: N;
set of int: NODE = 1..N;
array[NODE,NODE] of float: cost;

array[NODE] of var NODE: path;

constraint alldifferent(path);

% symmetry breaking
constraint path[1] = 1;
constraint path[2] < path[N];

% dominance breaking
constraint forall(i in 2..N-2, j in i+1..N-1)(cost[path[i-1],path[i]] + cost[path[j],path[j+1]] <= cost[path[i-1],path[j]] + cost[path[i],path[j+1]]);

var float: obj = sum(p in 1..N-1)(cost[path[p],path[p+1]]) + cost[path[N],path[1]];

solve :: int_search(path, varsel, valsel) minimize obj;

output "\(obj) 1\n";
output [ "\(p-1) "| p in path ];

ann: varsel = first_fail;
ann: valsel = indomain_min