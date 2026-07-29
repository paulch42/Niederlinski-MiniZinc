% Section 5.10.3

include "globals.mzn";

enum person = {anna,ben,charles,derek,eva,fred,gary};

set of int: POSITION = 1..card(person);

array[person] of var POSITION: position;

function var int: between(person: middle, person: p1, person: p2) = beside(middle,p1) + beside(middle,p2);
predicate beside(person: p1, person: p2) = abs(position[p1]-position[p2]) = 1;

constraint alldifferent(position);

var int: obj = between(anna,eva,fred) + between(ben,anna,eva) + between(derek,fred,charles) + between(gary,derek,charles);

solve maximize obj;