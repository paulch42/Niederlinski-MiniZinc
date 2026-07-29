include "globals.mzn";

set of int: position = 1..5;

enum passenger = {bob,keeley,rachael,eilish,amy};

enum age = {a14,a21,a46,a52,a81};

enum website = {rush_limbaugh,conservapedia,american_culture,jeff_rense,american_thinker};

enum lives = {town,city,village,farm,hostel};

enum hairstyle = {afro,long,straight,curly,bald};

enum destination = {france,australia,england,africa,italy};

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

constraint inverse(passenger_at,pos_of_passenger);
constraint inverse(age_at,pos_of_age);
constraint inverse(pos_of_website,website_at);
constraint inverse(lives_at,pos_of_lives);
constraint inverse(hairstyle_at,pos_of_hairstyle);
constraint inverse(destination_at,pos_of_destination);

% 1
constraint website_at[3] = jeff_rense;

% 2
constraint passenger_at[1] = bob;

% 3
constraint abs(pos_of_website[rush_limbaugh] - pos_of_lives[hostel]) = 1;

% 4
constraint pos_of_destination[africa] = pos_of_passenger[rachael]+1;

% 5
constraint lives_at[pos_of_age[a52]] = village;

% 6
constraint hairstyle_at[pos_of_destination[australia]] = straight;

% 7
constraint website_at[pos_of_destination[africa]] = jeff_rense;

% 8
constraint pos_of_age[a14] = 5;

% 9
constraint passenger_at[pos_of_website[american_culture]] = amy;

% 10
constraint hairstyle_at[pos_of_destination[italy]] = long;

% 11
constraint lives_at[pos_of_passenger[keeley]] = village;

% 12
constraint hairstyle_at[pos_of_age[a46]] = bald;

% 13
constraint destination_at[4] = england;

% 14
constraint abs(pos_of_hairstyle[curly] - pos_of_hairstyle[straight]) = 1;

% 15
constraint abs(pos_of_website[conservapedia] - pos_of_hairstyle[afro]) = 1;

% 16
constraint abs(pos_of_passenger[rachael] - pos_of_hairstyle[afro]) = 1;

% 17
constraint age_at[pos_of_lives[hostel]] = a21;

% 18
constraint hairstyle_at[pos_of_website[conservapedia]] = long;

% 19
constraint age_at[pos_of_lives[farm]] = a81;

% 20
constraint lives_at[pos_of_destination[france]] = town;
