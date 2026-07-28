USING: kernel math sequences ;
IN: backyard-birdcount

: today ( days -- count/f )
    [ f ] [ first ] if-empty ;

: increment-day-count ( days -- new-days )
    [ { 1 } clone ] [ unclip 1 + prefix ] if-empty ;

: has-day-without-birds? ( days -- ? )
    [ f ] [ unclip zero? [ drop t ] [ has-day-without-birds? ] if ]
    if-empty ;

: total ( days -- sum )
    [ 0 ] [ unclip [ total ] dip + ] if-empty ;

: busy-days ( days -- count )
    [ 0 ] [ unclip [ busy-days ] dip 5 >= 1 0 ? + ] if-empty ;
