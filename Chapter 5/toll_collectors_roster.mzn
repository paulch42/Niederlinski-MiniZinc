% Section 5.9.3

include "globals.mzn";

int: num_hours = 24;
set of int: HOUR = 0..num_hours-1;
set of int: HOUR24 = 0..num_hours;
array[_] of HOUR: start_period = [0,6,10,12,16,18,22];
int: num_periods = length(start_period);
set of int: PERIOD = 1..num_periods;
int: max_staff = 20;
set of int: STAFF = 1..max_staff;
array[PERIOD] of 1..max_staff: demand = [2,8,4,3,6,5,3];
array[HOUR] of 1..max_staff: hourly_demand = array1d(HOUR,[demand[max(i in PERIOD where start_period[i] <= h)(i)] | h in HOUR]);
array[HOUR] of set of HOUR: onshift_starting_at =
                      array1d(HOUR,[{if x >= num_hours then x-num_hours else x endif | x in h..h+3 union h+5..h+8}| h in HOUR]);

array[STAFF] of var HOUR24: hour_of_start;

% number of staff on-shift in a given hour
function var STAFF: onshift(HOUR: h) = sum(s in STAFF where hour_of_start[s] != 24)(h in onshift_starting_at[hour_of_start[s]]);

% staff on-shift must meet demand
constraint forall(h in HOUR)(onshift(h) >= hourly_demand[h]);

% objective is number of staff required
var int: obj = sum(s in STAFF)(hour_of_start[s] != 24);

% symmetry breaking
constraint increasing(hour_of_start);

solve minimize obj;
