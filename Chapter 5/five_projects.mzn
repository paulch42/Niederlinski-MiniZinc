int: num_projects;
int: num_years;
set of int: PROJECT = 1..num_projects;
set of int: YEAR = 1..num_years;
array[PROJECT,YEAR] of int: expenditure;
array[PROJECT] of int: returns;
array[YEAR] of int: funds;

var set of PROJECT: selection;

% don't exceed maximum funds
constraint forall(y in YEAR)(sum(p in selection)(expenditure[p,y]) <= funds[y]);

% if project 1 or 3 selected, then 5 must also be selected
constraint selection intersect {1,3} != {} -> 5 in selection;

% projects 2 and 3 can't both be selected
constraint card(selection intersect {2,3}) < 2;

solve maximize sum(p in selection)(returns[p]);