include "globals.mzn";

enum competitor = {a,b,c,d,e};
enum medal = {gold,silver,bronze};

array[medal] of var competitor: award;

constraint alldifferent(award);

% comments are problem statements, constraints are their negation since none are true

% A didn't win gold and B didn't win silver
constraint not (award[gold] != a /\ award[silver] != b);

% D didn't win soilver and E didn't win bronze
constraint not (award[silver] != d /\ award[bronze] != e);

% C won a medal, D didn't
constraint not(c in award /\ not (d in award));

% A won a medal, C didn't
constraint not(a in award /\ not (c in award));

% D and E both won medals
constraint not(d in award /\ e in award);
