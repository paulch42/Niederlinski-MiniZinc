enum horse = {penuche_fudge, whispered_promises, happy_go_lucky, skippers_gal, near_miss};

% decision variable for each horse (its position in the race)
array[horse] of var 1..card(horse): position;

% 1: penuche fudge before near miss and after whispered promisies
constraint position[penuche_fudge] < position[near_miss];
constraint position[whispered_promises] < position[penuche_fudge];

% 2: whisoered promisies tied with penuche fudge iff happy go lucky did not tie with skippers gal
constraint position[whispered_promises] = position[penuche_fudge] <-> position[happy_go_lucky] != position[skippers_gal];

% 3: penuche fudge finished as many places after skippers gal iff whispered promises finished before near miss
constraint position[penuche_fudge] - position[skippers_gal] = position[skippers_gal] - position[whispered_promises]
           <-> position[whispered_promises] < position[near_miss];