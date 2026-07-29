% Section 3.7.6

include "globals.mzn";

enum element;
set of element: classA; 
set of element: classB;
set of element: classC;
array[int] of set of element: incompatible;
array[element] of int: price;
int: total_price;

% This constraint is invalid because partition_set returns a var bool, but assert requires a bool. Replace with following four.
%constraint assert(partition_set([classA,classB,classC], element), "Class subsets do not form a partition of elements");
constraint assert(array_union([classA,classB,classC]) = element, "there are elements that do not belong to any class set");
constraint assert(classA intersect classB = {}, "class A and class B are not disjoint");
constraint assert(classA intersect classC = {}, "class A and class C are not disjoint");
constraint assert(classB intersect classC = {}, "class B and class C are not disjoint");

var set of element: solution;
var int: cost;

constraint card(solution) = 3;
constraint classA intersect solution != {};
constraint classB intersect solution != {};
constraint classC intersect solution != {};
constraint forall(i in incompatible)(not (i subset solution));
constraint cost = sum(e in solution)(price[e]);
constraint cost <= total_price;

solve minimize cost;