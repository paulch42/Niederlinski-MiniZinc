% Section 6.17-18

% Use Huub solver

include "globals.mzn";

int: num_machines;
set of int: MACHINE = 1..num_machines;

int: num_jobs;
set of int: JOB = 1..num_jobs;

int: num_tasks;
set of int: TASK = 1..num_tasks;

array[JOB] of set of TASK: tasks;        % the set of tasks that constitute a job (task number dictates execution order)
array[JOB] of int: earliest_start;       % earliest time at which a job can start

array[TASK] of MACHINE: performed_on;    % the machine on which each task is performed
array[MACHINE] of set of TASK: performs  % the set of tasks performed by each machine
                                        = [{t | t in TASK where performed_on[t] = m} | m in MACHINE];
array[TASK] of int: duration;            % the time taken to perform each task

set of int: TIME = 0..sum(duration);

constraint assert(TASK = array_union(tasks), "union of job tasks does not equal task set");
constraint assert(forall(j1,j2 in JOB where j1 < j2)(tasks[j1] intersect tasks[j2] = {}), "tasks appear in more than one job");

array[TASK] of var TIME: start;
array[TASK] of var TIME: end = [start[t]+duration[t] | t in TASK];

% earliest time a job can start
constraint forall(j in JOB)(earliest_start[j] <= start[min(tasks[j])]);

% tasks for a job must be performed in order
constraint forall(j in JOB, t,u in tasks[j] where t < u)(end[t] <= start[u]);

% no two tasks can be performed simultaneously on a machine
constraint forall(m in MACHINE)(disjunctive([start[t] | t in performs[m]], [duration[t] | t in performs[m]]));

% redundant - no effect
constraint forall(j in JOB)(disjunctive([start[t] | t in sort(tasks[j])], [duration[t] | t in sort(tasks[j])]));
constraint forall(j in JOB)(increasing([start[t] | t in tasks[j]]));

solve minimize max(end);