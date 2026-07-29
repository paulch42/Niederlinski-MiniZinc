int: num_projects;
int: num_years;
set of int: PROJECT = 1..num_projects;
set of int: YEAR = 1..num_years;
array[PROJECT,YEAR] of int: expenditure;
array[PROJECT] of int: returns;
array[YEAR] of int: funds;

var set of PROJECT: selection;

constraint forall(y in YEAR)(sum(p in selection)(expenditure[p,y]) <= funds[y]);

constraint selection intersect {1,3} != {} -> 5 in selection;

constraint card(selection intersect {2,3}) < 2;

solve maximize sum(p in selection)(returns[p]);