int: num_districts;
set of int: DISTRICT = 1..num_districts;
int: num_outlets;
set of int: OUTLET = 1..num_outlets;
array[OUTLET] of int: cost;
array[OUTLET] of set of DISTRICT: serves;
%array[OUTLET,DISTRICT] of int: serves;

var set of OUTLET: selection;
%array[OUTLET] of var bool: selection;

%constraint array_union([serves[o] | o in selection]) = DISTRICT;
constraint array_union([if o in selection then serves[o] else {} endif | o in OUTLET]) = DISTRICT;
%constraint array_union([ if selection[o] then { d | d in DISTRICT where serves[o,d] = 1 } else {} endif | o in OUTLET ]) = DISTRICT;

var int: obj = sum(o in selection)(cost[o]);
%var int: obj = sum(o in OUTLET where selection[o])(cost[o]);

solve minimize obj;