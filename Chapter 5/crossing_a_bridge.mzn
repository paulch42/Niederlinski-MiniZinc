int: num_travellers = 4;
set of int: TRAVELLER = 1..num_travellers;

array[TRAVELLER] of int: time = [1,2,5,10]; % time taken by each traveller to cross

enum side = {left,right};

int: max_steps = 2*num_travellers; 
set of int: STEP = 1..max_steps;

var STEP: num_steps;

array[STEP] of var side: lamp;                % location of lamp each step
array[STEP,TRAVELLER] of var side: traveller; % location of travellers each step
array[STEP] of var int: cost;                 % time taken for each step

% verify traveler movements from step 'i' to 'i+1' are valid
% clumsy, could be improved
function var bool: move(STEP: i) = let {var int: lmove = enum2int(lamp[i])-enum2int(lamp[i+1]);
                                        array[TRAVELLER] of var int: arr = [enum2int(traveller[i,t])-enum2int(traveller[i+1,t]) | t in TRAVELLER];
                                        var int: x = sum(arr);
                                        var set of int: y = { arr[t] | t in TRAVELLER where arr[t] != 0}}
                                   in 1 <= abs(x) /\ abs(x) <= 2 /\ card(y) = 1 /\ (x > 0 <-> lamp[i] = right);

% constraints for lamp: start on left, end on right, must move every step
constraint lamp[1] = left;
constraint forall(i in 1..num_steps-1)(lamp[i] != lamp[i+1]);
constraint forall(i in num_steps..max_steps)(lamp[i] = right);

% constraints for travellers: start on left, end on right, each move in valid
constraint forall(t in TRAVELLER)(traveller[1,t] = left);
constraint forall(i in 1..num_steps-1)(move(i));
constraint forall(i in num_steps..max_steps, t in TRAVELLER)(traveller[i,t] = right);

% calculate cost; i.e. total time for all to cross
constraint cost[1] = 0;
constraint forall(i in 2..num_steps)(cost[i] = max(t in TRAVELLER)(time[t]*(traveller[i-1,t] != traveller[i,t])));
constraint forall(i in num_steps+1..max_steps)(cost[i] = 0);

% minimize total time
solve minimize sum(i in STEP)(cost[i]);