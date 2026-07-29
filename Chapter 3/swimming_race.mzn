include "globals.mzn";

enum competitor = {a,b,c,d,e};
enum medal = {gold,silver,bronze};

array[medal] of var competitor: award;

constraint alldifferent(award);

constraint not (award[gold] != a /\ award[silver] != b);
constraint not (award[silver] != d /\ award[bronze] != e);
constraint not(c in award /\ not (d in award));
constraint not(a in award /\ not (c in award));
constraint not(d in award /\ e in award);
