include "globals.mzn";

enum subject = {physics,math,chemistry};
enum pupil = {andrew,bridget,neil,paul,wendy};
enum mark = {e,d,c,b,a};

array[pupil,subject] of var mark: grades;

constraint forall(p in pupil)(alldifferent([grades[p,s] | s in subject]));
constraint forall(s in subject)(alldifferent([grades[p,s] | p in pupil]));
constraint grades[andrew,physics] > grades[bridget,physics];
constraint grades[andrew,math] > grades[neil,math];
constraint exists(s in subject)(grades[wendy,s] = c);
constraint forall(s in subject)(grades[wendy,s] != a);
constraint forall(s in subject)(grades[bridget,s] != c);
constraint forall(p in pupil)(grades[p,math] = e -> grades[p,chemistry] = b /\ grades[p,physics] != c);
constraint grades[paul,physics] = d;
constraint max(s in subject)(grades[paul,s]) = c;
constraint forall(p in pupil)(grades[p,math] = b -> grades[p,physics] != e);
constraint max(s in subject)(grades[bridget,s]) = grades[bridget,chemistry];
constraint grades[bridget,math] < grades[paul,math];