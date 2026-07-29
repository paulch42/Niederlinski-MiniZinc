% Section 4.5.2

include "globals.mzn";

int: num_rooms = 10;
set of int: position = 1..num_rooms;

enum colour = {red,green,blue,white,yellow,pink,violet,orange,brown,grey};
enum day = {monday_am,tuesday_am,wednesday_am,thursday_am,friday_am,monday_pm,tuesday_pm,wednesday_pm,thursday_pm,friday_pm};
enum subject = {physics,maths,informatics,economics,english,chemistry,german,history,music,electronics};
enum mark = {dull,difficult,interesting,most_interesting,nothing_special,exhausting,funny,popular,singing,absorbing};
enum technology = {computer,internet,video,blackboard,projector,reagents,dictionaries,maps,piano,oscilloscope};

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

constraint position_of_colour[red] = position_of_subject[physics];
constraint position_of_subject[english] = position_of_technology[video];
constraint position_of_subject[maths] = 1;
constraint position_of_mark[dull] = position_of_colour[yellow];
constraint next_to(position_of_technology[computer], position_of_mark[interesting]);
constraint next_to(position_of_subject[maths], position_of_colour[blue]);
constraint position_of_mark[nothing_special] = position_of_technology[blackboard];
constraint position_of_mark[most_interesting] in {position_of_day[thursday_am],position_of_day[thursday_pm]};
constraint position_of_subject[informatics] in {position_of_day[tuesday_am],position_of_day[tuesday_pm]};
constraint position_of_subject[economics] = position_of_mark[difficult];
constraint next_to(position_of_technology[internet], position_of_mark[dull]);
constraint position_of_colour[green] in {position_of_day[friday_am], position_of_day[friday_pm]};
constraint left_of(position_of_colour[white], position_of_colour[green]);
% This is the Eclipse constraint, but the wording is not clear
constraint position_of_day[wednesday_am] = 3;
constraint position_of_colour[pink] = position_of_day[monday_pm];
constraint position_of_subject[chemistry] = position_of_technology[reagents];
constraint position_of_mark[exhausting] = position_of_day[monday_pm];
constraint next_to(position_of_technology[reagents], position_of_technology[projector]);
constraint position_of_colour[pink] = position_of_day[monday_pm];
constraint position_of_colour[violet] = position_of_technology[dictionaries];
constraint next_to(position_of_colour[violet], position_of_colour[pink]);
constraint next_to(position_of_subject[german], position_of_subject[chemistry]);
constraint next_to(position_of_day[tuesday_pm], position_of_mark[funny]);
constraint left_of(position_of_technology[dictionaries], position_of_colour[orange]);
constraint left_of(position_of_subject[german], position_of_mark[popular]);
constraint position_of_colour[orange] = position_of_day[wednesday_pm];
constraint position_of_subject[history] = position_of_technology[maps];
constraint position_of_technology[piano] = 9;
constraint position_of_subject[music] = position_of_mark[singing];
constraint position_of_colour[brown] = position_of_technology[piano];
constraint position_of_colour[brown] = position_of_day[thursday_pm];
constraint next_to(position_of_subject[electronics], position_of_subject[music]);
constraint position_of_subject[electronics] = position_of_technology[oscilloscope];
constraint position_of_mark[absorbing] = position_of_technology[oscilloscope];
constraint position_of_colour[grey] = position_of_day[friday_pm];