USING: kernel math ;
IN: collatz-conjecture

: collatz ( n -- n' )
    dup even? [ 2 / ] [ 3 * 1 + ] if
    ;

: steps-impl ( steps n -- steps )
    [ dup 1 = ] 
    [ [ 1 + ] dip collatz ]
    until drop
    ;

: steps ( n -- steps )
    dup 1 <
        [ "Only positive integers are allowed" throw ]
        [ 0 swap steps-impl ] if
    ;
