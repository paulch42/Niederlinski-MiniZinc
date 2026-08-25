enum line;
enum glue;
int: max_workers;
array[line] of int: salary;
array[line] of int: setup_cost;
array[line,glue] of int: productivity;
array[glue] of int: production_target;

array[line,glue] of var 0..10000: line_production;
array[line] of var 0..max_workers: num_workers;

% must deliver at least production target
constraint forall(g in glue)(sum(l in line)(line_production[l,g]) >= production_target[g]);

% production function of line productivity and number of workers on line
constraint forall(l in line, g in glue)(line_production[l,g] = num_workers[l] * productivity[l,g]);

var int: weekly_cost = sum(l in line)((num_workers[l] > 0) * setup_cost[l] + num_workers[l] * salary[l]);

solve minimize weekly_cost;