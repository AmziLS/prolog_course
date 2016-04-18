% A dating service example,
% matching people with similar interests
%

%-----------------------------
% isa(T1, T2).
% where T1 is a T2
%

isa1(basketball, team_sport).
isa1(baseball, team_sport).
isa1(football, team_sport).
isa1(softball, baseball).
isa1(hardball, baseball).
isa1(team_sport, sport).
isa1(individual_sport, sport).
isa1(golf, individual_sport).
isa1(golf, frustrating).
isa1(apple, fruit).
isa1(pear, fruit).
isa1(fruit, food).
isa1(apple, computer).
isa1(macintosh, apple).
isa1(pc, computer).
isa1(hamburger, meat).
isa1(meat, food).
isa1(hotdog, meat).

%--------------------------------------------------------------------
% isa(ITEM, CATEGORY)
% CATEGORY - a category
% ITEM - an item that fits in that category, or its subcategory.
% use the isa1/2 facts.
%
% ?- isa(football, team_sport).
% yes.
% ?- isa(golf, team_sport).
% no.
% ?- isa(golf, sport).
% ?- isa(X, sport).
% X = baseball ; etc.
%
% Like ancestor/descendent - isa will be more efficient
% one way than the other.
%
% Get one way working.  Then, get a second way working
% so there are two recursive clauses, one for each condition,
% and use the cut (!) to make sure only one is used.
%
% isa(ITEM, CATEGORY) :- boundary condition
% % ITEM is a variable case
% isa(ITEM, CATEGORY) :-
%   var(ITEM),
%   !,
%   ...
% $ ITEM is bound case
% isa(ITEM, CATEGORY) :-
%   ...
%
% Rather than write two predicates, write one with two
% recursive clauses, one for each case.
%
% The built-in var(X) can be used to test if an argument
% is a variable.  Or nonvar(X) can be used instead.
%
% The cut (!) can be used to tell Prolog not to consider
% the second recursive clause if the first one is being
% used.
%


%--------------------------------------------------
% basic_isa(Category).
%
% lists all the lowest level items in a category.
%
% basic_isa(food).
% delicious
% macintosh
% pear
% hamburger
% hotdog
%
% HINT: write basic_isa(CAT, X) first that tests if X
% is a lowest level item in category CAT.
%
% ?- basic_isa(food, pear).
% yes
% ?- basic_isa(food, fruit).
% no
%


% END ISA DATING EXERCISES
%---------------------------------------------------

% START AKO DATING EXERCISES
%---------------------------------------------------
% facts that are logically the
% same but are represented using lists.
% ako( Category, Items ).
%

ako1(sport, [team_sport, individual_sport]).
ako1(team_sport, [basketball, baseball, football, ultimate_frisbee]).
ako1(individual_sport, [golf, tennis, rock_climbing, running, cycling]).
ako1(baseball, [softball, hardball]).
ako1(football, [touch_football, flag_football, tackle_football]).
ako1(rock_climbing, [bouldering, sport_climbing, trad_climbing]).
ako1(cycling, [mountain_biking, road_racing]).
ako1(alcohol, [wine, beer]).
ako1(beer, [bud, miller, corona]).
ako1(wine, [merlot, chardonay]).
ako1(pizza, [pepperoni_pizza, cheese_pizza]).
ako1(movie, [drama_flic, comedy_flic, action_flic, scifi_flic]).
ako1(scifi_flic, ['Matrix', 'Terminator']).
ako1(action_flic, ['Matrix', 'Terminator', 'The Mummy']).
ako1(comedy_flic, ['Nurse Betty', 'Dumb and Dumber']).

%----------------------------------------------------------
% ako(ITEM, CATEGORY).
%
% Works just like isa(ITEM, CATEGORY),
% but uses the ako1 facts which are:
% ako1(CATEGORY, ITEM_LIST).
%
% HINT: you might call the variables in the recursive
% clause, ako1(Category, SubCategories), and them use
% member to pick a SubCat in SubCategories
%
%    You could make two recursive clauses,
%    depending on whether ITEM or
%    CATEGORY is a variable.  Not required.
%
% ?- ako(softball, baseball).
% yes
% ?- ako(X, baseball).
% X = softball;
% X = hardball;
% ?- ako(softball, X).
% X = baseball
%
% HINT: use member/2

member(A, [A|_]).
member(A, [_|Z]) :- member(A, Z).

check_member(A, [A|_]) :- !.
check_member(A, [_|Z]) :- check_member(A, Z).

%--------------------------------------------------
% akon(X, Y, N)
% Same, but with N being the count of degrees of
% separation
%
% ?- akon(softball, C, N).
% C = baseball
% N = 1 ;
% C = sport
% N = 3 ;
% C = team_sport
% N = 2 ;
% no
%
% Use an accumulator to count the layers of recursion,
% just like for finding the length of a list.

akon(Item, Cat, N) :-
   akon(Item, Cat, 1, N).


%-----------------------------------------------
% add some people and the things they like
%

person(bob, [girls, softball, golf, pizza, movies] ).
person(sally, [tackle_football, mountain_biking, 'Matrix']).
person(bill, [bud, 'Terminator']).
person(sue, [merlot, golf, 'Matrix']).
person(samantha, [pizza, parks, 'Terminator']).
person(al, [parks, golf, 'Nurse Betty']).
person(sabina, [merlot, tackle_football, 'The Mummy']).


%----------------------------------------------
% likes_same_thing(Person1, Person2, Thing).
% Two persons who share a common interest, where the
% interest might be a super category of an interest.
%
% ?- likes_same_thing(sue, al, C).
% C = golf
%
% ?- likes_same_thing(sue, P, I).
% 
% P = bob
% I = golf ;
% 
% P = sally
% I = 'Matrix' ;
% ...
%
% experiment with all binding combinations.
%
% It will help to write a helper predicate, match_item/2
% that looks for common matches in two lists of likes.
% match_item(+L1, +L2, -Item)
%
% ?- match_item([a, b, c], [d, a, r], X).
% X = a
%



%----------------------------------------------
% likes_same_category(Person1, Person2, Category).
% Two persons who share a common interest, where the
% interest might be a super category of an interest.
%
% ?- likes_same_category(sue, bill, C).
% C = alcohol
% 
% Add a new clause to match_cat/2 that finds elements
% that are both in the same category in each.
%
% ?- match_cat([golf, merlot], [bud, pizza], C).
% C = alcohol


%-------------------------------------------------------------
% likes_same_category(Person1, Person2, Category, Distance).
% same as above, but with fourth argument indication the
% degrees of separation.  Use an accumulator to count the
% levels of recursion.
%
% ?- likes_same_category(sue, bill, C, N).
% C = alcohol
% N = 3
%

%----------------------------------------------------------
% likes_list(Person1, List)
% List is a list of all the people Person1 might like, and
% the category.  Present them as Friend:Category
%
% HINT: use findall(F:C, ......



%--------------------------------------------------------
% likes_list_distance(Person, List)
% same as above, but also include the distance in the
% categories, use likes_same_category/4) and sort the results.
% Present
% the items as Distance - Friend:Category
%
% HINT: use findall(N - F:C, ....



%-----------------------------------------
% likes_best(Person, N - P2:Cat).
% use likes_same_category/4 to find all the people someone
% might like, and then use findall and keysort to find the
% best match for someone.
%
% uses findall and keysort to find the best match for a person.
%



% END OF DATING EXERCISES
%-----------------------------------------------------