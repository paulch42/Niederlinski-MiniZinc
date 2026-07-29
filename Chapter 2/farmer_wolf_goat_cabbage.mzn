enum location = {left,right};
int: num_subjects = 1;
set of int: num_on_left = 0..num_subjects;
type state = tuple(location,location,location,location); % (farmer,wolf,goat,cabbage)
int: max_steps = 10;

array[1..max_steps] of var state: plan;

var 1..max_steps: num_steps;
 
 % all on left bank at start
constraint plan[1] = (left,left,left,left);

% in each step farmer crosses
constraint forall(i in 1..num_steps-1)(plan[i].1 != plan[i+1].1);

% at most one of wolf, goat and cabbage crosses in each step
constraint forall(i in 1..num_steps-1)
                 ((plan[i].2 != plan[i+1].2) + (plan[i].3 != plan[i+1].3) + (plan[i].4 != plan[i+1].4) <= 1);

% whenever wolf and goat are on same side, then farmer on that side as well
constraint forall(i in 1..num_steps-1)(plan[i].2 = plan[i].3 -> plan[i].1 = plan[i].3);

% whenever goat and cabbage are on same side, then farmer on that side as well
constraint forall(i in 1..num_steps-1)(plan[i].3 = plan[i].4 -> plan[i].1 = plan[i].4);

% once all on right bank, stay there
constraint forall(i in num_steps..max_steps)(plan[i] = (right,right,right,right));

solve minimize num_steps;