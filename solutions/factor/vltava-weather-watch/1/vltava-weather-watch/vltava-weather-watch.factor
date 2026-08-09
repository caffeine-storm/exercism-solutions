USING: io io.encodings.utf8 io.files kernel sequences ;
IN: vltava-weather-watch

! Each word receives a path to the station's log file. Reach for
! `file-lines`, `file-contents`, `with-file-appender`, and
! `set-file-lines` from the `io.files` vocabulary, paired with the
! `utf8` encoding from `io.encodings.utf8`.

: read-readings ( path -- readings )
    utf8 file-lines ;

: latest-reading ( path -- reading )
    read-readings last ;

: log-text ( path -- text )
    utf8 file-contents ;

: record-reading ( reading path -- )
    swap [ print ] curry utf8 swap with-file-appender ;

: rewrite-log ( readings path -- )
    utf8 set-file-lines ;
