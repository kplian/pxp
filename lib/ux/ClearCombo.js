/**
 * Advanced and lightweight combobox
 * with multi-selection options.
 *
 * @author Revolunet
 * @version 0.1.3
 * @class Ext.ux.ClearCombo
 * @extends Ext.form.ComboBox
 * @constructor
 * @param {Object} config Configuration options
 * @xtype ClearCombo
 */
Ext.ux.ClearCombo = {
	

	
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
	 * This parameter is only used if {@link Ext.ux.ClearCombo#format format}
	 * is set to "string".
	 * Defines separator used to split {@link Ext.ux.ClearCombo#setValue setValue}
	 * given arg and to join {@link Ext.ux.ClearCombo#getValue getValue} return.
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
	 * {@link Ext.ux.ClearCombo#tpl tpl} config.
	 * Defaults to "div.ClearCombo" if
	 * {@link Ext.ux.ClearCombo#enableMultiSelect enableMultiSelect} config is set
	 * to true, else default comboBox value.
	 */
	//itemSelector: 'div.ClearCombo-item',

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
		
		Ext.ux.ClearCombo.superclass.initComponent.call(this);
		
		
		this.addEvents(
		/**
		 * @event beforeentrycheck
		 * Fires before an entry is checked. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentrycheck',

		/**
		 * @event entrycheck
		 * Fires when an entry is checked.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entrycheck',

		/**
		 * @event beforeentryuncheck
		 * Fires before an entry is unchecked. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'beforeentryuncheck',

		/**
		 * @event entryuncheck
		 * Fires when an entry is unchecked.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.data.Record} record The data record returned from the underlying store
		 * @param {Number} index The index of the selected item in the dropdown list
		 */
		'entryuncheck',

		/**
		 * @event beforetooltipshow
		 * Fires before tooltip show. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'beforetooltipshow',

		/**
		 * @event tooltipshow
		 * Fires when tooltip show.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Ext.Tooltip} tooltip This combo box tooltip
		 * @param {String} title The tooltip title
		 * @param {String} content The tooltip content
		 */
		'tooltipshow',

		/**
		 * @event beforedisplayrefresh
		 * Fires before display is refreshed. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated value
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'beforedisplayrefresh',

		/**
		 * @event displayrefresh
		 * Fires when display is refreshed.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 * @param {Number} nb Number of selected items
		 * @param {String} text The generated text
		 * @param {Boolean} valueFound True if value was found else false
		 */
		'displayrefresh',

		/**
		 * @event beforereset
		 * Fires before reset is called. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 */
		'beforereset',

		/**
		 * @event reset
		 * Fires when reset is called.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 */
		'reset',

		/**
		 * @event beforetriggerclick
		 * Fires when expand/toggle trigger was clicked. Return false to cancel the action.
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 */
		'beforetriggerclick',
		
		/**
		 * @event clear
		 * RAC 01112011
		 * se dipsra al limpiar los datos del combo
		 * @param {Ext.ux.ClearCombo} combo This combo box
		 */
		'clearcmb'
		
		
		
		
		);
		
		this.addListener('clear', this.onInternalClear, this);
		
	},

	
	/**
	 * Flush all values.
	 */
	reset: function() {
		
		Ext.ux.ClearCombo.superclass.reset.call(this);
		this.fireEvent('reset', this);
	}
};

// private Ext.ux.ClearCombo override.
Ext.apply(Ext.ux.ClearCombo, {
	// private
	onTrigger1Click: function() {
		if (this.readOnly || this.disabled) {
			return;
		}
		this.reset();
		console.log('clear')
		this.fireEvent('clearcmb', this);
	},

	// private
	onTrigger2Click: function() {
		if (this.fireEvent('beforetriggerclick', this) === false) {
			return (false);
		}
		Ext.ux.ClearCombo.superclass.onTriggerClick.call(this);
	},

	// private
	getTrigger : function(index){
		return this.triggers[index];
	},

	// private
	afterRender: function(){
		Ext.ux.ClearCombo.superclass.afterRender.call(this);
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
		Ext.ux.ClearCombo.superclass.onDestroy.call(this);
	}
});
// private Ext.ux.ClearCombo events.
Ext.ux.ClearCombo = Ext.apply(Ext.ux.ClearCombo, {
	
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
	}

});




Ext.ux.ClearCombo = Ext.extend(Ext.form.ComboBox, Ext.ux.ClearCombo);
Ext.form.ClearCombo=Ext.ux.ClearCombo;
Ext.reg('ClearCombo', Ext.ux.ClearCombo);
