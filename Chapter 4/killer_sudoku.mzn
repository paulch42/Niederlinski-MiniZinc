include "globals.mzn";

int: unit_size;
set of int: UNIT = 1..unit_size;

int: grid_size = unit_size * unit_size;
set of int: GRID = 1..grid_size;

type cell = tuple(GRID,GRID);

type cage = record(
  list of cell: cells,
  int: value
);

list of cage: cages;

array[GRID,GRID] of var GRID: square;

function var bool: check_cage(cage: c) = sum([square[p.1,p.2] | p in c.cells]) = c.value;

constraint forall(r in GRID)(alldifferent([square[r,c] | c in GRID]));

constraint forall(c in GRID)(alldifferent([square[r,c] | r in GRID]));

constraint forall(r, c in UNIT)(alldifferent([square[i,j] | i in (r-1)*unit_size+1..r*unit_size, j in (c-1)*unit_size+1..c*unit_size]));

constraint forall(c in 1..length(cages))(check_cage(cages[c]));