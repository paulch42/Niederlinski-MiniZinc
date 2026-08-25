enum colour = {yellow,red,green,blue};
enum gardener = {mr_green, mr_yellow, mr_red, mr_blue};

% for each gardener and rose, does that gardener grow the rose?
array[gardener,colour] of var bool: rose;

% the set of rose colours grown by a gardener
function var set of colour: colours(gardener: g) = { c | c in colour where rose[g,c] };

% two roses of each colour
constraint forall(c in colour)(count(g in gardener)(rose[g,c]) = 2);

% mr green has yellow rose
constraint yellow in colours(mr_green);

% mr yellow does not have a red rose
constraint not (red in colours(mr_yellow));

% mr red has a blue rose
constraint blue in colours(mr_red);

% mr red does not have a green rose
constraint not (green in colours(mr_red));

% mr blue does not have a yellow rose
constraint not (yellow in colours(mr_blue));

% one gardener has a red and a green rose
constraint count(g in gardener)({red,green} subset colours(g)) = 1;

% one gardener has a yellow and a blue rose
constraint count(g in gardener)({yellow,blue} subset colours(g)) = 1;

% one gardener has a green rose but no red rose
constraint count(g in gardener)(green in colours(g) /\ not (red in colours(g))) = 1;

% no gardener with a yellow rose has a green rose
constraint forall(g in gardener)(yellow in colours(g) -> not (green in colours(g)));

% no gardener has two roses of the same colour
% guaranteed by the definition of the model

% no two gardeners have the same coloured roses
constraint forall(g1, g2 in gardener where g1 < g2)(colours(g1) != colours(g2));
