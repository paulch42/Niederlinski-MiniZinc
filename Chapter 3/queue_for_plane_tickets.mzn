include "globals.mzn";

set of int: position = 1..5;

enum passenger = {bob,keeley,rachael,eilish,amy};

enum age = {a14,a21,a46,a52,a81};

enum website = {rush_limbaugh,conservapedia,american_culture,jeff_rense,american_thinker};

enum lives = {town,city,village,farm,hostel};

enum hairstyle = {afro,long,straight,curly,bald};

enum destination = {france,australia,england,africa,italy};

% queue position is the primary value
% map between it and the other attributes

% map: queue position - passenger
array[position] of var passenger: passenger_at;
array[passenger] of var position: pos_of_passenger;

% map: queue position - age
array[position] of var age: age_at;
array[age] of var position: pos_of_age;

% map: queue position - website
array[position] of var website: website_at;
array[website] of var position: pos_of_website;

% map: queue position - live at
array[position] of var lives: lives_at;
array[lives] of var position: pos_of_lives;

% map: queue position - hairstyle
array[position] of var hairstyle: hairstyle_at;
array[hairstyle] of var position: pos_of_hairstyle;

% map: queue position - destination
array[position] of var destination: destination_at;
array[destination] of var position: pos_of_destination;

% channel the different views
constraint inverse(passenger_at,pos_of_passenger);
constraint inverse(age_at,pos_of_age);
constraint inverse(pos_of_website,website_at);
constraint inverse(lives_at,pos_of_lives);
constraint inverse(hairstyle_at,pos_of_hairstyle);
constraint inverse(destination_at,pos_of_destination);

% 1: person in middle reads jeff rense program
constraint website_at[3] = jeff_rense;

% 2: bob is first in queue
constraint passenger_at[1] = bob;

% 3: person reading rush limbaugh show is next to person who lives in youth hostel
constraint abs(pos_of_website[rush_limbaugh] - pos_of_lives[hostel]) = 1;

% 4: person going to africa is behind rachael
constraint pos_of_destination[africa] > pos_of_passenger[rachael];

% 5: person who lives in a village is 52
constraint lives_at[pos_of_age[a52]] = village;

% 6: person going to australia has straight hair
constraint hairstyle_at[pos_of_destination[australia]] = straight;

% 7: person going to africa reads jeff rense program
constraint website_at[pos_of_destination[africa]] = jeff_rense;

% 8: 14 year old is at end of queue
constraint pos_of_age[a14] = card(position);

% 9: amy reads american culture
constraint passenger_at[pos_of_website[american_culture]] = amy;

% 10: person going to italy has long hair
constraint hairstyle_at[pos_of_destination[italy]] = long;

% 11: keely lives in a village
constraint lives_at[pos_of_passenger[keeley]] = village;

% 12: the 46 year old is bald
constraint hairstyle_at[pos_of_age[a46]] = bald;

% 13: fourth in queue is going to england
constraint destination_at[4] = england;

% 14: people with curly and striaght hair are next to each other
constraint abs(pos_of_hairstyle[curly] - pos_of_hairstyle[straight]) = 1;

% 15: person who reads conservapedia is next to person with an afro
constraint abs(pos_of_website[conservapedia] - pos_of_hairstyle[afro]) = 1;

% 16: person next to rachael has an afro
constraint abs(pos_of_passenger[rachael] - pos_of_hairstyle[afro]) = 1;

% 17: the 21 year old lives in a youth hostel
constraint age_at[pos_of_lives[hostel]] = a21;

% 18: person who reads conservapedia has long hair
constraint hairstyle_at[pos_of_website[conservapedia]] = long;

% 19: the 81 year old lives on a farm
constraint age_at[pos_of_lives[farm]] = a81;

% 20: person going to france lives in a town
constraint lives_at[pos_of_destination[france]] = town;
