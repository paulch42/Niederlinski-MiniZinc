% Section 3.6.3

% seems to be an error in the ECLiPSe model
% a couple of the constraints are not staisfied in the solution (model or just incorrect output?)

include "globals.mzn";

int: num_students = card(student);
enum student = {poland,sweden,germany,finland,hungary};
enum language = {polish,swedish,german,finnish,hungarian};
% note: model assumes nationality and language appear in same order in respective enumerations

constraint assert(card(student) = card(language), "'student' and 'language' must have same cardinality");

% decision variable: does a student speak a language?
array[student,language] of var bool: speaks;

% 1: each student speaks their native langauges and at least one foreign language
constraint forall(i in 1..num_students)(speaks[to_enum(student,i),to_enum(language,i)]);
constraint forall(s in student)(count(l in language)(speaks[s,l]) > 1);

% 2: no language is spoken by all students
constraint forall(l in language)(count(s in student)(speaks[s,l]) < num_students);

% 3: any pair of students can converse in some common language
constraint forall(s, t in student where s < t)(exists(l in language)(speaks[s,l] /\ speaks[t,l]));

% 4: common languages include native languages of all students
% guaranteed by definition of model

% 5: students on average speak two foreign languages (i.e. three in total)
constraint count(l in language, s in student)(speaks[s,l]) = num_students*3;

% 6: pole and hungarian each speak three foreign languages (i.e. four in total)
constraint count(l in language)(speaks[poland,l]) = 4;
constraint count(l in language)(speaks[hungary,l]) = 4;

% 7: if swede absent, others have a common language
constraint exists(l in language)(forall(s in student where s != sweden)(speaks[s,l]));

% 8: if finn absent, others have a common language
constraint exists(l in language)(forall(s in student where s != finland)(speaks[s,l]));

% 9: all but two students speak swedish
constraint count(s in student)(speaks[s,swedish]) = card(student)-2;

% 10: polish and finnish is spoken (as a foreign language) by only two students
constraint count(s in student where not(s in {poland,finland}))(speaks[s,polish] /\ speaks[s,finnish]) = 2;

% 11: pole and finn can communicate in two languages, neither of which is german
constraint count(l in language)(speaks[poland,l] /\ speaks[finland,l]) = 2;
constraint not(speaks[poland,german] /\ speaks[finland,german]);

% 12: hungarian and swede have one common language
constraint count(l in language)(speaks[sweden,l] /\ speaks[hungary,l]) = 1;
