USING: kernel ;
IN: annalyns-infiltration

: can-do-fast-attack ( knight-awake -- ? )
    not ;

: can-spy ( knight-awake archer-awake prisoner-awake -- ? )
    or or ;

: can-signal-prisoner ( archer-awake prisoner-awake -- ? )
    not or not ;

: can-free-prisoner ( archer-awake dog-present prisoner-awake knight-awake -- ? )
    rot [ drop drop not ] [ not and swap not and ] if ;
