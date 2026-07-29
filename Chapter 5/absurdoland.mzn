% Section 5.8.5

array[int] of int: straight;
array[int] of int: other;

set of int: DISTRICT = index_set(straight);

array[int,DISTRICT] of float: distance;

set of int: SCHOOL = index_set_1of2(distance);

array[DISTRICT] of var SCHOOL: attends;

function var int: num_straight(var SCHOOL: s) = sum(d in DISTRICT where attends[d] = s)(straight[d]);

function var int: num_other(var SCHOOL: s) = sum(d in DISTRICT where attends[d] = s)(other[d]);

% in the following if 'round(distance[s,d]*10)' is replaced with 'distance[s,d]' then it is unsatisfiable! Why should a float in this position make it unsatisfiable?
function var float: total_distance(var SCHOOL: s) = sum(d in DISTRICT where attends[d] = s)(round(distance[s,d]*10) * (straight[d]+other[d]));

constraint forall(s in SCHOOL)(num_straight(s) <= num_other(s) * 10);

constraint forall(s in SCHOOL)(num_straight(s) + num_other(s) >= 130);

solve minimize sum(s in SCHOOL)(total_distance(s)) / (10*sum(d in DISTRICT)(straight[d]+other[d]));
