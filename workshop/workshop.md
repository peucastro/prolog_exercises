# Prolog Workshop

## Code Smells

do not use

```pl
;
==
=
->
```

## if-then-else

"if a execute b. otherwise, execute c."

```pl
p :- a, !, b.
p :- c.
```

## Documentation

* `+`: input
* `-`: output
* `?`: hybrid

```pl
% is_grandchild(?X, ?Y)
% This rule checks if X is a grandchild of Y
is_grandchild(X, Y):-
    father(Y, _Z),
    father(_Z, X).
```

## Lists

### Useful Predicates (SLAM)

* `Sort`
* `Length`
* `Append`
* `Member`
