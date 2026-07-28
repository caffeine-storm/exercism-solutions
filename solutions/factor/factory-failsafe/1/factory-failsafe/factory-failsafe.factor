USING: continuations kernel locals math sequences ;
IN: factory-failsafe

! Task 1: Define a machine-error error class.
ERROR: machine-error ;

: check-humidity ( h -- )
    70 > [ "humidity too high" throw ] when ;

: check-temperature ( t -- )
    500 > [ "temperature too high" throw ] when ;

:: monitor ( humidity temp -- )
    [ temp check-temperature humidity check-humidity ]
    [ drop machine-error ] recover
    ;

: monitor-throws? ( humidity temp -- ? )
    [ monitor f ] [ 3drop t ] recover ;

: monitor-batch ( readings -- count )
    [ first2 monitor-throws? ] count ;
