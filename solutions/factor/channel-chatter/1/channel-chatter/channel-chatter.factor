USING: ascii io io.streams.string kernel sequences ;
IN: channel-chatter

: hear-out ( reader -- contents )
    stream-contents ;

: count-messages ( reader -- n )
    stream-lines length ;

: echo-back ( reader -- response )
    stream-lines ?last "" or >upper ;

: broadcast ( message writer -- )
    [ stream-write ] keep stream-flush ;

: capture ( quot -- captured )
    with-string-writer ; inline 
