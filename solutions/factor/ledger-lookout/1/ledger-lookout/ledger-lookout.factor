USING: kernel regexp sequences ;
IN: ledger-lookout

: amt-rx ( -- rx )
    R/ \$\d+(.\d\d)?/ ;

: dollars-rx ( -- rx )
    R/ \$\d+/ ;

: percent-rx ( -- rx )
    R/ \b\d+%\b/ ;

: valid-amount? ( line -- ? )
    amt-rx matches? ;

: dollar-amounts ( line -- amounts )
    dollars-rx [
        subseq rest
    ] map-matches ;

: percentages ( line -- nums )
    percent-rx [
        subseq 1 head*
    ] map-matches ;

: flagged? ( line -- ? )
    R/ refund|chargeback/i re-contains? ;
