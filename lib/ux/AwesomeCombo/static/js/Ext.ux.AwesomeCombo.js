/**
 * Advanced and lightweight combobox
 * with multi-selection options.
 *
 * @author Revolunet
 * @version 0.1.3
 * @class Ext.ux.AwesomeCombo
 * @extends Ext.form.ComboBox
 * @constructor
 * @param {Object} config Configuration options
 * @xtype awesomecombo
 */
Ext.ux.AwesomeCombo = {
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
	 * This parameter is only used if {@link Ext.ux.AwesomeCombo#format format}
	 * is set to "string".
	 * Defines separator used to split {@link Ext.ux.AwesomeCombo#setValue setValue}
	 * given arg and to join {@link Ext.ux.AwesomeCombo#getValue getValue} return.
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
	 * {@link Ext.ux.AwesomeCombo#tpl tpl} config.
	 * Defaults to "div.awesomecombo" if
	 * {@link Ext.ux.AwesomeCombo#enableMultiSelect enableMultiSelect} config is set
	 * to true, else default comboBox value.
	 */
	//itemSelector: 'div.awesomecombo-item',

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
		Ext.ux.AwesomeCombo.superclass.initComponent.call(this);
		var config = {
			tpl: new Ext.XTemplate(
			'<tpl for="."><div class="awesomecombo-item {checked}">',
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
			itemSelector: 'div.awesomecombo-item'
		};
		if (this.enableMultiSelect && Ext.isDefined(this.tpl) === false) {
			Ext.apply(this, config);
			Ext.apply(this.initialConfig, config);
		}
		this.addEvents(
		/**
		 * @event beforeentrycheck
		 * Fires before an entry is checked. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentrycheck',

		/**
		 * @event entrycheck
		 * Fires when an entry is checked.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entrycheck',

		/**
		 * @event beforeentryuncheck
		 * Fires before an entry is unchecked. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentryuncheck',

		/**
		 * @event entryuncheck
		 * Fires when an entry is unchecked.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entryuncheck',

		/**
		 * @event beforetooltipshow
		 * Fires before tooltip show. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'beforetooltipshow',

		/**
		 * @event tooltipshow
		 * Fires when tooltip show.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'tooltipshow',

		/**
		 * @event beforedisplayrefresh
		 * Fires before display is refreshed. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated value
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'beforedisplayrefresh',

		/**
		 * @event displayrefresh
		 * Fires when display is refreshed.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated text
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'displayrefresh',

		/**
		 * @event beforereset
		 * Fires before reset is called. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 */
		'beforereset',

		/**
		 * @event reset
		 * Fires when reset is called.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 */
		'reset',

		/**
		 * @event beforetriggerclick
		 * Fires when expand/toggle trigger was clicked. Return false to cancel the action.
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 */
		'beforetriggerclick',
		
		
		/**
		 * @event clear
		 * RAC 01112011
		 * se dipsra al limpiar los datos del combo
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 */
		'clearcmb'
		
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
	 * Defaults to {@link Ext.ux.AwesomeCombo#format format} parameter value.
	 * @return {Mixed} value
	 * The selected value(s) corresponding to
	 * {@link Ext.ux.AwesomeCombo#format format} parameter value.
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
	 * - Could be single/multiple valueField values separate by {@link Ext.ux.AwesomeCombo#formatSeparator}
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

// private Ext.ux.AwesomeCombo override.
Ext.apply(Ext.ux.AwesomeCombo, {
	// private
	beforeBlur: function() {
		if (Ext.isDefined(this.store)) {
			Ext.ux.AwesomeCombo.superclass.beforeBlur.call(this);
		}
		this.refreshDisplay();
	},

	// private
	onTrigger1Click: function() {
		if (this.readOnly || this.disabled) {
			return;
		}
		this.reset();
		this.validate();
		//RAC 01/11/11
		//aumenta el evento para cuando se limpia el contenido
		this.fireEvent('clearcmb', this);
		
		
	},

	// private
	onTrigger2Click: function() {
		if (this.fireEvent('beforetriggerclick', this) === false) {
			return (false);
		}
		Ext.ux.AwesomeCombo.superclass.onTriggerClick.call(this);
	},

	// private
	getTrigger : function(index){
		return this.triggers[index];
	},

	// private
	afterRender: function(){
		Ext.ux.AwesomeCombo.superclass.afterRender.call(this);
		var triggers = this.triggers,
		i = 0,
		len = triggers.length;
		for(; i < len; ++i){
			var disabled = false;
			if (i === 0) {
				disabled = this.disableClearButton;
			} else if (i === 1) {
				disabled = this.hideTrigger;
			}
			if(disabled || this['hideTrigger' + (i + 1)]){
				triggers[i].hide();
			}
		}
	},

	updateEditState: function() {
		if (this.rendered) {
			if (this.readOnly) {
				this.el.dom.readOnly = true;
				this.el.addClass('x-trigger-noedit');
				this.triggers[0].setReadOnly(this.readOnly);
				this.triggers[1].setReadOnly(this.readOnly);
			} else {
				if (!this.editable) {
					this.el.dom.readOnly = true;
					this.el.addClass('x-trigger-noedit');
				} else {
					this.el.dom.readOnly = false;
					this.el.removeClass('x-trigger-noedit');
				}
			}
		}
	},

	// private
	initTrigger : function(){
		var ts = this.trigger.select('.x-form-trigger', true),
		triggerField = this;

		ts.each(function(t, all, index){
			var triggerIndex = 'Trigger'+(index+1);

			t.hide = function() {
				var w = triggerField.wrap.getWidth();
				if (triggerField.width) {
					w = triggerField.width;
				}
				this.dom.style.display = 'none';
				triggerField['hidden' + triggerIndex] = true;
				var width = w - triggerField.getTriggerWidth();
				triggerField.el.setWidth(width);
			};

			t.show = function() {
				if (this.readOnly) {
					return (this.hide());
				}
				var w = triggerField.wrap.getWidth();
				if (triggerField.width) {
					w = triggerField.width;
				}
				this.dom.style.display = '';
				triggerField['hidden' + triggerIndex] = false;
				var width = w - triggerField.getTriggerWidth();
				triggerField.el.setWidth(width);
			};

			t.setReadOnly = function(readOnly) {
				this.readOnly = readOnly;
				if (this.readOnly) {
					this.hide();
				}
			};

			this.mon(t, 'click', this['on'+triggerIndex+'Click'], this, {
				preventDefault:true
			});
			t.addClassOnOver('x-form-trigger-over');
			t.addClassOnClick('x-form-trigger-click');
		}, this);
		this.triggers = ts.elements;
	},

	// private
	getTriggerWidth: function() {
		var tw = 0;
		Ext.each(this.triggers, function(t, index){
			var triggerIndex = 'Trigger' + (index + 1);
			var disabled = false;
			if (triggerIndex === 'Trigger1') {
				disabled = this.disableClearButton;
			} else if (triggerIndex === 'Trigger2') {
				disabled = this.hideTrigger;
			}
			if (disabled !== true && this.readOnly !== true) {
				if (this['hidden' + triggerIndex] !== true) {
					tw += this.defaultTriggerWidth;
				} else {
					tw += t.getWidth();
				}
			}
		}, this);
		return (tw);
	},

	// private
	onDestroy : function() {
		Ext.destroy(this.triggers);
		Ext.ux.AwesomeCombo.superclass.onDestroy.call(this);
	}
});
// private Ext.ux.AwesomeCombo events.
Ext.ux.AwesomeCombo = Ext.apply(Ext.ux.AwesomeCombo, {
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
	},
	
	//RAC 15/7/2011 sobrecarga el validade para que considere multiples valores
	 validate : function(){
	     if(this.disabled || this.validateValue(this.processValue(this.getStringValue()!=''?this.getStringValue():this.getRawValue()))){
            this.clearInvalid();
            return true;
        }
        return false;
    }
	
});
// private Ext.ux.AwesomeCombo tooltip.
Ext.ux.AwesomeCombo = Ext.apply(Ext.ux.AwesomeCombo, {
	// private
	getTooltip: function() {
		if (Ext.isDefined(this.itooltip) === false &&
			Ext.QuickTips.isEnabled()) {
			this.itooltip = new Ext.ToolTip({
				title: ' ',
				html: ' ',
				target: this.getId(),
				listeners: {
					scope: this,
					show: this.onTooltipShow
				}
			});
            if (Ext.isDefined(this.tooltipContentTpl) === false) {
                this.tooltipContentTpl =
                    new Ext.XTemplate('<tpl for="data">',
                                      ' - {', this.displayField || 'field1', '} <br />',
                                      '</tpl>', {compiled: true});
            }
            if (Ext.isDefined(this.tooltipTitleTpl) === false) {
                this.tooltipTitleTpl = new Ext.XTemplate('<tpl for=".">',
                                                         '<tpl if="count == 0">',
                                                         'No item selected.',
                                                         '</tpl>',
                                                         '<tpl if="count &gt; 0">',
                                                         '{count} item',
                                                         '<tpl if="count &gt; 1">',
                                                         's',
                                                         '</tpl>',
                                                         ' selected: ',
                                                         '</tpl>',
                                                         '</tpl>', {compiled: true});
            }
		}
		return (this.itooltip);
	},

	// private
	generateTooltipContent: function() {
        var data = {
            data: this.internal.getRange(),
            count: this.internal.getCount()
        };
		this.tooltipTitle = this.tooltipTitleTpl.apply(data);
        this.tooltipContent = this.tooltipContentTpl.apply(data);
		return (true);
	},

	// private
	onTooltipShow: function() {
		if (this.getTooltip().rendered == false) {
			return (false);
		}
		if (this.rendered === false) {
			this.getTooltip().hide();
			return (false);
		}
		if (this.generateTooltipContent() == false) {
			this.getTooltip().hide();
			return (false);
		}
		if (this.fireEvent('beforetooltipshow', this, this.getTooltip(),
			this.tooltipTitle, this.tooltipContent) == false) {
			this.getTooltip().hide();
			return (false);
		}
		this.getTooltip().setTitle(this.tooltipTitle);
		this.getTooltip().update(this.tooltipContent);
		this.fireEvent('tooltipshow', this, this.getTooltip(),
			this.tooltipTitle, this.tooltipContent);
	}
});
// private Ext.ux.AwesomeCombo format.
Ext.ux.AwesomeCombo = Ext.apply(Ext.ux.AwesomeCombo, {
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
					Ext.ux.AwesomeCombo.superclass.setValue.call(this, values[i]);
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

Ext.ux.AwesomeCombo = Ext.extend(Ext.form.ComboBox, Ext.ux.AwesomeCombo);
Ext.form.AwesomeCombo=Ext.ux.AwesomeCombo;

Ext.reg('awesomecombo', Ext.ux.AwesomeCombo);
