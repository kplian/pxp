// private {{classname}} events.
{{classname}} = Ext.apply({{classname}}, {
	// private
	onBeforeSelect: function(combo, record, index) {
		if (this.isChecked(record) && this.enableMultiSelect) {
			if (this.fireEvent('beforeentryuncheck', this, record, index) === false) {
				return (false);
			}
			this.uncheckRecord(record);
			this.fireEvent('entryuncheck', this, record, index);
		} else {
			if (this.fireEvent('beforeentrycheck', this, record, index) === false) {
				return (false);
			}
			this.checkRecord(record);
			if (this.enableMultiSelect !== true) {
				this.collapse();
				this.refreshDisplay();
			}
			this.fireEvent('entrycheck', this, record, index);
		}
		this.fireEvent('select', this, record, index);
		return (false);
	},

	// private
	onCollapse: function(combo) {
		this.refreshDisplay(true);
	},

	// private
	onAfterRender: function(cmp) {
		if (this.enableTooltip) {
			this.getTooltip();
		}
		if (this.disableClearButton) {
			this.triggers[0].hide();
		}
		this.refreshDisplay();
	},

	// private
	onFieldKeyUp: function(textfield, event) {
		if (this.enableMultiSelect === false) {
			var rawValue = this.getRawValue();
			if (rawValue.length == 0) {
				this.reset();
			}
		}
	},

	// private
	onExpand: function(combo) {
		if (this.hasPageTbButton == false) {
			this.hasPageTbButton = true;
			this.defaultCheckRecords();
		}
	},

	// private
	onStoreLoad: function(store, records, options) {
		for (i in records) {
			if (Ext.isObject(records[i])) {
				if (this.enableMultiSelect !== true) {
					records[i].beginEdit();
				}
				records[i].set('checked',
					(this.isChecked(records[i]) ? 'checked' : 'unchecked'));
				if (this.enableMultiSelect !== true) {
					records[i].endEdit();
				}
			}
		}
	},

	// private
	onInternalAdd: function(index, obj, key) {
		var record = this.findRecord(this.valueField, key);
		if (Ext.isObject(record)) {
			obj[this.displayField] = record.get(this.displayField);
			if (this.enableMultiSelect !== true) {
				record.beginEdit();
			}
			record.set('checked', 'checked');
			if (this.enableMultiSelect !== true) {
				record.endEdit();
			}
		}
		this.refreshDisplay();
	},

	// private
	onInternalClear: function() {
		this.getStore().each(function(record) {
			if (this.enableMultiSelect !== true) {
				record.beginEdit();
			}
			record.set('checked', 'unchecked');
			if (this.enableMultiSelect !== true) {
				record.endEdit();
			}
		});
		this.refreshDisplay();
	},

	// private
	onInternalRemove: function(obj, key) {
		var record = this.findRecord(this.valueField, key);
		if (Ext.isObject(record)) {
			if (this.enableMultiSelect !== true) {
				record.beginEdit();
			}
			record.set('checked', 'unchecked');
			if (this.enableMultiSelect !== true) {
				record.endEdit();
			}
		}
		this.refreshDisplay();
	}
});