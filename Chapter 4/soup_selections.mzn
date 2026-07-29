include "globals.mzn";

int: size = 6;
set of int: RANGE = 1..size;

enum person = {gloria,marvin,quincy,jenna,isabel,norville};

enum surname = {earle,dugan,caruso,friedman,burns,anderson};

enum soup = {french_onion,split_pea,ministrone,asparagus,chowder,chicken_noodle};

enum restaurant = {apple,hennigans,michels,pine_cove,village,country};

array[RANGE] of var person: person_at;
array[person] of var RANGE: person_pos;
array[RANGE] of var surname: surname_at;
array[surname] of var RANGE: surname_pos;
array[RANGE] of var soup: soup_at;
array[soup] of var RANGE: soup_pos;
array[RANGE] of var restaurant: restaurant_at;
array[restaurant] of var RANGE: restaurant_pos;

function var bool: opposite(var RANGE: x, var RANGE: y) = (x + (size div 2)) mod size = y;
function var bool: next_to(var RANGE: x, var RANGE: y) = abs(x-y) = 1 \/ abs(x-y) = size-1;

constraint inverse(person_at,person_pos);
constraint inverse(surname_at,surname_pos);
constraint inverse(soup_at,soup_pos);
constraint inverse(restaurant_at,restaurant_pos);

% 1
constraint soup_at[person_pos[gloria]] in {french_onion,split_pea};
constraint restaurant_at[person_pos[gloria]] in {apple,hennigans};

% 2
constraint soup_pos[ministrone] < person_pos[marvin];

% 3
constraint opposite(surname_pos[anderson], restaurant_pos[michels]);

% 4
constraint (person_pos[marvin] = 5 /\ opposite(soup_pos[asparagus],soup_pos[chicken_noodle]))
        \/ (opposite(person_pos[marvin],soup_pos[chicken_noodle]) /\ soup_pos[asparagus] = 5);

% 5
constraint next_to(person_pos[norville], restaurant_pos[country]);

% 6
constraint (person_pos[quincy] = surname_pos[dugan] /\ not opposite(restaurant_pos[village],soup_pos[asparagus]))
        \/ (restaurant_pos[village] = surname_pos[dugan] /\ not opposite(person_pos[quincy],soup_pos[asparagus]));

% 7
constraint (restaurant_pos[pine_cove] = surname_pos[anderson] /\ soup_pos[ministrone] != 4)
        \/ (restaurant_pos[pine_cove] != soup_pos[ministrone] /\ surname_pos[anderson] = 4);

% 8
constraint restaurant_at[surname_pos[burns]] = apple;
constraint soup_at[surname_pos[burns]] != split_pea;

% 9
constraint card({person_pos[jenna], surname_pos[dugan], restaurant_pos[pine_cove], soup_pos[chowder], 3, (surname_pos[dugan] + size div 2) mod size}) = 6;

% 10
constraint (person_pos[isabel] = restaurant_pos[michels] /\ surname_pos[friedman] = soup_pos[chicken_noodle])
        \/ (person_pos[isabel]= soup_pos[chicken_noodle] /\  restaurant_pos[michels] = surname_pos[friedman]);

% 11
constraint soup_at[person_pos[marvin]] != chowder;

% 12
constraint person_pos[jenna] mod 2 = 1;
constraint next_to(person_pos[jenna], surname_pos[caruso]);

% 13
constraint restaurant_pos[pine_cove] != 6;