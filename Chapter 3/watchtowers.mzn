% Section 3.7.3

int: num_guards = 12;
set of int: index = 0..num_guards;

var index: n;
var index: ne;
var index: e;
var index: se;
var index: s;
var index: sw;
var index: w;
var index: nw;

% total of 12 guards
constraint n+ne+e+se+s+sw+w+nw = 12;

% 5 guards on each side wall
constraint n+ne+nw = 5;
constraint ne+e+se = 5;
constraint s+se+sw = 5;
constraint nw+w+sw = 5;