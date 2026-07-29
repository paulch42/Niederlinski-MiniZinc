enum individual;
enum category;
array[category,individual] of 0..1: type_of;

var set of individual: committee;

constraint forall(c in category)({ i | i in individual where type_of[c,i] = 1 } intersect committee != {});

solve minimize card(committee);