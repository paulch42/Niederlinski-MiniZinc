int: num_days = 7;
set of int: DAY = 1..num_days;

array[DAY] of int: need_on_day = [20,16,13,16,19,14,12];

int: max_employees = 50;
array[DAY] of var 0..max_employees: start_on_day;
array[DAY] of set of int: x = [ last5(d) | d in DAY];

function set of int: last5(DAY:d) = { if x < 1 then x+num_days else x endif | x in d-4..d };

constraint forall(d in DAY)(sum(y in last5(d))(start_on_day[y]) >= need_on_day[d]);

var int: obj = sum(start_on_day);

solve minimize obj;
