USING: assocs kernel math sequences ;
IN: rpn-calculator

ERROR: zero-divisor-error ;

: take-2 ( stack -- new-stack fst snd )
    [ 2 head* ] [ last2 ] bi ;

: add-op ( stack -- new-stack )
    take-2 + suffix ;

: multiply-op ( stack -- new-stack )
    take-2 * suffix ;

: apply-op ( stack op: ( stack -- new-stack ) -- new-stack )
    call( stk -- new-stk ) ;

: evaluate ( stack ops -- final-stack )
    [ apply-op ] each ; inline

: evaluate-named ( stack ops names -- final-stack )
    swap '[ _ at ] map evaluate ;

: divide-op ( stack -- new-stack )
    take-2 dup zero? [ zero-divisor-error ] when
    / suffix ;
