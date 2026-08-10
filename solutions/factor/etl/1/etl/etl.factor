USING: arrays ascii assocs kernel sequences sets ;
IN: etl

: (transform-step) ( acc score letter-seq -- acc' )
    swap '[ >lower _ swap pick set-at ] each ;

: transform ( legacy -- new )
    H{ } clone [ (transform-step) ] assoc-reduce ;
