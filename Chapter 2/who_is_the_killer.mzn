% Section 2.4.3

% Statements made by the suspects
var bool: ben_mike_friends;
var bool: colin_mike_friends;
var bool: alex_mike_friends;

% Note: Ben saying he was out of town is equivalent to asserting innocence

% Are the suspects telling the truth
var bool: Alex;
var bool: Ben;
var bool: Colin;

% Truth of statements made by the the suspects
constraint Alex -> ben_mike_friends /\ not colin_mike_friends;
constraint Ben -> not ben_mike_friends;
constraint Colin -> alex_mike_friends /\ ben_mike_friends;

% Someone (killer) is not telling the truth
constraint not Alex \/ not Ben \/ not Colin;

% At least two people telling the truth
constraint (Alex /\ Ben) \/ (Alex /\ Colin) \/ (Ben /\ Colin);