% This is wrong!

enum common = {C1,C2};
enum tropical = {T1,T2,T3};
enum oil = C(common) ++ T(tropical);

int: max_common = 200;
int: max_tropical = 250;
int: ton_price = 150;

array[oil] of int: cost = [110,120,130,110,116];
array[oil] of float: hardiness = [8.8,6.1,2.0,4.2,5.0];

array[oil] of var 0..50000: purchase;
var 3.0..6.0: blend;

% can't exceed available common oil
constraint sum(c in common)(purchase[C(c)]) <= max_common;

% can't exceed available tropical oil
constraint sum(t in tropical)(purchase[T(t)]) <= max_tropical;


constraint blend = sum(purchase);

constraint let {var float: f = sum(o in oil)(hardiness[o]*purchase[o])}
           in 3*blend <= f /\ f <= 6*blend;
           
var float: profit = ton_price * blend - sum(o in oil)(cost[o]*purchase[o]);

solve maximize profit;