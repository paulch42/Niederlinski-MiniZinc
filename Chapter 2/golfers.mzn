% Section 2.4.1

include "globals.mzn";

int: num_golfers = 4;
set of int: index = 1..num_golfers;

% Each golfer represented by their position in the order
var index: Fred;
var index: Joe;
var index: Tom;
var index: Bob;

% Each colour represented by the position in the order of the golfer with that colour
var index: Red;
var index: Orange;
var index: Blue;
var index: Plaid;

% Golfers in different positions
constraint alldifferent([Fred,Joe,Tom,Bob]);

% Colours in different positions; i.e. no two golfers have same colour
constraint alldifferent([Red,Orange,Blue,Plaid]);

% someone is wearing read
% guaranteed by model definition

% golfer to fred's right is wearing blue
constraint Blue = Fred+1;

% joe is second
constraint Joe = 2;

% bob is wearing plaid
constraint Bob = Plaid;

% tom isn't first or fourth, and is not waering orange
constraint Tom != 1;
constraint Tom != 4;
constraint Tom != Orange;
