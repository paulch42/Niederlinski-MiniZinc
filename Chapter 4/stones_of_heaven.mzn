include "globals.mzn";

enum customer = {finland,italy,japan,us};

enum figurine = {buckle,dragon,grasshopper,horse};

enum colour = {dark_green,light_green,red,white};

enum dynasty = {ching,ming,sung,tang};

% decision variables; the various characteristics are linked via the figurine attribute
array[figurine] of var customer: bought_by;
array[customer] of var figurine: bought;
array[figurine] of var colour: has_colour;
array[colour] of var figurine: colour_for;
array[figurine] of var dynasty: of_dynasty;
array[dynasty] of var figurine: dynasty_for;

constraint inverse(bought_by,bought);
constraint inverse(has_colour,colour_for);
constraint inverse(of_dynasty,dynasty_for);

% 1: rare white dragon not from sung dynasty and not bought by american
constraint bought_by[dragon] != us;
constraint of_dynasty[dragon] != sung;

% 2: belt buckle not a shade of green and created for the tang dynasty
constraint not (has_colour[buckle] in {dark_green,light_green});
constraint of_dynasty[buckle] = tang;

% 3: finn didn't buy dragon, japanese didn't buy ching item, and light green item was not the horse
constraint bought[finland] != dragon;
constraint bought_by[dynasty_for[ching]] != japan;
constraint colour_for[light_green] != horse;

% 4: american did not buy the grasshopper or the sung dynasty item
constraint not (bought[us] in {grasshopper,dynasty_for[sung]});