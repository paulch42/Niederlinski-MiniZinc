% Section 2.5.2

enum bank = {left,right};
int: num_subjects = 3;
set of int: num_on_left = 0..num_subjects;

% sate is a 3-tuple: (location of boat, number of missionaries on left bank,number of cannibals on left bank)
type state = tuple(bank,num_on_left,num_on_left);

% upper limit on number of steps
int: max_steps = 15;

% sequence of states in solution
array[1..max_steps] of var state: plan;

% actual number of steps taken
var 1..max_steps: num_steps;

% initial state: everyone on left bank
constraint plan[1] = (left,num_subjects,num_subjects);

% boat must cross river in every step
constraint forall(i in 1..num_steps-1)(plan[i].1 != plan[i+1].1);

% either one or two people cross in each step
constraint forall(i in 1..num_steps-1)
                 (plan[i].1 = left -> plan[i].2 >= plan[i+1].2 /\ plan[i].3 >= plan[i+1].3 /\ (plan[i].2 + plan[i].3) - (plan[i+1].2 + plan[i+1].3) in 1..2);
constraint forall(i in 1..num_steps-1)
                 (plan[i].1 = right -> plan[i].2 <= plan[i+1].2 /\ plan[i].3 <= plan[i+1].3 /\ (plan[i+1].2 + plan[i+1].3) - (plan[i].2 + plan[i].3) in 1..2);

% number of cannibals on either bank must not exceed the number of missionaries
constraint forall(i in 1..num_steps-1)(plan[i].2 in 1..num_subjects-1 -> plan[i].2 = plan[i].3);

% final state: everyone on right bank
constraint forall(i in num_steps..max_steps)(plan[i] = (right,0,0));

solve minimize num_steps;