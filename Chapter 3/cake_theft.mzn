enum villain = {arnold,brian,charlie,derek,edward};

array[villain] of var bool: guilty;

constraint not guilty[edward] != guilty[brian];
constraint not guilty[charlie] != not guilty[edward];
constraint guilty[edward] != not guilty[arnold];
constraint guilty[charlie] != guilty[brian];
constraint guilty[derek] != not guilty[arnold];
constraint count(v in villain)(guilty[v]) = 1;