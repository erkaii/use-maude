# Explanation
This folder contains Maude code from CS 524 lecture 14.

# Usage
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
