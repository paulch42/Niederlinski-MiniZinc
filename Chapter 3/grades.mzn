include "globals.mzn";

enum subject = {physics,math,chemistry};
enum pupil = {andrew,bridget,neil,paul,wendy};
enum mark = {e,d,c,b,a}; % grades ordered such that better grade has higher value in enumeration

% the grade for each pupil in each subject
array[pupil,subject] of var mark: grades;

% each pupil obtained a different grade in each subject
constraint forall(p in pupil)(alldifferent([grades[p,s] | s in subject]));

% no two pupils had the same grade in the same subject
constraint forall(s in subject)(alldifferent([grades[p,s] | p in pupil]));

% andrew outscored bridget in physics
constraint grades[andrew,physics] > grades[bridget,physics];

% andrew outscored neil in math
constraint grades[andrew,math] > grades[neil,math];

% wendy got a C, bridget didn't
constraint exists(s in subject)(grades[wendy,s] = c);
constraint forall(s in subject)(grades[bridget,s] != c);

% wendy got no As
constraint forall(s in subject)(grades[wendy,s] != a);

% pupil with E in maths got B in chemistry but not C in physics 
constraint forall(p in pupil)(grades[p,math] = e -> grades[p,chemistry] = b /\ grades[p,physics] != c);

% paul got a D in physics
constraint grades[paul,physics] = d;

% paul's highest grade was C
constraint max(s in subject)(grades[paul,s]) = c;

% the B in maths was not to the same student with an E in physics
constraint forall(p in pupil)(grades[p,math] = b -> grades[p,physics] != e);

% bridget's best result was in chemistry
constraint max(s in subject)(grades[bridget,s]) = grades[bridget,chemistry];

% bridget's mark in math was lower than paul's
constraint grades[bridget,math] < grades[paul,math];