include "globals.mzn";

enum contestant = {louis,rene,johannes};

set of int: position = 1..card(contestant);

array[position] of var contestant: result;

constraint alldifferent(result);

constraint (result[1] = louis) != (result[2] = rene);

constraint (result[1] = johannes) != (result[2] = louis);