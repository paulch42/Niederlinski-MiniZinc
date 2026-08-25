include "globals.mzn";

enum member = {akerman,baird,chatham,duval,etting};

enum motion = {m1,m2,m3,m4,m5};
set of int: MOTION = 1..5;

enum vote = {yes,no};

array[member,motion] of var vote: voting; % what member voted on each motion

% list for votes on all motions by member 'm'
function array[MOTION] of var vote: votes_of_member(member: m) = [voting[m,i] | i in motion];
% the number of 'v' votes (yes or no) for motion 'm'
function var int: motion_votes(motion: m, vote: v) = sum([voting[i,m] = v | i in member]);
% the number of 'v' votes (yes or no) by member 'm'
function var int: member_votes(member: m, vote: v) = sum([voting[m,i] = v | i in motion]);

% 1: different number of yes votes for each motion
constraint alldifferent([motion_votes(m,yes) | m in motion]);

% 2: in total, 3 more yes votes than no votes
constraint sum([motion_votes(m,yes) | m in motion]) = sum([motion_votes(m,no) | m in motion]) + 3;

% 3: no two council members voted same way on all motions
constraint forall(m,n in member where m > n)(votes_of_member(m) != votes_of_member(n));

% 4: women disagreed on their votes more often than they agreed
constraint let { array[MOTION] of var vote: baird_votes = votes_of_member(baird);
                 array[MOTION] of var vote: duval_votes = votes_of_member(duval)
               }
           in sum([baird_votes[enum2int(i)] = duval_votes[enum2int(i)] | i in motion]) <= card(motion) div 2;

% 5: no two consecutive yes votes by chatham
constraint forall(m in m1..m4)(not (voting[chatham,m] = yes /\ voting[chatham,enum_next(motion,m)] = yes));

% 6: ackerman and baird both voted for motion 4
constraint voting[akerman,m4] = yes;
constraint voting[baird,m4] = yes;

% 7: motion 1 received two more yes votes than motion 2
constraint motion_votes(m1,yes) = motion_votes(m2,yes) + 2;

% 8: motion 3 received twice as many votes as motion 4
constraint motion_votes(m3,yes) = motion_votes(m4,yes) * 2;