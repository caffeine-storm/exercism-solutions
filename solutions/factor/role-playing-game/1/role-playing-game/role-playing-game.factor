USING: accessors kernel math math.order ;
IN: role-playing-game

TUPLE: player 
    { name }
    { level initial: 0 }
    { health initial: 100 }
    { mana }
;

: introduce ( player -- string )
    name>> "Mighty Magician" or ;

: revive ( player -- player' )
    dup health>> zero?
        [ clone 100 >>health 100 >>mana ]
        [ drop f ]
        if
    ;

: take-damage ( player damage -- player' )
    [ clone dup health>> ] dip
    - 0 max >>health
    ;

