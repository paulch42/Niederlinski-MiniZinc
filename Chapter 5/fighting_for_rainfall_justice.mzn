% Section 5.7.8

include "globals.mzn";

enum applicant;
enum agenda;
array[applicant] of int: salary;
array[applicant,agenda] of 0..1: apply;

var set of applicant: assigned;

constraint forall(a in agenda)(exists(x in assigned)(apply[x,a] = 1));

solve minimize sum(a in assigned)(salary[a]);