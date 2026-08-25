include "globals.mzn";

set of int: POSITION = 1..4;

enum dj = {skin_flint,slam_dunk,jam_jar,park_ride};

enum number = {n1,n2,n3,n4};  % the numbers worn by the djs

enum colour = {red,yellow,blue,green};  % the colours of the decks

array[POSITION] of var dj: dj_at;
array[dj] of var POSITION: dj_pos;
array[POSITION] of var number: number_at;
array[number] of var POSITION: number_pos;
array[POSITION] of var colour: colour_at;
array[colour] of var POSITION: colour_pos;

constraint inverse(dj_at,dj_pos);
constraint inverse(number_at,number_pos);
constraint inverse(colour_at,colour_pos);

% skin flint was first
constraint dj_at[1] = skin_flint;

% only one dj was in same position as their number
constraint sum(p in POSITION)(p = number_at[p]) = 1;

% slam dunk wore number 1
constraint number_at[dj_pos[slam_dunk]] = n1;

% dj with number 2 had red deck
constraint colour_at[number_pos[n2]] = red;

% jam jar didn't have a yellow deck
constraint colour_at[dj_pos[jam_jar]] != yellow;

% dj who was last has a blue deck
constraint colour_at[max(POSITION)] = blue;

% park'n'ride beat slam dunk
constraint dj_pos[park_ride] < dj_pos[slam_dunk];

% dj who wore 1 had green deck 
constraint colour_at[number_pos[n1]] = green;

% dj who came second wore number 3
constraint number_at[2] = n3;