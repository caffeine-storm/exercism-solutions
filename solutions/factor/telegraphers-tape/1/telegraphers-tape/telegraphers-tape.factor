USING: accessors combinators.short-circuit destructors io kernel
sequences ;
IN: telegraphers-tape

! 1. Define the tuple — `tape` extends `disposable` with a `wire`
! slot for the underlying input stream.

TUPLE: tape < disposable wire ;

: <tape> ( wire -- tape )
    tape new-disposable swap >>wire ;

! 2. Mark `tape` as an `input-stream` so the protocol's default
!    methods dispatch to your class.

INSTANCE: tape input-stream

! 3. Implement `stream-read1`. Read bytes from the wire until you
!    hit a Morse symbol (`.`, `-`, or space) or end-of-stream
!    (`f`).

: (is-morse-or-f) ( chr -- ? )
    { [ not ] [ " -." member? ] } 1|| ;

M: tape stream-read1 ( tape -- elt/f )
    wire>> [ stream-read1 ] curry
    CHAR: a
    [ dup (is-morse-or-f) ]
    [ drop dup call( -- chr-or-f ) ] until
    nip ;

! 4. Delegate `stream-element-type` to the wire.

M: tape stream-element-type ( tape -- elem-type )
    wire>> stream-element-type ;

! 5. Implement `dispose*` so the wire is closed when the tape is.

M: tape dispose* ( tape -- )
    wire>> dispose ;
