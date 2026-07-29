include "globals.mzn";

enum person = {alex,brook,cody};

enum role = {knight,knave,spy};

array[person] of var role: roles;

constraint alldifferent(roles);

constraint roles[alex] = knight -> roles[cody] = knave;
constraint roles[alex] = knave -> roles[cody] != knave;

constraint roles[brook] = knight -> roles[alex] = knight;
constraint roles[brook] = knave -> roles[alex] != knight;

constraint roles[cody] = knight -> roles[cody] = spy;
constraint roles[cody] = knave <-> roles[cody] != spy;