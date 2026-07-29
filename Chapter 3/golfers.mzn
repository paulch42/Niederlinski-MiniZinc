% Section 3.7.2

include "globals.mzn";

int: num_golfers = 4;
set of int: position = 1..4;
enum person = {fred,joe,bob,tom};
enum colour = {orange,blue,red,plaid};

array[position] of var person: golfer;
array[person] of var position: position_of_golfer;
array[position] of var colour: pants;
array[colour] of var position: position_of_pants;

constraint inverse(golfer,position_of_golfer);
constraint inverse(pants,position_of_pants);

constraint golfer[2] = joe;
constraint pants[position_of_golfer[bob]] = plaid;
constraint not (position_of_golfer[tom] in {1,4});
constraint pants[position_of_golfer[tom]] != orange;
constraint pants[position_of_golfer[fred]+1] = blue;