% Use COIN-BC solver

include "globals.mzn";
int: max_num_beneficiaries;
set of int: BENEFICIARY = 1..max_num_beneficiaries;
int: num_types;
set of int: TYPE = 1..num_types;
array[TYPE] of int: happiness;
array[TYPE] of int: cost;

array[TYPE] of var set of BENEFICIARY: beneficiaries;

constraint card(beneficiaries[4]) <= 15;
constraint card(beneficiaries[5]) <= 30;
constraint card(beneficiaries[6]) <= 6;
constraint disjoint(beneficiaries[2], beneficiaries[3]);
constraint sum(t in TYPE)(card(beneficiaries[t]) * cost[t]) < 10000000;

var int: obj = sum(t in TYPE)(card(beneficiaries[t]) * happiness[t]);

solve maximize obj; 