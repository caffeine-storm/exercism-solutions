USING: kernel math ;
IN: grains

: square ( n -- grains )
    [ ] [ 1 < ] [ 64 > ] tri or
    [ "square must be between 1 and 64" throw ] when
    1 - 2^ ;

: sum-of-square-naturals ( n -- sum-1-to-n-squared )
    2^ 1 - ;

: total ( -- grains )
    64 sum-of-square-naturals ;
