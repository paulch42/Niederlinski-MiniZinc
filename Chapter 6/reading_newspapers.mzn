% Section 6.11-13

include "globals.mzn";

enum student = {andy,ben,carl,dusty};
enum newspaper = {md,da,mb,gn};
set of int: TASK = 1..card(newspaper);
set of int: TIME = 0..600;

array[student,TASK] of newspaper: newspaper_at = [| md,da,mb,gn | da,mb,md,gn | mb,da,md,gn | gn,md,da,mb |]; 

array[student,TASK] of TIME: duration = [| 60,30,2,5 | 75,3,25,10 | 5,15,10,30 | 90,5,5,5 |];
array[student] of TIME: min_start = [30,45,45,90];

array[student,TASK] of var TIME: start;
array[student,TASK] of var TIME: end = array2d(student,TASK,[start[s,t]+duration[s,t] | s in student, t in TASK]);

% student does not perform two tasks simultaneously
constraint forall(s in student)(disjunctive([start[s,t] | t in TASK],[duration[s,t] | t in TASK]));

% student performs tasks in required order
constraint forall(s in student)(strictly_increasing([start[s,t] | t in TASK]));

% no newspaper read simultaneously by two students
constraint forall(n in newspaper)(disjunctive([start[s,t] | s in student, t in TASK where newspaper_at[s,t] = n],
                                              [duration[s,t] | s in student, t in TASK where newspaper_at[s,t] = n]));

% minimum start times for each student
constraint forall(s in student)(start[s,1] >= min_start[s]);

var int: obj = max([end[s,t] | s in student, t in TASK]);

solve minimize obj;