include "globals.mzn";

enum person = {danielle,owen,victoria,stan,hannah,jenny,monica,alexander,mathew,irene,oto,paul,veronica,rick,pamela,robert};

set of person: man = {owen,stan,alexander,mathew,oto,paul,rick,robert};

enum surname = {black,horricks,smith,cermak,kuril,dvorak,zajac,swain};

enum car = {fiat,ford,chrysler,volkswagen,toyota,moskvic,renault,audi};

enum employment = {assistant,manager,accountant,collector,doctor,teacher,agriculturalist,shopper};

enum colour = {red,brown,white,pink,green,blue,violet,yellow};

enum book = {death_west,economy_lesson,gulag_archpelago,fatal_conceit,wordly_wisdom,atlas_shrugged,humorous_prose,devils_dictionary};

array[person] of var surname: surname_of;
array[surname] of var car: drives;
array[car] of var surname: driven_by;
array[surname] of var employment: employed_as;
array[employment] of var surname: employment_of;
array[surname] of var colour: likes;
array[colour] of var surname: liked_by;

array[surname] of var book: bought;
array[book] of var surname: bought_by;
array[surname] of var book: borrowed;
array[book] of var surname: borrowed_by;

constraint inverse(drives,driven_by);
constraint inverse(employed_as,employment_of);
constraint inverse(likes,liked_by);
constraint inverse(bought,bought_by);
constraint inverse(borrowed,borrowed_by);

% group into couples
constraint forall(s in surname)(count([surname_of[p] = s | p in  person]) = 2);

% couple is a male and a female
constraint forall(s in surname)(card({p | p in person where surname_of[p] = s} intersect man) = 1);

% 1
constraint surname_of[danielle] = black;
constraint employed_as[black] = assistant;

% 2
constraint bought[driven_by[fiat]] = death_west;

% 3
constraint surname_of[owen] = surname_of[victoria];
constraint likes[surname_of[owen]] = brown;

% 4
constraint surname_of[stan] = horricks;
constraint likes[horricks] = white;

% 5
constraint surname_of[jenny] = smith;
constraint employed_as[smith] = manager;
constraint drives[smith] = ford;

% 6
constraint surname_of[monica] = surname_of[alexander];
constraint borrowed[surname_of[monica]] = economy_lesson;

% 7
constraint likes[surname_of[mathew]] = pink;
constraint bought[surname_of[mathew]] = gulag_archpelago;

% 8
constraint surname_of[irene] = surname_of[oto];
constraint employed_as[surname_of[irene]] = accountant;

% 9
constraint drives[borrowed_by[fatal_conceit]] = chrysler;

% 10
constraint employed_as[cermak] = collector;
constraint bought[cermak] = wordly_wisdom;

% 11
constraint employed_as[kuril] = doctor;
constraint borrowed[kuril] = atlas_shrugged;

% 12
constraint likes[surname_of[paul]] = green;

% 13
constraint surname_of[veronica] = dvorak;
constraint likes[surname_of[veronica]] = blue;

% 14
constraint bought[surname_of[rick]] = atlas_shrugged;
constraint drives[surname_of[rick]] = volkswagen;

% 15
constraint bought_by[humorous_prose] = borrowed_by[gulag_archpelago];

% 16
constraint likes[driven_by[toyota]] = violet;

% 17
constraint borrowed[employment_of[teacher]] = humorous_prose;

% 18
constraint employment_of[agriculturalist] = driven_by[moskvic];

% 19
constraint drives[surname_of[pamela]] = renault;
constraint bought[surname_of[pamela]] = economy_lesson;

% 20
constraint borrowed[surname_of[pamela]] = bought[zajac];

% 21
constraint likes[surname_of[robert]] = yellow;
constraint borrowed[surname_of[robert]] = devils_dictionary;

% 22
constraint employed_as[swain] = shopper;

% 23
constraint bought_by[devils_dictionary] = driven_by[audi];