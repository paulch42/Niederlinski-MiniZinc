% Section 3.7.4

int: num_papers;

type position = tuple(int,int);
array[int] of position: places;
set of int: place = 1..length(places);

array[place] of var 1..num_papers: papers;

predicate neighbour(position: pos1, position: pos2) =
              pos1.1 in pos2.1-1..pos2.1+1 /\ pos1.2 in pos2.2-1..pos2.2+1;

constraint forall(i in place, j in 1..i-1)(neighbour(places[i],places[j]) -> papers[i] != papers[j]);
