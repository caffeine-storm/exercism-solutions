USING: kernel math math.order ;
IN: currency-conversion

: exchange-money ( budget exchange-rate -- exchanged )
    /f ;

: get-change ( budget exchanging-value -- change )
    - ;

: value-of-bills ( denomination number-of-bills -- value )
    * ;

: number-of-bills ( amount denomination -- bills )
    /i ;

: leftover-of-bills ( amount denomination -- leftover )
    mod ;

: exchangeable-value ( denomination budget spread exchange-rate -- value )
    swap 0.01 * 1.0 + *  ! denom budget effective-rate
    /f over number-of-bills * ;

: safe-change ( budget exchanging-value -- change )
    get-change 0 max ;

: cap-spend ( budget price -- spend )
    min ;
