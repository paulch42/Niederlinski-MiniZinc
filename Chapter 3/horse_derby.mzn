set of int: Position = 1..10;

% decision variable for each horse (its position in the race)
var Position: sylvester;
var Position: zebra_wings;
var Position: frogmans_flippers;
var Position: tweetie_pie;
var Position: fizzy_pop;
var Position: minty_mouse;
var Position: cd_player;
var Position: windy_miller;
var Position: top_trumps;
var Position: kool_kat;

% zerba wings beat sylvester
constraint zebra_wings < sylvester;

% zebra wings beat frogmans flippers
constraint zebra_wings < frogmans_flippers;

% zebra wings beat tweetie pie
constraint zebra_wings < tweetie_pie;

% minty mouse beat fizzy pop
constraint minty_mouse < fizzy_pop;

% sylvester beat fizzy pop
constraint sylvester < fizzy_pop;

% player beat fizzy pop
constraint cd_player < fizzy_pop;

% frogmans flippers beat windy miller
constraint frogmans_flippers < windy_miller;

% frogmans flippers beat cd player
constraint frogmans_flippers < cd_player;

% frogmans flippers beat sylvester
constraint frogmans_flippers < sylvester;

% kool cat beat top trumps
constraint kool_kat < top_trumps;

% cd player beat top trumps
constraint cd_player < top_trumps;

% tweetie pie beat top trumps
constraint tweetie_pie < top_trumps;

% cd player beat fizzy pop
constraint cd_player < fizzy_pop;

% sylvester beat tweety pie
constraint sylvester < tweetie_pie;

% tweetie pie beat kool cat
constraint tweetie_pie < kool_kat;

% frogmans flippers beat kool cat
constraint frogmans_flippers < kool_kat;

% frogmans flippers beat fizzy pop
constraint frogmans_flippers < fizzy_pop;

% frogmans flippers beat minty mouse
constraint frogmans_flippers < minty_mouse;

% kool cat beat cd player
constraint kool_kat < cd_player;

% tweetie pie beat cd player
constraint tweetie_pie < cd_player;

% top trumps beat fizzy pop
constraint top_trumps < fizzy_pop;

% top trumps beat windy miller
constraint top_trumps < windy_miller;

% windy miller beat minty mouse
constraint windy_miller < minty_mouse;

% sylvester beat minty mouse
constraint sylvester < minty_mouse;

% tweety pie beat windy miller
constraint tweetie_pie < windy_miller;

% cd player beat windy miller
constraint cd_player < windy_miller;
