include "globals.mzn";

int: size = 3;
set of int: SIZE = 1..size;
set of int: NUMBER = 1..size*size;

array[SIZE,SIZE] of var NUMBER: square;
var int: value;

constraint alldifferent([square[i,j] | i,j in SIZE]);

% sum first row to compare with other sequences
constraint value = sum(i in SIZE)(square[1,i]);

% row sums
constraint forall(r in SIZE)(sum(c in SIZE)(square[r,c]) = value);

% column sums
constraint forall(c in SIZE)(sum(r in SIZE)(square[r,c]) = value);

% diagonal sums
constraint sum([square[i,i] | i in SIZE]) = value;
constraint sum([square[i,size-i+1] | i in SIZE]) = value;