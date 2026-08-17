% Section 2.4.2

include "globals.mzn";

int: num_cubes = 3;
set of int: cube = 1..3;
enum size = {small,medium,large};  % cube sizes
enum colour = {black,grey,white};  % cube colours

% bijective relation between cubes and sizes
array[cube] of var size: size_of_cube;
array[size] of var cube: cube_of_size;
constraint inverse(size_of_cube, cube_of_size);

% bijective relation between cubes and colours
array[cube] of var colour: colour_of_cube;
array[colour] of var cube: cube_of_colour;
constraint inverse(colour_of_cube, cube_of_colour);

constraint colour_of_cube[cube_of_size[large]] > colour_of_cube[cube_of_size[medium]];
constraint size_of_cube[2] = small;
constraint cube_of_colour[black] > cube_of_colour[white];
constraint size_of_cube[3] < size_of_cube[cube_of_colour[grey]];