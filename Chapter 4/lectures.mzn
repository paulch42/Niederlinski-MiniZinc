include "globals.mzn";

enum day = {monday,tuesday,wednesday,thursday,friday};

enum subject = {college,hygenie,art,nutrition,study};

enum lecturer = {alice,bernadette,charles,duane,eddie};

enum surname = {felicidad,garber,haller,itakura,jeffreys};

set of lecturer: man = {charles,duane,eddie};

% decision variables; the various characteristics are linked via the lecturer attribute
array[lecturer] of var day: lectures_on;
array[lecturer] of var subject: lectures_about;
array[subject] of var lecturer: lectured_by;
array[lecturer] of var surname: has_surname;
array[surname] of var lecturer: surname_of;

constraint alldifferent(lectures_on);
constraint inverse(lectures_about,lectured_by);
constraint inverse(has_surname,surname_of);

% 1: alice lectured on monday
constraint lectures_on[alice] = monday;

% 2: charles lecture on physical hygine not on tuesday
constraint lectures_on[charles] != tuesday;
constraint lectures_about[charles] = hygenie;

% 3: jeffries gave lecture on nutrition
constraint lectures_about[surname_of[jeffreys]] = nutrition;

% 4: modern art lecure by a man
constraint lectured_by[art] in man;

% 5: itakura and the study habits lecturer spoke on consecutive days
constraint abs(enum2int(lectures_on[surname_of[itakura]]) - enum2int(lectures_on[lectured_by[study]])) = 1;

% 6: haller lectured later than eddie
constraint lectures_on[surname_of[haller]] > lectures_on[eddie];

% 7: duane felicidad lectured before modern art
constraint has_surname[duane] = felicidad;
constraint lectures_on[duane] < lectures_on[lectured_by[art]];