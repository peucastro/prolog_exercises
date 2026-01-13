-----  Exam Notes  -----

1st slide is useless (I hope)

-----  INTRODUCTION TO PROLOG  ----- {

    ------  Facts  ------
    Express a relation that is true. You can (kind of) interpret them as lines in a database table. For example:

        male(homer).        % homer is a male
        female(marge).      % marge is a female
        father(homer, bart).        % homer is the father of bart
        mother(marge, bart).        % marge is the mother of bart

    Statements end with a period, arguments between parenthses and separated by commas and the predicate (relation) names start with lowercase letter.

    -----  Rules  -----
    Allow for the deduction of new knowledge from existing kownledge (facts and other rules). Rules are exoressed in the form of Horn Clauses:

        Head :- Body
        grandfather(X, Y) :- father(X, Z), parent(Z, Y).        % X is the grandfather of Y
                                                                % if X is the father of Z
                                                                % and Z is the parent of Y

        % multiple definitions of a rule with the same head: rule one or rule two or ...
        parent(X, Y) :- father(X, Y).       % X is a parent of Y if X is the father of Y
        parent(X, Y) :- mother(X, Y).       % X is a parent of Y if X is the mother of Y

    The head of a rule can have 0 or more arguments
        parent(X, Y):- father(X, Y).        % X is a parent of Y if X is the father of Y
        father(X):- father(X, Y).           % X is a father if he is the father of some Y
        fathers:- father(X, Y).             % fathers is true if there is (at least one)
                                            % father/child relation

    -----  Disjunction  -----
    Disjunction can also be expressed with the ; operator. The disjunction operator (;) should be used sparingly. Always use parentheses to clarify

        parent(X, Y):- father(X, Y). % X is a parent of Y if X is the father of Y
        parent(X, Y):- mother(X, Y). % X is a parent of Y if X is the mother of Y
        % is equivalent to
        parent(X, Y):- father(X, Y) ; mother(X, Y).

    -----  Logic Table  -----
        Implication     A :- B      B -> A
        Conjunction     A , B       A ∧ B
        Disjunction     A ; B       A V B

    -----  Terms  -----
    Everything in Prolog is a term, which can be
        • Constant
        • Variable
        • Compound term

    -----  Constants  -----
    Constants represent elementary objects

    Numbers
        • Integers (e.g., 4, -8) (bases other than decimal can also be used, e.g., 8 755)
        • Floats (e.g., 1.5, -1.6) (also supports exponent, e.g., 23.4E-2)

    Atoms
        • Start with lower-case letter (e.g., john_doe, johnSmith42)
        • String within single quotes (e.g., 'John Doe', 'John Smith 42')

    -----  Variables  -----
    Variables act as placeholders for arbitrary terms
        • Start with a capital letter (e.g., Variable1)
        • Start with an underscore (e.g., _Var2)
        • Single underscore (_) (anonymous variable)

    Variables are universally instantiated in logic programs
        plus(0, S, S).          % 0 is the neutral element of addition
        mult(1, V, V).          % 1 is the neutral element of multiplication
        human(Homer).           % everything is human
        father(homer, Bart)     % homer is the father of everything
        grandfather(X, Y):- father(X, Z), parent(Z, Y).

    Variables occurring only in the body of a rule can be seen as existentially quantified. We need to be careful when using variables with facts.

    -----  Compound Terms  -----
    Atoms, numbers and variables are building blocks for compound terms Compound terms are comprised of a functor and arguments (which are terms)

        The functor is characterized by its name (an atom) and arity (the number of arguments), usually represented as name/arity

        E.g., point/2 represents a functor named point with two arguments
            point(4, 2) is a possible instance of point/2, and so is point(foo, point(3, bar))

    ----- Queries -----
    Computations in Prolog start with a question, which has two possible answers:
        Yes (possibly with answer substitution - variable binding)
        No

    The attempt to prove the question right/wrong (is it a consequence of the program?) produces the computations
        | ?- male(homer).               yes
        | ?- father(homer, bart).       yes
        | ?- female(marge).             yes
        | ?- father(marge, bart).       no

    ----- Variables in Queries -----
    Queries can include variables - Variables are existentially quantified in queries. A variable starting with an underscore is a "don't care"
        | ?- father(X, bart).           X = homer ?
                                        yes
        | ?- father(_X, bart).          yes
        | ?- male(_).                   yes
        | ?- male(X).                   X = homer ?
                                        yes
        | ?- male(X).                   X = homer ? ;
                                        X = bart ? n
                                        no
    If satisfied with the answer, just hit enter .If you want another answer, type "n", "no" or ";"

    ----- Variables and Compound Queries -----
    Queries can be more complex, combining goals. Variables are used to glue together the different goals - Underscore alone (_) is the exception
        | ?- male(X), parent(X, bart).          X = homer ? ;
                                                no
        | ?- male(_X), parent(_X, bart).        yes
        | ?- male(_X), parent(Y, bart).         Y = homer ? ;
                                                Y = marge ? ;
                                                Y = homer ? ;
                                                Y = marge ? ;
                                                no

    ----- Closed Word Assumption -----
    Assumption that everything that is true is known to be true (i.e., is represented as a clause in the program). Therefore, everything that cannot be deduced from the clauses in the program is assumed to be false.
        | ?- male(donald).      no
    Requires attention to make sure everything we want to deduce can be deduced from the program clauses

    ----- Horn Clauses -----
    Everything in Prolog is expressed as a Horn Clause
        Rules are complete horn clauses (head :- body)
        male(homer):- true.     <=>     male(homer).

    Facts are horn clauses where the body is always true (just the head)
        parent(X, Y):- father(X, Y).        <=>     father(X, Y) => parent(X, Y)

    Queries are horn clauses without a head (just the body)
        | ?- father(X, bart).

    ----- Predicates -----
    A predicate is a set of clauses for the same functor
        Clauses are either facts or rules - parent is a predicate with two clauses:
            parent(marge, bart).
            parent(homer, bart).

    Functors with the same name but different arity refer to different predicates
        father(X):- father(X, Y).       % X is a father
                                        % if X is the father of some Y

    ----- How Prolog Works -----
        Top to bottom - The order of clauses is important
        Left to right - In rules, prove sub-goals in left-to-right order
        With backtracking - If a sub-goal fails, go back to previous decision point

}

-----  UNIFICATION AND EXECUTION MODEL  ----- {

    ----- Substitution -----
    Recall everything in Prolog is a term. Terms can be either:
        • Ground - there are no variables in the term (completely instantiated)
        • Unground - there are variables in the term

    Unification is how Prolog matches two terms. Two terms are unifiable if
        • they are the same, or
        • they can be the same after variable substitution

    A substitution 𝜃 is a set of pairs Xi = ti where
        • Xi is a variable
        • ti is a term
        • Xi ≠ Xj for all i ≠ j
        • Xi does not occur in any tj, for all i and j

    To apply a substitution 𝜃 to a term T (T𝜃) is to replace in T all occurrences of Xi for ti, for all pairs Xi=ti in 𝜃
        T = father(X, bart)
        𝜃 = {X=homer}
        T𝜃 = father(homer, bart)

    A is said to be an instance of B if there is a substitution 𝜃 such that A = B𝜃
        father(homer, bart) is an instance of father(X, bart)

    A term T is a common instance of T1 and T2 if there are substitutions 𝜃1 and 𝜃2 such that T = T1𝜃1 and T = T2𝜃2
        parent(homer, bart) is a common instance of parent(X, bart) and parent(homer, Y)


    A term G is more general than term T if T is an instance of G but G is not an instance of T
        parent(X, bart) is more general than parent(homer, bart)

    A term V is a variant of a term T if they can be converted into one another by a simple variable renaming
        parent(Y, bart) is a variant of parent(X, bart)

    ----- Unification -----
    Given two atomic sentences, p and _q, a unification algorithm returns a substitution 𝜃 (the most general unifier) that makes them identical (or fails if such substitution does not exist):
        Unify(p, _q) = 𝜃 where p𝜃 = _q𝜃
    𝜃 is said to be the (most general) unifier of the two sentences

    The most general unifier (MGU) is the one that compromises the variables as little as possible - the respective instance is the most general
            Unify( parent(X, bart), parent(Y, Z) ) produces 𝜃 = { Y=X, Z=bart }

    Example: Unification of f(X, a) and f(b, Y)
        1. Push f(X,a) = f(b,Y)
        2. Pop → same functor f, arity 2 → push X = b and a = Y
        3. Pop a = Y → Y is variable and doesn't occur in a → add Y = a to θ
        4. Pop X = b → X is variable and doesn't occur in b → add X = b to θ
        5. Stack empty → return θ = {X = b, Y = a}

    Unification in Practice
    Both terms are constants: the terms unify if they are the same.
    One of the terms is a variable: it is instantiated to the other term.
    If both terms are variables, they are bound to each other.
    Two compound terms unify if:
        • They have the same functor and arity
        • All the corresponding arguments unify
        • All substitutions are compatible

    ----- Computation -----
    Program P composed of Clauses - Clauses are universally quantified logical sentences
        A:- B1, ..., Bk, k >= 0
        A and Bi are goals

    Computation of a Logic Program P:
        Find an instance of a given query Q logically deducible from P
        Query is an existentially quantified conjunction
            A1, ..., An, n > 0
            Ai are goals
        Goal: Atom or compound term

    Given a program P and an initial query Q, computation terminates:
        With success - (an instance of) Q was proven (Multiple successful computations (solutions) may exist)
        Without success - Q cannot be proven

    Computation may not terminate (no result) .Non-termination comes from recursive rules that may not end - Avoid left-recursive rules:

        ancestor(X, Y) :- ancestor(X, Z), parent(Z, Y).

        married(homer, marge).
        ...
        married(X, Y):- married(Y, X).

    Resolvent is a conjunctive question (query) with the set of goals still to be processed

    Trace is the evolution of the computation (sequence of resolvents) with information regarding:
        • Selected goal
        • Rule selected for reduction
        • Associated substitution

    Reduction is the replacement, in the resolvent, of a goal G with the body of a clause whose head unifies with G

    ----- Abstract Interpreter -----
    Abstract interpreter algorithm, given program P and query Q:

    Let resolvent be Q
    While resolvent is not empty do
        1. Choose a goal A from resolvent
        2. Choose a renamed clause B :- B1, ..., Bn from P such that A and B unify with an MGU 𝜃 (exit if no such goal and clause exist)
        3. Remove A from resolvent and add B1, ..., Bn to resolvent
        4. Apply 𝜃 to resolvent and to Q
    If resolvent is empty, return Q; else return failure

    ----- Execution Model -----
    An implementation of Logic Programming needs to instantiate the abstract interpreter, making choices that influence how the computation is performed
        • Choice of goal from resolvent
        • Choice of clause
        • Add goal(s) to resolvent
    Different languages / implementations may make different choices to implement the abstract interpreter

    Prologs implementation of the abstract interpreter
        • Choice of goal from resolvent: left to right
            Choice is arbitrary, does not affect computation (logical meaning, not operational)
        • Choice of clause: top to bottom with backtracking
            Choice affects computation
        • Add goal(s) to resolvent: at the beginning
            Results in a depth-first search
            If it were to be added to the end, it would result in a breadth-first search (assuming leftmost goal is chosen next)

    ----- Search Trees -----
    A search tree contains all possible search paths
        Root: Query Q
        Nodes: resolvents, with selected goal
        Edges: one edge for each clause in P whose head unifies with the selected goal in the source node - Includes substitution from the unification
        Leaves: success nodes, if empty resolvent; or fail nodes
        Paths from root to leaves: computation of Q using P

    Example:

    a :- b, c.
    b :- d.
    b :- e.
    c.
    e.
    | ?- a, e.

    Search Tree:

    (a, e) --> (b, c, e) --> (d, c, e) --> fail (d doesnt get resolved)
                         --> (e, c, e) --> (c, e) --> (e) --> success!

    It is independent of the clause selection criteria (it contains all alternatives). There can be different search trees for the same query and program, depending on the goal selection criteria. The number of success nodes is the same in all trees.

    Contains all answers
        it is named search tree because a concrete interpreter needs a strategy to traverse the tree searching for solutions
        Depth-first search, breadth-first search, parallel search, ...

}

