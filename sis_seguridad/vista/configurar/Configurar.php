<?php
/**
*@package pXP
*@file Configurar.php
*@author  (mflores)
*@date 29-11-2011
*@description Para configurar la cuenta
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Configurar = Ext.extend(Phx.frmInterfaz,
{
	constructor: function(config)
	{
		Phx.vista.Configurar.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();	
	},	
	
	Atributos:
	[
       	{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_usuario'
			},
			type:'Field',
			form:true 
		},
       	{
       		config:{
	       		name: 'autentificacion',
				fieldLabel: 'Autentificación',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['Contraseña ENDESIS','Contraseña WINDOWS']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:0,
       		form:true
	    },
	    {
       		config:{
	       		name: 'modificar_clave',
				fieldLabel: 'Cambiar contraseña',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['SI','NO']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:1,
       		form:true
	    },	    
	    {
			config:{
				name: 'clave_anterior',
				fieldLabel: 'Contraseña anterior',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:255
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_nueva',
				fieldLabel: 'Nueva contraseña',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				showCapsWarning: false,
				showStrengthMeter: true,
				maxLength:255,
				validateValue:
				
					function(pw)
					{							
						function tiene_numeros(pw)
						{
							var expreg=/^.*[0-9]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}						
						
						function tiene_letras(pw)
						{
						   var expreg=/^.*[a-zA-Z������������]+.*$/;
						  
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
							
						function tiene_minusculas(pw)
						{
						   var expreg=/^.*[a-z������]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
					
						function tiene_mayusculas(pw)
						{
						   var expreg=/^.*[A-Z������]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
						
						function tiene_especial(pw)
						{
						   var expreg=/^.*\W+.*$/;	   //[^a-zA-Z0-9������������]
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}		
						
						var x = '';
						var seguridad = 0;												
											
						if(tiene_numeros(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene números<br>';
															
						if(tiene_minusculas(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene minúsculas<br>';
									
						
						if(tiene_mayusculas(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene mayúsculas<br>';
									
						
						if(tiene_especial(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene especiales<br>';
											
						if(pw.length > 8)
							seguridad += 18;
						else
							x += '8 caracteres mínimamente<br>';
						
						this.markInvalid(x);
						
						if(pw.length == 0)
							seguridad = 0;
							
						if(x=='')
							return true
						else
						    return false				
					}																			
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_confirmacion',
				fieldLabel: 'Confirmación',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:255
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_windows',
				fieldLabel: 'Contraseña actual de Windows',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:255
			},
			type:'TextField',
			id_grupo:0,
			grid:true,
			form:true
		},
		{
       		config:{
	       		name: 'estilo',
				fieldLabel: 'Estilo de vista',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['xtheme-blue.css','xtheme-gray.css','xtheme-access.css']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:0,
       		form:true
	    }
	],
	title:'Configuración',
	ActSave:'../../sis_seguridad/control/Configurar/configurar',
	topBar:true,
	botones:false,
	borientacion:false,
	bformato:false,
	btamano:false,
	labelReset:'Limpiar',
	tooltipSubmit:'<b>Guardar cambios</b>',
	tooltipReset:'<b>Limpiar campos</b>',	
	//iconSubmit:'../../../lib/imagenes/guardar.jpg',				
	
	//md5 en javascript
		
	MD5: function (string) 
	{
	   function RotateLeft(lValue, iShiftBits) 
	   {
	   		return (lValue<<iShiftBits) | (lValue>>>(32-iShiftBits));
	   }

	   function AddUnsigned(lX,lY) 
	   {
           var lX4,lY4,lX8,lY8,lResult;
           lX8 = (lX & 0x80000000);
           lY8 = (lY & 0x80000000);
           lX4 = (lX & 0x40000000);
           lY4 = (lY & 0x40000000);
           lResult = (lX & 0x3FFFFFFF)+(lY & 0x3FFFFFFF);
           if (lX4 & lY4)
           {
           		return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
           }
           if (lX4 | lY4) 
           {
               if (lResult & 0x40000000) 
               {
                    return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
               } 
               else 
               {
               		return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
               }
           } 
           else 
           {
           		return (lResult ^ lX8 ^ lY8);
           }
	   }

	   function F(x,y,z) { return (x & y) | ((~x) & z); }
	   function G(x,y,z) { return (x & z) | (y & (~z)); }
	   function H(x,y,z) { return (x ^ y ^ z); }
	   function I(x,y,z) { return (y ^ (x | (~z))); }

	   function FF(a,b,c,d,x,s,ac) 
	   {
           a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
           return AddUnsigned(RotateLeft(a, s), b);
	   };

	   function GG(a,b,c,d,x,s,ac) 
	   {
           a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
           return AddUnsigned(RotateLeft(a, s), b);
	   };

	   function HH(a,b,c,d,x,s,ac) 
	   {
           a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
           return AddUnsigned(RotateLeft(a, s), b);
	   };

	   function II(a,b,c,d,x,s,ac) 
	   {
           a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
           return AddUnsigned(RotateLeft(a, s), b);
	   };

	   function ConvertToWordArray(string) 
	   {
           var lWordCount;
           var lMessageLength = string.length;
           var lNumberOfWords_temp1=lMessageLength + 8;
           var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1 % 64))/64;
           var lNumberOfWords = (lNumberOfWords_temp2+1)*16;
           var lWordArray=Array(lNumberOfWords-1);
           var lBytePosition = 0;
           var lByteCount = 0;
           while ( lByteCount < lMessageLength ) 
           {
                   lWordCount = (lByteCount-(lByteCount % 4))/4;
                   lBytePosition = (lByteCount % 4)*8;
                   lWordArray[lWordCount] = (lWordArray[lWordCount] | (string.charCodeAt(lByteCount)<<lBytePosition));
                   lByteCount++;
           }
           lWordCount = (lByteCount-(lByteCount % 4))/4;
           lBytePosition = (lByteCount % 4)*8;
           lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80<<lBytePosition);
           lWordArray[lNumberOfWords-2] = lMessageLength<<3;
           lWordArray[lNumberOfWords-1] = lMessageLength>>>29;
           return lWordArray;
	   };

	   function WordToHex(lValue) 
	   {
           var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;
           for (lCount = 0;lCount<=3;lCount++) 
           {
               lByte = (lValue>>>(lCount*8)) & 255;
               WordToHexValue_temp = "0" + lByte.toString(16);
               WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2);
           }
           return WordToHexValue;
	   };

	   function Utf8Encode(string) 
	   {           
           string = string.replace(/\r\n/g,"\n");
           var utftext = "";

           for (var n = 0; n < string.length; n++) 
           {
               var c = string.charCodeAt(n);

               if (c < 128) 
               {
                   utftext += String.fromCharCode(c);
               }
               else if((c > 127) && (c < 2048)) 
               {
                   utftext += String.fromCharCode((c >> 6) | 192);
                   utftext += String.fromCharCode((c & 63) | 128);
               }
               else 
               {
                   utftext += String.fromCharCode((c >> 12) | 224);
                   utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                   utftext += String.fromCharCode((c & 63) | 128);
               }
           }

           return utftext;
	   };

	   var x=Array();
	   var k,AA,BB,CC,DD,a,b,c,d;
	   var S11=7, S12=12, S13=17, S14=22;
	   var S21=5, S22=9 , S23=14, S24=20;
	   var S31=4, S32=11, S33=16, S34=23;
	   var S41=6, S42=10, S43=15, S44=21;

	   string = Utf8Encode(string);
	   
	   x = ConvertToWordArray(string);

	   a = 0x67452301; b = 0xEFCDAB89; c = 0x98BADCFE; d = 0x10325476;

	   for (k=0;k<x.length;k+=16) 
	   {
           AA=a; BB=b; CC=c; DD=d;
           a=FF(a,b,c,d,x[k+0], S11,0xD76AA478);
           d=FF(d,a,b,c,x[k+1], S12,0xE8C7B756);
           c=FF(c,d,a,b,x[k+2], S13,0x242070DB);
           b=FF(b,c,d,a,x[k+3], S14,0xC1BDCEEE);
           a=FF(a,b,c,d,x[k+4], S11,0xF57C0FAF);
           d=FF(d,a,b,c,x[k+5], S12,0x4787C62A);
           c=FF(c,d,a,b,x[k+6], S13,0xA8304613);
           b=FF(b,c,d,a,x[k+7], S14,0xFD469501);
           a=FF(a,b,c,d,x[k+8], S11,0x698098D8);
           d=FF(d,a,b,c,x[k+9], S12,0x8B44F7AF);
           c=FF(c,d,a,b,x[k+10],S13,0xFFFF5BB1);
           b=FF(b,c,d,a,x[k+11],S14,0x895CD7BE);
           a=FF(a,b,c,d,x[k+12],S11,0x6B901122);
           d=FF(d,a,b,c,x[k+13],S12,0xFD987193);
           c=FF(c,d,a,b,x[k+14],S13,0xA679438E);
           b=FF(b,c,d,a,x[k+15],S14,0x49B40821);
           a=GG(a,b,c,d,x[k+1], S21,0xF61E2562);
           d=GG(d,a,b,c,x[k+6], S22,0xC040B340);
           c=GG(c,d,a,b,x[k+11],S23,0x265E5A51);
           b=GG(b,c,d,a,x[k+0], S24,0xE9B6C7AA);
           a=GG(a,b,c,d,x[k+5], S21,0xD62F105D);
           d=GG(d,a,b,c,x[k+10],S22,0x2441453);
           c=GG(c,d,a,b,x[k+15],S23,0xD8A1E681);
           b=GG(b,c,d,a,x[k+4], S24,0xE7D3FBC8);
           a=GG(a,b,c,d,x[k+9], S21,0x21E1CDE6);
           d=GG(d,a,b,c,x[k+14],S22,0xC33707D6);
           c=GG(c,d,a,b,x[k+3], S23,0xF4D50D87);
           b=GG(b,c,d,a,x[k+8], S24,0x455A14ED);
           a=GG(a,b,c,d,x[k+13],S21,0xA9E3E905);
           d=GG(d,a,b,c,x[k+2], S22,0xFCEFA3F8);
           c=GG(c,d,a,b,x[k+7], S23,0x676F02D9);
           b=GG(b,c,d,a,x[k+12],S24,0x8D2A4C8A);
           a=HH(a,b,c,d,x[k+5], S31,0xFFFA3942);
           d=HH(d,a,b,c,x[k+8], S32,0x8771F681);
           c=HH(c,d,a,b,x[k+11],S33,0x6D9D6122);
           b=HH(b,c,d,a,x[k+14],S34,0xFDE5380C);
           a=HH(a,b,c,d,x[k+1], S31,0xA4BEEA44);
           d=HH(d,a,b,c,x[k+4], S32,0x4BDECFA9);
           c=HH(c,d,a,b,x[k+7], S33,0xF6BB4B60);
           b=HH(b,c,d,a,x[k+10],S34,0xBEBFBC70);
           a=HH(a,b,c,d,x[k+13],S31,0x289B7EC6);
           d=HH(d,a,b,c,x[k+0], S32,0xEAA127FA);
           c=HH(c,d,a,b,x[k+3], S33,0xD4EF3085);
           b=HH(b,c,d,a,x[k+6], S34,0x4881D05);
           a=HH(a,b,c,d,x[k+9], S31,0xD9D4D039);
           d=HH(d,a,b,c,x[k+12],S32,0xE6DB99E5);
           c=HH(c,d,a,b,x[k+15],S33,0x1FA27CF8);
           b=HH(b,c,d,a,x[k+2], S34,0xC4AC5665);
           a=II(a,b,c,d,x[k+0], S41,0xF4292244);
           d=II(d,a,b,c,x[k+7], S42,0x432AFF97);
           c=II(c,d,a,b,x[k+14],S43,0xAB9423A7);
           b=II(b,c,d,a,x[k+5], S44,0xFC93A039);
           a=II(a,b,c,d,x[k+12],S41,0x655B59C3);
           d=II(d,a,b,c,x[k+3], S42,0x8F0CCC92);
           c=II(c,d,a,b,x[k+10],S43,0xFFEFF47D);
           b=II(b,c,d,a,x[k+1], S44,0x85845DD1);
           a=II(a,b,c,d,x[k+8], S41,0x6FA87E4F);
           d=II(d,a,b,c,x[k+15],S42,0xFE2CE6E0);
           c=II(c,d,a,b,x[k+6], S43,0xA3014314);
           b=II(b,c,d,a,x[k+13],S44,0x4E0811A1);
           a=II(a,b,c,d,x[k+4], S41,0xF7537E82);
           d=II(d,a,b,c,x[k+11],S42,0xBD3AF235);
           c=II(c,d,a,b,x[k+2], S43,0x2AD7D2BB);
           b=II(b,c,d,a,x[k+9], S44,0xEB86D391);
           a=AddUnsigned(a,AA);
           b=AddUnsigned(b,BB);
           c=AddUnsigned(c,CC);
           d=AddUnsigned(d,DD);
        }

        var temp = WordToHex(a)+WordToHex(b)+WordToHex(c)+WordToHex(d);

        return temp.toLowerCase();
	},
	
	// fin md5 javascript				
		
	Grupos: 
	[
    	{
            xtype:'tabpanel',
            plain:true,
            activeTab: 0,
            height:400,
            
            //  By turning off deferred rendering we are guaranteeing that the
            //  form fields within tabs that are not activated will still be rendered.
            //  This is often important when creating multi-tabbed forms.
            
           // deferredRender: false,
            defaults:{bodyStyle:'padding:10px 10px 9px 70px'},
            items:[{
                title:'Preferencias',
                layout:'form',
                id:'tab1-Phx.vista.Configurar-13579',
                items: [],
				id_grupo: 0
            },{
                //cls:'x-plain',
                title:'Cambio de contraseña',
                layout:'form',
                id:'tab2-Phx.vista.Configurar-02468',
                items: [],
				id_grupo: 1
            }]
        }
    ],
    
    onSubmit:function(o)
    {    
    	if(this.getComponente('clave_nueva').getValue() != this.getComponente('clave_confirmacion').getValue())
    	{
    		Ext.Msg.alert('ERROR', 'Confirmación no coincide con la contraseña nueva.');   
    		this.getComponente('clave_nueva').setValue(""); 		
    		this.getComponente('clave_confirmacion').setValue("");  		
    	}
    	
    	Phx.vista.Configurar.superclass.onSubmit.call(this,o); 
    },
    
    successSave:function(r)
    {		
		this.getComponente('clave_nueva').setValue("");
		this.getComponente('clave_anterior').setValue("");		
		this.getComponente('clave_confirmacion').setValue("");
		this.getComponente('clave_windows').setValue("");
		this.getComponente('modificar_clave').setValue("NO");
		
		Phx.vista.Configurar.superclass.successSave.call(this,r);	
		
		var auten = '';
		if(this.getComponente('autentificacion').getValue() == 'Contraseña WINDOWS')
		{
			auten = 'ldap';
		} 
		else
		{
			auten = 'local';
		}
		
		Phx.CP.config_ini.autentificacion = auten;	
		
		if(Phx.CP.config_ini.autentificacion == 'ldap')
		{
			this.getComponente('autentificacion').setValue("Contraseña WINDOWS");
		}
		else
		{
			this.getComponente('autentificacion').setValue("Contraseña ENDESIS");
		}
		
		this.getComponente('clave_nueva').disable();
		this.getComponente('clave_anterior').disable();		
		this.getComponente('clave_confirmacion').disable();
		this.getComponente('clave_windows').disable();
		this.ocultarComponente(this.getComponente('clave_anterior'));
		this.ocultarComponente(this.getComponente('clave_nueva'));
		this.ocultarComponente(this.getComponente('clave_confirmacion'));
		this.ocultarComponente(this.getComponente('clave_windows'));
	},
	
	conexionFailure:function(resp1,resp2,resp3,resp4,resp5)
	{		
		this.getComponente('clave_nueva').setValue("");
		this.getComponente('clave_anterior').setValue("");		
		this.getComponente('clave_confirmacion').setValue("");
		this.getComponente('clave_windows').setValue("");
		Phx.vista.Configurar.superclass.conexionFailure.call(this,resp1,resp2,resp3,resp4,resp5)
	},
	
	iniciarEventos:function()
	{		
		var tab2 = Ext.getCmp('tab2-Phx.vista.Configurar-02468');
		this.getComponente('clave_nueva').disable();
		this.getComponente('clave_anterior').disable();		
		this.getComponente('clave_confirmacion').disable();
		this.getComponente('clave_windows').disable();
		
		this.ocultarComponente(this.getComponente('clave_anterior'));
		this.ocultarComponente(this.getComponente('clave_nueva'));
		this.ocultarComponente(this.getComponente('clave_confirmacion'));
		this.ocultarComponente(this.getComponente('clave_windows'));
								
		if(Phx.CP.config_ini.autentificacion == 'local')
		{
			this.getComponente('autentificacion').setValue('Contraseña ENDESIS');
			tab2.enable();
		}
		else
		{
			this.getComponente('autentificacion').setValue('Contraseña WINDOWS');
			tab2.disable();
		}					
		
		this.getComponente('modificar_clave').setValue('NO');
		this.getComponente('estilo').setValue(Phx.CP.config_ini.estilo_vista);
		
		this.getComponente('autentificacion').on('select',function(c,r,i)
		{				
			if(i==1) //contraseña windows
			{
				this.mostrarComponente(this.getComponente('clave_windows'));
				this.getComponente('clave_windows').enable();
				tab2.disable();
			}
			else //contraseña endesis
			{
				this.ocultarComponente(this.getComponente('clave_windows'));
				this.getComponente('clave_windows').disable();
				tab2.enable();
			}
		},this);
		
		this.getComponente('modificar_clave').on('select',function(c,r,i)
		{				
			if(i==0) //cambiar clave -- SI
			{
				this.mostrarComponente(this.getComponente('clave_anterior'));
				this.mostrarComponente(this.getComponente('clave_nueva'));
				this.mostrarComponente(this.getComponente('clave_confirmacion'));
				this.getComponente('clave_nueva').enable();
				this.getComponente('clave_anterior').enable();		
				this.getComponente('clave_confirmacion').enable();
			}
			else //NO
			{
				this.ocultarComponente(this.getComponente('clave_anterior'));
				this.ocultarComponente(this.getComponente('clave_nueva'));
				this.ocultarComponente(this.getComponente('clave_confirmacion'));
				this.getComponente('clave_nueva').disable();
				this.getComponente('clave_anterior').disable();		
				this.getComponente('clave_confirmacion').disable();
			}
		},this);			
		
		this.getComponente('estilo').on('select',function(c,r,i)
		{
			Phx.CP.setEstiloVista(this.getComponente('estilo').getValue());
		},this);
			
	},			
})
</script>