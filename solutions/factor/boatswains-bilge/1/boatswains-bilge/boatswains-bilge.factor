USING: accessors destructors kernel ;
IN: boatswains-bilge

: drain-bilge ( pump -- )
    dispose ;

: pump-out ( pump quot -- )
    with-disposal ; inline

: shift-routine ( pump-a pump-b quot -- )
    '[
        _ &dispose
        _ &dispose
        _ call
    ] with-destructors ; inline

: risky-pump-out ( pump quot -- )
    '[
        _ |dispose
        _ call
    ] with-destructors ; inline

! Task 5: the valve tuple is declared for you. Implement <valve>
! (construct a fresh open valve) and M: valve dispose* (mark it closed).
TUPLE: valve < disposable is-open ;

: <valve> ( -- valve )
    valve new-disposable t >>is-open ;

M: valve dispose* ( valve -- )
    f >>is-open drop ;
