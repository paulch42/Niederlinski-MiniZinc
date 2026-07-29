% Section 2.4.10

include "globals.mzn";

enum person = {andrew,barbara,christopher};
enum topic = {ke,ai,em};
enum professor = {paul,smith,jones};
enum room = {k2,d3,r104};
enum day = {tue,wed,thu};
enum time = {t200,t345,t530};

array[person] of var topic: topics;
array[topic] of var person: topics_person;
array[person] of var professor: professors;
array[professor] of var person: professors_person;
array[person] of var room: rooms;
array[room] of var person: rooms_person;
array[person] of var day: days;
array[day] of var person: days_person;
array[person] of var time: times;
array[time] of var person: times_person;

constraint inverse(topics,topics_person);
constraint inverse(professors,professors_person);
constraint inverse(rooms,rooms_person);
constraint inverse(days,days_person);
constraint inverse(times,times_person);

constraint professors[andrew] = paul;
constraint times[days_person[tue]] != t200;
constraint times[topics_person[ke]] != t530;
constraint times[days_person[thu]] = t345;
constraint topics[christopher] = em;
constraint days[barbara] = tue;
constraint rooms[topics_person[ai]] = d3;
constraint rooms[days_person[wed]] = r104;
constraint topics[professors_person[smith]] != em;
constraint rooms[professors_person[jones]] != k2;