-----  RECURSION AND ARITHMETIC  ----- {

    ----- Recursion -----
    Recursion is based on the inductive proof One or more base clauses and one or more recursion clauses

        ancestor(X, Y):-            % X is an ancestor of Y
            parent(X, Y).           % if X is a parent of Y

        ancestor(X, Y):-            % X is an ancestor of Y
            parent(X, Z),           % if X is a parent of Z
            ancestor(Z, Y).         % and Z is an ancestor of Y

    The order of clauses and goals may influence performance, or even cause infinite computations

        sumN(0, 0).                 % Base clause
        sumN(N, Sum):- N > 0,       % Guard - make sure we dont
            N1 is N-1,              % have infinite recursion
            sumN(N1, Sum1),         % Recursive call
            Sum is Sum1 + N.

    ----- Tail Recursion -----
    Tail Recursion can increase efficiency. Add a new argument to the predicate: the accumulator. Make the recursive call the last call
        sumN(N, Sum):- sumN(N, Sum, 0).         % Encapsulate
        sumN(0, Sum, Sum).                      % Base case - the result is
        sumN(N, Sum, Acc):- N > 0,              % in the accumulator
        N1 is N-1,
        Acc1 is Acc + N,
        sumN(N1, Sum, Acc1).                    % Recursive call is now the last sub-goal
    To increase efficiency, we actually need to add a cut in the base clause

    ----- Arithmetic -----
    Arithmetic expressions are not evaluated immediately
        Example: A = 4+2 unifies A with the term +(4, 2), not the value 6
    The _is_ predicate can be used to evaluate an arithmetic expression - The right-side of is needs to be instantiated

    Examples:
        | ?- A = 4 + 2.             A = 4+2 ?
                                    yes
        | ?- B is 4 + 2.            B = 6 ?
                                    yes
        | ?- 6 is 4 + 2.            yes
        | ?- 4+2 is 4+2.            No
        | ?- C is 4+B.              ! Instation error in argument 2 of (is)/2
                                    ! goal: _419 is 4+_427

    Arithmetic expressions can be compared for (in)equality
        Expr1 =:= Expr2 evaluates both expressions and if they are equal
        Expr1 =\= Expr2 evaluates both expressions and if they are different
        Comparison
            E1 < E2     E1 > E2     E1 =< E2    E1 >= E2
    Prolog can also compare and order terms
            T1 @< T2    T1 @> T2    T1 @=< T2   T1 @>= T2
        Term1 == Term2 verifies whether the two terms are literally identical
        Term1 \== Term2 checks if the two terms are not literally identical

    There are several functions available
        X + Y, X - Y, X * Y, X / Y (float quotient)
        X // Y is the integer quotient, truncated towards 0
        X div Y is the integer quotient (rounded down)
        X rem Y is integer remainder: X - Y * (X // Y)
        X mod Y is integer remainder: X - Y * (X div Y)

    Examples:
        | ?- A is 5 // 2.           A = 2 ?
                                    yes
        | ?- A is .5 // 2.          A = -2 ?
                                    yes
        | ?- A is 5 div 2.          A = 2 ?
                                    yes
        | ?- A is -5 div 2.         A = -3 ?
                                    yes
        | ?- A is 5 rem 2.          A = 1 ?
                                    yes
        | ?- A is -5 rem 2.         A = -1 ?
                                    yes
        | ?- A is 5 mod 2.          A = 1 ?
                                    yes
        | ?- A is -5 mod 2.         A = 1 ?
                                    yes

}

-----  LISTS  ----- {

    ----- Lists -----
    Lists are the quintessential data structure in Prolog. Empty list represented as [ ]. Elements separated by commas within square brackets
        [a, b, c]
        [4, 8, 15, 16, 23, 42]
    Lists elements can be anything, including other lists
        [ 1, [a, b, v], g, [2, [D, y], 3], 4 ]

    The internal representation uses the . functor and two arguments - the head and tail of the list
        [1, 2, 3] = .(1, .(2, .(3, []) ) ).
        | ?- A = .(1, .(2, .(3, []) ) ).        A = [1, 2, 3] ?
                                                yes

    Strings are a representation of lists of character ASCII codes
        | ?- A = "Hello".                       A = [72, 101, 108, 108, 111] ?
                                                yes

    Easily separate the head of the list from the rest of the list - the head of the list can separate more than one element
        [ H | T ]               % where T is a list with the remaining elements of the list
        [ 4 ] = [ 4 | [ ] ]     % tail of list with one element is empty list
        [4, 8, 15, 16, 23, 42] = [4 | [8, 15, 16, 23, 42] ]
        [4, 8, 15, 16, 23, 42] = [ 4, 8 | [ 15, 16, 23, 42] ]

    Definition of what is a list
        An empty list                               is_list( [ ] ).
        A list construct where tail is a list       is_list( [H|T] ):- is_list(T).

    ----- The Mystical Four List Functions - SLAM! -----
    sort(+L, -L1) : sorts list L and put it in list L1. removes duplicates
    Recursive implementation:
        /do this before test/

    length(?L, ?N) : puts length of l in n
    Recursive implementation:
        length( [ ], 0 ).
        length( [_|T], L ):-
            length(T, L1),
            L is L1+1.

    append(?L1, ?L2, ?L) : the same as haskell ++ l1 is the first list, l2 is the second, l is the output list
    Recursive implementation:
        append( [ ], L2, L2 ).
        append( [H|T], L2, [H|T3] ):-
            append(T, L2, T3).

    member(?E,?L) : is element e in list l? can be used as for to iterate through the list (make e a variable)
    Recursive implementation
        member( X, [X|_] ).
        member( X, [_|T] ):-
            member(X, T).

        memberchk( X, [X|_] ).
        memberchk( X, [Y|T] ):-
            X \= Y,
            memberchk(X, T).

    +   -   Instantiated Variable
    -   -   Non-Instantiated Variable (will be unified)
    ?   -   Hybrid variable (can be instantiated or not)

    ----- Lists library -----

    nth0(?Pos, ?List, ?Elem) / nth1(?Pos, ?List, ?Elem)
    nth0(?Pos, ?List, ?Elem, ?Rest) / nth1(?Pos, ?List, ?Elem, ?Rest)
    Predicate                   Indexing starts at      Example
    nth0(Index, List, Elem)     0 (zero-based)          nth0(0, [a,b,c], X). % X = a
    nth1(Index, List, Elem)     1 (one-based)           nth1(1, [a,b,c], X). % X = a

    Form                            Meaning                         Example
    nth0(I, L, E)                   Get element E at position I     nth0(2,[a,b,c,d],X). % X=c
    nth1(I, L, E)                   Same using 1-based index        nth1(4,[a,b,c,d],X). % X=d
    nth0(I, L, E)                   with E known Find index I       nth0(I,[a,b,c],b). % I=1
    nth0(Index, List, Elem, Rest)   Get element and list without    nth0(2,[a,b,c,d],X,R).
                                    it (delete elem.)               % X=c, R=[a,b,d]
    nth0(Index, List, Elem, Rest)   Add an element                  nth0(2,X,c,[a,b,d]).
                                                                    % X=[a,b,c,d]
    nth0(Index, List, Elem, Rest)   Replace an element              nth0(1,[a,b,c],X,R),
                                                                    nth0(1,S,f,R).
                                                                    % X=b, R=[a,c], S=[a,f,c]

    select(?X, ?XList, ?Y, ?YList)
        finds an occurrence of X in XList, replaces it with Y, and produces YList

    delete(+List, +ToDel, -R)
    delete(+List, +ToDel, +Count, -R)
        Deletes Count occurrences of ToDel in List, result R

    last(?Init, ?Last, ?List)
        Last element of List and the rest in Init

    segment(?List, ?Segment)
        succeed when Segment is a contiguous subsequence of List.

    sublist(+List, ?Part, ?Before, ?Length, ?After)
        extract a contiguous Part of List with Length size and Before/After pre/suffix

    append(+ListOfLists, -List)
        concate of Haskell

    reverse(?List, ?Reversed)

    rotate_list(+Amount, ?List, ?Rotated)
        cyclically shifts (rotates) List by Amount number of positions

    transpose(?Matrix, ?Transposed)
        converts rows into columns (and vice-versa)

    remove_dups(+List, ?PrunedList)

    permutation(?List, ?Permutation)
        List permutations, with backtracking

    sumlist(+ListOfNumbers, ?Sum)
    max_member(?Max, +List)
    min_member(?Min, +List)
    max_member(:Comp, ?Max, +List)
        Comp is a comparison predicate of arity 2 used to compare elements
    min_member(:Comp, ?Min, +List)

    maplist(:Pred, +L) / maplist(:Pr, +L1, ?L2) / maplist(:Pr, +L1, ?L2, ?L3)
        Applies predicate to each element / map / zipWith

    map_product(:Pred, +Xs, +Ys, ?List)
        Cartesian product

    scanlist(:Pred, +Xs, ?Start, ?Final)
        foldl

    cumlist(:Pred, +Xs, ?Start, ?List)
        Similar to accumulate in python

    some(:Pred, +List)
        any

    include(:P, +X, ?L) / include(:P, +X, +Y, ?L) / include(:P, +X, +Y, +Z, ?L)
        filter / P(x, y) succeeds, L ⊆ X / P(x, y, z) succeeds, L ⊆ X

    exclude(:P, +X, ?L) / exclude(:P, +X,+Y, ?L) / exclude(:P, +X,+Y,+Z, ?L)
        not include

    group(:Pred, +List, ?Front, ?Back)
        Group until predicate fails, splitting the list at that point

}

-----  NON-LOGICAL FEATURES  ----- {

    ----- Cuts -----
    backtracking in Prolog can lead to some inefficiency. Branches that to no feasible solution are still explored. Soultion: cut (!)

    Always succeeds as a goal (can be ignored in a declarative reading). Binds Prolog to all choices made since the parent goal unified with the clause where the cut is. This prunes all clauses for the same predicate below the one where the cut is and all alternative solutions to the goals left of the cut in the clause, but does not prune the goals to the right of the cut in the clause. these can produce several solutions via backtracking, however,backtracking to the cut fails and causes backtracking to the last choice point.

    Example:
        a(X, Y) :- b(X), !, b(Y)
        a(3, 4).
        b(2).
        b(3).

        | ?- a(X, Y).
        X = 2,
        Y = 2 ? ;
        X = 2,
        Y = 3 ? ;
        no

    sumN with cut:
        sumN(N, Sum) :- sumN(N, Sum, 0).
        sumN(0, Sum, Sum) :- !.

        sumN(N, Sum, Acc) :- N > 0,
                             N1 is N-1
                             Acc1 is Acc + N,
                             sumN(N1, Sum, Acc1).

    ----- Red Cuts Vs. Green Cuts -----
    Red cut is one that influences the results. If we remove the cut, the results will be different.
    a(A, B) :- b(A), !, b(B).           a(A, B) :- b(A), b(B)
    a(3, 4).                            a(3, 4).
    b(2).                               b(2).
    b(3).                               b(3).

    | ?- a(X, Y).                       | ?- a(X, Y).
    X = 2,                              X = 2,
    Y = 2 ? ;                           Y = 2 ? ;
    X = 2,                              X = 2,
    Y = 3 ? ;                           Y = 3 ? ;
    no                                  X = 3,
                                        Y = 2 ? ;
                                        X = 3,
                                        Y = 3 ? ;
                                        X = 3,
                                        Y = 4 ? ;
                                        no

    Green cut is one that does not influence results, but is used to incresase efficiency. If we remove the cuts, the results will be the same, but Prolog will explore branches that wont lead to any possible solution.
    classify(BMI, "low weight"):- BMI < 18.5, !.
    classify(BMI, "normal weight"):- BMI >= 18.5, BMI < 25, !.
    classify(BMI, "excessive weight"):- BMI >= 25, BMI < 30, !.
    classify(BMI, "obesity"):- BMI >= 30, !.

    ----- Negation as Failure -----
    Negation can be attained by using a cut.
    not(X) :- X, !, fail
    not(_X).
    Fail always fails. The cut is necessary to ensure the second clause is not reached when backtracking.

    Negation should be used with ground terms (no variables in the goal), or "strange" results may occur. Example: determine if a man is not a father
        not_a_father(X):- not(parent(X, _)), male(X).

    Works well with instantiated values, but what about with a variable?
        not_a_father(bart).         not_a_father(X).
        yes                         no

    Change the order of the goals so that variables in the negated goal are ground (possibly instantiated by other goals in the clause)
        not_a_father(X):- male(X), not(parent(X, _)).

    ----- Conditional as Failure -----
    We can attain a conditional execution by using two clauses with a mutually exclusive condition verification
        pred_ite(If, Then, _Else):- If, Then.
        pred_ite(If, _Then, Else):- not(If), Else.

    Conditional execution can also be attained by using a cut
        if_then_else(If, Then, _Else):- If, !, Then.
        if_then_else(_If, _Then, Else):- Else.

    ----- Input/Output -----
    Input / Output is based on streams, used either for reading or writing, in text (characters and terms) or binary (bytes) mode. At any one time there is one current input stream and one current output stream (by default the users terminal). I/O predicates operate on the corresponding current stream. All predicates support additional parameter (as the first one) specifying the stream to read from / write to

    Input and output cannot be undone, but variable binding (from input predicates) is undone when backtracking

    • read/1 reads a term (by default, from the standard input)
        Input needs to end with a period (spans multiple lines)
        If a compound term is being read, input must match term being read
        Use unnamed variables (_X)
    • write/1 writes a term
    • nl/0 prints a new line
    • get_char obtains a single character
    • get_code obtains the ASCII code of a single character
    • put_char prints a single character
    • put_code prints a single character given its ASCII code
    • char_code(?Atom, ?Code) allows converting between character and corresponding ASCII code
    • get_byte and put_byte read and write binary data
    • peek_char, peek_code and peek_byte obtain a single character / code / byte without consuming it from the input stream
    • format prints terms with specified formatting options
    • skip_line skips any input until the end of the line - It is OS independent

    ----- File Input/Output -----
    There are some useful predicates to work with files
    • see/1 opens a file for reading -The file is used for reading instead of the standard input
    • seen/0 closes the file that was opened for reading
    • tell/1 opens a file for writing - The file is used for writing instead of the standard output
    • told/0 closes the file that was opened for writing
    Other predicates exist to open, manage and close streams

    ----- Libraries -----
    Several directives can be used to import files
        use_module(library(lib_name)) % for libraries or modules
        consult(file_to_load)
        [file_to_load]
        ensure_loaded(file_to_load)
        include(file_to_include)

    Repeat
    repeat always succeeds. Can be used to repeat some portion of code until it succeeds. It may be useful to use a cut after reaching the condition to break the cycle, to avoid undesired backtracking
        read_value(X):-
            repeat,
            write("write hello"),
            read(X),
            X = hello.

    Between
    between(+Lower, +Upper, ?Number) can be used both to test and generate integers between given bounds. Necessary to include the between library
        | ?- between(1, 6, 4).
        yes
        | ?- between(1, 6, 9).
        no
        | ?- between(1, 3, X).
        X = 1 ? ;
        X = 2 ? ;
        X = 3 ? ;
        no
    Hint: you can use repeat together with between to test for valid coordinate input in the practical assignment

    Random
    Random library provides several predicates for generating random numbers
        maybe / maybe(+Probability)
        random(+Lower, +Upper, -Value)
        random_member(-Element, +List)
        random_select(?Element, ?List, ?Rest)
        random_permutation(?List, ?Permutation)

}

-----  GRAPHS AND TREES  ----- {

    ----- Collecting Solutions -----
    Prolog provides three predicates to obtain multiple solutions to a query: findall, bagof, and setof. They allow systematic collection of answers to any goal. The template is similar to all three predicates. Returns the list List of all instances of Term such that Goal is provable. Goal specifies a goal to be called. List is a list of terms
        findall/bagof/setof(?Term, :Goal, -List).

    ----- findall -----
    findall finds all solutions, including repetitions if present. If there are no solutions, an empty list is returned
        | ?- findall(Child, parent(homer, Child), Children).
        Children = [lisa, bart, maggie] ? ;
        no
        | ?- findall(Parent, parent(Parent, _Child), List).
        List = [homer,homer,homer,marge,marge,marge] ? ;
        no
        | ?- findall(Child, parent(bart, Child), List).
        List = [] ? ;
        no

    We can use a conjunctive goal (parentheses are required)
        | ?- findall(C, ( parent(homer, C), female(C) ), Daughters).
        Daughters = [lisa, maggie] ? ;
        no
    We can obtain more than one variable using a compound term
        | ?- findall(Parent-Child, parent(Parent, Child), L).
        L = [homer-lisa, homer-bart, homer-maggie, marge-lisa, ...] ? ;
        no
    If all we want is a count, we can use anything
        | ?- findall(_, parent(homer, _C), _L), length(_L, N).
        N = 3 ? ;
        no

    ----- bagof -----
    bagof has similar behavior, but results are grouped by variables appearing in Goal but not in the search Term
        | ?- findall(Child, parent(Parent, Child), Children).
        Children = [lisa, bart, maggie, lisa, bart, maggie] ? ;
        no
        | ?- bagof(Child, parent(Parent, Child), Children).
        Parent = homer, Children = [lisa, bart, maggie] ? ;
        Parent = marge, Children = [lisa, bart, maggie] ? ;
        no
    While findall returns an empty list if there are no results, bagof fails
        | ?- findall(Child, parent(bart, Child), L).
        L = [] ? ;
        no
        | ?- bagof(Child, parent(bart, Child), L).
        no

    We can direct bagof to ignore additional variables in Goal by using existential quantifiers: Var^Goal. If all variables appearing in Goal but not in the search Term are existentially quantified, then bagof behaves like findall
        | ?- bagof(Child, parent(Parent, Child), Children).
        Parent = homer, Children = [lisa, bart, maggie] ? ;
        Parent = marge, Children = [lisa, bart, maggie] ? ;
        no
        | ?- bagof(Child, Parent^parent(Parent, Child), Children).
        Children = [lisa, bart, maggie, lisa, bart, maggie] ? ;
        no

    ----- setof -----
    setof has similar behavior to bagof, but results are ordered and without repetitions.
        | ?- bagof(Child, parent(Parent, Child), Children).
        Parent = homer, Children = [lisa, bart, maggie] ? ;
        Parent = marge, Children = [lisa, bart, maggie] ? ;
        no
        | ?- setof(Child, parent(Parent, Child), Children).
        Parent = homer, Children = [bart, lisa, maggie] ? ;
        Parent = marge, Children = [bart, lisa, maggie] ? ;
        no
    Existential quantifiers can also be used with setof, with the same effect as with bagof (results will remain ordered and without repeats). If all variables in Goal but not in search Term are existentially quantified, then setof behaves like findall followed by sort
        | ?- bagof(Child, Parent^parent(Parent, Child), Children).
        Children = [lisa, bart, maggie, lisa, bart, maggie] ? ;
        no
        | ?- setof(Child, Parent^parent(Parent, Child), Children).
        Children = [bart, lisa, maggie] ? ;
        no

    ----- Graphs and Searches -----
    Graphs can be represented as the connections between nodes - set of facts representing [directed] edges. Searching for a possible connection between nodes is made easy by Prologs standard depth-first search mechanism
        connected(porto, lisbon).
        connected(lisbon, madrid).
        connected(lisbon, paris).
        connected(lisbon, porto).
        connected(madrid, paris).
        connected(madrid, lisbon).
        connected(paris, madrid).
        connected(paris, lisbon).

        ---- DFS ----
        connects_dfs(F, F, _Path).
        connects_dfs(S, F, T):-
            connected(S, N),
            not( memberchk(N, T) ),
            connects_dfs(N, F, [N|T]).

        connects_dfs(S, F):-
            connects_dfs(S, F, [S]).

        dfs([C2 | _], C2, [C2]).
        dfs([Ca | T], C2, [Ca | Trajectory]) :-
            borders(Ca, L),
            member(Cb-_, L),
            \+ member(Cb, T),
            dfs([Cb, Ca | T], C2, Trajectory).

        trajectory(C1, C2, Trajectory) :-
            dfs([C1], C2, Trajectory).

        ---- BFS ----
        connects_bfs(S, F):-
            connects_bfs([S], F, []).
        connects_bfs([F|_], F, _V).
        connects_bfs([S|R], F, V):-
            findall(
                N,
                ( connected(S, N),
                not(memberchk(N, V)),
                not(memberchk(N, [S|R]))),
                L),
            append(R, L, NR),
            connects_bfs(NR, F, [S|V]).

    ----- Binary trees -----
    A binary tree can be recursively defined using node elements. Empty node represented as null. Other nodes as node(Value, Left, Right)
        binary_tree(null).
        binary_tree( node(Value, Left, Right) ):-
            binary_tree(Left),
            binary_tree(Right).

    Tree operations are easily implemented from this definition
    Check if value is a member of the tree
        tree_member(Val, node(Val, _L, _R) ).
        tree_member(Val, node(V, L, _R) ):-
            [Val < V,] tree_member(Val, L).
        tree_member(Val, node(V, _L, R) ):-
            [Val > V,] tree_member(Val, R).
    List all tree elements (in-order traversal)s
        tree_list( null, [] ).
        tree_list( node(Val, L, R), List ):-
            tree_list(L, Left),
            tree_list(R, Right),
            append(Left, [Val|Right], List).
    Verify if tree is ordered
        tree_is_ordered(Tree):-
            tree_list(Tree, List),
            sort(List, List).
    Insert an element into the tree
        tree_insert( null, V, node(V, null, null) ).
        tree_insert( node(V, L, R), V, node(V, L, R) ).
        tree_insert( node(V, L, R), Val, node(V, NL, R) ):-
            Val < V, tree_insert( L, Val, NL).
        tree_insert( node(V, L, R), Val, node(V, L, NR) ):-
            Val > V, tree_insert( R, Val, NR).
    Determine the height of the tree
        tree_height( null, 0).
        tree_height( node(Val, L, R), H):-
            tree_height(L, HL),
            tree_height(R, HR),
            H is 1 + max(HL, HR).
    Check whether the tree is balanced
        tree_is_balanced( null ).
        tree_is_balanced( node(Val, L, R) ):-
            tree_is_balanced(L),
            tree_is_balanced(R),
            tree_height(L, HL),
            tree_height(R, HR),
            abs(HL-HR) =< 1.

    ----- Games and Puzzles -----
    A generic [abstract] solver to one-person games/puzzles
        initial(InitialState).

        final(State):- winning_condition(State).

        move(OldState, NewState):- valid_move(OldState, NewState).

        play(CurrSt, Path, Path):- final(CurrSt), !.
        play(CurrSt, Path, States):- move(CurrSt, Next),
                not( member(Next, Path) ),
                play(Next, [Next|Path], States).

        play:- initial(Init),
                play(Init, [Init], States),
                reverse(States, Plays),
                write(Plays).

    Example: fill a 5-gallon jug with 4 gallons of water, using the 5-gallon jug and a 3-gallon jug
        initial(0-0). % Jug5-Jug3
        final(4-_).
        move(_-S, 5-S). % fill jug 1
        move(F-_, F-3). % fill jug 2
        move(_-S, 0-S). % empty jug 1
        move(F-_, F-0). % empty jug 2
        move(F-S, NF-NS):- NF is max(0, F+S-3), NS is min(3, F+S). % 1->2
        move(F-S, NF-NS):- NF is min(5, F+S), NS is max(0, F+S-5). % 2->1

    Shortest Path
    To find the smallest set of plays we just need to find all paths and select the shortest one - Easily accomplished using setof
        play:-  initial(Init),
                setof(
                    Length-Path,
                    ( play(Init, [Init], Path),
                    length(Path, Length) ),
                    [_ShortestLength-States|_]
                ),
                reverse(States, Path),
                write(Path).

}

-----  META-PROGRAMMING AND OPERATORS  ----- {

    ----- Meta-Programming -----
    Prolog has some meta-logical predicates for type checking
        integer(A)      A is an integer
        float(A)        A is a floating point number
        number(A)       A is a number (integer or float)
        atom(A)         A is an atom
        atomic(A)       A is an atom or a number
        compound(A)     A is a compound term
        var(A)          A is a variable (it is not instantiated)
        nonvar(A)       A is an atom, a number or a compound term
        ground(A)       A is nonvar, and all substructures are nonvar

    These predicates can be very useful to implement different versions of predicates depending on variable instantiation.
        grandparent(X, Y):- nonvar(Y), !, parent(Z, Y), parent(X, Z).
        grandparent(X, Y):- parent(X, Z), parent(Z, Y).
    We can think of an implementation of the sum/3 predicate that tests for instantiation, using a more appropriate definition in each case
        sum(A, B, S):- number(A), number(B), !, S is A + B.
        sum(A, B, S):- number(A), number(S), !, B is S - A.
        sum(A, B, S):- number(B), number(S), !, A is S - B.
    Other predicates allow access to terms and their arguments / to construct new terms
    functor(+Term, ?Name, ?Arity) or functor(?Term, +Name, +Arity)
        If Term is instantiated, returns the name and arity of the term
        If Term is not instantiated, creates a new term with given name and arity
        process_term(Term, Result) :-
            functor(Term, F, _Arity),
            dispatch(F, Term, Result).

        dispatch(sum, sum(A,B), R) :- R is A + B.
        dispatch(diff, diff(A,B), R) :- R is A - B.
        dispatch(neg, neg(X), R) :- R is -X.
        dispatch(const, const(C), C).

        | ?- process_term(sum(2,3), R).
        R = 5.

    arg(+Index, +Term, ?Arg) -Given an index and a term, instantiates Arg with the argument in the Nth position (index starts in 1)
        | ?- arg(2, paretn(homer, bart), Arg).
        Arg = bart ?
        yes

    +Term =.. ?[Name | Args] or ?Term =.. +[Name | Args] - Given a term, returns a list with the name and arguments of the term. Given a proper list, creates a new term with name and arguments as specified by the contents of the list
        | ?- paretn(homer, bart) =.. List.
        List = [parent,homer,bart] ?
        yes
        | ?- Term =.. [parent, homer, bart].
        Term = parent(homer,bart) ?
        yes

    The call/1 predicate calls (executes) a given goal
        | ?- C = write("Hello World!"), call(C).
        Hello World!
        C = write("Hello World!") ?
        yes
        | ?- C = write("Hello World!"), c.
        Hello World!
        C = write("Hello World!") ?
        yes
        | ?- G =.. [write, "Hi there!"], G.
        Hi there!
        G = write("Hi there!") ?
        yes
    In this example, C is a meta-variable - it repreents a callable goal. callable/1 verifies if a term is callable. call/1 can be used with up to 255 arguments, in which case the first term is extended with the remaning arguments. The first argument has to instantiated, this has a similar effect to using univ to construct the term to call.

    ----- Operators -----
    Prolog allows for the definition of new operators. We can easily change the way we write programs:
        homer likes marge.
        marge likes homer.
        homer and marge parented bart.
        homer and marge parented lisa.
    Operators are characterized by precedence and associativity.
    Precedence determines which operation is executed first. The lower, the more priority the operator has. Precedence in Prolog is given by a number between 1 and 1200 - Multiplication has precedence level 400 and Addition has precedence level 500
    Associativity determines how to associate operations. Division is left-associative, while ^ is right associative.

    The op/3 predicate can be used to specify new operators.
        op(+Precedence, +Type, +Name).
        Precedence is a number between 1 and 1200
        Type defines the type and associativity of the operator.
            Prefix - fx or fy           f defines the position of the operator
            Postfix - xf or yf          x and y represent the operands
            Infix - xfx, xfy or yfx     x means non-associative and y means side-associate

    Built-in operators:
        :- op(1200, xfx, [ :-, --> ]).
        :- op(1200, fx, [:-, ?- ]).
        :- op(1150, fx, [mode, public, dynamic, volatile, discontiguous, multifile, block, meta_predicate, initialization]).
        :- op(1100, xfy, [;, do]).
        :- op(1050, xfy, [ -> ]).
        :- op(1000, xfy, [ ',' ]).
        :- op(900, fy, [\+, spy, nospy]).
        :- op(700, xfx, [=, \=, is, =.., ==, \==, @<, @>, @=<, @>=, =:=, =\=, <, >, =<, >=]).
        :- op(550, xfy, [:]).
        :- op(500, yfx, [+, -, \, /\, \/]).
        :- op(400, yfx, [*, /, //, div, mod, rem, <.<, >>]). (no point betwen <)
        :- op(200, xfx, [**]).
        :- op(200, xfy, [ ^ ]).
        :- op(200, fy, [+, -, \]).

    Example:
        :-op(400, xfx, parented).
        :-op(380, xfy, and).

        X and Y parented Z:-
            bagof(S,
                ( parent(X, S),
                parent(Y, S), X@<Y), L),
                as_list(L, Z).

        as_list([A, B|T], A and R):- !,
            as_list([B|T], R).
        as_list([A], A).

    ----- Computaional Models -----
    Emulate DFAs/NFAs (rules - initial(qi). / final(qf). / delta(q1, 0/1, q2).)
        accept(Str):-
            initial(State),
            accept(Str, State).
        accept([], State):-
            final(State).
        accept([S|Ss], State):-
            delta(State, S, NState),
            accept(Ss, NState)

    Emulate PDAs (rules - initial(qi). / final(qf). / delta(q1, A, B, q2, C). - A, B/C)
        accept(Str):- initial(State), accept(Str, State, []).
        accept([], State, []):- final(State).
        accept([S|Ss], State, Stack):-
            delta(State, S, Stack, NewState, NewStack),
            accept(Ss, NewState, NewStack).

    Emulate TM (rules - initial(qi). / final(qf). / delta(q1, L, [1/0|R], q2, [1/0|L], R).)
        tm(Str):- initial(State),
            append(Str, [empty], StrEmpty),
            tm([empty], StrEmpty, State).
        tm(Left, [S|Right], State):-
            delta(State, Left, [S|Right], NewState, NewLeft, NewRight),!,
            tm(NewLeft, NewRight, NewState).
        tm(_, _, State):- final(State).

    Emulate CFGs (rules - S --> empty / S --> X / S --> XSX)
        accept(Str):- ss(Str).
        ss([]).
        ss([X]).
        ss([X|SX]):- append(S, [X], SX), ss(S).
    The definition of CFGs can be simplified using DCGs (Definite Clause Grammars). It uses a syntax similar to the specification of grammar rules. It can be used both to recognize and to generate strings.
        pal --> [].
        pal --> [_].
        pal --> [S], pal, [S].
    Verifications can be made as extensions to the grammar rules
        palb --> [].
        palb --> [S], {[S] = "0"; [S]="1"}.
        palb --> [S], palb, [S], {[S] = "0"; [S]="1"}.
    More complex rules can be used
        expr(Z) --> term(X), "+", expr(Y), {Z is X + Y}.
        expr(X) --> term(X).
        term(Z) --> num(X), "*", term(Y), {Z is X * Y}.
        term(Z) --> num(Z).
        num(X) --> [D], num(R), {"0"=<D, D=<"9", X is (D-"0")*10 + R}.
        num(X) --> [D], {"0"=<D, D=<"9", X is D-"0"}.

    ----- Incomplete Data Structures -----
    Incomplete data structures increase efficiency by allowing 'partial' or 'incomplete' structures to be specified and incrementally constructed during runtime. This is achieved by maintaining a free variable as the final element of the structure, as opposed to a constant (such as [] for lists or null). Changes to the incomplete structure can be made by [partially] instantiating the ending variable, thus not requiring the use of an extra output argument.

    Implementation of a dictionary using incomplete lists. When Key is present, Value is verified/returned. When Key is not present, the new Key-Value pair is added to the dictionary
        lookup(Key, [ Key-Value | Dic ], Value).
        lookup(Key, [ K-V | Dic ], Value):-
            Key \= K,
            lookup(Key, Dic, Value).
    Dictionary implemented with incomplete binary search tree
        lookup(Key, dtnode(Key-Value, _L, _R), Value).
        lookup(Key, dtnode(K-_V, L, _R), Value):-
            Key < K, lookup(Key, L, Value).
        lookup(Key, dtnode(K-_V, _L, R), Value):-
            Key > K, lookup(Key, R, Value).

    Difference Lists
    While lists are widely used, some common operations may not be very efficient, as is the case of appending two lists. Linear on the size of the first list. Idea: increase efficiency by 'also keeping a pointer to the end of the list'. This is accomplished by using difference lists. We can use any symbol to separate the two parts of the difference list. With this representation, we can have an incomplete list (when the second list is not instantiated)
        X = [1, 2, 3]
        X = [1, 2, 3, 4, 5, 6]\[4, 5, 6]
        X = [1, 2, 3, a, b, c]\[a, b, c]
        X = [1, 2, 3]\[]
        X = [1, 2, 3 | T]\T
    We can now append two (difference) lists in constant time. To append X\Y with Z\W, simply unify Y with Z. Note that the two lists must be compatible - the tail of the first list must either be uninstantiated or be equal to the second list
        append_dl(X\Y, Y\W, X\W).
        | ?- append_dl( [a, b, c | Y ]\Y, [d, e, f | W]\W, A).
        Y=[d,e,f|W]
        A=[a,b,c,d,e,f|W]\W

    ----- SICStus Libraries -----
    aggregate - library provides operators for SQL-like queries. Results can be aggregated using sum, count, min, max, ...

    clpfd - library provides one of the best constraint programming solvers and library for integers. Very good for puzzles, and combinatorial optimization problems
        schedule(Ss, End):-
            length(Ss, 7), domain(Ss, 1, 30),
            length(Es, 7), domain(Es, 1, 50),
            buildTasks(Ss, [16,6,13,7,5,18,4], Es, [2,9,3,7,10,1,11], Tasks),
            maximum(End, Es),
            cumulative(Tasks, [limit(13)]),
            labeling([minimize(End)], [End|Ss]).
        buildTasks([], [], [], [], []).
        buildTasks([S|Ss], [D|Ds], [E|Es], [C|Cs], [task(S, D, E, C, 0)|Ts]):-
            buildTasks(Ss, Ds, Es, Cs, Ts).

}

-----  PRATICAL CLASS 0 - Prolog and SICStus Basics  ----- {

    ----- Useful commands -----
    Some SICStus commands
        halt.                       Exit Prolog
        [file].                     Load a program from file file.pl
        consult('file.pl').         Same as [file].
        reconsult('file.pl').       Reload file after edits
        listing.                    Show all loaded facts and rules
        trace.                      Start trace mode
        notrace.                    Stop trace mode

        ?-                          Prompt for a query
        .                           Ends the query
        ;                           Ask for the next solution
        no.                         No solutions found
        Error message               Problem in query or program syntax

}

-----  PRATICAL CLASS 1 - knowledge Representation in Prolog  ----- {

    -----  1.- Family relations  -----
    c) write new rules that allow you to define more complex family relations, such as father/2, grandparent/2, grandmother/2, siblings/2, halfsiblings/2, cousins/2, uncle/2
        % father(?Father, ?Child).
        father(P, C) :- parent(P, C), male(P).
        % grandparent(?Grandparent,?GrandChild).
        grandparent(G,GChild):- parent(G,Parent), parent(Parent,GChild).
        % mother(?Mother,?Child).
        mother(P,C):- female(P), parent(P,C).
        % grandmother(?Grandmother,?GrandChild).
        grandmother(G,GChild):- mother(G,P), parent(P,GChild).
        % siblings(?OneSibling,?AnotherSibling).
        siblings(A,B):- parent(P1,A), parent(P1,B), parent(P2,A), parent(P2,B), P1 @< P2, A \= B.
        % halfsiblings(?OneHalfSibling,?AnotherHalfSibling).
        halfsiblings(A,B):- parent(P,A), parent(P,B), A \= B, \+siblings(A,B).
        % cousins(?OneCousin,?AnotherCousin).
        cousins(A,B):- grandparent(G,A), grandparent(G,B), A \= B.
        % uncle(?Uncle,?NephewNiece).
        uncle(A,B):- siblings(A,P), male(A), parent(P,B).
        % aunt(?Aunt,?NephewNiece).
        aunt(A,B):- siblings(A,P), female(A), parent(P,B).
        % first_alphabetical_child(?P,?C): The child of P whose names comes first alphabetically is C.
        first_alphabetical_child(P,C):- parent(P,C), \+((parent(P,C1), C1 @< C)).
        % has_exactly_1_child(?P): P has exactly one child.
        has_exactly_1_child(P):- parent(P,C), \+((parent(P,C1), C \= C1)).
        % has_exactly_2_children(?P): P has exactly two children.
        has_exactly_2_children(P):- parent(P,C1), parent(P,C2), C1 @< C2, \+((parent(P,C3), C3 \= C1, C3 \= C2)).
        % has_2plus_children(?P): P has at least two children.
        has_2plus_children(P):- parent(P,C1), parent(P,C2), C1 @< C2, \+((parent(P,C3), C3 \= C1, C3 @< C2)).

    e) What predicates would you use to represent information regarding marriages and divorces? How would you represent Jay and Glorias marriage in 2008, or Jay and Dedes marriage in 1968 and respective divorce in 2003?
        % married(Husband,Wife,Year).
        married(jay,gloria,2008).
        married(jay,dede,1968).
        % divorced(Husband,Wife,Year).
        divorced(jay,dede,2003).
        % currently_married(?Husband,?Wife,+Year).
        currently_married(H,W,Y):-
            married(H,W,Y1),
            Y >= Y1,
            \+divorced(H,W,_).          % underscore (_) means "don't care"
        currently_married(H,W,Y):-
            married(H,W,Y1),
            Y >= Y1,
            divorced(H,W,Y2),
            Y =< Y2.

    -----  2.- Teachers and Students  -----
    a) represent the table information
        teaches(course, professor).
        attends(course, student).

    c) make prolog rules
    is X a student of professor X?
        is_student(Student, Professor) :-
            attends(Course, Student), teaches(Course, Professor).
    student of both professor X and Y
        both(Student, ProfX, ProfY) :-
            teaches(A, ProfX),
            attends(A, Student),
            teaches(B, ProfY),
            attends(B, Student),
            ProfX \= ProfY.
    Who is colleagues with whom? (two students are colleagues if they attend at least one course in common; two teachers are colleagues)
        colleagues(X, Y) :-
            attends(A, X),
            attends(A, Y),
            X @< Y.
        colleagues(X, Y) :-
            teaches(_, X),
            teaches(_, Y),
            X @< Y.
    Who are the students that attend more than one course?
        more_course(X) :-
            attends(A, X),
            attends(B, X),
            A \= B.

    -----  3.- Red Bull Air Race  -----
    % i. Who won the race in Porto?
    winned(X, porto).

    % ii. What team won the race in Porto?
    winned(_P, porto), team(_P, X).

    % iii. Which circuits have nine gates?
    gates(X, 9).

    % iv. Which pilots do not fly an Edge540?
    drives(X, _C), _C \= edge540.

    % v. Which pilots have won more than one circuit?
    winned(X, _C1), winned(X, _C2), _C1 \= _C2.

    -----  5.- Jobs and Bosses  -----
    % i. Is X a direct supervisor of Y?
    supervises(X, Y) :- job(_R1, X), job(_R2, Y), supervised_by(_R2, _R1).

    % ii. Are X and Y supervised by people with the same job?
    same_supervisor_job(X, Y) :- job(_JX, X), job(_JY, Y), supervised_by(_JX, R), supervised_by(_JY, R), X \= Y.

    % iii. Is X responsible for supervising more than one job?
    supervises_more_than_one_job(X) :- job(_J, X), supervised_by(_R1, _J), supervised_by(_R2, _J), _R1 \= _R2.

    % iv. Is X a supervisor of Ys supervisor?
    supervises_supervisor(X, Y) :- job(_J1, X), job(_J2, Y), supervised_by(_J2, _S), supervised_by(_S, _J1), _J1 \= _J2.


}

