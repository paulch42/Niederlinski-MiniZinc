include "globals.mzn";

enum male = {owen,stan,alexander,mathew,oto,paul,rick,robert};

enum female = {danielle,victoria,hannah,jenny,monica,irene,veronica,pamela};

enum person = M(male) ++ F(female);

enum surname = {black,horricks,smith,cermak,kuril,dvorak,zajac,swain};

enum car = {fiat,ford,chrysler,volkswagen,toyota,moskvic,renault,audi};

enum employment = {assistant,manager,accountant,collector,doctor,teacher,agriculturalist,shopper};

enum colour = {red,brown,white,pink,green,blue,violet,yellow};

enum book = {death_west,economy_lesson,gulag_archpelago,fatal_conceit,wordly_wisdom,atlas_shrugged,humorous_prose,devils_dictionary};

% decision variables; the various characteristics are linked via the surname attribute
array[male] of var surname: male_surname;
array[female] of var surname: female_surname;
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

constraint alldifferent(male_surname);
constraint alldifferent(female_surname);
constraint inverse(drives,driven_by);
constraint inverse(employed_as,employment_of);
constraint inverse(likes,liked_by);
constraint inverse(bought,bought_by);
constraint inverse(borrowed,borrowed_by);

% 1: danielle black and husband are shop assistants
constraint female_surname[danielle] = black;
constraint employed_as[black] = assistant;

% 2: death of the west bought by couple with a fiat who like red
constraint bought[driven_by[fiat]] = death_west;
constraint bought[liked_by[red]] = death_west;

% 3: owen and wife victoria like brown
constraint male_surname[owen] = female_surname[victoria];
constraint likes[male_surname[owen]] = brown;

% 4: stan horricks and wife hannah like white
constraint male_surname[stan] = female_surname[hannah];
constraint male_surname[stan] = horricks;
constraint likes[horricks] = white;

% 5: jenny smith and husband are warehouse managers and have a ford
constraint female_surname[jenny] = smith;
constraint employed_as[smith] = manager;
constraint drives[smith] = ford;

% 6: monica and husband alexander borrowed economy in one lesson
constraint female_surname[monica] = male_surname[alexander];
constraint borrowed[female_surname[monica]] = economy_lesson;

% 7: mathew and wife like pink and bought gulag archipelago
constraint likes[male_surname[mathew]] = pink;
constraint bought[male_surname[mathew]] = gulag_archpelago;

% 8: irene and husband oto work as accountants
constraint female_surname[irene] = male_surname[oto];
constraint employed_as[female_surname[irene]] = accountant;

% 9: fatal conceipt bowwowed by couple with a chrysler
constraint drives[borrowed_by[fatal_conceit]] = chrysler;

% 10: cermaks are ticket collectors and bought art of wordly wisdom
constraint employed_as[cermak] = collector;
constraint bought[cermak] = wordly_wisdom;

% 11: kurils are doctors and borrowed atlas shrugged
constraint employed_as[kuril] = doctor;
constraint borrowed[kuril] = atlas_shrugged;

% 12: paul and wife like green
constraint likes[male_surname[paul]] = green;

% 13: veronica dvorak and husband like blue
constraint female_surname[veronica] = dvorak;
constraint likes[female_surname[veronica]] = blue;

% 14: rick and wife bought atlas shrugged and drive a volkswagen
constraint bought[male_surname[rick]] = atlas_shrugged;
constraint drives[male_surname[rick]] = volkswagen;

% 15: couple who bought oxford huumorous prose also borrowed gulag archipelago
constraint bought_by[humorous_prose] = borrowed_by[gulag_archpelago];

% 16: couple that drive a toyota like violet
constraint likes[driven_by[toyota]] = violet;

% 17: teachers borrowed oxford humorous prose
constraint borrowed[employment_of[teacher]] = humorous_prose;

% 18: agriculturalists drive a moskvic
constraint employment_of[agriculturalist] = driven_by[moskvic];

% 19: pamela and husband drive a renault and economy in one lesson
constraint drives[female_surname[pamela]] = renault;
constraint bought[female_surname[pamela]] = economy_lesson;

% 20: pamela and husband borrowed book that zajacs bought
constraint borrowed[female_surname[pamela]] = bought[zajac];

% 21: robert and wife like yellwo and borrowed devil's dictionary
constraint likes[male_surname[robert]] = yellow;
constraint borrowed[male_surname[robert]] = devils_dictionary;

% 22: swains work as shoppers
constraint employed_as[swain] = shopper;

% 23: couple that bought devil's dictionary drive and audi
constraint bought_by[devils_dictionary] = driven_by[audi];