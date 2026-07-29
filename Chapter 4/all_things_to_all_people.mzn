% Section 4.5.3

include "globals.mzn";

enum location = {lower,upper,middle};
enum activist = {blather,jabber,fable};
enum day = {monday,tuesday,wednesday};

array[activist] of var location: location_of_activist;
array[location] of var activist: activist_at_location;
array[activist] of var day: day_of_activist;
array[day] of var activist: activist_on_day;

constraint inverse(location_of_activist, activist_at_location);
constraint inverse(day_of_activist, activist_on_day);

constraint location_of_activist[blather] != lower;
constraint location_of_activist[jabber] in {lower,upper} -> day_of_activist[jabber] != tuesday;
constraint location_of_activist[jabber] = upper -> day_of_activist[jabber] != monday;
constraint forall(a in activist)(day_of_activist[a] = monday -> location_of_activist[a] != lower);
constraint location_of_activist[blather] != upper;
constraint location_of_activist[blather] = lower -> day_of_activist[blather] != monday;
constraint location_of_activist[fable] != middle;