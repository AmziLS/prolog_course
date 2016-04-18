%---------------------------

:- op(800, xfx, has).

processGD(_,[],[]) :- !.

processGD(GD,[HTripfare|RestTripfares],TripfareList) :-
  HTripfare has tripfare(fd_carrier:yy, globdir:GD),
  !,
  processGD(GD,RestTripfares,TripfareList).
processGD(GD,[HTripfare|RestTripfares],[HTripfare|TripfareList]) :-
  !,
  processGD(GD,RestTripfares,TripfareList).

TripFare has tripfare(A, B) :-
   chkmember(A, TripFare),
   chkmember(B, TripFare).
   
testfare( [
   [this:a, that:b, fd_carrier:yy, globdir:aa],
   [fd_carrier:ww, globdir:cc],
   [fd_carrier:zz, globdir:aa, more:44],
   [globdir:aa, fd_carrier:xx],
   [globdir:bb, fd_carrier:yy],
   [globdir:bb, fd_carrier:zz, lose_luggage:yes] ]).
   
test(GD) :-
   testfare(X),
   processGD(GD, X, Answer),
   write_list(Answer).

write_list([]) :- nl.
write_list([A|Z]) :-
   write(A), nl,
   write_list(Z).

chkmember(A, [A|_]) :- !.
chkmember(A, [_|Z]) :- chkmember(A,Z).
   
get_value(Property, Value, List) :-
   chkmember(Property:Value, List).
   
%-----------------------------------------------------

removeYYs([],[]) :- !.

removeYYs([HFare|RestFares],NewFaresList) :-
  HFare has tripfare(fd_carrier:yy), !,
  removeYYs(RestFares,NewFaresList).

removeYYs([HFare|RestFares],[HFare|NewFaresList]) :- !,
  removeYYs(RestFares,NewFaresList).

%--------------------------------------------------

check_acctravel(List) :-
  acctravelfindall(List,[]).

acctravelfindall(0,_).
acctravelfindall([],_).
acctravelfindall([Pax|T],PrevPsgrs) :-
  (T == 0 ->
     OtherPsgrs = PrevPsgrs
     ;
     append(T,PrevPsgrs,OtherPsgrs)
  ),
  check_pax_combinable([check(Pax,OtherPsgrs)]),
  acctravelfindall(T,[Pax|PrevPsgrs]).

check_pax_combinable([]).
check_pax_combinable([check(Pax,OtherPsgrs)|T]) :-
  check_combinable(Pax,OtherPsgrs),
  check_pax_combinable(T).

/**
  check_combinable/2. Succeeds if the one possiblefare is combinable
  with the possiblefares of the OtherPsgrs.
  Note that both fares' acc travel rules must be checked.
**/

check_combinable([],_OtherPsgrs) :- !.
check_combinable([H|T],OtherPsgrs) :- !,
  check_combinable(H,OtherPsgrs),
  check_combinable(T,OtherPsgrs).


check_numbers([]).
check_numbers([A|Z]) :-
   number(A),
   check_numbers(Z).