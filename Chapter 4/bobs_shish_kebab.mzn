% Section 4.8.2

include "globals.mzn";

enum person = {bob,patty,javier,marie};
enum vegetable = {mushroom,onion,pepper,tomato};
enum item = V(vegetable) ++ {beef};
int: num_pieces_per_skewer = 6;
set of int: PIECE = 1..num_pieces_per_skewer;
array[person,PIECE] of var item: skewer;
int: beef_pieces_per_skewer = 3;

% fixed number of beef chunks on each skewer
constraint forall(p in person)(sum(q in PIECE)(skewer[p,q] = beef) = beef_pieces_per_skewer);

% a vegetable pieces does not appear more than once on a skewer
constraint forall(p in person)(all_different([skewer[p,q] | q in PIECE], {beef}));

% 1: no kebab has two consecutive beef cubes
constraint forall(p in person)(forall(q in 1..num_pieces_per_skewer-1)(not (skewer[p,q] = beef /\ skewer[p,q+1] = beef)));

% 2: no two people have beef cubes in same positions
constraint all_different([{q | q in PIECE where skewer[p,q] = beef} | p in person]);

% 3: one shish kebab has beef, pepper and mushroom in first three positions, but not javier's
constraint xorall(p in person)([skewer[p,i] | i in 1..3] = [beef,V(pepper),V(mushroom)]);
constraint [skewer[javier,i] | i in 1..3] != [beef,V(pepper),V(mushroom)];

% 4: one skewer has beef cubes in positions 1, 3 and 5, and tomato at position 6
constraint exists(p in person)({q | q in PIECE where skewer[p,q] = beef} = {1,3,5} /\ skewer[p,6] = V(tomato));

% 5: bob has onion and other vegetables at positions 4 and 5
constraint V(onion) in {skewer[bob,q] | q in PIECE};
constraint {skewer[bob,4],skewer[bob,5]} subset {V(mushroom),V(pepper),V(tomato)};

% 6: the four skewers have beef, mushroom, onion and tomato at position 5
constraint {skewer[p,5] | p in person} = {beef,V(mushroom),V(onion),V(tomato)};

% 7: every onion chunk is between two beef cubes
constraint forall(p in person)(skewer[p,1] != V(onion) /\ skewer[p,6] != V(onion));
constraint forall(p in person)(forall(q in 2..num_pieces_per_skewer-1 where skewer[p,q] = V(onion))(skewer[p,q-1] = beef /\ skewer[p,q+1] = beef));

% 8: no pepper is between two beef chunks
constraint forall(p in person)(forall(q in 2..num_pieces_per_skewer-1 where skewer[p,q] = V(pepper))(skewer[p,q-1] != beef \/ skewer[p,q+1] != beef));

% 9: marie's skewer does not have mushroom
constraint not (V(mushroom) in {skewer[marie,q] | q in PIECE});

% 10: at least two kebabs have the same vegetable in the same position
constraint exists(p,p1 in person where p < p1, q in PIECE where skewer[p,q] != beef /\ skewer[p1,q] != beef)(skewer[p,q] = skewer[p1,q]);