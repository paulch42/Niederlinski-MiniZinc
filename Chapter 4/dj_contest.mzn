include "globals.mzn";

set of int: POSITION = 1..4;

enum dj = {skin_flint,slam_dunk,jam_jar,park_ride};

enum number = {n1,n2,n3,n4};

enum colour = {red,yellow,blue,green};

array[POSITION] of var dj: dj_at;
array[dj] of var POSITION: dj_pos;
array[POSITION] of var number: number_at;
array[number] of var POSITION: number_pos;
array[POSITION] of var colour: colour_at;
array[colour] of var POSITION: colour_pos;

constraint inverse(dj_at,dj_pos);
constraint inverse(number_at,number_pos);
constraint inverse(colour_at,colour_pos);

constraint dj_at[1] = skin_flint;

constraint sum(p in POSITION)(p = number_at[p]) = 1;

constraint number_at[dj_pos[slam_dunk]] = n1;

constraint colour_at[number_pos[n2]] = red;

constraint colour_at[dj_pos[jam_jar]] != yellow;

constraint colour_at[4] = blue;

constraint dj_pos[park_ride] < dj_pos[slam_dunk];

constraint colour_at[number_pos[n1]] = green;

constraint number_at[2] = n3;