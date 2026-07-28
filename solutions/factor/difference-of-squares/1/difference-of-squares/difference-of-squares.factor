USING: combinators kernel math ;
IN: difference-of-squares

: square-of-sum ( n -- m )
    dup 1 + * 2 / dup * ;

: sum-of-squares ( n -- m )
    [ ] [ 1 + ] [ 2 * 1 + ] tri
    * * 6 / ;

: difference-of-squares ( n -- m )
    [ square-of-sum ] [ sum-of-squares ] bi - ;