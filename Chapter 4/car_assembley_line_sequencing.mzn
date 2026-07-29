include "globals.mzn";

int: num_models;
set of int: MODEL = 1..num_models;

array[MODEL] of int: num_cars;  % number of each model to be produced
int: length = sum(num_cars);    % the length of the assembly line (total number of cars to be produced)
set of int: LINE = 1..length;

enum option;
int: num_options = card(option);
set of int: OPTION = 1..num_options;

array[MODEL,OPTION] of 0..1: option_needed; % which models require which options
array[OPTION,1..2] of int: rate;            % maximum allowed in a window

array[LINE] of var MODEL: line;             % assembley line
array[OPTION,LINE] of var 0..1: line_opt;   % is an option needed at each point on the line

% relate 'line_opt' to 'line' and 'option_needed'
constraint line_opt = array2d(OPTION,LINE,[option_needed[line[l],o] | o in OPTION, l in LINE]);

% swapping the order of the next two constraint increases the time to solve about 5x

% required number of each model
constraint forall(m in MODEL)(sum(i in LINE)(line[i] = m) = num_cars[m]);

% satisfy the capacity constraints on optional extras
constraint forall(o in OPTION)(sliding_among(0, rate[o,1], rate[o,2], [line_opt[o,l] | l in LINE], {1}));

%constraint forall(o in OPTION)(sum(l in LINE)(option_needed[line[l],o]) = demand[o]);
%constraint forall(o in OPTION, i in 1..length div rate[o,2])(sum(j in (i-1)*rate[o,2]+1..i*rate[o,2])(line[j] = 1) <= rate[o,1]);
