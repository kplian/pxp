<?php
    /**
     * Simple script to invoke external apps in a script instead of directly
     *
     */

    // get arguments
    $arguments = getopt("s:t:d:o:p:");
    if ($arguments['o']) {
        passthru(dirname(__FILE__) . $arguments['p'] . ' /I ' . $arguments['s'] . ' /O ' . $arguments['t'] . ' /LEVEL 4 /F');
        chmod($arguments['t'], 0644);
    } else {
        copy($arguments['s'], $arguments['t']);
    }
    // How to start OpenOffice in headless mode: lib/openoffice/openoffice.org3/program/soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard';
    passthru('java -jar ' . dirname(__FILE__) . '/../lib/openoffice/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar ' . $arguments['t'] . ' ' . $arguments['d']);