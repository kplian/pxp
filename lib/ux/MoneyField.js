Ext.ns('Ext.ux');
Ext.ux.MoneyField = Ext.extend(Ext.form.NumberField, {
	fieldClass: 'x-form-field x-form-money-field',
	currencyChar: '$',
	numberDelim: ',',
	delimLength: 3,
	alwaysShowCents: true,
	
	initEvents: function() {
		Ext.ux.MoneyField.superclass.initEvents.call(this);
		var allowed = this.baseChars + '';
		var stripBeforeParse = [];
		
        if (this.allowDecimals) {
            allowed += this.decimalSeparator;
        }
        if (this.allowNegative) {
            allowed += '-';
        } if (this.currencyChar) {
			allowed += this.currencyChar;
			stripBeforeParse.push(Ext.escapeRe(this.currencyChar));
		} if (this.numberDelim) {
			allowed += this.numberDelim;
			stripBeforeParse.push(Ext.escapeRe(this.numberDelim));
		}
        this.maskRe = new RegExp('[' + Ext.escapeRe(allowed) + ']');
		this.stripBeforeParseRe = new RegExp('[' + stripBeforeParse.join('|') + ']','g');
	},
	
	getErrors: function() {
		var errors = Ext.form.NumberField.superclass.getErrors.apply(this, arguments);        
                return errors;
	},
	
	setValue: function(v) {
		if(v){
		   v = this.formatValue(this.parseValue(v));
		if (!Ext.isEmpty(v)) this.setRawValue(v);
		}
		else{
			
			Ext.form.NumberField.superclass.setValue.call(this,v);
		}
	},
	
	beforeBlur: function() {
		var v = this.parseValue(this.getRawValue());
		if (!Ext.isEmpty(v)) {
			this.setRawValue(this.formatValue(v));
		}
	},
	
	parseValue: function(value) {
		value = String(value).replace(this.stripBeforeParseRe, '');
		value = Ext.ux.MoneyField.superclass.parseValue.call(this, value);
		return value;
	},
	
	formatValue: function(value) {
		value = String(Ext.ux.MoneyField.superclass.fixPrecision.call(this, value));
		var vSplit = value.split('.');
		
		var cents = (vSplit[1]) ? '.' + vSplit[1] : '';
		if (this.alwaysShowCents && cents == '') cents = '.00';
		
		if (this.numberDelim && this.delimLength) {
			var numbers = vSplit[0].split('');
			var sNumbers = [];
			var c=0;
			while (numbers.length > 0) {
				c++;
				if (c > this.delimLength) c = 1;
				sNumbers.unshift(numbers.pop());
				if (c == this.delimLength && numbers.length > 0) sNumbers.unshift(this.numberDelim);
			}
			value = sNumbers.join('') + cents;
		} else {
                        value = vSplit[0] + cents;
                }
		if (this.currencyChar) value = this.currencyChar + String(value);
		return value;
	}
});

Ext.reg('moneyfield', Ext.ux.MoneyField);
Ext.form.MoneyField=Ext.ux.MoneyField;