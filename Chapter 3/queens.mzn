% Section 3.7.5

include "globals.mzn";

int: size = 30;

array[1..size] of var 1..size: column;

constraint alldifferent(column);
constraint forall(i in 1..size, j in 1..i-1)(abs(column[i]-column[j]) != i-j);
