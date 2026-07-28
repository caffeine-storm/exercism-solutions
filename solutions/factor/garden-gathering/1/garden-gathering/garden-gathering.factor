USING: accessors kernel locals math namespaces sequences ;
IN: garden-gathering

TUPLE: plot id registered-to ;

SYMBOLS: registrations next-id not-found ;

: open-garden ( -- )
    V{ } clone registrations set-global
    1 next-id set-global ;

: list-registrations ( -- plots )
    registrations get-global ;

: mint-id ( -- n )
    next-id get-global
    next-id [ 1 + ] change-global ;

: register ( name -- plot )
    mint-id swap plot boa
    dup registrations get-global push
    ;

: release ( id -- )
    '[ [ id>> _ = ] reject ] registrations swap change-global ;

: get-registration ( id -- plot/symbol )
    registrations get-global swap
    '[ id>> _ = ] find nip
    [ not-found ] unless* ;

: find-by-name ( name -- plots )
    registrations get-global swap
    '[ registered-to>> _ = ] filter ;
