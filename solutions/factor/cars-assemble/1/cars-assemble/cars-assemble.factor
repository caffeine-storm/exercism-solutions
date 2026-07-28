USING: kernel math math.order combinators ;
IN: cars-assemble

: production-status ( speed -- status )
    zero? [ "stopped" ] [ "running" ] if ;

CONSTANT: base-speed 221

: success-rate ( speed -- rate )
    {
        { [ dup zero? ] [ drop 0.0 ] }
        { [ dup 1 4 between? ] [ drop 1.0 ] }
        { [ dup 5 8 between? ] [ drop 0.9 ] }
        { [ dup 9 = ]          [ drop 0.8 ] }
        { [ dup 10 = ]         [ drop 0.77 ] }
        [ "bad speed" throw ]
    } cond ;

: production-rate-per-hour ( speed -- rate )
    [ success-rate ] [ base-speed * ] bi * ;

: working-items-per-minute ( speed -- count )
    production-rate-per-hour 60 /i ;
