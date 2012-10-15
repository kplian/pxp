/*
**********************************************************
Nombre de la clase:	    EncriptacionPrivada
Propósito:				Manejo de encriptaciona simetrica publica + redes de feistel
Fecha de Creación:		21 - 11 - 09
Versión:				0
Autor:					Rensi Arteaga Copari
**********************************************************
*/



Ext.namespace('Phx','Phx.vista');

Phx.Encriptacion=function(config){
	Ext.apply(this,config);
	Phx.Encriptacion.superclass.constructor.call(this,config);
	this.key =  new this.RSAKeyPair(this.encryptionExponent, this.decryptionExponent, this.modulus);
	
}

Ext.extend(Phx.Encriptacion,Ext.util.Observable,{
	alfabeto:"0123456789. ",
	vueltas:2,
	encryptionExponent:"0", 
	decryptionExponent:"0", 
	modulus:"0",
	permutacion:'0',
	k:'0',
	x:1,//para definir si se encripta o no
	Encriptar:function(s){
	return this.EncriptarFeistel(this.encryptedString(s));	
    },

	EncriptarFeistel:function(original){
		
		vueltas=2;
		//creamos el modelo de columnas
		tamano_bloque = this.permutacion.length;
		tamano_total =original.length
		//desarma el texto original
		var aux=this.desarmar(original,tamano_bloque,tamano_total);
		//muestra resultados
		for(var i = 0;i < vueltas;i++ ){
			aux=this.sustitucion(aux,this.k)
			aux=this.permutar(aux,this.permutacion);
			if(i!=vueltas -1){
				aux = this.Girar(aux);
			}

		}
		
		return this.armar(aux)
		
	},



	//esta funcion intercabia el bloque izquierdo por el derecho
	Girar:function(Vec){
		var Vec2 = new Array();
		for(j=0 ;j< Vec.length ; j=j+2){
			Vec2[j+1]=Vec[j];
			Vec2[j]=Vec[j+1];
		}
		return Vec2
	},


	sustitucion:function(Vec,k){

		var Vec2 = new Array();
		var Vec2=new Array();


		for(var i =0; i < Vec.length; i ++){


			if(i%2==1){

				Vec2[i]=Vec[i];
			}
			else{
				Vec2[i]=this.SustituirCadena(Vec[i],k);
			}

		}
		return Vec2;

	},


	SustituirCadena:function(cadena,k){

		var aux='';
		for(var j=0 ; j < cadena.length; j ++){
			ind_aux=(parseInt(this.alfabeto.indexOf(cadena.charAt(j))) + parseInt(k))% this.alfabeto.length;
			aux= aux + this.alfabeto.charAt( ind_aux    );

		}

		return aux;

	},


	permutar:function(Vec,per){
		var Vec2=new Array();
		for(var i =0; i < Vec.length; i ++){
			if(i%2==1){
				Vec2[i]=Vec[i];
			}
			else{
				Vec2[i]=this.PermutacionCadena(Vec[i],per);
			}
		}
		return Vec2;
	},


	PermutacionCadena:function(cadena,per){
		var aux = '';
		for(var j = 0; j<=per.length; j++){
			aux=aux+cadena.charAt(per.charAt(j)-1);
		}

		return aux;
	},

	//descomponente en un numero de bolques par para iniciar el cifrado

	desarmar:function(org,tb,tt){

		var Vec = new Array()
		var i = Math.floor(tt / tb); //cantidad de bloques
		var llave=0;
		var sw=false;

		if(tt-(i*tb) > 0){
			i=i+1;
			llave=(i*tb)-tt
		}

		if(i %2 == 1){
			i=i+1;
			sw=true
		}

		var n_aux1=0;
		var n_aux2=tb

		for(var j=0; j < i; j++){

			Vec[j]=org.substr(n_aux1,n_aux2);
			n_aux1=n_aux1+tb;
			n_aux2=n_aux2+tb;

			if(j== i-1 && !sw){
				for(var l=0; l <  llave ;l++){
					Vec[j]=Vec[j]+' ';
				}
			}

			if(j== i-2&&sw){
				for(var l=0; l <  llave ;l++){
					Vec[j]=Vec[j]+' '
				}
			}

			if(j== i-1&&sw){

				for(var l=0; l <  tb ;l++){
					Vec[j]=Vec[j]+' ';
				}
			}
		}

		return Vec
	},
	armar:function(Vec){
		var text=new String()
		for(var i = 0; i <Vec.length;i++)
		text = text + Vec[i];
		return text;
	},
	
	
	// RSA, a suite of routines for performing RSA public-key computations in
	// JavaScript.
	//
	// Requires BigInt.js and Barrett.js.
	//
	// Copyright 1998-2005 David Shapiro.
	//
	// You may use, re-use, abuse, copy, and modify this code to your liking, but
	// please keep this header.
	//
	// Thanks!
	// 
	// Dave Shapiro
	// dave@ohdave.com 


	 encryptedString:function(s){
		// Altered by Rob Saunders (rob@robsaunders.net). New routine pads the
		// string after it has been converted to an array. This fixes an
		// incompatibility with Flash MX's ActionScript.
	
		var a = new Array();
		var sl = s.length;
		var i = 0;
		while (i < sl) {
			a[i] = s.charCodeAt(i);
			i++;
		}

		while (a.length % this.key.chunkSize != 0) {
			a[i++] = 0;
		}
		var al = a.length;
		var result = "";
		var j, k, block;
		for (i = 0; i < al; i += this.key.chunkSize) {
			block = new BigInt();
			j = 0;
			for (k = i; k < i + this.key.chunkSize; ++j) {
				block.digits[j] = a[k++];
				block.digits[j] += a[k++] << 8;
			}
			var crypt = this.key.barrett.powMod(block, this.key.e);
			var text = this.key.radix == 16 ? biToDecimal(crypt) : biToString(crypt, this.key.radix);
			result += text + ".";
		}
		return result.substring(0, result.length - 1); // Remove last space.
	},
	 RSAKeyPair:function(encryptionExponent, decryptionExponent, modulus){
		
		this.e = biFromDecimal(encryptionExponent);
		this.d = biFromDecimal(decryptionExponent);
		this.m = biFromDecimal(modulus);
		

		// We can do two bytes per digit, so
		// chunkSize = 2 * (number of digits in modulus - 1).
		// Since biHighIndex returns the high index, not the number of digits, 1 has
		// already been subtracted.
		this.chunkSize = 2 * biHighIndex(this.m);
		this.radix = 10;
		this.barrett = new BarrettMu(this.m);
	}

});


