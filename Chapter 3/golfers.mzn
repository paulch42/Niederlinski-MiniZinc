% Section 3.7.2

% a different approach to the same problem can be found in chapter 2

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

% one is wearing red
% guaranteed by the inverse constraints

% golfer to fred's right is wearing blue
constraint pants[position_of_golfer[fred]+1] = blue;

% joe is second in line
constraint golfer[2] = joe;

% tom isn't first or fourth
constraint not (position_of_golfer[tom] in {1,4});

% bob is wearing plaid
constraint pants[position_of_golfer[bob]] = plaid;

% tom isn't wearing orange
constraint pants[position_of_golfer[tom]] != orange;