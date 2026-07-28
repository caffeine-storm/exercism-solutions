USING: kernel combinators math ;
IN: joiners-journey

: kerf-budget ( -- n ) 2 100 / ;
: kerf-scale ( -- n ) 1 kerf-budget + ;
: finish-budget ( -- n ) 5 100 / ;
: finish-scale ( -- n ) 1 finish-budget + ;

: with-kerf ( length -- length+kerf )
    kerf-scale * ;

: kerf-and-finish ( length -- kerf finish )
    [ kerf-budget * ] [ finish-budget * ] bi ;

: cut-card ( length -- length kerf finish )
    { [ ] [ kerf-budget * ] [ finish-budget * ] } cleave ;

: per-piece ( bolt-length pieces -- per-piece )
    [ with-kerf ] dip / ;

: compare-bolts ( length-a length-b -- kerf-a kerf-b )
    [ kerf-budget * ] bi@ ;
