% Section 2.4.10

include "globals.mzn";

enum person = {andrew,barbara,christopher};
enum topic = {knowledge_engineering,artificial_intelligence,econometric_models};
enum professor = {paul,smith,jones};
enum room = {k2,d3,r104};
enum day = {tue,wed,thu};
enum time = {t200,t345,t530}; % symbolic constraints for fixed times of lectures

% person is key entity
% there is a bijective relation between person and each other entity
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

% 1: andrew attends lecture by prof paul
constraint professors[andrew] = paul;

% 2: tuesday lecture does not start at 2pm
constraint times[days_person[tue]] != t200;

% 3: lecture on kmnwledge enginweering does not start at 5:30pm
constraint times[topics_person[knowledge_engineering]] != t530;

% 4: thursday lecture starts at 3:45pm
constraint times[days_person[thu]] = t345;

% 5: christopher attends lecture on econometic models
constraint topics[christopher] = econometric_models;

% 6: barbara attends lecture on tuesdays
constraint days[barbara] = tue;

% 7: artificial intelligence lecture in in building D3
constraint rooms[topics_person[artificial_intelligence]] = d3;

% 8: wednesday lecture is in room 104
constraint rooms[days_person[wed]] = r104;

% 9: prof smith does not give lecture on ecomometric models
constraint topics[professors_person[smith]] != econometric_models;

% 10: prof jones does not give lecture in room K2
constraint rooms[professors_person[jones]] != k2;