% Section 2.2.1

include "globals.mzn";

enum element;
set of element: classA; % elements in class A
set of element: classB; % elements in class B
set of element: classC; % elements in class C
array[int] of set of element: incompatible; % pairs of incompatible elements
array[element] of int: price; % cost of each element
int: max_price; % maximum allowed price

% This constraint is invalid because partition_set returns a var bool, but assert requires a bool. Replace with following four.
%constraint assert(partition_set([classA,classB,classC], element), "Class subsets do not form a partition of elements");
constraint assert(array_union([classA,classB,classC]) = element, "there are elements that do not belong to any class set");
constraint assert(classA intersect classB = {}, "class A and class B are not disjoint");
constraint assert(classA intersect classC = {}, "class A and class C are not disjoint");
constraint assert(classB intersect classC = {}, "class B and class C are not disjoint");

var set of element: solution;
var int: cost;

% One element from each class.
constraint card(solution) = 3;
constraint classA intersect solution != {};
constraint classB intersect solution != {};
constraint classC intersect solution != {};

% avoid incompatible pairs
constraint forall(i in incompatible)(not (i subset solution));

% minimize the total cost of the items
constraint cost = sum(e in solution)(price[e]);
constraint cost <= max_price;

solve minimize cost;