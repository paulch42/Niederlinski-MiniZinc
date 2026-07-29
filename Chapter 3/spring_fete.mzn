enum colour = {yellow,red,green,blue};
enum gardener = {mr_green, mr_yellow, mr_red, mr_blue};

array[gardener,colour] of var bool: rose;

function var set of colour: colours(gardener: g) = { c | c in colour where rose[g,c] };

constraint forall(c in colour)(count(g in gardener)(rose[g,c]) = 2);
constraint yellow in colours(mr_green);
constraint not (red in colours(mr_yellow));
constraint blue in colours(mr_red);
constraint not (green in colours(mr_red));
constraint not (yellow in colours(mr_blue));
constraint count(g in gardener)({red,green} subset colours(g)) = 1;
constraint count(g in gardener)({yellow,blue} subset colours(g)) = 1;
constraint count(g in gardener)(green in colours(g) /\ not (red in colours(g))) = 1;
constraint forall(g in gardener)(yellow in colours(g) -> not (green in colours(g)));
constraint forall(g1, g2 in gardener where g1 < g2)(colours(g1) != colours(g2));
