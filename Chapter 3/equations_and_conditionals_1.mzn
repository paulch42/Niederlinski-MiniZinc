include "globals.mzn";

set of int: Range = 1..100;

var Range: A;
var Range: B;
var Range: C;
var Range: D;
var Range: E;
var Range: F;
var Range: G;
var Range: H;

constraint A + E = G;
constraint C + D = 10;
constraint E + F = 8;
constraint A + C = 6;
constraint F != 6 -> H > F;
constraint E != 1 -> H > B;
constraint G != 8 -> F > B;
constraint B != 5 -> G != 5;
constraint E != 3 -> C != 4;

constraint alldifferent([A,B,C,D,E,F,G,H]);

solve minimize sum([A,B,C,D,E,F,G,H]);