<?php
/**
 * Simple script to invoke external apps in a script instead of directly
 *
 */

// get arguments
$arguments = getopt("s:p:e:t:");
if ($arguments['t']) {
    passthru($arguments['p'] . ' --invisible "macro:///Standard.Module1.SaveToPdf(' . realpath($arguments['s']) . ')"');
} else {
    passthru($arguments['p'] . ' --invisible --convert-to ' . $arguments['e'] . ' ' . $arguments['s']);
}
