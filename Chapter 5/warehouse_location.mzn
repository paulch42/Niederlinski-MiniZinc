% Section 5.8.1-4

include "globals.mzn";

array[int] of int: building_cost;
array[int,int] of int: delivery_cost;

int: num_warehouses = card(index_set(building_cost));
set of int: WAREHOUSE = 1..num_warehouses;

int: num_customers = card(index_set_1of2(delivery_cost));
set of int: CUSTOMER = 1..num_customers;

array[WAREHOUSE] of var set of CUSTOMER: service;
array[CUSTOMER] of var set of WAREHOUSE: serviced_by;

constraint partition_set(service, CUSTOMER);
constraint forall(c in CUSTOMER, w in serviced_by[c])(c in service[w]);
constraint forall(w in WAREHOUSE, c in service[w])(w in serviced_by[c]);

solve minimize sum(c in CUSTOMER, w in serviced_by[c])(delivery_cost[c,w]) + sum(w in WAREHOUSE where service[w] != {})(building_cost[w]);