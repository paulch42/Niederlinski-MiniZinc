% Section 4.5.3

include "globals.mzn";

enum location = {lower,upper,middle};
enum activist = {blather,jabber,fable};
enum day = {monday,tuesday,wednesday};

% decision variables: activists, their locations, and the day on which they are at a location
array[activist] of var location: location_of_activist;
array[activist] of var day: day_of_activist;

constraint alldifferent(location_of_activist);
constraint alldifferent(day_of_activist);

% 1: blather wont travel to lower hole
constraint location_of_activist[blather] != lower;

% 2: jabber wont travel to lower or upper hole on tuesdays
constraint location_of_activist[jabber] in {lower,upper} -> day_of_activist[jabber] != tuesday;

% 3: jabber wont travel to upper hole on mondays
constraint location_of_activist[jabber] = upper -> day_of_activist[jabber] != monday;

% 4: no-one wants to travel to lower hole on mondays
constraint forall(a in activist)(day_of_activist[a] = monday -> location_of_activist[a] != lower);

% 5: blather must not go to upper hole
constraint location_of_activist[blather] != upper;

% 6: blather must not go to lower hole on mondays (redundant; see constraint 1)
constraint location_of_activist[blather] = lower -> day_of_activist[blather] != monday;

% 7: fable must not go to middle hole
constraint location_of_activist[fable] != middle;