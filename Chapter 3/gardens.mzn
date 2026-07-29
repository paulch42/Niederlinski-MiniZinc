% Two constraints from the problem have been commented out.
% Either results in an unsatisfiable model.
% Can't work out why. Possibly misinterpreting some of the rules in the text.

include "globals.mzn";

enum variety = {apple,pear,nut,cherry,carrot,parsley,gourd,onion,aster,rose,tulip,lily};
enum person = {paul,sam,luke,hank,zick};

set of int: position = 1..card(person);

set of variety: fruit = {apple,pear,nut,cherry};
set of variety: vegetable = {carrot,parsley,gourd,onion};
set of variety: flower = {aster,rose,tulip,lily};

array[position] of var set of variety: grows;
array[variety] of var set of position: grown_by;

array[position] of var person: gardener;
array[person] of var position: garden;

constraint forall(p in position)(forall(v in grows[p])(p in grown_by[v]));
constraint forall(v in variety)(forall(p in grown_by[v])(v in grows[p]));

constraint inverse(gardener,garden);

%1
constraint array_union([grows[p] | p in position]) = variety;
%2
constraint forall(p in position)(card(grows[p]) = 4);
%3 Redundant
constraint forall(v in variety)(grown_by[v] != {});
%4
constraint card(array_intersect([grows[p] | p in position])) = 1;
%5
constraint count(p in position)(not disjoint(grows[p],vegetable) /\ not disjoint(grows[p],fruit) /\ not disjoint(grows[p],flower)) = 1;
%6
%constraint count(p in position)(fruit subset grows[p] \/ vegetable subset grows[p] \/ flower subset grows[p]) = 1;
%7
%constraint forall(p in position)(pear in grows[p] <-> p in {1,card(person)});
%8
constraint garden[paul] = 3;
constraint not (lily in grows[garden[paul]]);
%9
constraint forall(p in grown_by[aster])(disjoint(grows[p], vegetable));
%10
constraint forall(p in grown_by[rose])(not (parsley in grows[p]));
%11
constraint forall(p in grown_by[nut])({gourd,parsley} subset grows[p]);
%12
constraint {apple,cherry} subset grows[1];
%13
constraint card(grown_by[cherry]) = 2;
%14
constraint {onion,cherry} subset grows[garden[sam]];
%15
constraint card(grows[garden[luke]] intersect fruit) = 2;
%16
constraint card(grown_by[tulip]) = 2;
%17
constraint card(grown_by[apple]) = 1;
%18
constraint card(grown_by[parsley]) = 1;
var set of position: zick_neighbour = {if garden[zick] = 1 then 2 else garden[zick]-1 endif, if garden[zick] = 5 then 4 else garden[zick]+1 endif};
constraint sum(p in zick_neighbour)(parsley in grows[p]) = 1;
%19
constraint not (garden[sam] in {1,card(person)});
%20
constraint disjoint(grows[garden[hank]], vegetable union {aster});
%21
constraint card(grows[garden[paul]] intersect vegetable) = 3;