-----  PRATICAL CLASS 2 - Recursion  ----- {

    -----  1.- Prolog and backtracking  -----
    r(a, b).        p(b, c).
    r(a, d).        p(b, d).
    r(b, a).        p(c, c).
    r(a, c).        p(d, e).
        i. r(X, Y), p(Y, Z).
        ii. p(Y, Y), r(X, Y).
        iii. r(X, Y), p(Y, Y).
    b) How many times does Prolog backtrack from the second to the first goal before producing the first answer for each of the queries?
        i. 0 backtrack (r(a, b) -> p(b, c))
        ii. 0 backtrack (p(c, c) -> r(a, b))
        iii. 3 backtracks (r(a, b) -> p(b, c) / r(a, b) -> p(b, d) / r(a, b) -> p(c, c) / r(a, b) -> p(d, e))

    -----  2.- backtracking and Search tree  -----
    Search Tree for all solutions, caling trace. pairs(X, Y).:
        pairs(X, Y) :- d(X), q(Y).
        pairs(X, X) :- u(X).
        u(1).
        d(2).
        d(4).
        q(4).
        q(16).
    pairs(X, Y) --> X = 2 --> Y = 4     (2, 4)
                          --> Y = 16    (2, 16)
                --> X = 4 --> Y = 4     (4, 4)
                          --> Y = 16    (4, 16)
    pairs(X, X) --> X = 1               (1, 1)

    -----  4.- Recursion  -----
    a) factorial(+N, -F)
        factorial(0,1).
        factorial(N,F):-
            N >= 1,
            N1 is N-1,
            factorial(N1,F1),
            F is F1 * N.
    b) sum_rec(+N, -Sum)
        sum_rec(0, 0).
        sum_rec(N, Sum) :-
            N > 0,
            N1 is N-1,
            sum_rec(N1, Sum1),
            Sum is Sum1+N.
    c) pow_rec(+X, +Y, -P)
        pow_rec(_, 0, 1).
        pow_rec(X, Y, P) :-
            Y > 0,
            Y1 is Y - 1,
            pow_rec(X, Y1, P1),
            P is P1 * X.
    d) square_rec(+N, -S)
        square_rec(N, S) :- square_acc(N, 1, 0, S).
        square_acc(0, _, Acc, Acc).
        square_acc(N, Odd, Acc, S) :-
            N > 0,
            Acc1 is Acc + Odd,
            Odd1 is Odd + 2,
            N1 is N - 1,
            square_acc(N1, Odd1, Acc1, S).
    e) fibonacci(+N, -F).
        fibonacci(0,0).
        fibonacci(1,1).
        fibonacci(N,F):-
            N >= 2,
            N1 is N-1,
            fibonacci(N1,F1),
            N2 is N1-1,
            fibonacci(N2,F2),
            F is F1 + F2.
    f) colatz(+N, -S)
        collatz(1, 0).
        collatz(N, S) :-
            N > 1,
            0 is N mod 2,
            N1 is N // 2,
            collatz(N1, S1),
            S is S1 + 1.
        collatz(N, S) :-
            N > 1,
            1 is N mod 2,
            N1 is 3*N + 1,
            collatz(N1, S1),
            S is S1 + 1.
    g) is_prime(+X)
        is_prime(2).
        is_prime(X) :-
            X > 2,
            X mod 2 =\= 0,
            check_prime(X, X - 1).
        check_prime(_, 1).
        check_prime(X, D) :-
            D > 1,
            X mod D =\= 0,
            D1 is D - 1,
            check_prime(X, D1).

    -----  5.- Tail Recursion  -----
    a) factorial_tailrec(+N, -F)
        factorial_tailrec(N,F):-
            factorial_tailrec_aux(N,1,F).
        factorial_tailrec_aux(0,Acc,Acc).
        factorial_tailrec_aux(N,Acc,F):-
            N >= 1,
            N1 is N - 1,
            Acc1 is Acc * N,
            factorial_tailrec_aux(N1,Acc1,F).
    b) sum_tailrec(+N, -Sum)
        sum_tailrec(N, Sum) :-
            sum_tailrec_aux(N, 0, Sum).
        sum_tailrec_aux(0, Acc, Acc).
        sum_tailrec_aux(N, Acc, Sum) :-
            N > 0,
            N1 is N - 1,
            Acc1 is Acc + N,
            sum_tailrec_aux(N1, Acc1, Sum).
    c) pow_tailrec(+X, +Y, -P)
        pow_tailrec(X, Y, P) :-
            pow_tailrec_aux(X, Y, 1, P).
        pow_tailrec_aux(_, 0, Acc, Acc).
        pow_tailrec_aux(X, Y, Acc, P) :-
            Y > 0,
            Acc1 is Acc * X,
            Y1 is Y - 1,
            pow_tailrec_aux(X, Y1, Acc1, P).
    e) fibonacci_tailrec(+N, ?F).
        fibonacci_tailrec(0,0).
        fibonacci_tailrec(N,F):-
            fibonacci_tailrec_aux(N,0,1,F).
        fibonacci_tailrec_aux(1,_,F,F).
        fibonacci_tailrec_aux(N,F1,F2,F):-
            N >= 2,
            N1 is N-1,
            F3 is F1 + F2,
            fibonacci_tailrec_aux(N1,F2,F3,F).

    -----  6.- Greatest Common Divisor and Least Common Multiple  -----
    a) gcd(+X, +Y, -G)
        gcd(X, 0, X) :- X > 0.
        gcd(X, Y, G) :-
            Y > 0,
            R is X mod Y,
            gcd(Y, R, G).
    b) lcm(+X, +Y, -M)
        lcm(X, Y, M) :-
            X > 0,
            Y > 0,
            gcd(X, Y, G),
            M is X * Y // G.

    -----  7.- Family Relations Revisited  -----
    a) ancestor_of(?X, ?Y)
        ancestor_of(X, Y) :- parent(X, Y).
        ancestor_of(X, Y) :- parent(X, Z), ancestor_of(Z, Y).
    b) descendant_of(?X, ?Y)
        descendant_of(X, Y) :- parent(Y, X).
        descendant_of(X, Y) :- parent(Y, Z), descendant_of(X, Z).
    c) marriage_years(?X, ?Y, -Years)
        marriage_years(X, Y, Years) :-
            married(X, Y, MarriedYear),
            divorced(X, Y, DivorcedYear),
            Years is DivorcedYear - MarriedYear.
    e)
        i) before(+X, +Y)
            before(X, Y) :- X < Y.
        ii) older(?X, ?Y, ?Older)
            older(X, Y, X) :- born(X, DX), born(Y, DY), before(DX, DY).
            older(X, Y, Y) :- born(X, DX), born(Y, DY), before(DY, DX).
        iii) oldest(?X)
            oldest(X) :- born(X, DX), \+ (born(Y, DY), before(DY, DX)).
}

