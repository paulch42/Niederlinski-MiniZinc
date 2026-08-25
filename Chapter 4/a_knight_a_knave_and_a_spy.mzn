include "globals.mzn";

enum person = {alex,brook,cody};

enum role = {knight,knave,spy};

array[person] of var role: roles;

constraint alldifferent(roles);

% if alex is a knight, cody is a knave
constraint roles[alex] = knight -> roles[cody] = knave;
% if alex is a knave, cody is not a knave
constraint roles[alex] = knave -> roles[cody] != knave;

% if brook is a knight, alex is a knight
constraint roles[brook] = knight -> roles[alex] = knight;
% if brook is a knave, alex is not a knight
constraint roles[brook] = knave -> roles[alex] != knight;

% if cody is a knight, cody is a spy
constraint roles[cody] = knight -> roles[cody] = spy;
% if cody is a knave, cody is not a spy
constraint roles[cody] = knave <-> roles[cody] != spy;