include "globals.mzn";

int: roll_width;
int: num_orders;
set of int: ORDER = 1..num_orders;
array[ORDER] of int: order_width;
array[ORDER] of int: order_rolls;
int: max_cut = roll_width div min(order_width);
int: max_rolls = sum(order_rolls) div (roll_width div max(order_width));

solve minimize num_rolls;

array[1..max_rolls,ORDER] of var 0..max_cut: order;

constraint forall(o in ORDER)(sum(i in 1..num_rolls)(order[i,o]) = order_rolls[o]);

constraint forall(i in 1..num_rolls)(sum(j in ORDER)(order_width[j]*order[i,j]) <= roll_width);

constraint forall(i in 1..max_rolls-1)(lex_greatereq([order[i,j] | j in ORDER],[order[i+1,j] | j in ORDER]));

var 1..max_rolls: num_rolls;
constraint num_rolls = sum(i in 1..max_rolls)(sum(j in ORDER)(order[i,j]) > 0);

