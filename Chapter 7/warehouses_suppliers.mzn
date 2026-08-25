% Section 7.3

int: num_warehouses = 3;
set of int: WAREHOUSE = 1..num_warehouses;
int: num_suppliers = 4;
set of int: SUPPLIER = 1..num_suppliers;

array[WAREHOUSE] of float: capacity = [60,55,51];
array[SUPPLIER] of float: contract = [35.5,37,22.7,32];

% unit cost to deliver to a warehouse from a supplier
array[WAREHOUSE,SUPPLIER] of float: cost = [| 6.5,2,6.3,7.3 | 4,9.7,5.2,3 | 5.8,2.4,1.7,9 |];

% decision variables: how much to deliver to each warehouse from each supplier
array[SUPPLIER,WAREHOUSE] of var 0..max(contract): deliver;

% don't exceed warehouse capacity
constraint forall(w in WAREHOUSE)(sum(s in SUPPLIER)(deliver[s,w]) <= capacity[w]);

% supplier must deliver contracted amount
constraint forall(s in SUPPLIER)(sum(w in WAREHOUSE)(deliver[s,w]) = contract[s]);

% cost to deliver all items
var float: delivery_cost = sum(w in WAREHOUSE, s in SUPPLIER)(cost[w,s]*deliver[s,w]);

solve minimize delivery_cost;