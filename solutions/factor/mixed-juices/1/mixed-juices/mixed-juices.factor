USING: accessors assocs combinators kernel math namespaces
sequences ;
IN: mixed-juices

SYMBOL: juice-times

H{
    { "Pure Strawberry Joy" 0.5 }
    { "Energizer" 1.5 }
    { "Green Garden" 1.5 }
    { "Tropical Island" 3 }
    { "All or Nothing" 5 }
} juice-times set-global

: time-to-mix-juice ( juice -- minutes )
    juice-times get-global at
    2.5 or ;

: wedges-from-lime ( size -- wedges )
    {
        { "small" [ 6 ] }
        { "medium" [ 8 ] }
        { "large" [ 10 ] }
    } case ;

:: limes-to-cut ( needed! limes! -- count )
    0 :> numcut!
    limes [ wedges-from-lime ] map limes!
    [ needed 0 > limes empty? not and ]
    [
        needed
        limes unclip [ limes! ] dip
        - needed!
        numcut 1 + numcut!
    ] while numcut ;

: order-times ( orders -- times )
    [ time-to-mix-juice ] map ;

:: remaining-orders ( time-left! orders! -- remaining )
    [ time-left 0 > orders empty? not and ]
    [
        time-left
        orders unclip [ orders! ] dip
        time-to-mix-juice - time-left!
    ] while
    orders ;
