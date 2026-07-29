% Section 5.7.3-6

% Use COIN-BC solver

int: yard_capacity;
array[int] of int: produces;
array[int] of int: production_cost;
array[int,int] of int: delivery_cost;

int: num_mines = card(index_set(produces));
set of int: MINE = 1..num_mines;

int: num_yards = card(index_set_2of2(delivery_cost));
set of int: YARD = 1..num_yards;

% how much does each mine deliver to each yard
array[MINE,YARD] of var 0..yard_capacity: delivery; 

% each yard must achieve its capacity
constraint forall(y in YARD)(sum(m in MINE)(delivery[m,y]) = yard_capacity);

% respect production capacity of a mine
constraint forall(m in MINE)(sum(y in YARD)(delivery[m,y]) <= produces[m]);

var 0..300000: total_production_cost = sum(m in MINE, y in YARD)(production_cost[m]*delivery[m,y]);

var 0..300000: total_delivery_cost = sum(m in MINE, y in YARD)(delivery_cost[m,y]*delivery[m,y]);

solve minimize total_production_cost+total_delivery_cost;