USING: combinators kernel math math.order prettyprint sequences ;
IN: signalers-satchel

: quote-value ( v -- s )
    unparse ;

: flag-body ( flag -- body )
    1 head-slice* 1 tail-slice ;

: split-flag ( flag header-len -- header body )
    [ head-slice ] [ tail-slice ] 2bi ;

: triangulate ( reading-a reading-b -- difference midpoint ratio )
    [ - ] [ + 2 / ] [ / ] 2tri ;

: triangle-stats ( a b c -- sum product max )
    [ + + ] [ * * ] [ max max ] 3tri ;
