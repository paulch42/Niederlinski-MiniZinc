% Section 3.6.3

include "globals.mzn";

int: num_students = card(student);
enum student = {poland,sweden,germany,finland,hungary};
enum language = {polish,swedish,german,finnish,hungarian};

constraint assert(card(student) = card(language), "'student' and 'language' must have same cardinality");

array[student,language] of var bool: speaks;

constraint forall(i in 1..num_students)(speaks[to_enum(student,i),to_enum(language,i)]);
constraint forall(s in student)(count(l in language)(speaks[s,l]) > 1);
constraint forall(l in language)(count(s in student)(speaks[s,l]) < num_students);
constraint forall(s, t in student where s < t)(exists(l in language)(speaks[s,l] /\ speaks[t,l]));
constraint count(l in language, s in student)(speaks[s,l]) = num_students*3;
constraint count(l in language)(speaks[poland,l]) = 3;
constraint count(l in language)(speaks[hungary,l]) = 3;
constraint exists(l in language)(forall(s in student where s != sweden)(speaks[s,l]));
constraint exists(l in language)(forall(s in student where s != finland)(speaks[s,l]));
constraint count(s in student)(speaks[s,swedish]) = 3;
constraint count(s in student where not(s in {poland,finland}))(speaks[s,polish] /\ speaks[s,finnish]) = 2;
constraint count(l in language)(speaks[poland,l] /\ speaks[finland,l]) = 2;
constraint not(speaks[poland,german] /\ speaks[finland,german]);
constraint count(l in language)(speaks[sweden,l] /\ speaks[hungary,l]) = 1;