-----  PRATICAL CLASS 3 - Lists  ----- {

    -----  1.- Lists  -----
    a) | ?- [a | [b, c, d] ] = [a, b, c, d].
        yes
    b) | ?- [a | b, c, d ] = [a, b, c, d].
        sintactic error, tail needs to be inside []
    c) | ?- [a | [b | [c, d] ] ] = [a, b, c, d].
        yes
    d) | ?- [H|T] = [pfl, lbaw, fsi, ipc].
        H = pfl, T = [lbaw, fsi, ipc]
    e) | ?- [H|T] = [lbaw, ltw].
        H = lbaw, T = [ltw]
    f) | ?- [H|T] = [leic].
        H = leic, T = []
    g) | ?- [H|T] = [].
        no, H needs to be an element, cant be empty list
    h) | ?- [H|T] = [leic, [pfl, ipc, lbaw, fsi] ].
        H = leic, T = [[pfl, ipc, lbaw, fsi]]
    i) | ?- [H|T] = [leic, Two].
        H = leic, T = [Two]
    j) | ?- [Inst, feup] = [gram, LEIC].
        Inst = gram, LEIC = feup
    k) | ?- [One, Two | Tail] = [1, 2, 3, 4].
        One = 1, Two = 2, Tail = [3,4]
    l) | ?- [One, Two | Tail] = [leic | Rest].
        One = leic, Rest = [Two | Tail]

    -----  2.- Recursion Over Lists  -----
    % a) Implement list_size(+List, ?Size), which determines the size of List.
    list_size_aux([], Acc, Acc).
    list_size_aux([_ | T], Acc, Size) :- Acc1 is Acc + 1, list_size_aux(T, Acc1, Size).

    list_size(List, Size) :- list_size_aux(List, 0, Size).

    % b) Implement list_sum(+List, ?Sum), which sums the values contained in List (assumed to be a proper list of numbers).
    list_sum_aux([], Acc, Acc).
    list_sum_aux([X | Xs], Acc, Sum) :- Acc1 is Acc + X, list_sum_aux(Xs, Acc1, Sum).

    list_sum(List, Sum) :- list_sum_aux(List, 0, Sum).

    % c) Implement list_prod(+List, ?Prod), which multiplies the values in List (assumed to be a proper list of numbers).
    list_prod_aux([], Acc, Acc).
    list_prod_aux([X | Xs], Acc, Prod) :- Acc1 is Acc * X, list_prod_aux(Xs, Acc1, Prod).

    list_prod([X | Xs], Prod) :- list_prod_aux(Xs, X, Prod).

    % d) Implement inner_product(+List1, +List2, ?Result), which determines the inner product of two vectors (represented as lists of integers, of the same size).
    inner_product_aux([], [], Acc, Acc).
    inner_product_aux([X | Xs], [Y | Ys], Acc, Result) :- Acc1 is Acc + X * Y, inner_product_aux(Xs, Ys, Acc1, Result).

    inner_product(List1, List2, Result) :- inner_product_aux(List1, List2, 0, Result).

    % e) Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List.
    count_aux(_, [], Acc, Acc).
    count_aux(Elem, [X | Xs], Acc, N) :- X == Elem, Acc1 is Acc + 1, count_aux(Elem, Xs, Acc1, N).
    count_aux(Elem, [X | Xs], Acc, N) :- X \== Elem, count_aux(Elem, Xs, Acc, N).

    count(Elem, List, N) :- count_aux(Elem, List, 0, N).

    -----  3.- List Manipulation  -----
    % a) Implement invert(+List1, ?List2), which inverts list List1.
    invert_aux([], Acc, Acc).
    invert_aux([X | Xs], Acc, List2) :- invert_aux(Xs, [X | Acc], List2).

    invert(List1, List2) :- invert_aux(List1, [], List2).

    % b) Implement del_one(+Elem, +List1, ?List2), which deletes the first occurrence of Elem from List1, resulting in List2.
    del_one(_, [], []).
    del_one(Elem, [Elem | Xs], Xs).
    del_one(Elem, [X | Xs], [X | List2]) :- X \= Elem, del_one(Elem, Xs, List2).

    % c) Implement del_all(+Elem, +List1, ?List2), which deletes all occurrences of Elem from List1, resulting in List2.
    del_all(_, [], []).
    del_all(Elem, [Elem | Xs], List2) :- del_all(Elem, Xs, List2).
    del_all(Elem, [X | Xs], [X | List2]) :- X \== Elem, del_all(Elem, Xs, List2).

    % d) Implement del_all_list(+ListElems, +List1, ?List2), which deletes from List1 all occurrences of all elements of ListElems, resulting in List2.
    del_all_list([], List1, List1).
    del_all_list([Target | ListElems], List1, List2) :- del_all(Target, List1, TempList), del_all_list(ListElems, TempList, List2).

    % e) Implement del_dups(+List1, ?List2), which eliminates repeated values from List1.
    del_dups_aux([], _, []).
    del_dups_aux([X | Xs], Acc, List2) :- memberchk(X, Acc), del_dups_aux(Xs, Acc, List2).
    del_dups_aux([X | Xs], Acc, [X | List2]) :- \+ memberchk(X, Acc), del_dups_aux(Xs, [X | Acc], List2).

    del_dups(List1, List2) :- del_dups_aux(List1, [], List2).

    % g) Implement replicate(+Amount, +Elem, ?List) which generates a list with Amount repetitions of Elem.
    replicate(0, _, []).
    replicate(Amount, Elem, [Elem | List]) :- Amount > 0, Amount1 is Amount - 1, replicate(Amount1, Elem, List).

    % h) Implement intersperse(+Elem, +List1, ?List2), which intersperses Elem between the elements of List1, resulting in List2.
    intersperse(_, [], []).
    intersperse(_, [X], [X]) :- !.
    intersperse(Elem, [X | Xs], [X, Elem | List2]) :- intersperse(Elem, Xs, List2).

    % i) Implement insert_elem(+Index, +List1, +Elem, ?List2), which inserts Elem into List1 at position Index, resulting in List2.
    insert_elem(0, [], X, [X]).
    insert_elem(0, List1, Elem, [Elem | List1]).
    insert_elem(Index, [X | Xs], Elem, [X | List2]) :- Index > 0, Index1 is Index - 1, insert_elem(Index1, Xs, Elem, List2).

    % j) Implement delete_elem(+Index, +List1, ?Elem, ?List2), which removes the element at position Index from List1 (which is unified with Elem), resulting in List2.
    delete_elem(0, [X | Xs], X, Xs).
    delete_elem(Index, [X | Xs], Elem, [X | List2]) :- Index > 0, Index1 is Index - 1, delete_elem(Index1, Xs, Elem, List2).

    % k) Implement replace(+List1, +Index, ?Old, +New, ?List2), which replaces the Old element, located at position Index in List1, by New, resulting in List2.
    replace([X | Xs], 0, X, New, [New | Xs]).
    replace([X | Xs], Index, Old, New, [X | List2]) :- Index > 0, Index1 is Index - 1, replace(Xs, Index1, Old, New, List2).

    -----  4.- Append, The Powerful  -----
    % a) Implement list_append(?L1, ?L2, ?L3), where L3 is the concatenation of lists L1 and L2.
    list_append([], L2, L2).
    list_append([X | Xs], L2, [X | L3]) :- list_append(Xs, L2, L3).

    % b) Implement list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once.
    list_member(Elem, List) :- append(_, [Elem | _], List).

    % c) Implement list_last(+List, ?Last), which unifies Last with the last element of List, using solely the append predicate exactly once.
    list_last(List, Last) :- append(_, [Last], List).

    % d) Implement list_nth(?N, ?List, ?Elem), which unifies Elem with the Nth element of List, using only the append and length predicates.
    list_nth(N, List, Elem) :- append(Prefix, [Elem | _], List), length(Prefix, N).

    % e) Implement list_append(+ListOfLists, ?List), which appends a list of lists.
    list_append([], []).
    list_append([[] | ListOfLists], List) :- list_append(ListOfLists, List).
    list_append([[X | Xs] | ListOfLists], [X | List]) :- list_append([Xs | ListOfLists], List).

    % f) Implement list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, unifying the result with Res, using only the append predicate twice.
    list_del(List, Elem, Res) :- append(Prefix, [Elem | Suffix], List), append(Prefix, Suffix, Res).

    % g) Implement list_before(?First, ?Second, ?List), which succeeds if the first two arguments are members of List, and First occurs before Second, using only the append predicate twice.
    list_before(First, Second, List) :- append(_, [First | Suffix], List), append(_, [Second | _], Suffix).

    % h) Implement list_replace_one(+X, +Y, +List1, ?List2), which replaces one occurrence of X in List1 by Y, resulting in List2, using only the append predicate twice.
    list_replace_one(X, Y, List1, List2) :- append(Prefix, [X | Suffix], List1), append(Prefix, [Y | Suffix], List2).

    % i) Implement list_repeated(+X, +List), which succeeds if X occurs repeatedly (at least twice) in List, using only the append predicate twice.
    list_repeated(X, List) :- append(_, [X | Suffix], List), append(_, [X | _], Suffix).

    % j) Implement list_slice(+List1, +Index, +Size, ?List2), which extracts a slide of size Size from List1 starting at index Index, resulting in List2, using only the append and length predicates.
    list_slice(List, Index, Size, List2) :- append(Prefix, Suffix, List), length(Prefix, Index), append(List2, _, Suffix), length(List2, Size).

    % k) Implement list_shift_rotate(+List1, +N, ?List2), which rotates List1 by N elements to the left, resulting in List2, using only the append and length predicates.

    list_shift_rotate(List1, N, List2) :- length(Prefix, N), append(Prefix, Suffix, List1), append(Suffix, Prefix, List2).

}

