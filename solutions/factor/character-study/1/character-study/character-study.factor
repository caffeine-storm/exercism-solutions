USING: kernel combinators math.order assocs unicode ;
IN: character-study

SYMBOLS: less equal greater
    big small no-size
    alpha numeric space newline unknown ;

: compare-chars ( c1 c2 -- symbol )
    <=> {
        { +eq+ equal }
        { +gt+ greater }
        { +lt+ less }
    } at ;

: size-of-char ( c -- symbol )
    {
        { [ dup LETTER? ] [ drop big ] }
        { [ dup letter? ] [ drop small ] }
        [ drop no-size ]
    } cond ;

: change-size-of-char ( c desired -- c' )
    {
        { [ dup big = ] [ drop ch>upper ] }
        { [ dup small = ] [ drop ch>lower ] }
        [ "bad directive" throw ]
    } cond ;

: type-of-char ( c -- symbol )
    {
        { [ dup CHAR: space = ] [ drop space ] }
        { [ dup CHAR: \n = ] [ drop newline ] }
        { [ dup digit? ] [ drop numeric ] }
        { [ dup Letter? ] [ drop alpha ] }
        [ drop unknown ]
    } cond ;
