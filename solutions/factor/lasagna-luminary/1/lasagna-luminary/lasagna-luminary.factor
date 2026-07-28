USING: assocs combinators kernel locals math sequences ;
IN: lasagna-luminary

:: cooking-status ( timer -- string )
    {
        { [ timer zero? ] [ "Lasagna is done." ] }
        { [ timer not ] [ "You forgot to set the timer." ] }
        [ "Not done, please wait." ]
    } cond ;

:: preparation-time ( layers minutes-per-layer -- total )
    layers length minutes-per-layer * ;

:: quantities ( layers -- noodles sauce )
    layers [ "noodles" = ] count 50 *
    layers [ "sauce" = ] count 1 5 / *
    ;

: add-secret-ingredient ( friends-list my-list -- new-list )
    swap last suffix ;

: scale-recipe ( recipe portions -- new-recipe )
    [let 2 / :> scalar
        [| key val | key val scalar * ] assoc-map
    ] ;
