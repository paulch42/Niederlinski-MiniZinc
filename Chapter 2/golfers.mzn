% Section 2.4.1

include "globals.mzn";

int: num_golfers = 4;
set of int: index = 1..num_golfers;

var index: Fred;
var index: Joe;
var index: Tom;
var index: Bob;
var index: Red;
var index: Orange;
var index: Blue;
var index: Plaid;

constraint Joe = 2;
constraint Blue = Fred+1;
constraint Bob = Plaid;
constraint Tom != 1;
constraint Tom != 4;
constraint Tom != Orange;
constraint alldifferent([Fred,Joe,Tom,Bob]);
constraint alldifferent([Red,Orange,Blue,Plaid]);
