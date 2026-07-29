include "globals.mzn";

enum person = {bob,patty,javier,marie};
enum item = {mushroom,onion,pepper,tomato,beef};
int: num_pieces_per_skewer = 6;
set of int: PIECE = 1..num_pieces_per_skewer;
array[person,PIECE] of var item: skewer;
int: beef_pieces_per_skewer = 3;

constraint forall(p in person)(sum(q in PIECE)(skewer[p,q] = beef) = beef_pieces_per_skewer);
constraint forall(p in person)(all_different_except([skewer[p,q] | q in PIECE], {beef}));

% 1
constraint forall(p in person)(forall(q in 1..num_pieces_per_skewer-1)(not (skewer[p,q] = beef /\ skewer[p,q+1] = beef)));

% 2
constraint all_different([{q | q in PIECE where skewer[p,q] = beef} | p in person]);

% 3
constraint xorall(p in person)([skewer[p,i] | i in 1..3] = [beef,pepper,mushroom]);
constraint [skewer[javier,i] | i in 1..3] != [beef,pepper,mushroom];

% 4
constraint exists(p in person)({q | q in PIECE where skewer[p,q] = beef} = {1,3,5} /\ skewer[p,6] = tomato);

% 5
constraint onion in {skewer[bob,q] | q in PIECE};
constraint {skewer[bob,4],skewer[bob,5]} subset {mushroom,pepper,tomato};

% 6
constraint {skewer[p,5] | p in person} = {beef,mushroom,onion,tomato};

% 7
constraint forall(p in person)(skewer[p,1] != onion /\ skewer[p,6] != onion);
constraint forall(p in person)(forall(q in 2..num_pieces_per_skewer-1 where skewer[p,q] = onion)(skewer[p,q-1] = beef /\ skewer[p,q+1] = beef));

% 8
constraint forall(p in person)(forall(q in 2..num_pieces_per_skewer-1 where skewer[p,q] = pepper)(skewer[p,q-1] != beef \/ skewer[p,q+1] != beef));

% 9
constraint not (mushroom in {skewer[marie,q] | q in PIECE});

% 10
constraint exists(p,p1 in person where p < p1, q in PIECE where skewer[p,q] != beef /\ skewer[p1,q] != beef)(skewer[p,q] = skewer[p1,q]);