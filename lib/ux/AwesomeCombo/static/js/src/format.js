// private {{classname}} format.
{{classname}} = Ext.apply({{classname}}, {
	// private
	setStringValue: function(value) {
		var values = value.split(this.formatSeparator);
		var length = values.length;
		for (var i = 0; i < length; ++i) {
			var index = values[i].toString();
			if (Ext.isEmpty(index) === false) {
				var item = {};
				item[this.valueField] = values[i];
				this.internal.add(index, item);
				if (this.enableMultiSelect !== true) {
					{{classname}}.superclass.setValue.call(this, values[i]);
					break;
				}
			}
		}
	},

	// private
	setArrayValue: function(value) {
		var success = false;
		for (var i in value) {
			if (i == this.valueField) {
				success = this.setObjectValue(value);
			} else if (Ext.isObject(value[i])) {
				success = this.setObjectValue(value[i]);
			} else if (Ext.isArray(value[i])) {
				success = this.setArrayValue(value[i]);
			}
			if (this.enableMultiSelect !== true && success) {
				break;
			}
		}
		return (success);
	},

	// private
	setObjectValue: function(value) {
		if (Ext.isDefined(value[this.valueField])) {
			var index = value[this.valueField].toString();
			if (Ext.isEmpty(index) === false) {
				var item = {};
				item[this.valueField] = value[this.valueField];
				this.internal.add(index, item);
				if (Ext.isDefined(value[this.displayField])) {
					this.internal.get(index)[this.displayField] = value[this.displayField];
				}
				return (true);
			}
		}
		return (false);
	},

	// private
	getStringValue: function() {
		var values = new Array();
		if (this.internal.getCount()) {
			this.internal.eachKey(function(key, item) {
				if (this.enableMultiSelect) {
					values.push(key);
				} else if (values.length == 0) {
					values.push(key);
				}
			}, this);
		}
		if (this.enableMultiSelect !== true) {
			return (values.pop());
		}
		return (values.join(this.formatSeparator));
	},

	// private
	getObjectValue: function() {
		var values = new Array();
		if (this.internal.getCount()) {
			this.internal.eachKey(function(key, item) {
				if (this.enableMultiSelect) {
					values.push(item);
				} else if (values.length == 0) {
					values.push(item);
				}
			}, this);
		}
		if (this.enableMultiSelect !== true) {
			return (values.pop());
		}
		return (values);
	}
});

{{classname}} = Ext.extend(Ext.form.ComboBox, {{classname}});

Ext.reg('{{xtype}}', {{classname}});
