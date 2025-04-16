# Usage

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
