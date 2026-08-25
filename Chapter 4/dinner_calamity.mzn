include "globals.mzn";

enum name = {astor,davis,blake,crane};
enum person = M(name) ++ W(name);

int: num_people = card(person);

set of int: POSITION = 1..num_people;

array[POSITION] of var person: person_at;
array[person] of var POSITION: position_of;
array[POSITION] of var POSITION: insulted;

function var bool: next_to(var POSITION:p, var POSITION: q) = {p,q} = {1,num_people} \/ p in {q-1,q+1};

function var bool: opposite(var POSITION: p, var POSITION: q) = (p-1) mod 4 = (q-1) mod 4;

constraint inverse(person_at,position_of);

% 1: mrs astor was insulted by mr blake, who insulted her
constraint next_to(position_of[W(astor)],position_of[M(blake)]);
constraint insulted[position_of[M(blake)]] = position_of[W(astor)];

% 2: mr blake was insulted by mrs crane, who sat opposite him
constraint opposite(position_of[M(blake)],position_of[W(crane)]);
constraint insulted[position_of[W(crane)]] = position_of[M(blake)];

% 3: mrs blake was insulted by mrs astor, who sat opposite her
constraint opposite(position_of[W(blake)],position_of[W(astor)]);
constraint insulted[position_of[W(astor)]] = position_of[W(blake)];

% 4: mrs Davis insulted by the only person to sit between two men
constraint xorall(p in person)(insulted[position_of[p]] = position_of[W(davis)] /\
                               exists(m,n in name where m<n)
                                     (next_to(position_of[p],position_of[M(m)]) /\ next_to(position_of[p],position_of[M(n)])));

% 5: mrs Davis only person to sit between a married couple
constraint exists(n in name, p = M(n), q = W(n))
                 (next_to(position_of[p],position_of[W(davis)]) /\ next_to(position_of[q],position_of[W(davis)]));

% 6: mrs davis sat opposite mr davis
constraint opposite(position_of[W(davis)],position_of[M(davis)]);
