USING: accessors arrays combinators kernel math math.constants
    math.functions math.vectors namespaces sequences ;

IN: bering-bearings

! Task 1: define the data model and the two generic words here:
!   - tuple cardinal (slot: direction); tuple polar (magnitude bearing);
!     tuple relative (distance bearing)
!   - SYMBOLS: north east south west  ahead starboard behind port
!   - SYMBOL: heading
!   - GENERIC: >cartesian ( direction -- x y )
!   - GENERIC: flip ( direction -- direction' )
!   - the M: cardinal method of >cartesian
! The polar/relative >cartesian methods (tasks 2-3) and the flip
! methods (task 4) are added later.

TUPLE: cardinal direction ;
TUPLE: polar magnitude bearing ;
TUPLE: relative distance bearing ;

SYMBOLS: north east south west ;
SYMBOLS: ahead starboard behind port ;
SYMBOL: heading

GENERIC: >cartesian ( direction -- x y )
GENERIC: flip ( direction -- direction' )

[ 0   1 ] north set-global
[ 1   0 ] east  set-global
[ 0  -1 ] south set-global
[ -1  0 ] west  set-global

[   0 ] ahead     set-global
[  90 ] starboard set-global
[ 180 ] behind    set-global
[ 270 ] port      set-global

M: cardinal >cartesian ( cardinal -- x y )
    direction>> get-global call( -- x y ) ; inline

M: cardinal flip ( dir -- dir' )
    [ {
        { north [ south ] }
        { south [ north ] }
        { east [ west ] }
        { west [ east ] }
    } case ] change-direction ;

: deg-to-rad ( degress -- radians )
    pi * 180 / ;

M:: polar >cartesian ( pol -- x y )
    pol bearing>> deg-to-rad
    [ sin ] [ cos ] bi
    [ pol magnitude>> * ] bi@ ;

M: polar flip ( pol -- pol' )
    [ 180 + 360 mod ] change-bearing ;

M:: relative >cartesian ( rel -- x y )
    heading get
    rel bearing>> get-global call( -- n ) +
    deg-to-rad [ sin ] [ cos ] bi
    [ rel distance>> * ] bi@ ; inline

M: relative flip ( rel -- rel' )
    [ {
        { ahead [ behind ] }
        { behind [ ahead ] }
        { starboard [ port ] }
        { port [ starboard ] }
    } case ] change-bearing ;

: add-bearings ( a b -- x y )
    [ >cartesian 2array ] bi@ v+ [ first ] [ second ] bi ;
    
