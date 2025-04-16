mod BAKERY is sorts Nat LNat Nat? State WProcs Procs .
	subsorts Nat LNat < Nat? .  subsort WProcs < Procs .
	op 0 : -> Nat .
	op s : Nat -> Nat .
	op [_] : Nat -> LNat .		*** Number-locking operator
	op < wait,_> : Nat -> WProcs .
	op < crit,_> : Nat -> Procs .
	op mt : -> WProcs .			*** Empty multiset
	op __ : Procs Procs -> Procs [assoc comm id: mt] . *** union
	op __ : WProcs WProcs -> WProcs [assoc comm id: mt] . *** union
	op _|_|_ : Nat Nat? Procs -> State .

	vars n m i j k : Nat . 
	var x? : Nat? . 
	var PS : Procs . 
	var WPS : WProcs . 
	rl [new]: m | n | PS => s(m) | n | < wait,m > PS [narrowing] .
	rl [enter]: m | n | < wait,n > PS => m | [n] | < crit,n > PS [narrowing] . 
	rl [leave]: m | [n] | < crit,n > PS => m | s(n) | PS [narrowing] .
endm
