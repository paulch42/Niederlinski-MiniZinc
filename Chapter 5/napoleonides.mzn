include "globals.mzn";

int: max_num_beneficiaries;
set of int: BENEFICIARY = 1..max_num_beneficiaries;
int: num_types;
set of int: TYPE = 1..num_types;
array[TYPE] of int: happiness;   % happiness value of a benefit type
array[TYPE] of int: cost;        % cost per beneficiary of a benefit type

array[TYPE] of var set of BENEFICIARY: beneficiaries;

% no more than 15 beneficiaries of type 4
constraint card(beneficiaries[4]) <= 15;

% no more than 30 beneficiaries of type 5
constraint card(beneficiaries[5]) <= 30;

% no more than 6 beneficiaries of type 6
constraint card(beneficiaries[6]) <= 6;

% can't benefit from type 2 and type 3
constraint disjoint(beneficiaries[2], beneficiaries[3]);

% can't exceed budget
constraint sum(t in TYPE)(card(beneficiaries[t]) * cost[t]) <= 10000000;

var int: obj = sum(t in TYPE)(card(beneficiaries[t]) * happiness[t]);

solve maximize obj; 