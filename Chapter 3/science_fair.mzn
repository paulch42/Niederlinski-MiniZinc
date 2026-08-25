include "globals.mzn";

enum contestant = {louis,rene,johannes};

set of int: position = 1..card(contestant);

array[position] of var contestant: result;

constraint alldifferent(result);

% in each statement, one part is true and one part is false (hence inequality)

% art: louise won, renee was second 
constraint (result[1] = louis) != (result[2] = rene);

% bert: johannes won, louise came second
constraint (result[1] = johannes) != (result[2] = louis);