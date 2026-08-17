% Section 2.4.4-7

include "globals.mzn";

int: size = 30;

% one cell per board column
array[1..size] of var 1..size: column;

% no two queen in same row
constraint alldifferent(column);

% no two queens on same diagonal
constraint forall(i in 1..size, j in 1..i-1)(abs(column[i]-column[j]) != i-j);
