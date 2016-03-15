/*
usage:


var eurFormatter = Ext.util.Format.CurrencyFactory(2, ",", ".", "\u20ac", true);
var value = 12345.67;
return eurFormatter(value); //--> 12.345,67€

var usFormatter = Ext.util.Format.CurrencyFactory();
var value = 12345.67;
return usFormatter(value); //--> $12,345.67

*/
if (Ext.util.Format) {
	if (!Ext.util.Format.CurrencyFactory) {
		Ext.util.Format.CurrencyFactory = function(dp, dSeparator, tSeparator, symbol, rightPosition) {
			
			
			return function(n) {
				
				if(n){
		            dp = Math.abs(dp) + 1 ? dp : 2;
					dSeparator = dSeparator || "."; 
					tSeparator = tSeparator || ",";
					symbol = symbol || "$";
					rightPosition = rightPosition || false;
					
					var m = /(\d+)(?:(\.\d+)|)/.exec(n + ""),
					x = m[1].length > 3 ? m[1].length % 3 : 0;
					
					var v = (n < 0? '-' : '') // preserve minus sign
					+ (x ? m[1].substr(0, x) + tSeparator : "")
					+ m[1].substr(x).replace(/(\d{3})(?=\d)/g, "$1" + tSeparator)
					+ (dp? dSeparator + (+m[2] || 0).toFixed(dp).substr(2) : "");
	
				    return rightPosition?v+symbol:symbol+v;
				}
				else{
					
					return '-';
				}
			};
		};
	}
	
}

var bolFormatter = Ext.util.Format.CurrencyFactory(2, ",", ".", " Bs.", false);