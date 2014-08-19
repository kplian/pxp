<?php
echo json_encode(array(
    'type'=>'event',
    'name'=>'message',
    'data'=>'Successfully xxx polled at: '. date('g:i:s a')
));
