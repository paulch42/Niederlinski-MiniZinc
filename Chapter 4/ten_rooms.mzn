% Section 4.5.2

include "globals.mzn";

int: num_rooms = 10;
set of int: position = 1..num_rooms;

enum colour = {red,green,blue,white,yellow,pink,violet,orange,brown,grey};
enum day = {monday_am,tuesday_am,wednesday_am,thursday_am,friday_am,monday_pm,tuesday_pm,wednesday_pm,thursday_pm,friday_pm};
enum subject = {physics,maths,informatics,economics,english,chemistry,german,history,music,electronics};
enum mark = {dull,difficult,interesting,most_interesting,nothing_special,exhausting,funny,popular,singing,absorbing};
enum technology = {computer,internet,video,blackboard,projector,reagents,dictionaries,maps,piano,oscilloscope};

% decision variables; the various characteristics are linked via the position (room number) attribute
array[position] of var day: day_of_position;
array[day] of var position: position_of_day;
array[position] of var colour: colour_of_position;
array[colour] of var position: position_of_colour;
array[position] of var subject: subject_of_position;
array[subject] of var position: position_of_subject;
array[position] of var mark: mark_of_position;
array[mark] of var position: position_of_mark;
array[position] of var technology: technology_of_position;
array[technology] of var position: position_of_technology;

predicate next_to(var position: x, var position: y) = abs(x-y) = 1;
predicate left_of(var position: x, var position: y) = x = y+1;

constraint inverse(day_of_position,position_of_day);
constraint inverse(colour_of_position,position_of_colour);
constraint inverse(subject_of_position,position_of_subject);
constraint inverse(mark_of_position,position_of_mark);
constraint inverse(technology_of_position,position_of_technology);

% 1: physics class in red room
constraint position_of_colour[red] = position_of_subject[physics];

% 2: english class requires video
constraint position_of_subject[english] = position_of_technology[video];

% 3: maths is run in first room
constraint position_of_subject[maths] = 1;

% 4: class in yellow room is dull
constraint position_of_mark[dull] = position_of_colour[yellow];

% 5: class in room next to computer room is interesting
constraint next_to(position_of_technology[computer], position_of_mark[interesting]);

% 6: maths is in room next to blue room
constraint next_to(position_of_subject[maths], position_of_colour[blue]);

% 7: nothing special class uses chalk and blackboard
constraint position_of_mark[nothing_special] = position_of_technology[blackboard];

% 8: thursday class is most interesting
constraint position_of_mark[most_interesting] in {position_of_day[thursday_am],position_of_day[thursday_pm]};

% 9: informatics is on tuesday
constraint position_of_subject[informatics] in {position_of_day[tuesday_am],position_of_day[tuesday_pm]};

% 10: economics is difficult
constraint position_of_subject[economics] = position_of_mark[difficult];

% 11: class next to internet class is dull
constraint next_to(position_of_technology[internet], position_of_mark[dull]);

% 12: green room classes are on firday
constraint position_of_colour[green] in {position_of_day[friday_am], position_of_day[friday_pm]};

% 13: green room is on the right of white room
constraint left_of(position_of_colour[white], position_of_colour[green]);

% 14: middle room classes are on wednesday
constraint position_of_day[wednesday_am] = 3;

% 15: pink room classes are monday pm
constraint position_of_colour[pink] = position_of_day[monday_pm];

% 16: reagents are used in chemistry class
constraint position_of_subject[chemistry] = position_of_technology[reagents];

% 17: monday pm classes are exhausting
constraint position_of_mark[exhausting] = position_of_day[monday_pm];

% 18: projector is next to romm where reagents used
constraint next_to(position_of_technology[reagents], position_of_technology[projector]);

% 19: monday pm class is in pink room
constraint position_of_colour[pink] = position_of_day[monday_pm];

% 20: violet room has dictionaries
constraint position_of_colour[violet] = position_of_technology[dictionaries];

% 21: violet room next to pink room
constraint next_to(position_of_colour[violet], position_of_colour[pink]);

% 22: german room next to chemistry room
constraint next_to(position_of_subject[german], position_of_subject[chemistry]);

% 23: tuesday pm class is funny
constraint next_to(position_of_day[tuesday_pm], position_of_mark[funny]);

% 24: dictionary room is to left of orange room
constraint left_of(position_of_technology[dictionaries], position_of_colour[orange]);

% 25: popular class is on right side of german
constraint left_of(position_of_subject[german], position_of_mark[popular]);

% 26: wednesday pm class in orange room
constraint position_of_colour[orange] = position_of_day[wednesday_pm];

% 27: history class needs maps
constraint position_of_subject[history] = position_of_technology[maps];

% 28: piano is in room 9
constraint position_of_technology[piano] = 9;

% 29: singing takes place in music class
constraint position_of_subject[music] = position_of_mark[singing];

% 30: piano is in brown room
constraint position_of_colour[brown] = position_of_technology[piano];

% 31: class in brown room is thursday pm
constraint position_of_colour[brown] = position_of_day[thursday_pm];

% 32: electronics is in room next to music
constraint next_to(position_of_subject[electronics], position_of_subject[music]);

% 33: electronics requires an oscilloscope
constraint position_of_subject[electronics] = position_of_technology[oscilloscope];

% 34: the class that uses oscilloscope is absorbing
constraint position_of_mark[absorbing] = position_of_technology[oscilloscope];

% 35: friday pm class is in grey room
constraint position_of_colour[grey] = position_of_day[friday_pm];