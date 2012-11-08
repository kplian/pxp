<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Actualización de secuencias</title>
</head>

<body>
<form id="form1" name="form1" method="post" action="ActionSecuencias.php">

<table width="45%" border="2" cellpadding="3" cellspacing="0">
  <tr>
   <!-- <td width="60%">&nbsp;</td>-->
    <td width="100%" colspan="0"><b><div align="center">Actualización de secuencias</div></b></td>
  </tr>
  
  <!--<tr bgcolor="#55D562">
    <td><b>Base de Datos Origen</b></td>
    <td><label>
      <div align="center">
        <input type="text" name="bdOrigen"/>
        </div>
    </label></td>
  </tr>  -->
  <tr bgcolor="#55D562">
    <td><b>Host</b></td>
    <td><label>
      <div align="center">
        <input type="text" name="host"/>
        </div>
    </label></td>
  </tr>  
  
  <tr bgcolor="#55D562">
    <td><b>Base de Datos</b></td>
    <td><label>
      <div align="center">
        <input type="text" name="bdDestino"/>
        </div>
    </label></td>
  </tr>  
  <tr>
  
  <tr bgcolor="#55D562">
    <td><b>Usuario Base</b></td>
    <td><label>
      <div align="center">
        <input type="text" name="usuario"  maxlength="70">
        </div>
    </label></td>
  </tr> 
  
  <tr bgcolor="#55D562">
    <td><b>Contraseña Base</b></td>
    <td><label>
      <div align="center">
        <input type="password" name="contrasena"  maxlength="70">
        </div>
    </label></td>
  </tr> 
  
              
                        
                    
  <td>ESQUEMA (Ej. segu)</td> 
    <td><label>
      <div align="center">
      	<input type="text" name="id_subsistema"  maxlength="70">
						
		</select>   
      
        </div>
    </label></td>
    

  <tr>
    <td height="47">&nbsp;</td>
    <td><label>
      <div align="center">
        <input type="submit" name="Submit" value="Enviar"/>
        <input type="reset" name="Submit2" value="Reset"/>
        </div>
    </label></td>
  </tr>
</table>
</form>
</body>
</html>