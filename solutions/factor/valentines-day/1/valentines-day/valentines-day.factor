USING: combinators kernel math math.vectors sequences ;
IN: valentines-day

SYMBOLS: yes no maybe
    korean turkish
    crime horror romance thriller
    board-game chill movie restaurant walk ;

: rate-restaurant ( cuisine -- approval )
    {
        { korean [ yes ] }
        { turkish [ maybe ] }
    } case ;

: rate-movie ( genre -- approval )
    {
        { romance [ yes ] }
        [ drop no ]
    } case ;

: rate-walk ( km -- approval )
    {
        { [ dup 11 > ] [ drop yes ] }
        { [ dup 6 > ] [ drop maybe ] }
        [ drop no ]
    } cond ;

: rate-activity ( activity -- approval )
    [ second ] [ first ] bi
    {
        { board-game [ drop no ] }
        { chill [ drop no ] }
        { movie [ rate-movie ] }
        { restaurant [ rate-restaurant ] }
        { walk [ rate-walk ] }
        [ "unknown activity" throw ]
    } case ;

: classify ( sym -- vec )
    {
        { yes [ { 1 0 0 } ] }
        { maybe [ { 0 1 0 } ] }
        { no [ { 0 0 1 } ] }
        { f [ { 0 0 0 } ] }
    } case ;

: approval-counts ( activities -- counts )
    [ rate-activity classify ] map
    f classify [ v+ ] reduce ;
