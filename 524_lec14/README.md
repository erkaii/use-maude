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
 
