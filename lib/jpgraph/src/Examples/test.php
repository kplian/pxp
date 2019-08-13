<?php
header("Content-type: image/jpeg");
$im  = imagecreatetruecolor(300, 300);
$w   = imagecolorallocate($im, 255, 255, 255);
$red = imagecolorallocate($im, 255, 0, 0);

/* Draw a dashed line, 5 red pixels, 5 white pixels */
$style = array($red, $red, $red, $red, $red, $w, $w, $w, $w);

//$style = array(862038515, 862038515, 862038515, 862038515, 862038515, -6, -6, -6, -6);
imagesetstyle($im, $style);
imageline($im, 0, 0, 300, 300, IMG_COLOR_STYLED);

/* Draw a line of happy faces using imagesetbrush() with imagesetstyle */
//$style = array($w, $w, $w, $w, $w, $w, $w, $w, $w, $w, $w, $w, $red);
//imagesetstyle($im, $style);

//$brush = imagecreatefrompng("http://www.libpng.org/pub/png/images/smile.happy.png");
//$w2 = imagecolorallocate($brush, 255, 255, 255);
//imagecolortransparent($brush, $w2);
//imagesetbrush($im, $brush);
//imageline($im, 100, 0, 0, 100, IMG_COLOR_STYLEDBRUSHED);

imagejpeg($im);
imagedestroy($im);
?>
