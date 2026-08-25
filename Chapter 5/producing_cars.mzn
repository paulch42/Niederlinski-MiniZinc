include "globals.mzn";

int: num_models;
set of int: MODEL = 1..num_models;
set of int: MODEL0 = 0..num_models;
int: num_plants;
set of int: PLANT = 1..num_plants;
array[PLANT] of int: fixed_cost;
array[PLANT,MODEL] of int: production_cost;
int: production_target;

array[PLANT] of var MODEL0: manufactures;

% 1: each plant manufactures one model only
% 2: total production for one model must be located in a single plant
constraint alldifferent(manufactures);

% 3: if plants 3 and 4 are producing, then plant 1 must also produce 
constraint manufactures[3] > 0 /\ manufactures[4] > 0 -> manufactures[1] > 0;

var int: obj = sum(p in PLANT where manufactures[p] != 0)(production_cost[p,manufactures[p]] * production_target + fixed_cost[p]);

solve minimize obj;