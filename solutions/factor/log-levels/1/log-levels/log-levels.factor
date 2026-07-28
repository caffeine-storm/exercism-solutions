USING: kernel splitting ascii sequences ;
IN: log-levels

: trim-ws ( str-with-spaces -- str-without-spaces )
    [ blank? ] trim ;

: message ( log-line -- message )
    ": " split1 nip
    trim-ws ;

: log-level ( log-line -- level )
    "[]:" split harvest first >lower ;

: reformat ( log-line -- formatted )
    dup log-level "(" ")" surround [ message ] dip " " glue ;
