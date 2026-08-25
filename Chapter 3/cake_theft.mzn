enum villain = {arnold,brian,charlie,derek,edward};

array[villain] of var bool: guilty;

% each villian makes two staement, one true and one false, so they have different values

% 1 arnold: edward innocent, brian guilty
constraint not guilty[edward] != guilty[brian];

% 2 brian: charlie innocent, edward innocent
constraint not guilty[charlie] != not guilty[edward];

% 3 charlie: edward guilty, arnold innocent
constraint guilty[edward] != not guilty[arnold];

% 4 derek: charlie guilty, brian guilty
constraint guilty[charlie] != guilty[brian];

% 5 edward: derek guilty, arnold innocent
constraint guilty[derek] != not guilty[arnold];

% only one villian is guilty
constraint count(v in villain)(guilty[v]) = 1;