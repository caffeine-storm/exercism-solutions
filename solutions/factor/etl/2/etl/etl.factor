USING: ascii assocs kernel sequences ;
IN: etl

:: transform ( old -- result )
    H{ } clone :> result
    old [| score letters |
        letters [ >lower score swap result set-at ] each
    ] assoc-each
    result ;
