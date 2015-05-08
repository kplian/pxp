<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="Serpent.js"></script>
<script type="text/javascript" src="rijndael.js"></script>
<script type="text/javascript" src="mcrypt.js"></script>
<script type="text/javascript" src="md5.js"></script>
<script type="text/javascript" src="../base64.js"></script>
<script type="text/javascript">
var pass =md5('admin');
var res = Base64.encode(mcrypt.Encrypt(pass,undefined,pass,'rijndael-256','ecb'));
alert(res);


</script>
</head>
<body>
<div style="float:left;">
<form name="main" action="" method="GET">

Check With PHP's Mcrypt:<input type="submit" value="Go"/>
</form>
</div>

</body>
</html>