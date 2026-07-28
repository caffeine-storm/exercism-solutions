USING: math math.order kernel sequences ;
IN: librarians-ledger

: clamp-non-negative ( n -- +n )
    0 max ;

: protected-balance ( opening requests -- balance )
    swap [ + clamp-non-negative ] reduce ;

: running-balance-with ( transactions quot -- balances )
    0 swap accumulate* ; inline

: running-balance ( transactions -- balances )
    [ + clamp-non-negative ] running-balance-with ;

: least-balance-so-far ( transactions -- worsts )
    [ { } clone ]
    [ [ + ] running-balance-with
      dup first [ min ] accumulate* ]
    if-empty ;

: halve-until ( principal target -- balances )
    [ 2dup > ] [ [ 2 /i ] dip over ] produce 2nip ;
