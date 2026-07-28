USING: arrays bosuns-briefing.helpers kernel sequences ;
IN: bosuns-briefing

: roster ( names -- str ) [ crew-line ] map "\n" join ;

: briefing ( names -- str )
    roster
    greeting swap
    closing
    3array "\n" join ;
