USING: ascii assocs kernel sequences ;
IN: etl

:: transform ( old -- result )
    H{ } clone
    old [| score letters |
        letters [ >lower score swap pick set-at ] each
    ] assoc-each ;
