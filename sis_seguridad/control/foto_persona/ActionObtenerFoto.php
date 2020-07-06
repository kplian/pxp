<?php
session_start();
$file = $_GET['file'];
$datos = explode('.', $file);
$filename = $datos[0];

if (empty($filename)) {
    $filename = 'user-icon';
}

$files = glob(dirname(__DIR__) . '/../../../' . $_SESSION['_FOLDER_FOTOS_PERSONA'] . '/' . $filename . '.*');
$default = glob(dirname(__DIR__) . '/foto_persona/user-icon.jpg');
if (count($files) > 0) {
    $foto = $files[0];
} else
    $foto = $default[0];

header("Content-Type: image/jpeg");
$imgContents = file_get_contents($foto);
$image = @imagecreatefromstring($imgContents);
imagejpeg($image);