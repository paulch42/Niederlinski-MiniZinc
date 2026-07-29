% The vales are 10 times that of the original problem to remain in the integer domain.

include "globals.mzn";

enum spot = {summerset,cucumber_creek,old_man_mountain,white_oak_inn,amish_covered_bridge,sugar_maple_farm,fallbrook};

set of int: DIST = 0..100;
set of int: POS = 1..card(spot);
int: num_spots = card(spot);

array[POS] of var spot: spots;
array[spot] of var POS: position;
array[POS] of var DIST: distance; % Total distance to each position
array[POS] of var DIST: deltas;   % Distance between successive positions

function var DIST: distance_to(spot: s) = distance[position[s]];

constraint inverse(spots,position);

constraint forall(i in 2..num_spots)(deltas[i] = distance[i] - distance[i-1]);

constraint alldifferent(deltas);

constraint spots[1] = summerset;
constraint distance[1] = 0;
constraint spots[num_spots] = fallbrook;
constraint distance[num_spots] = 100;

constraint max(deltas) = 36;
constraint min([deltas[i] | i in 2..num_spots]) = 4;

constraint deltas[2] = 18;
constraint spot[num_spots-1] != amish_covered_bridge;
constraint distance_to(fallbrook) - distance_to(amish_covered_bridge) = 10;
constraint distance_to(cucumber_creek) = distance_to(white_oak_inn) - distance_to(old_man_mountain);
constraint abs(distance_to(white_oak_inn) - distance_to(cucumber_creek)) > 50;
constraint abs(distance_to(sugar_maple_farm) - distance_to(cucumber_creek)) = 2 * abs(distance_to(old_man_mountain) - distance_to(cucumber_creek))