USING: kernel regexp ;
IN: passphrase-patrol

CONSTANT: badge-re R/ [A-Z]{2}-\d{4}/

: valid-badge? ( badge -- ? )
    badge-re matches? ;

: badge-codes ( line -- codes )
    badge-re all-matching-subseqs ;

: digit-count ( string -- n )
    R/ \d/ count-matches ;

: redact ( line -- line' )
    R/ pass=\w+/ "pass=****" re-replace ;
