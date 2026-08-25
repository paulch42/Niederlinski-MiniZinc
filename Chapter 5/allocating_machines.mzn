int: num_machines;
set of int: MACHINE = 1..num_machines;
array[MACHINE] of int: fixed_cost;
array[MACHINE] of int: unit_cost;
array[MACHINE] of int: capacity;
int: production_goal;

array[MACHINE] of var 0..production_goal: produced;

% achieve production goal
constraint sum(produced) = production_goal;

% don't exceed capacity of any machine
constraint forall(m in MACHINE)(produced[m] <= capacity[m]);

var int: cost = sum(m in MACHINE)(fixed_cost[m] * (produced[m] > 0) + unit_cost[m] * produced[m]);

solve minimize cost;
