include "globals.mzn";

enum person = {george,oliver,colleen,patti,theresa};

enum surname = {gold,orlando,chiasson,petroski,truang};

% iniital letters of names; note both first and surnames have same set of initial letters
enum initial = {gi,oi,ci,pi,ti};

set of person: man = {george,oliver};

enum dish = {crab,filet_mignon,ribs,shrimp,sirloin_steak};

enum potato = {baked,french_fried,lyonnaise,mashed,scalloped};

enum beverage = {ginger_ale,iced_tea,lemonade,root_beer,water};

% map person (first name) to initial
array[person] of initial: person_initial = [gi,oi,ci,pi,ti];
% map surname to initial
array[surname] of initial: surname_initial = [gi,oi,ci,pi,ti];

array[person] of var surname: surname_of;
array[surname] of var person: person_of;
array[person] of var dish: dish_of;
array[dish] of var person: eaten_by;
array[person] of var potato: potato_of;
array[potato] of var person: potato_eaten_by;
array[person] of var beverage: beverage_of;
array[beverage] of var person: drank_by;

constraint inverse(surname_of,person_of);
constraint inverse(dish_of,eaten_by);
constraint inverse(beverage_of,drank_by);
constraint inverse(potato_of,potato_eaten_by);

% the only person with the same first and last name initial had ribs
constraint forall(p in person)(person_initial[p] = surname_initial[surname_of[p]] <-> p = eaten_by[ribs]);

% 2
constraint (person_of[petroski] = potato_eaten_by[lyonnaise] /\ eaten_by[shrimp] = drank_by[root_beer])
        \/ (person_of[petroski] = drank_by[root_beer] /\ eaten_by[shrimp] = potato_eaten_by[lyonnaise]);

% filet mignon did not drink lemonade
constraint drank_by[lemonade] != eaten_by[filet_mignon];

% scalloped potatos din't eat sirloin steak or drink water
constraint potato_eaten_by[scalloped] != eaten_by[sirloin_steak];
constraint potato_eaten_by[scalloped] != drank_by[water];

% root beer drinker has same first name initial as george's surname
constraint person_initial[drank_by[root_beer]] = surname_initial[surname_of[george]];

% theresa didn't drink water
constraint beverage_of[theresa] != water;

% shrip eater and baked potato eater have different gender
constraint eaten_by[shrimp] in man <-> not(potato_eaten_by[baked] in man);

% first name initial of crab eater is same as surname initial of mashed potato eater
constraint person_initial[eaten_by[crab]] = surname_initial[surname_of[potato_eaten_by[mashed]]];

% first name initial of lemonade drinker is same as surname initial of lyonnaise potato eater
constraint person_initial[drank_by[lemonade]] = surname_initial[surname_of[potato_eaten_by[lyonnaise]]];

% patti's surname is not chaisson; chaisson did not eat french fried or lyonnaise potatos
constraint person_of[chiasson] != patti;
constraint not(potato_of[person_of[chiasson]] in {french_fried,lyonnaise});

% truang did not have french fried or mashed potatos, or drink ginger ale
constraint not(potato_of[person_of[truang]] in {french_fried,mashed});
constraint beverage_of[person_of[truang]] != ginger_ale;

% colleen had filet mignon or sirloin
constraint dish_of[colleen] in {filet_mignon,sirloin_steak};