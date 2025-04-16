# Introduction

This directory contains examples of using maude to perform system property checking, with different search techniques. 

Note that the examples in different subsections are **independent** from each other.

## Explicit State Model Checking
Launch maude with the module loaded

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

## Symbolic Model Checking Using Narrowing
Launch maude with the module loaded

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
