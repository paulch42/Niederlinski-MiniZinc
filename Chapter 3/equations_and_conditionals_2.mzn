include "globals.mzn";

set of int: Range = 1..100;

var Range: A;
var Range: B;
var Range: C;
var Range: D;
var Range: E;
var Range: F;
var Range: G;

constraint B + G = D;
constraint B + C = A;
constraint C + E + G = F;
constraint D < A -> C = 2;
constraint D >= A -> E = 2;

constraint alldifferent([A,B,C,D,E,F,G]);

solve minimize sum([A,B,C,D,E,F,G]);