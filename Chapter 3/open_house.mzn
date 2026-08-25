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

% 1: smith isn't moises or olive, and diesn't study philosophy
constraint not (firstnames[smith] in {moises,olive});
constraint studies[firstnames[smith]] != philosophy;

% 2: two of wu's relatove assisted
constraint card(helpers[firstnames[wu]]) = 2;

% 3: zacher enlited fewer relatives to assist than at least one other student
constraint card(helpers[firstnames[zacher]]) < max([card(helpers[s]) | s in student where s != firstnames[zacher]]);

% 4: sculpture major is only student that enlisted no relatives to assist
constraint helpers[studied_by[sculpture]] = {};
constraint forall(s in student where s != studied_by[sculpture])(helpers[s] != {});

% 5: brittany and hendeson each enlisted one parent, and neither is maths major
constraint card(helpers[brittany]) = 1 /\ helpers[brittany] subset {father,mother} /\ studies[brittany] != math;
constraint card(helpers[firstnames[henderson]]) = 1 /\ helpers[firstnames[henderson]] subset {father,mother} /\ studies[firstnames[henderson]] != math;

% 6: moises and geography major either both enlisted father's assistance, or neither did
constraint father in helpers[moises] <-> father in helpers[studied_by[geography]];

% 7: no two students of same gender enlisted their mothers
constraint forall(m, n in boy where m < n)(not (mother in (helpers[m] intersect helpers[n])));
constraint forall(m, n in girl where m < n)(not (mother in (helpers[m] intersect helpers[n])));

% 8: bradshaw's fatehr didn't assist
constraint not (father in helpers[firstnames[bradshaw]]);

% 9: olive enlisted one more assistant than math major
constraint card(helpers[olive]) = card(helpers[studied_by[math]]) + 1;

% 10: natalie is language major and her father didn't assist
constraint studies[natalie] = language;
constraint not (father in helpers[natalie]);