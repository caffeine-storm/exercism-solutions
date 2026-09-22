USING: accessors arrays assocs combinators formatting io
io.encodings.utf8 io.files kernel math sequences sorting unicode
;
IN: grep

! `grep` receives the search string, an array of flag strings
! (any of "-n", "-l", "-i", "-v", "-x"), and an array of file
! names. Read each file in turn, find the matching lines, and
! return them as an array of strings.
!
! Reading a file's lines: `<file-name> utf8 file-lines` (from the
! `io.files` and `io.encodings.utf8` vocabularies).

SYMBOLS:
    LINE
    POSN-LINE
    FILE-LINE
    FILE-POSN-LINE
    FILELIST
;

TUPLE: matcher
    pattern 

    ! ( pattern input-line -- matches? )
    run-match

    ! a symbol to pick which output style to use
    line-style

    ! ( file line-num input-line -- formatted-line )
    fmt-line

    ! ( formatted-line-to-emit -- )
    match-sink
;

: with-line-num ( sym -- sym' )
    H{
        { LINE           POSN-LINE }
        { POSN-LINE      POSN-LINE }
        { FILE-LINE      FILE-POSN-LINE }
        { FILE-POSN-LINE FILE-POSN-LINE }
        { FILELIST       FILELIST }
    } at* [ "bad symbol" throw ] unless ;

: with-filename ( sym -- sym' )
    H{
        { LINE           FILE-LINE }
        { POSN-LINE      FILE-POSN-LINE }
        { FILE-LINE      FILE-LINE }
        { FILE-POSN-LINE FILE-POSN-LINE }
        { FILELIST       FILELIST }
    } at* [ "bad symbol" throw ] unless ;

: lengths-match ( pat str -- ? )
    [ length ] bi@ = ;

: -and-lengths-match-too ( quot: ( pat str -- ? ) -- quot' )
    [ [ lengths-match ] 2bi and ] curry ;

! modifies the given matcher to use the given sink once but drop
! all subsequent items.
: emit-just-once ( sink matcher -- )
    tuck '[ _ call( str -- ) [ drop ] _ match-sink<< ]
    swap match-sink<<
;

: (pick-formatter) ( sym -- quot: ( file line# line -- line' ) )
    H{
        { LINE           [ 2nip ] }
        { POSN-LINE      [ nipd "%d:%s" sprintf ] }
        { FILE-LINE      [ nip "%s:%s" sprintf ] }
        { FILE-POSN-LINE [ "%s:%d:%s" sprintf ] }
        { FILELIST       [ 2drop ] }
    } at ;

: (init-fmt-line) ( matcher -- matcher' )
    dup line-style>> (pick-formatter) >>fmt-line ;

: (make-matcher) ( pattern flags -- matcher )
    [
        [ subseq? ]    ! run-match
        LINE           ! line-style
        [ 2nip ]       ! fmt-line
        [ drop ]       ! match-sink
        matcher boa
    ] dip
    [ {
        { "-n" [ [ with-line-num ] change-line-style ] }
        { "-l" [ FILELIST >>line-style ] }
        { "-i" [ [ [ [ >lower ] bi@ ] prepose ] change-run-match ] }
        { "-v" [ [ [ not ] compose ] change-run-match ] }
        { "-x" [ [ -and-lengths-match-too ] change-run-match ] }
        { FILE-LINE [ [ with-filename ] change-line-style ] }
    } case ] each
    (init-fmt-line)
    ;

: (read-lines) ( fname -- lines )
    utf8 file-lines ;

: (consume-line) ( matcher line -- matcher line-or-f )
    over [ pattern>> ] [ drop over ] [ run-match>> ] tri
    ! matcher line pattern line match-closure
    call( pattern input-line -- matches? )

    [ drop f ] unless ;

: (format-line) ( line line0# file matcher -- line' )
    [ spin ] dip over
    [ fmt-line>> call( file line-num line -- line' ) ]
    [ 4drop f ] if
    ;

: (output-line) ( line matcher -- )
    over
    [ match-sink>> call( line -- ) ]
    [ 2drop ] if ; 

: (output-matches) ( file matcher lines -- )
    f prefix rot pick '[ _ _ (format-line) ] map-index
    swap '[ _ (output-line) ] each
    ;

: (run-matcher) ( fname matcher -- output-lines )
    V{ } clone dup '[ _ push ]
    ! fname matcher acc [sink]

    ! do we need to emit no-more than once per file?
    pick line-style>> FILELIST =
    [ pick emit-just-once ]
    [ pick match-sink<< ] if
    -rot
    ! acc fname matcher

    over (read-lines)
    [ (consume-line) ] map
    (output-matches) ;

: grep ( pattern flags files -- lines )
    ! if more than one file, include file-name in output
    dup length 1 > [ [ FILE-LINE prefix ] dip ] when
    -rot (make-matcher)
    '[ _ (run-matcher) ] map concat sift >array ;
