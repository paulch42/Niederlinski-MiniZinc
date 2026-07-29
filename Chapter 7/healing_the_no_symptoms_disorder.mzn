enum item = {pill,suppository,syrup,vaccine, patch};

int: raw_available = 1000;
int: max_pills_suppositories = 1000;
int: textile_available = 10;
int: solvent_available = 100;

array[item] of float: raw_needed = [0.01,0.015,0.01,0.02,0.012];
array[item] of float: textile_needed = [0.0,0.0,0.0,0.0,0.01];
array[item] of float: solvent_needed = [0.0,0.0,0.001,0.01,0.0];

array[item] of float: profit = [1.5,1.8,2.0,3.5,2.5];

array[item] of var 0..100000: production;

constraint production[pill] + production[suppository] <= max_pills_suppositories;

constraint sum(i in item)(production[i]*raw_needed[i]) <= raw_available;
constraint sum(i in item)(production[i]*textile_needed[i]) <= textile_available;
constraint sum(i in item)(production[i]*solvent_needed[i]) <= solvent_available;

var float: total_profit = sum(i in item)(production[i] * profit[i]);

solve maximize total_profit;