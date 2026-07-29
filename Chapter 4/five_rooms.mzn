% Section 4.5.1

include "globals.mzn";

int: num_rooms = 5;
set of int: position = 1..num_rooms;

enum colour = {red,green,blue,white,yellow};
enum day = {monday,tuesday,wednesday,thursday,friday};
enum subject = {physics,maths,informatics,economics,english};
enum mark = {dull,difficult,interesting,most_interesting,nothing_special};
enum technology = {computer,internet,video,blackboard,projector};

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

constraint position_of_colour[red] = position_of_subject[physics];
constraint position_of_subject[english] = position_of_technology[video];
constraint position_of_subject[maths] = 1;
constraint position_of_mark[dull] = position_of_colour[yellow];
constraint next_to(position_of_technology[computer], position_of_mark[interesting]);
constraint next_to(position_of_subject[maths], position_of_colour[blue]);
constraint position_of_mark[nothing_special] = position_of_technology[blackboard];
constraint position_of_mark[most_interesting] = position_of_day[thursday];
constraint position_of_subject[informatics] = position_of_day[tuesday];
constraint position_of_subject[economics] = position_of_mark[difficult];
constraint next_to(position_of_technology[internet], position_of_mark[dull]);
constraint position_of_colour[green] = position_of_day[friday];
constraint position_of_colour[green] = position_of_colour[white]+1;
constraint position_of_day[wednesday] = 3;
