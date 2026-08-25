% Section 2.5.1

enum bank = {west,east};

% state is a record representing location of (farmer,wolf,goat,cabbage)
type state = record(bank:farmer,bank:wolf,bank:goat,bank:cabbage);

% upper limit of number of steps to complete
int: max_steps = 10;

% sequence of states in solution
array[1..max_steps] of var state: plan;

% actual number of steps taken
var 1..max_steps: num_steps;
 
% all on west bank at start
constraint plan[1] = (farmer:west,wolf:west,goat:west,cabbage:west);

% in each step farmer crosses
constraint forall(i in 1..num_steps-1)(plan[i].farmer != plan[i+1].farmer);

% at most one of wolf, goat and cabbage crosses in each step
constraint forall(i in 1..num_steps-1)
                 ((plan[i].wolf != plan[i+1].wolf) + (plan[i].goat != plan[i+1].goat) + (plan[i].cabbage != plan[i+1].cabbage) <= 1);

% whenever wolf and goat are on same side, then farmer on that side as well
constraint forall(i in 1..num_steps-1)(plan[i].wolf = plan[i].goat -> plan[i].farmer = plan[i].goat);

% whenever goat and cabbage are on same side, then farmer on that side as well
constraint forall(i in 1..num_steps-1)(plan[i].goat = plan[i].cabbage -> plan[i].farmer = plan[i].cabbage);

% once all on east bank, stay there
constraint forall(i in num_steps..max_steps)(plan[i] = (farmer:east,wolf:east,goat:east,cabbage:east));

solve minimize num_steps;