:- module(english).

sentence(s(S,V,O)) --> subject(S), verb(V), object(O).

subject(sb(M,N)) -->  modifier(M),  noun(N).

object(ob(M,N)) -->  modifier(M),  noun(N).

modifier(m(the)) --> [the].

noun(n(dog)) --> [dog].
noun(n(cow)) --> [cow].

verb(v(chases)) --> [chases].
verb(v(eats)) --> [eats].

:- end_module(english).