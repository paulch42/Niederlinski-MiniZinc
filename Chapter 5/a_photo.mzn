% Section 5.10.3

include "globals.mzn";

enum person = {anna,ben,charles,derek,eva,fred,gary};

set of int: POSITION = 1..card(person);

array[person] of var POSITION: position;

% how many of 'p1' and 'p2' are beside 'middle'
function var int: between(person: middle, person: p1, person: p2) = beside(middle,p1) + beside(middle,p2);

% are two prople beside each other
predicate beside(person: p1, person: p2) = abs(position[p1]-position[p2]) = 1;

% each person occupies a different position
constraint alldifferent(position);

% satisfy as many as possible of:
% - anna next to eva and fred
% - ben next to anna and eva
% - derek next to fred and charles
% - gary next to derek and charles
var int: obj = between(anna,eva,fred) + between(ben,anna,eva) + between(derek,fred,charles) + between(gary,derek,charles);

solve maximize obj;