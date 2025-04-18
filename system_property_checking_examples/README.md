# Introduction

This directory contains examples of using maude to perform system property checking, with different search techniques. 

Note that the examples in different subsections are **independent** from each other.

## Explicit State Model Checking
An example of QLOCK protocol is implemented as a maude module. Launch maude with the module loaded

```
maude qlock.maude
```

Search for violation of mutual exclusion in QLOCK.

```
Maude> search init(7) =>* {S < U | W | C i j | Q >} .
search in QLOCK : init(7) =>* {S < U | W | i j C | Q >} .

No solution.
states: 74272  rewrites: 295241 in 220ms cpu (225ms real) (1339131 rewrites/second)
```

Search deadlock states in QLOCK (meaning the violation of deadlock freedom).

```
Maude> search init(7) =>! X:State .
search in QLOCK : init(7) =>! X:State . 

No solution.
states: 74272  rewrites: 295241 in 192ms cpu (196ms real) (1531388 rewrites/second)    
```

## Dekker's Algorithm Checked in PARALLEL Language
PARALLEL is a simple concurrent imperative language. Dekker's algorithm was the earliest solution to the mutual exclusion problem.

Launch maude while loading the PARALLEL language module with a module implementing Dekker's algorithm.

```
maude parallel.maude dekker.maude
```

Search for violation of mutex.
```
Maude> search initial =>* {S | [1,crit1 ; R] | [2,crit2 ; P],M} .
search in DEKKER : initial =>* {S | [1, crit1 ; R] | [2, crit2 ; P], M} .

No solution.
states: 152  rewrites: 982 in 1ms cpu (2ms real) (531385 rewrites/second)
```

Search for violation of deadlock freedom.

```
Maude> search initial =>! MS:MachineState .
search in DEKKER : initial =>! MS:MachineState .

No solution.                           
states: 152  rewrites: 982 in 1ms cpu (1ms real) (640992 rewrites/second) 
```

## Symbolic Model Checking Using Narrowing
An example of Lamport's Bakery protocol is implemented as a maude module. Launch maude with the module loaded

```
maude Lamport_Bakery.maude
```

Test the narrowing with folding, we are interested in violation of mutual exclusion.

```
Maude> {fold} vu-narrow m | n | WPS =>* i | x? | < crit, j > < crit, k > PS .
{fold} vu-narrow in BAKERY : m | n | WPS =>* i | x? | < crit, j > < crit, k > PS .

No solution.
rewrites: 3 in 0ms cpu (1ms real) (3118 rewrites/second)        
```

## R&W System Checking
A simple readers-writers system is specified by the **R&W** module, which can be loaded with

```
maude rw.maude
```

The definition of the rewrite module can be visualized as the following (suppose ```< 0, 0 >``` is the initial state).

```

    < 0, 0 > <---> < 0, s(0) >
        ^
        |
        |
        |
        V
    < s(0), 0 >
        ^
        |
        |
        |
        V
    < s(s(0)), 0 >
        ^
        |
        |
        |
        V
       ...

```
A violation of mutual exclusion can be specified as ```< s(N), s(M) >```. And a violation of one writer can be specified as ```< 0, s(s(M)) >```. A violation of deadlock freedom can be specified as ```! C:Config``` (since this means no futher operation can be performed).

Naively searching for the violations will lead to an endless search, hence, a depth boundary needs to be set when searching. 

```
Maude> search [1, 1000000] < 0,0 > =>* < s(N:Nat), s(M:Nat) > . 
search [1, 1000000] in R&W : < 0, 0 > =>* < s N:Nat, s M:Nat > .

No solution.
states: 1000002  rewrites: 2000001 in 1058ms cpu (1092ms real) (1890120 rewrites/second) 

Maude> search [1, 1000000] < 0,0 > =>* < N:Nat, s(s(M:Nat)) > .
search [1, 1000000] in R&W : < 0, 0 > =>* < N:Nat, s_^2(M:Nat) > .

No solution.
states: 1000002  rewrites: 2000001 in 910ms cpu (938ms real) (2195643 rewrites/second)   

Maude> search [1, 1000000] < 0,0 > =>! C:Config .
search [1, 1000000] in R&W : < 0, 0 > =>! C:Config .

No solution.
states: 1000003  rewrites: 2000002 in 745ms cpu (765ms real) (2684054 rewrites/second)  
```

To overcome the limitation of bounded search (caused by the infinite states), one can make use of symbolic model checking. 

Search with narrowing for violation of mutual exclusion.

```
Maude> {fold} vu-narrow < R,0 > =>* < s(N),s(M) > .
{fold} vu-narrow in R&W : < R, 0 > =>* < s(N), s(M) > .

No solution.
rewrites: 4 in 0ms cpu (0ms real) (9324 rewrites/second)  
```

View the fixed point reached by narrowing.

```
Maude> show most general states .
< #1:Nat, 0 > \/
< 0, s(0) >    
```

One can also verify the general states reached are not intersecting with the mutual exclusion pattern by using the ```unify``` command.

```
Maude> unify < R,0 > =? < N,s(s(M)) > .
Decision time: 0ms cpu (0ms real)
No unifier.

Maude> unify < 0, s(0) > =? < N,s(s(M)) > .
Decision time: 0ms cpu (0ms real)
No unifier.
```
