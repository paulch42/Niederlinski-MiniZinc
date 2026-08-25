% Section 4.5.1

include "globals.mzn";

int: num_rooms = 5;
set of int: position = 1..num_rooms;

enum colour = {red,green,blue,white,yellow};
enum day = {monday,tuesday,wednesday,thursday,friday};
enum subject = {physics,maths,informatics,economics,english};
enum mark = {dull,difficult,interesting,most_interesting,nothing_special};
enum technology = {computer,internet,video,blackboard,projector};

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
constraint position_of_mark[most_interesting] = position_of_day[thursday];

% 9: informatics is on tuesday
constraint position_of_subject[informatics] = position_of_day[tuesday];

% 10: economics is difficult
constraint position_of_subject[economics] = position_of_mark[difficult];

% 11: class next to internet class is dull
constraint next_to(position_of_technology[internet], position_of_mark[dull]);

% 12: green room classes are on firday
constraint position_of_colour[green] = position_of_day[friday];

% 13: green room is on the right of white room
constraint position_of_colour[green] = position_of_colour[white]+1;

% 14: middle room classes are on wednesday
constraint position_of_day[wednesday] = 3;
