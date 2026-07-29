include "globals.mzn";

enum student = {brittany,natalie,olive,emile,moises};
enum study = {geography,language,math,philosophy,sculpture};
enum assistant = {mother,father,grandmother};
enum surname = {bradshaw,henderson,smith,wu,zacher};

set of student: girl = {brittany,natalie,olive};
set of student: boy = {emile,moises};

array[student] of var surname: surnames;
array[surname] of var student: firstnames;
array[student] of var study: studies;
array[study] of var student: studied_by;
array[student] of var set of assistant: helpers;

constraint inverse(firstnames,surnames);
constraint inverse(studies,studied_by);

% 1
constraint not (firstnames[smith] in {moises,olive});
constraint studies[firstnames[smith]] != philosophy;

% 2
constraint card(helpers[firstnames[wu]]) = 2;

% 3
constraint card(helpers[firstnames[zacher]]) < max([card(helpers[s]) | s in student where s != firstnames[zacher]]);

% 4
constraint helpers[studied_by[sculpture]] = {};

% 5
constraint card(helpers[brittany]) = 1 /\ helpers[brittany] subset {father,mother} /\ studies[brittany] != math;
constraint card(helpers[firstnames[henderson]]) = 1 /\ helpers[firstnames[henderson]] subset {father,mother} /\ studies[firstnames[henderson]] != math;

% 6
constraint father in helpers[moises] <-> father in helpers[studied_by[geography]];

% 7
constraint forall(m, n in boy where m < n)(not (mother in (helpers[m] intersect helpers[n])));
constraint forall(m, n in girl where m < n)(not (mother in (helpers[m] intersect helpers[n])));

% 8
constraint not (father in helpers[firstnames[bradshaw]]);

% 9
constraint card(helpers[olive]) = card(helpers[studied_by[math]]) + 1;

% 10
constraint studies[natalie] = language;
constraint not (father in helpers[natalie]);