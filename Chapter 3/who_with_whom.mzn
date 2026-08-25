% Section 3.6.2

include "globals.mzn";

enum boy = {andy,ben,carl,dusty};
enum girl = {eva,olive,paula,sabrina};
enum event = {concert,cinema,theater,exhibition};

% decision variables relate boys and girls to events
array[event] of var boy: boy_at;
array[boy] of var event: boy_attended;
array[event] of var girl: girl_at;
array[girl] of var event: girl_attended;

% inverse constraints since every person attends exactly one event
constraint inverse(boy_at,boy_attended);
constraint inverse(girl_at,girl_attended);

% 1: andy attended concert
constraint boy_at[concert] = andy;

% ben accompanied olive
constraint boy_attended[ben] = girl_attended[olive];

% 3: carl did not accompany eva
constraint boy_attended[carl] != girl_attended[eva];

% 4: paula went to the cinema
constraint girl_at[cinema] = paula;

% 5: eva went to the theatre
constraint girl_at[theater] = eva;

% 6: one boy and one girl went to an exhibition
% guaranteed by inverse constraints
