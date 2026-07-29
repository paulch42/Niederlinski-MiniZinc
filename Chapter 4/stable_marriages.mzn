include "globals.mzn";

enum men;
enum women;

int: num_couples = card(men);

set of int: rank = 1..num_couples;

array[men,women] of rank: men_rank;
array[women,men] of rank: women_rank;

constraint assert(card(women) = num_couples, "Number of men and women not equal");

array[women] of var men: husband_of;
array[men] of var women: wife_of;

constraint inverse(husband_of, wife_of);

predicate stable(var men: husband, var women: wife) =
  forall(w in women)(men_rank[husband,w] < men_rank[husband,wife] -> women_rank[w,husband_of[w]] < women_rank[w,husband]) /\
  forall(m in men)(women_rank[wife,m] < women_rank[wife,husband] -> men_rank[m,wife_of[m]] < men_rank[m,wife]);
  
constraint forall(m in men)(stable(m,wife_of[m]));
