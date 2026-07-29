USING: arrays formatting kernel math sequences ;
IN: lap-leaderboard

: assign-bibs ( names -- pairs )
    [ swap 2array ] map-index ;

: lane-labels ( names -- labels )
    [ swap "Lane %d: %s" sprintf ] map-index ;

: tag-racers ( names tag -- tagged )
    ! after curry, stack will be { name index tag }
    ! want { tag index name } so, spin
    [ spin "%s/%d: %s" sprintf ] curry map-index ;

: record-finishes ( names ledger -- )
    [ 
        [ swap "%d: %s" sprintf ] map-index
    ] dip push-all ;

: lap-bells ( laps -- str )
    "" swap [ "ding " append ] times ;
