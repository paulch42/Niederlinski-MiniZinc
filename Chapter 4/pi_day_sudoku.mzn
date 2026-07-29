int: size = 12;
set of int: INDEX = 1..size;
set of int: DIGIT = 1..9;

% the number of occurrences of each digit in the pi expansion
array[DIGIT] of int: pi_digits = [2,1,2,1,3,1,0,1,1];

type cell = tuple(INDEX,INDEX);
type region = array[INDEX] of cell;
type fixed_val = tuple(cell,DIGIT);

list of region: regions;
list of fixed_val: pre_populate;
 
array[INDEX,INDEX] of var DIGIT: square;

% check a region meets the pi digit constraint
function var bool: check_region(array[INDEX] of var DIGIT: r) = forall(d in DIGIT)(count_eq(r,d,pi_digits[d]));

% pre-populated values
constraint forall(p in pre_populate)(square[p.1.1,p.1.2] = p.2);

% row constraint
constraint forall(r in INDEX)(check_region([square[r,c] | c in INDEX]));

% column constraint
constraint forall(c in INDEX)(check_region([square[r,c] | r in INDEX]));

% region constraint
constraint forall(r in regions)(check_region([square[r[i].1,r[i].2] | i in INDEX]));