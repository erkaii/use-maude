# What is This?
This folder contains Maude code related to lambda calculus from CS 524.

# How to Use?
To load the **FUN-DEFS** module in one go, run

```
maude load_fun_defs.maude
```

To load the **ALPHA-CAN-NAT-NAME** in one go, run 
```
maude load_alpha_can.maude
```

# Usage Step by Step
Start by launching maude.

```
maude
```

Load the **NAME** functional theory. It defines an equality predicate for names, so that given names *x* and *y* we can determine whether they are the same. This is captured by the ```.=.``` predicate. The theory also requires the data type of names to be countably infinite, this is patured by the operators *i* and *j* and the two equations relating them, which put names and numbers in bijective correspondence.

```
load name.maude
```

Load the **SET\{N :: NAME\}** functional module, it defines how sets of names behave.

```
load set_name.maude
```

Load the **LAMBDA** module. This is a parameterized rewrite theory formalizing the lambda-calculus.

```
load lambda.maude
```

Play with lambda-calculus like the following example. Note the limitation here is the variables available are limited to just X, Y, Z, U, V, W.

```
Maude> rew (\ X . (X Y)) V . 
rewrite in LAMBDA : (\ X . (X Y)) V .
rewrites: 6 in 0ms cpu (0ms real) (~ rewrites/second)
result Lambda{N}: V if X .=. Y then V else Y fi
```

One thing worth noticing is that the **LAMBDA** module defined here doesn't automatically perform alpha rule to avoid free names causing confusion, an example is given as:

```
Maude> rew (\ X . \ Y . (Y X)) Y .
rewrite in LAMBDA : (\ X . \ Y . (Y X)) Y .
rewrites: 1 in 0ms cpu (0ms real) (~ rewrites/second)
result Lambda{N}: [X := Y] \ Y . (Y X)
```

The key issue with **LAMBDA** module is that the alpha-conversion equation is non-executable, this is because there are infinite number of names to choose for alpha-conversion, hence this process is non-deterministic.

Load **FRESH** functional module. This provides a deterministic way of choosing new names in alpha-conversions.

```
load fresh.maude
```  

Load **LAMBDA-FRESH** module which gives an executable version of lambda-calculus.

```
load lambda_fresh.maude
```

However, testing **LAMBDA-FRESH** with the same input doesn't give better result than **LAMBDA** module. This is because **LAMBDA-FRESH** is parametric on the choice of a data type of names, it doesn't know how to get a **fresh()** variable unless a data type is defined for **FRESH**.

Load **NAT-NAME** functional module to get a natural data type *x1, x2, ...*

```
load nat_name.maude
```

Instantiate **LAMBDA-NAT-NAME** by first viewing **NatName**.

```
load view.maude
load lambda_nat_name.maude
```

Now test the **LAMBDA-NAT-NAME** and see how it handles the confusion case naturally.

```
Maude> rew (\ x{1} . \ x{2} . (x{2} x{1})) x{2} .
rewrite in LAMBDA-NAT-NAME : (\ x{1} . \ x{2} . (x{2} x{1})) x{2} .
rewrites: 56 in 0ms cpu (0ms real) (746666 rewrites/second)
result Lambda{NatName}: \ x{3} . (x{3} x{2})
```

After defining lambda-calculus, some basic functions and constants can be defined (functions are just lambda-terms without free variables).

Load **FUN-DEFS** module to have a definition of basic functions and constants in lambda-calculus.

```
load fun_defs.maude
```