-----  Exame 2023  ----- {

    Consider the following knowledge base about the Pasta & Flour Lounge (PFL) restaurant.. Each dish/3 fact contains a dishs name, the price for which it is sold in the restaurant, and a list with the quantity of each ingredient needed to produce it (each ingredient appears only once on the list). For instance, to produce a pizza, which is sold for 2200 cents, 300g of cheese and 350g of tomato are needed. Each ingredient/2 fact contains an ingredients name and unit cost (i.e., how many cents are required to buy 1 gram).
        % dish(Name, Price, IngredientGrams).
        dish(pizza, 2200, [cheese-300, tomato-350]).
        dish(ratatouille, 2200, [tomato-70, eggplant-150, garlic-50]).
        dish(garlic_bread, 1600, [cheese-50, garlic-200]).
        :- dynamic ingredient/2.
        % ingredient(Name, CostPerGram).
        ingredient(cheese, 4).
        ingredient(tomato, 2).
        ingredient(eggplant, 7).
        ingredient(garlic, 6).

    Implement count_ingredients(?Dish, ?NumIngredients), which determines how many different ingredients are needed to produce a dish.
        count_ingredients(Dish, NumIngredients):-
            dish(Dish, _, Ingredients),
            length(Ingredients, NumIngredients).

    Implement ingredient_amount_cost(?Ingredient, +Grams, ?TotalCost), which determines the total cost (in cents) of buying a certain amount (in grams) of an ingredient.
        ingredient_amount_cost(Ingredient, Grams, TotalCost):-
            ingredient(Ingredient, CostPerGram),
            TotalCost is CostPerGram*Grams.

    Implement dish_profit(?Dish, ?Profit), which determines the profit of selling a dish in the restaurant. A dishs profit is the difference between its price and the combined cost of its ingredients.
        getIngredientsCost([], TotalIngredientCost, TotalIngredientCost).
        getIngredientsCost([Ingredient-Grams|Ingredients], Aux,TotalIngredientCost):-
            ingredient_amount_cost(Ingredient, Grams, Price),
            NewAux is Aux+Price,
            getIngredientsCost(Ingredients, NewAux, TotalIngredientCost).
        dish_profit(Dish, Profit):-
            dish(Dish, TotalCost, Ingredients),
            getIngredientsCost(Ingredients, 0, TotalCost),
            Profit is Price - TotalCost.

    Implement update_unit_cost(+Ingredient, +NewUnitCost), which modifies the knowledge base by updating the unit cost of an ingredient. If the ingredient does not exist, it should be added to the knowledge base. The predicate must always succeed.
        update_unit_cost(Ingredient, NewUnitCost):-
            retractall(ingredient(Ingredient, _)),
            assert(ingredient(Ingredient, NewUnitCost)).

}

