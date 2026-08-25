% Section 2.6.4

% initial water volume (must not exceed capacity of jug A)
int: water_volume = 8;

% three water jugs and their capacities
int: sizeA = 8;
set of int: A = 0..sizeA;
int: sizeB = 5;
set of int: B = 0..sizeB;
int: sizeC = 3;
set of int: C = 0..sizeC;

% a state records the volume of water contained in each jug
type State = tuple(A,B,C);

% maximum allowed number of steps in the solution
int: max_steps = 10;
set of int: STEP = 1..max_steps;

% the sequence of states defining the transfer of water between jugs
array[STEP] of var State: steps;

% actual number of steps taken
var STEP: num_steps;

% the initial and final states
constraint steps[1] = (water_volume,0,0);
constraint steps[num_steps] = (4,4,0);

% details for the jug that receives water in a state transition
var tuple(int,int,int): receiver(var State: from, var State: to) =
                        if from.1 < to.1 then (sizeA,from.1,to.1)
                        elseif from.2 < to.2 then (sizeB,from.2,to.2)
                        else /* from.3 < to.3 */ (sizeC,from.3,to.3)
                        endif;

% details for the jug that loses water in a state transition
var tuple(int,int,int): source(var State: from, var State: to) =
                        if from.1 > to.1 then (sizeA,from.1,to.1)
                        elseif from.2 > to.2 then (sizeB,from.2,to.2)
                        else /* from.3 > to.3 */ (sizeC,from.3,to.3)
                        endif;

% in each step:
% - no water lost
% - either the receiver is full, or the source is empty
predicate transfer(var State: from, var State: to) =
    (from.1 = to.1 xor from.2 = to.2 xor from.3 = to.3) /\
    let {var tuple(int,int,int): down = source(from,to);
         var tuple(int,int,int): up = receiver(from,to)}
    in up.3 = up.1 \/ down.3 = 0;

% maintain the original volume of water
constraint forall(i in 1..num_steps)(steps[i].1 + steps[i].2 + steps[i].3 = water_volume);

% water transferred in each step must respect water held and amount of space in each jug
constraint forall(i in 1..num_steps-1)(transfer(steps[i],steps[i+1]));

% no further water transfer after goal achieved
constraint forall(i in num_steps+1..max_steps)(steps[i] = steps[num_steps]);

solve minimize num_steps;