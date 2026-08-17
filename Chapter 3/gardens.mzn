include "globals.mzn";

enum variety = {apple,pear,nut,cherry,carrot,parsley,gourd,onion,aster,rose,tulip,lily};
enum person = {paul,sam,luke,hank,zick};

set of int: position = 1..card(person);

set of variety: fruit = {apple,pear,nut,cherry};
set of variety: vegetable = {carrot,parsley,gourd,onion};
set of variety: flower = {aster,rose,tulip,lily};

% check composition of subsets
constraint assert(fruit union vegetable union flower = variety, "");
constraint assert(fruit intersect vegetable = {}, "");
constraint assert(fruit intersect flower = {}, "");
constraint assert(vegetable intersect flower = {}, "");

% mapping between gardener and their position in the sequence of gardens
array[position] of var person: gardener;
array[person] of var position: garden;

% mapping between crop varieties and the positions in the sequence of gardens they occur
array[position] of var set of variety: grows;
array[variety] of var set of position: grown_by;

% channel garden and gardener
constraint inverse(gardener,garden);

% channel grows and grown_by
constraint inverse_set(grows,grown_by);

% 1: the 12 different varieties are grown
constraint array_union([grows[p] | p in position]) = variety;

% 2: every gardener grows exactly four varieties
constraint forall(p in position)(card(grows[p]) = 4);

% 3: every variety is in at least one garden (redundant, guaranteed by constraint all varieties are grown)
constraint forall(v in variety)(grown_by[v] != {});

% 4: only one variety is in four gardens
constraint count(v in variety)(count(p in position)(v in grows[p]) = 4) = 1;

% 5: only one garden grows all three kinds of crop
constraint count(p in position)
                (not disjoint(grows[p],vegetable) /\ not disjoint(grows[p],fruit) /\ not disjoint(grows[p],flower)) = 1;

% 6: only one garden grows all four varieties of a kind of crop
constraint count(p in position)(fruit subset grows[p] \/ vegetable subset grows[p] \/ flower subset grows[p]) = 1;

% 7: paers are only grown in the border gardens
constraint forall(p in position)(pear in grows[p] <-> p in {1,card(person)});

% 8: paul's garden is in the middle and does not grow lily
constraint garden[paul] = 3;
constraint not (lily in grows[garden[paul]]);

% 9: aster grower does not grow vegetables
constraint forall(p in grown_by[aster])(disjoint(grows[p], vegetable));

% 10: rose grower does not grow parsley
constraint forall(p in grown_by[rose])(not (parsley in grows[p]));

% 11: nut grower also grows gourd and parsley
constraint forall(p in grown_by[nut])({gourd,parsley} subset grows[p]);

% 12: apples and cherries are grown in the first garden
constraint {apple,cherry} subset grows[1];

% 13: cherries are grown in two gardens
constraint card(grown_by[cherry]) = 2;

% 14: sam grows onions and cherries
constraint {onion,cherry} subset grows[garden[sam]];

% 15: luke grows two kinds of fruit
constraint card(grows[garden[luke]] intersect fruit) = 2;

% 16: tulips grown in only two gardens
constraint card(grown_by[tulip]) = 2;

% 17: apples grown in only one garden
constraint card(grown_by[apple]) = 1;

% 18: only one garden grows parsley, and it is next to zick
constraint card(grown_by[parsley]) = 1;
var set of position: zick_neighbour = {if garden[zick] = 1 then 2 else garden[zick]-1 endif,
                                       if garden[zick] = 5 then 4 else garden[zick]+1 endif};
constraint count(p in zick_neighbour)(parsley in grows[p]) = 1;

% 19: sam's garden is not on the border (i.e. position 1 or 5)
constraint not (garden[sam] in {1,card(person)});

% 20: hank grows neither vegtables nor aster
constraint disjoint(grows[garden[hank]], vegetable union {aster});

% 21: paul grows three kinds of vegetable
constraint card(grows[garden[paul]] intersect vegetable) = 3;