-----  Exame 2024  ----- {

    Consider the following knowledge base regarding books and authors.
        %author(AuthorID, Name, YearOfBirth, CountryOfBirth).
        %book(Title, AuthorID, YearOfRelease, Pages, Genres).

    Implement book_author(?Title, ?Author), which associates a book title with the name of its author.
        book_author(Title, Author):-
            author(AuthID, Author, _YoB, _CoB),
            book(Title, AuthID, _YoP, _Pages, _Genres).

    Implement multi_genre_book(?Title), which unifies Title with the title of a book that has multiple genres.
        multi_genre_book(Title):- book(Title, _AuthID, _Year, _Pages, [_One, _Two | _Rest]).
        multi_genre_book(Title):-
            book(Title, _AuthID, _Year, _Pages, Genres),
            length(Genres, Len), % length is a built-in predicate
            Len > 1.
        multi_genre_book(Title):-
            book(Title, _AuthID, _Year, _Pages, Genres),
            member(A, Genres), % member is a built-in predicate
            member(B, Genres), % member is a built-in predicate
            A \= B.

    Implement shared_genres(?Title1, ?Title2, CommonGenres), which receives two book titles as arguments and returns on the third argument a list containing the genres that are common to both books. Any order of the shared genres is valid.
        shared_genres(Title1, Title2, CommonGenres):-
            book(Title1, _ID1, _Year1, _Pages1, Genres1),
            book(Title2, _ID2, _Year2, _Pages2, Genres2),
            common_elements(Genres1, Genres2, CommonGenres).
        common_elements([], _L, []).
        common_elements([H|T], L, [H|R]):-
            member(H, L), !,
            common_elements(T, L, R).
        common_elements([_|T], L, R):-
            common_elements(T, L, R).

    The Jaccard coefficient, also known as intersection over union IoU, is a similarity measurement between two sets, determined by the division between the intersection (number of common elements between the two sets) and the union (total number of different elements in both sets). Implement the similarity(?Title1, ?Title2, ?Similarity) predicate, which determines the Jaccard coefficient between the two books received as first two arguments, considering the genres of each book as the measure of similarity
        similarity(Title1, Title2, Similarity):-
            shared_genres(Title1, Title2, Intersection),
            book(Title1, _ID1, _Year1, _Pages1, Genres1),
            book(Title2, _ID2, _Year2, _Pages2, Genres2),
            union(Genres1, Genres2, Union),
            length(Intersection, LI),
            length(Union, LU),
            Similarity is LI / LU.
        union(Set1, Set2, UnionSet):-
            append(Set1, Set2, All),
            sort(All, UnionSet).

    The Passionate Fans of Literature PFL Book Club instituted a Secret Santa for Christmas. In a draw of luck, each member of the club was assigned another member for whom to buy a gift. Being a book club, everyone bought a book, and the full information was registered after the PFL Christmas Dinner in the following database:
        % gives_gift_to(Giver, Gift, Receiver)
    Implement circle_size(+Person, ?Size), which unifies the second argument with the number of people who form the circle of gifts that includes the person received as first argument.
        circle_size(Person, Size):-
            collect([Person], People),
            length(People, Size).
        collect( [H|T], People):-
            gives_gift_to(H, _, N),
            \+ member(N, [H|T]), !,
            collect( [N,H|T], People).
        collect(People, People).

    Implement largest_circle(?People), which unifies People with the list of people belonging to the largest circle in the book club. The order of the people in the list is not important. In case there is more than one circle with the largest dimension, the predicate should succeed more than once. The order of the results is not important.
        :-use_module(library(lists)).
        largest_circle(People):-
            all_people(Everyone),
            setof(Size-Person-Sorted, Persons^(member(Person, Everyone), collect([Person], Persons), sort(Persons, Sorted),
        length(Sorted, Size)), Triples),
            last(Triples, MaxSize-_-_),
            setof(Persons, P^member(MaxSize-P-Persons, Triples), LargestGroups),
            member(People, LargestGroups).
        all_people(List):-
            findall(X, (gives_gift_to(X, _, _) ; gives_gift_to(_, _, X)), Temp),
            sort(Temp, List).

    Implement dec2bin(+Dec, -BinList, +N), which converts a non-negative integer number Dec into a list of bits representing that number, using exactly N bits. If the number of bits is insufficient to represent the number, the predicate should fail. If the number to convert is negative, the predicate should fail.
        dec2bin(Dec, List, N):-
            Dec >= 0,
            dec2bin(Dec, [], List, N).
        dec2bin(0, List, List, 0):- !.
        dec2bin(Dec, Acc, List, N):-
            N > 0,
            Bit is Dec mod 2,
            Next is Dec div 2,
            N1 is N - 1,
            dec2bin(Next, [Bit|Acc], List, N1).

    Implement initialize(+DecNumber, -Bits, +Padding, -List), which receives a decimal number and number of bits in which to represent it, as well as Padding - the number of zeroes to place on each side of the resulting binary representation - returning in List the resulting list of bits.
        initialize(Dec, N, Padd, List):-
            dec2bin(Dec, Mid, N),
            dec2bin(0, Side, Padd),
            append([Side, Mid, Side], List).

    Implement print_generation(+List), which prints to the terminal a text representation of a list of bits, representing 0 as a dot ('.'), 1 as a capital M ()'M'), and separating each byte (set of 8 bits) with a pipe ('|').
        print_line(0, []):- !,
            write('|'), nl.
        print_line(_, []):- !, nl.
        print_line(0, Bits):- !,
            write('|'),
            print_line(8, Bits).
        print_line(N, [Bit|Bits]):-
            N1 is N-1,
            translate(Bit, Char),
            put_char(Char),
            print_line(N1, Bits).
        translate(0, '.').
        translate(1, 'M').
        print_generation(L):-
            write('|'),
            print_line(8, L).

    The rules for updating each cell from one generation to the next consider the state of the left neighbor, the cell itself, and the right neighbor. For each of the eight possible combinations, the rule(?Config, ?State) predicate gives the resulting cell state, where the first argument is a three-bit configuration represented as a compound term Left-Self-Right, and the second argument is the resulting state bit. Implement update_rule(+Rule), which receives a number between 0 and 255, and changes the knowledge base so that exactly eight rule/2 facts exist. This predicate should always succeed, except in case it receives a value outside the expected range of values
        update_rule(N):-
            \+ (dec2bin(N, Bits, 8)), !, fail.
        update_rule(N):-
            dec2bin(N, Bits, 8),
            abolish(rule/2),
            between(0, 1, FirstBit),
            between(0, 1, SecondBit),
            between(0, 1, ThirdBit),
            Index is 8 - (FirstBit * 4 + SecondBit * 2 + ThirdBit),
            nth1(Index, Bits, Bit),
            assert( rule(FirstBit-SecondBit-ThirdBit, Bit) ),
            fail.
        update_rule(_).

    Implement next_gen(+Previous, Next), which receives a list of binary values and computes the next generation, applying the existing rules to each position. Missing neighbors (for the first and last elements) are assumed to be zeroes.
        next_gen(Gen0, Gen1):-
            apply_rules(0, Gen0, Gen1).
        apply_rules(Left, [Self], [New]):-
            rule(Left-Self-0, New).
        apply_rules(Left, [Self, Right | Rest], [New | Tail]):-
            rule(Left-Self-Right, New),
            apply_rules(Self, [Right|Rest], Tail).

    Implement play(+DecNumber, Bits, Padding, Rule, N, which receives the input values for the initialize/4 predicate (DecNumber, Bits, and Padding), the input value for the update_rule/1 predicate (Rule), and N, the number of generations to simulate. This predicate should orchestrate the calls to existing predicates and print the first N generations to the terminal. Note that a call to play/5 with N  1 results in printing the initial generation only
        play(Init, N, Padd, Rule, Gens):-
            initialize(Init, N, Padd, Gen0),
            update_rule(Rule),
        play_gens(Gens, Gen0).
            play_gens(1, Gen):- !,
        print_generation(Gen).
            play_gens(N, Gen0):-
            N1 is N -1,
            print_generation(Gen0),
            next_gen(Gen0, Gen1),
            play_gens(N1, Gen1).
}
