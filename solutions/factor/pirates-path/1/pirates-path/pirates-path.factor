USING: arrays assocs deques dlists kernel math sequences sets ;
IN: pirates-path

: tide-queue ( items -- popped )
    [let
        <dlist> :> dq
        V{ } clone :> acc
        dq push-all-front
        dq [ acc push ] slurp-deque
        acc >array
    ] ;

:: coves-reachable ( start chart -- coves )
    HS{ } clone :> coves
    { start } >dlist :> frontier
    frontier [
        [ coves ?adjoin ] keep
        '[
            ! if it's new, push-back the neighbours
            _ chart at frontier push-all-back
        ] when
    ] slurp-deque
    coves ;

:: -hop-count ( start goal chart -- n/f )
    HS{ } clone :> coves
    { { start 0 } } >dlist :> frontier
    f :> result!
    frontier [
        [ [ second ] [ first ] bi goal = [ result! ] [ drop ] if ] keep
        [ first coves ?adjoin ] keep
        '[
            ! if it's new, push-back the neighbours with one
            ! more than the popped distance 
            _ [ first chart at ] [ second 1 + ] bi
            [ 2array ] curry map frontier push-all-back
        ] when
    ] slurp-deque
    result ;

:: hop-count ( start goal chart -- n/f )
    HS{ } clone :> coves
    { { start 0 } } >dlist :> frontier
    f :> result!
    frontier [ [ first ] [ second ] bi
        :> ( next-cove hops )
        next-cove coves ?adjoin
        [
            next-cove chart at
            hops 1 + [ 2array ] curry map
            frontier push-all-back
        ] when
        next-cove goal = [
            hops result!
            frontier clear-deque
        ] when
    ] slurp-deque
    result ;

CONSTANT: gold-distribution H{
    { "Hidden Cove"        80 }
    { "Skull Bay"         120 }
    { "Reef Point"         40 }
    { "Smuggler's Hollow" 200 }
    { "Plank Island"       60 }
    { "Lantern Rock"      150 }
}

MEMO: gold-count ( cove -- n )
    gold-distribution at 0 or ;

: treasure-route ( start chart -- best-cove )
    coves-reachable members [ gold-count ] maximum-by ;
