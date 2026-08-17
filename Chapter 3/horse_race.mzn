enum horse = {penuche_fudge, whispered_promises, happy_go_lucky, skippers_gal, near_miss};

array[horse] of var 1..card(horse): position;

constraint position[penuche_fudge] < position[near_miss];
constraint position[whispered_promises] < position[penuche_fudge];
constraint position[whispered_promises] = position[penuche_fudge] <-> position[happy_go_lucky] != position[skippers_gal];
constraint position[penuche_fudge] - position[skippers_gal] = position[skippers_gal] - position[whispered_promises]
           <-> position[whispered_promises] < position[near_miss];