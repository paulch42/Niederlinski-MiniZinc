% The values are 10 times that of the original problem to remain in the integer domain.

include "globals.mzn";

enum spot = {summerset,cucumber_creek,old_man_mountain,white_oak_inn,amish_covered_bridge,sugar_maple_farm,fallbrook};

set of int: DIST = 0..100;
set of int: POS = 1..card(spot);
int: num_spots = card(spot);

% scenic spots and their position in the trail
array[POS] of var spot: spots;
array[spot] of var POS: position;

array[POS] of var DIST: distance; % Total distance to each position
array[POS] of var DIST: deltas;   % Distance between successive positions

function var DIST: distance_to(spot: s) = distance[position[s]];

constraint inverse(spots,position);

constraint forall(i in 2..num_spots)(deltas[i] = distance[i] - distance[i-1]);

% no two consecutive spots are the same distance apart
constraint alldifferent(deltas);

% start at summerset
constraint spots[1] = summerset;
constraint distance[1] = 0;

% end at fallbrook, which 10 miles from the start (100 since distances multiplied by 10)
constraint spots[num_spots] = fallbrook;
constraint distance[num_spots] = 100;

% maxomum distance between spots is 3.6 miles, and minimum 0.4 miles
constraint max(deltas) = 36;
constraint min([deltas[i] | i in 2..num_spots]) = 4;

% first scenic spot after summerset is at 1.8 miles
constraint deltas[2] = 18;

% amish covered bridge is not last spot and is 1 mile south (i.e. before) of fallbrook
constraint spot[num_spots-1] != amish_covered_bridge;
constraint distance_to(fallbrook) - distance_to(amish_covered_bridge) = 10;

% distance from summerset (start point) to cucumber creek is same as from white oak inn to old man mountain
% white oak inn is north of old man mountain, so subtraction is positive
constraint distance_to(cucumber_creek) = distance_to(white_oak_inn) - distance_to(old_man_mountain);

% white oak inn and cucumber creek are more than 5 miles apart
constraint abs(distance_to(white_oak_inn) - distance_to(cucumber_creek)) > 50;

% cucumber creek is twice as far from sugar maple farm as it is from old man mountain
constraint abs(distance_to(sugar_maple_farm) - distance_to(cucumber_creek))
           = 2 * abs(distance_to(old_man_mountain) - distance_to(cucumber_creek))