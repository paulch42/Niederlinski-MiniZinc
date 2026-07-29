% Section 5.9.5

include "globals.mzn";

int: num_hours = 24;
set of int: HOUR = 0..num_hours-1;
set of int: HOUR24 = 0..num_hours;
int: num_periods = 6;
set of int: PERIOD = 1..num_periods;
int: max_staff = 200;
set of int: STAFF = 0..max_staff;
array[PERIOD] of 1..max_staff: demand = [22,55,88,110,44,33];

array[PERIOD] of var STAFF: start_at;

function var STAFF: onshift(PERIOD: p) = start_at[p] + (if p=1 then start_at[num_periods] else start_at[p-1] endif);

constraint forall(p in PERIOD)(onshift(p) >= demand[p]);

var int: obj = sum(start_at);

solve minimize obj;