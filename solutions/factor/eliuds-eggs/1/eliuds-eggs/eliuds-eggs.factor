USING: kernel math ;
IN: eliuds-eggs

: egg-count ( n -- count )
    0 
    [ over zero? ]
    [ [ 2 /mod ] dip + ] until
    nip ;
