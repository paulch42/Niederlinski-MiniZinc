var bool: mr_smith;
var bool: mrs_smith;
var bool: matt;
var bool: john;
var bool: tim;

constraint mr_smith -> mrs_smith;
constraint matt \/ john;
constraint mrs_smith != tim;
constraint tim = john;
constraint matt -> john /\ mr_smith;

% Alternate solution using sets

% enum family = {mr_smith,mrs_smith,matt,john,tim};

% var set of family: visit;

% constraint mr_smith in visit -> mrs_smith in visit;
% constraint {matt,john} intersect visit != {};
% constraint card({mrs_smith,tim} intersect visit) < 2;
% constraint card({tim,john} intersect visit) != 1;
% constraint matt in visit -> john in visit /\ mr_smith in visit;
