USING: kernel ;
IN: cargo-shuffle

: swap-crates ( a b -- b a )
    swap ;

: clear-spill ( a b c -- a b )
    drop ;

: peek-under ( a b -- a b a )
    over ;

: tidy-deck ( x y z -- z z y )
    rot drop  ! y z x --> y z
    dup       ! y z --> y z z
    rot ;
