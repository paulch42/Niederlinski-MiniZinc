% Section 3.6.2

include "globals.mzn";

enum boy = {andy,ben,carl,dusty};
enum girl = {eva,olive,paula,sabrina};
enum event = {concert,cinema,theater,exhibition};

array[event] of var boy: boy_at;
array[boy] of var event: boy_attended;
array[event] of var girl: girl_at;
array[girl] of var event: girl_attended;

constraint inverse(boy_at,boy_attended);
constraint inverse(girl_at,girl_attended);

constraint boy_at[concert] = andy;
constraint girl_at[cinema] = paula;
constraint girl_at[theater] = eva;
constraint boy_attended[ben] = girl_attended[olive];
constraint boy_attended[carl] != girl_attended[eva];