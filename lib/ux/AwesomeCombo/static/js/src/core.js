/**
 * Advanced and lightweight combobox
 * with multi-selection options.
 *
 * @author
 * @version
 * @class {{classname}}
 * @extends Ext.form.ComboBox
 * @constructor
 * @param {Object} config Configuration options
 * @xtype {{xtype}}
 */
{{classname}} = {
	/**
	 * @cfg {Boolean} enableTooltip
	 * True to enable tooltip on field
	 * hover, false to disable it.
	 * Defaults to true.
	 */
	enableTooltip: true,

	/**
	 * @cfg {Boolean} enableMultiSelect
	 * True to enable this component to handle multiple items selections.
	 * Defaults to false.
	 */
	enableMultiSelect: false,

	/**
	 * @cfg {String} format
	 * If value is set to "string" the getValue method will return
	 * selected value(s) as string.
	 * Else if value is set to "object" the getValue method will return
	 * selected value(s) as object.
	 * Defaults to "string".
	 */
	format: 'string',

	/**
	 * @cfg {String} formatSeparator
	 * This parameter is only used if {@link {{classname}}#format format}
	 * is set to "string".
	 * Defines separator used to split {@link {{classname}}#setValue setValue}
	 * given arg and to join {@link {{classname}}#getValue getValue} return.
	 */
	formatSeparator: ',',

	/**
	 * @cfg {Boolean} disableClearButton
	 * Set this parameter to true to hide trigger clear button.
	 * Defaults to false.
	 */
	disableClearButton: false,

	/**
	 * @cfg {Ext.XTemplate} tpl
	 * Override template.
	 */
	tpl: undefined,

	/**
	 * @cfg {Ext.XTemplate} tooltipTitleTpl (optional)
	 * Tooltip title template.
	 * Combo will pass mixed collection to this template.
	 */
	tooltipTitleTpl: undefined,

	/**
	 * @cfg {Ext.XTemplate} tooltipContentTpl (optional)
	 * Tooltip content template.
	 * Combo will pass mixed collection to this template.
	 */
	tooltipContentTpl: undefined,

	/**
	 * @cfg {String} itemSelection
	 * Override this parameter according to template given via
	 * {@link {{classname}}#tpl tpl} config.
	 * Defaults to "div.{{xtype}}" if
	 * {@link {{classname}}#enableMultiSelect enableMultiSelect} config is set
	 * to true, else default comboBox value.
	 */
	//itemSelector: 'div.{{xtype}}-item',

	/**
	 * @cfg {Int} pageSize
	 * Defaults to 0.
	 */
	pageSize: 0,

	/**
	 * @cfg {String} loadingText
	 * Override loading text.
	 */
	loadingText: 'Searching...',

	/**
	 * @cfg {String} trigger1Class (optional)
	 * Css class for clear button.
	 * Defaults to "x-form-clear-trigger".
	 */
	trigger1Class: 'x-form-clear-trigger',

	/**
	 * @cfg {String} trigger2Class (optional)
	 * Css class for expand button.
	 * Defaults to "x-form-trigger".
	 */
	trigger2Class: 'x-form-trigger',

	// private
	initComponent: function() {
		if (Ext.isString(this.emptyText)) {
			this.hasEmptyText = this.emptyText;
		} else {
			this.hasEmptyText = false;
		}
		this.triggerConfig = {
			tag: 'span',
			cls: 'x-form-twin-triggers',
			cn: [{
				tag: 'img',
				src: Ext.BLANK_IMAGE_URL,
				alt: '',
				cls: 'x-form-trigger ' + this.trigger1Class
			}, {
				tag: 'img',
				src: Ext.BLANK_IMAGE_URL,
				alt: '',
				cls: 'x-form-trigger ' + this.trigger2Class
			}]
		};
		var minListWidth = this.minListWidth;
		if (this.pageSize && minListWidth < 227) {
			minListWidth = 227;
		}
		Ext.apply(this, Ext.apply(this.initialConfig, {
			minListWidth: minListWidth
		}));
		if (this.store) {
			this.store = this.setMemoryStore(this.store);
		}
		if (this.enableMultiSelect === false) {
			Ext.apply(this, { enableKeyEvents: true });
			Ext.apply(this.initialConfig, { enableKeyEvents: true });
			this.on('keyup', this.onFieldKeyUp, this);
		}
		{{classname}}.superclass.initComponent.call(this);
		var config = {
			tpl: new Ext.XTemplate(
			'<tpl for="."><div class="{{xtype}}-item {checked}">',
			'{[this.wordwrap(values.', this.displayField || 'field1', ')]}',
			'</div></tpl>', {
				compiled: true,
				wordwrap: function(value) {
					if (value.length > 45) {
						return (value.substr(0, 45) + '...');
					}
					return (value);
				}
			}),
			itemSelector: 'div.{{xtype}}-item'
		};
		if (this.enableMultiSelect && Ext.isDefined(this.tpl) === false) {
			Ext.apply(this, config);
			Ext.apply(this.initialConfig, config);
		}
		this.addEvents(
		/**
		 * @event beforeentrycheck
		 * Fires before an entry is checked. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentrycheck',

		/**
		 * @event entrycheck
		 * Fires when an entry is checked.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entrycheck',

		/**
		 * @event beforeentryuncheck
		 * Fires before an entry is unchecked. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentryuncheck',

		/**
		 * @event entryuncheck
		 * Fires when an entry is unchecked.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entryuncheck',

		/**
		 * @event beforetooltipshow
		 * Fires before tooltip show. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'beforetooltipshow',

		/**
		 * @event tooltipshow
		 * Fires when tooltip show.
		 * @param {{{classname}}} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'tooltipshow',

		/**
		 * @event beforedisplayrefresh
		 * Fires before display is refreshed. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated value
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'beforedisplayrefresh',

		/**
		 * @event displayrefresh
		 * Fires when display is refreshed.
		 * @param {{{classname}}} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated text
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'displayrefresh',

		/**
		 * @event beforereset
		 * Fires before reset is called. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 */
		'beforereset',

		/**
		 * @event reset
		 * Fires when reset is called.
		 * @param {{{classname}}} combo This combo box
		 */
		'reset',

		/**
		 * @event beforetriggerclick
		 * Fires when expand/toggle trigger was clicked. Return false to cancel the action.
		 * @param {{{classname}}} combo This combo box
		 */
		'beforetriggerclick'
		);
		this.internal = new Ext.util.MixedCollection();
		this.internal.addListener('add', this.onInternalAdd, this);
		this.internal.addListener('clear', this.onInternalClear, this);
		this.internal.addListener('remove', this.onInternalRemove, this);
		this.hasPageTbButton = false;
		if (Ext.isDefined(this.store)) {
			this.store.on('load', this.onStoreLoad, this);
		}
		this.on('beforeselect', this.onBeforeSelect, this);
		this.on('afterrender', this.onAfterRender, this);
		this.on('expand', this.onExpand, this);
		this.on('collapse', this.onCollapse, this);
	},

	/**
	 * Check if given record is checked.
	 * @param {Ext.data.Record} record The record to check
	 * @return {Boolean} True if record is checked else false
	 */
	isChecked: function(record) {
		var index = record.get(this.valueField).toString();
		var success = this.internal.containsKey(index);
		if (success) {
			var item = this.internal.get(index);
			item[this.displayField] = record.get(this.displayField);
		}
		return (success);
	},

	/**
	 * Flush all values.
	 */
	reset: function() {
		if (this.fireEvent('beforereset', this) === false) {
			return (false);
		}
		this.internal.clear();
		if (this.isExpanded()) {
			this.refreshDisplay();
		}
		this.fireEvent('reset', this);
	},

	/**
	 * Uncheck the given record and remove it from values.
	 * @param {Ext.data.Record} record The record to uncheck
	 */
	uncheckRecord: function(record) {
		if (this.enableMultiSelect !== true) {
			this.internal.clear();
		} else {
			var index = record.get(this.valueField).toString();
			this.internal.removeKey(index);
		}
	},

	/**
	 * Check the given record and add it to values.
	 * @param {Ext.data.Record} record The record to check
	 */
	checkRecord: function(record) {
		if (this.enableMultiSelect !== true) {
			this.internal.clear();
			this.setValue(record.get(this.valueField));
		} else {
			var index = record.get(this.valueField).toString();
			var item = {};
			item[this.valueField] = record.get(this.valueField);
			item[this.displayField] = record.get(this.displayField);
			this.internal.add(index, item);
		}
	},

	/**
	 * Returns the currently selected field value or
	 * empty string if no value is set.
	 * @param {String} forcedFormat (optional) Force output format.
	 * Defaults to {@link {{classname}}#format format} parameter value.
	 * @return {Mixed} value
	 * The selected value(s) corresponding to
	 * {@link {{classname}}#format format} parameter value.
	 */
	getValue: function(forcedFormat) {
		if (Ext.isDefined(forcedFormat) === false) {
			forcedFormat = this.format;
		}
		if (forcedFormat === 'object') {
			return (this.getObjectValue());
		} else {
			return (this.getStringValue());
		}
	},

	// private
	getDisplayValue: function() {
		if (this.internal.getCount()) {
			var item = this.internal.get(0);
			if (Ext.isDefined(item[this.displayField])) {
				return (item[this.displayField]);
			} else {
				return (item[this.valueField]);
			}
		} else {
			return (false);
		}
	},

	// private
	defaultCheckRecords: function() {
		this.getStore().each(function(record) {
			record.set('checked', (this.isChecked(record) ? 'checked' : 'unchecked'));
			record.commit(true);
		}, this);
	},

	/**
	 * Set value.
	 * @param {Mixed} value
	 * - Could be single/multiple valueField values separate by {@link {{classname}}#formatSeparator}
	 * - Could be single/multiple javascript object values
	 */
	setValue: function(value) {
		if (value == this.getRawValue()) {
			this.refreshDisplay();
			return (this);
		}
		this.isSettingValue = true;
		this.reset();
		if (Ext.isArray(value)) {
			this.setArrayValue(value);
		} else if (Ext.isObject(value)) {
			this.setObjectValue(value);
		} else if (Ext.isString(value)) {
			this.setStringValue(value);
		}
		this.isSettingValue = false;
		this.refreshDisplay();
		return (this);
	},

	// private
	refreshDisplay: function(forced) {
		forced = forced || false;
		if (this.rendered === false || (forced === false && (this.isExpanded() ||
			this.isSettingValue))) {
			return (false);
		}
		this.generateDisplayText();
		if (this.fireEvent('beforedisplayrefresh', this,
			this.displayNb, this.displayText, this.valueFound) === false) {
			return (false);
		} else {
			if (this.displayNb == 1) {
				if (this.disableClearButton === false) {
					this.triggers[0].show();
				}
				if (this.valueFound) {
					this.clearValue();
					this.el.removeClass(this.emptyClass);
					this.setRawValue(this.displayText);
				} else {
					this.emptyText = '1 item selected';
					this.clearValue();
				}
				this.fireEvent('displayrefresh', this, this.displayNb,
					this.displayText, this.valueFound);
				return (true);
			} else if (this.displayNb > 0) {
				if (this.disableClearButton === false) {
					this.triggers[0].show();
				}
			} else {
				if (Ext.isString(this.hasEmptyText)) {
					this.displayText = this.hasEmptyText;
				} else {
					this.displayText = '';
				}
				if (this.disableClearButton === false) {
					this.triggers[0].hide();
				}
			}
		}
		this.emptyText = this.displayText;
		this.clearValue();
		this.fireEvent('displayrefresh', this, this.displayNb,
			this.displayText, this.valueFound);
		return (true);
	},

	// private
	generateDisplayText: function() {
		this.displayNb = this.internal.getCount();
		this.displayText = '';
		this.valueFound = false;
		var selectedValue = '';
		this.internal.each(function(item, index, length) {
			if (Ext.isDefined(item[this.displayField])) {
				selectedValue = item[this.displayField];
				this.valueFound = true;
			}
		}, this);
		if (this.displayNb > 0) {
			if (this.displayNb == 1) {
				this.displayText = selectedValue;
			} else {
				this.displayText = this.displayNb + ' item' +
					(this.displayNb > 1 ? 's' : '') + ' selected';
			}
		} else {
			this.displayText = this.emptyText;
		}
	}

	// private
	,setMemoryStore:function(store) {
		if (this.pageSize > 0 && Ext.isArray(store)) {
			this.valueField = this.displayField = "field1";
			var fields = [this.valueField];
			if (Ext.isArray(store[0])) {
				this.displayField = "field2";
				for (var i = 2, len = store[0].length; i <= len; ++i) {
					fields.push('field' + i);
				}
			}
			store = new Ext.data.Store({
				autoCreated: false,
				autoDestroy: true,
				reader:new Ext.data.ArrayReader({}, fields),
				proxy:new Ext.ux.data.PagingMemoryProxy(store)
			});
		}
		return store;
	}
};
