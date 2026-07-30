USING: assocs combinators hash-sets kernel locals namespaces
sets sequences ;
IN: lighthouse-logbook

: empty-log ( -- log )
    HS{ } clone ;

: sight ( log callsign -- )
    swap adjoin ;

: seen? ( log callsign -- ? )
    swap in? ;

: forget-sighting ( log callsign -- )
    swap delete ;

: unique-count ( log -- n )
    cardinality ;

:: reachable ( start relay-map -- visited )
    HS{ start } clone :> result
    V{ start } clone :> work
    [ work empty? ] [
        work pop relay-map at
        >hash-set result diff members
        [ work push-all ]
        [ result adjoin-all ]
        bi
    ] until
    result ;
