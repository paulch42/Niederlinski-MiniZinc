% Section 2.4.7

int: num_papers;

% position given by row/column
type position = tuple(int,int);

% the spots available for an exam
array[int] of position: places;
set of int: place = 1..length(places);

% what paper can be given at a spot
array[place] of var 1..num_papers: papers;

% determine if two spots are neighbours
predicate neighbour(position: pos1, position: pos2) =
              pos1.1 in pos2.1-1..pos2.1+1 /\ pos1.2 in pos2.2-1..pos2.2+1;

% same exam can't occur in neighbouring spots
constraint forall(i in place, j in 1..i-1)(neighbour(places[i],places[j]) -> papers[i] != papers[j]);
