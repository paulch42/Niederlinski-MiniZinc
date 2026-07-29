include "globals.mzn";

enum customer = {finland,italy,japan,us};

enum figurine = {buckle,dragon,grasshopper,horse};

enum colour = {dark_green,light_green,red,white};

enum dynasty = {ching,ming,sung,tang};

array[figurine] of var customer: bought_by;
array[customer] of var figurine: bought;
array[figurine] of var colour: has_colour;
array[colour] of var figurine: colour_for;
array[figurine] of var dynasty: of_dynasty;
array[dynasty] of var figurine: dynasty_for;

constraint inverse(bought_by,bought);
constraint inverse(has_colour,colour_for);
constraint inverse(of_dynasty,dynasty_for);

% 1
constraint bought_by[dragon] != us;
constraint of_dynasty[dragon] != sung;

% 2
constraint not (has_colour[buckle] in {dark_green,light_green});
constraint of_dynasty[buckle] = tang;

% 3
constraint bought[finland] != dragon;
constraint bought_by[dynasty_for[ching]] != japan;
constraint colour_for[light_green] != horse;

% 4
constraint not (bought[us] in {grasshopper,dynasty_for[sung]});