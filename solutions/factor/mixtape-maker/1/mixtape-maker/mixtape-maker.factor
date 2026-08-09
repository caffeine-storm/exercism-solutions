USING: arrays kernel math math.combinatorics sequences ;
IN: mixtape-maker

: count-combinations ( n k -- count )
    nCk ;

: count-permutations ( n k -- count )
    nPk ;

: list-combinations ( seq k -- combinations )
    all-combinations ;

: list-permutations ( seq -- permutations )
    all-permutations ;

:: combinations-summing-to ( seq k target -- combinations )
    V{ } clone :> result
    seq k [ dup sum target = [ result push ] [ drop ] if ]
    each-combination
    result >array ;
