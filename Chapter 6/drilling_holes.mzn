% Use COIN-BC, other solvers have problem with floats

include "globals.mzn";

array[_] of int: x = [1,3,5,7,8];
array[_] of int: y = [2,1,3,2,3];
set of int: INDEX = index_set(x);
array[INDEX,INDEX] of var float: distance = array2d(INDEX,INDEX,[sqrt(abs(x[i]-x[j])^2 + abs(y[i]-y[j])^2) | i,j in INDEX]);

array[INDEX] of var INDEX: order;

constraint alldifferent(order);

var float: time = sum(i in 1..max(INDEX)-1)(distance[order[i],order[i+1]]);

constraint order[1] < order[max(INDEX)];

solve minimize time;