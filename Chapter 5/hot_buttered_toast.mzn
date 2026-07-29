% INCOMPLETE

int: time_load = 3;
int: time_unload = 3;
int: time_flip = 3;
int: time_toast = 30;
int: time_butter = 12;
int: num_bread = 3;
int: max_steps = num_bread * 6;

set of int: BREAD = 1..num_bread;
set of int: BREAD0 = 0..num_bread;
set of int: STEP = 1..max_steps;

enum action = {load,flip,unload,toast,butter,none};

array[action] of int: time_of = [time_load, time_unload, time_flip, time_toast, time_butter, 0];

var 1..max_steps: steps;

array[STEP,BREAD] of var action: actions;
array[STEP,BREAD] of var BREAD0: slice;

constraint steps <= max_steps;

constraint forall(s in STEP, b in BREAD)(actions[s,b] = none <-> slice[s,b] = 0);

var int: time = sum(s in step)();

solve minimize time;