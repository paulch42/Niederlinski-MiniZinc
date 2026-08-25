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

% alex statement
constraint Alex -> ben_mike_friends /\ not colin_mike_friends;

% ben statement
constraint Ben -> not ben_mike_friends;

% colin statement
constraint Colin -> alex_mike_friends /\ ben_mike_friends;

% Someone (killer) is lying, others telling truth
constraint not Alex xor not Ben xor not Colin;