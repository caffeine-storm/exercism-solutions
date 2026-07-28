USING: assocs fry hashtables kernel math math.order sequences
sorting ;
IN: pursers-pantry

: create-inventory ( seq -- inventory )
    H{ } clone
    [ '[ _ inc-at ] each ] keep ;

: add-items ( inventory items -- inventory' )
    swap clone
    [ '[ _ inc-at ] each ] keep ;

: decrement-at ( key hash -- )
    [ 1 - 0 max ] ?change-at ;

: decrement-items ( inventory items -- inventory' )
    swap clone
    [ '[ _ decrement-at ] each ] keep ;

: remove-item ( inventory item -- inventory' )
    swap clone [ delete-at ] keep ;

: list-inventory ( inventory -- pairs )
    sort-keys [ second 0 > ] filter ;
