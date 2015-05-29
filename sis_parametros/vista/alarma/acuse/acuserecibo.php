<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Acuse de recibo</title>
		<link href="css/reset.css" rel="stylesheet" type="text/css" media="all" />
		<link href="../../../../lib/imagenes/font-awesome-4.2.0/css/font-awesome.css" rel="stylesheet" type="text/css" media="all" />

		<script type="text/javascript" charset="UTF-8" src="jquery-1.11.2.min.js"></script>
		
		<?php
		session_start();
		?>
		<script type="text/javascript">
			console.log('inicia consulta ...');
			
			$(document).ready(function() {

				function $_GET(param) {
					/* Obtener la url completa */
					url = document.URL;
					/* Buscar a partir del signo de interrogación ? */
					url = String(url.match(/\?+.+/));
					/* limpiar la cadena quitándole el signo ? */
					url = url.replace("?", "");
					/* Crear un array con parametro=valor */
					url = url.split("&");

					/*
					 Recorrer el array url
					 obtener el valor y dividirlo en dos partes a través del signo =
					 0 = parametro
					 1 = valor
					 Si el parámetro existe devolver su valor
					 */
					x = 0;
					while (x < url.length) {
						p = url[x].split("=");
						if (p[0] == param) {
							return decodeURIComponent(p[1]);
						}
						x++;
					}
				}

				var a = $_GET("token");
				

				$.ajax({
					url : 'http://172.17.45.229/kerp_capacitacion/lib/rest/parametros/Alarma/confirmarAcuseRecibo',
					type : 'POST',
					data : {
						'alarma' : a
					},
					success : function handleData(data) {
						console.log(data.ROOT.datos.mensaje_acuse)
						if(data.ROOT.datos.modificado == 'no'){
							$("#mensaje").append('El acuse ya fue confirmado');
						}else{
							$("#mensaje").append(data.ROOT.datos.mensaje_acuse);
						}
						
						$("#fecha_acuse").append(data.ROOT.datos.fecha_acuse);

						

					}
				})

			});

		</script>

		<style type="text/css" media="screen">
			#contenedor {
				width: 90%;
				height: 500px;
				background-color: #ccc;
				margin-left: auto;
				margin-right: auto;
				margin-top: 50px;
			}
			.logo {
				
				width:100%;
				height:131px;
				background-image: url("img/logo_header.png");
				background-size: 100% 131px;
    			background-repeat: no-repeat;
			}
			body {
				font-family: 'Arial';
				background-color: #2d4562;
			}
			.boton {
				font-family: 'Arial';
				border: none;
				background: #2d4562;
				font-weight: bold;
				color: white;
				width: 100%;
				height: 60px;
				line-height: 60px;
				text-align: center;
				-webkit-box-shadow: 0px 5px 0px #62AE8C;
				-moz-box-shadow: 0px 5px 0px #62AE8C;
				box-shadow: 0px 5px 0px #62AE8C;
				cursor: pointer;
				position: relative;
				display: block;
				text-transform: uppercase;
				text-decoration: none;
			}

		</style>

	</head>

	<body>

		<div id="contenedor">
			<div class="logo">
				<div style="float: right; width: 150px; height: 150px;">
					<img width="130" src="<?php echo '../'.$_SESSION['_DIR_IMAGEN_INI'];?>" />
				</div>
			</div>
			

				<div id="mensaje" style=" color: #111; margin-top: 100px; width: 80%; margin-left:auto; margin-right:auto; text-align: center; font-size: 20px;">

				</div>
				<div style="width: 40%; margin-left: auto; margin-right: auto;">
					<br />
					<a class="boton" href="javascript:;" style="top: 0px; -webkit-box-shadow: rgb(98, 174, 140) 0px 5px 0px 0px;">
						<i class="fa fa-clock-o"></i> Fecha Acuse - <span id="fecha_acuse"></span>
					</a>
				</div>
			
		</div>
		<script>
			$(".boton").mousedown(function() {
				$(this).animate({
					'top' : '5px',
					'boxShadowY' : '0'
				}, 100);
			}).mouseup(function() {
				$(this).animate({
					'top' : '0',
					'boxShadowY' : '5px'
				}, 100);
			});
		</script>
	</body>
</html>
