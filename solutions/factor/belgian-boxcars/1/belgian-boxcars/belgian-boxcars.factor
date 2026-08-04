USING: grouping hash-sets kernel sets splitting
splitting.monotonic ;
IN: belgian-boxcars

: couple ( cars n -- trains )
    group ;

: peek-couplings ( cars -- pairs )
    2 clump ;

: split-at-junctions ( cars junctions -- legs )
    >hash-set
    '[ _ in? ] split-when ;

: coalesce-cargo ( cars -- runs )
    [ = ] monotonic-split ;
