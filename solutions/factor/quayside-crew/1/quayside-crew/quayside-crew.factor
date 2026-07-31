USING: accessors concurrency.combinators concurrency.locks
concurrency.promises kernel math math.parser
namespaces sequences threads ;
IN: quayside-crew

: weigh-crate ( crate -- weight )
    sum ;

: weigh-all ( crates -- weights )
    [ weigh-crate ] parallel-map ;

TUPLE: crane
    lock
    tonnage
    ;

: <crane> ( -- crane )
    <lock> 0 crane boa ;

: hoist-crate ( weight crane -- )
    dup lock>> [
        [ + ] change-tonnage drop
    ] with-lock ;

: crane-tonnage ( crane -- tonnage )
    dup lock>> [
        tonnage>>
    ] with-lock ;

:: load-cargo ( crates crane -- )
    crates [| crate idx |
        <promise> :> p
        [ crate weigh-crate crane hoist-crate f p fulfill ] 
        "hand-" idx >dec append spawn drop
        p
    ] map-index
    [ ?promise drop ] each ;
        
