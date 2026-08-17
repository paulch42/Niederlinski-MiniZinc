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

constraint Joe = 2;
constraint Blue = Fred+1;
constraint Bob = Plaid;
constraint Tom != 1;
constraint Tom != 4;
constraint Tom != Orange;
