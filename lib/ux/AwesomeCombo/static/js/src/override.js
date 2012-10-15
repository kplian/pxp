// private {{classname}} override.
Ext.apply({{classname}}, {
	// private
	beforeBlur: function() {
		if (Ext.isDefined(this.store)) {
			{{classname}}.superclass.beforeBlur.call(this);
		}
		this.refreshDisplay();
	},

	// private
	onTrigger1Click: function() {
		if (this.readOnly || this.disabled) {
			return;
		}
		this.reset();
	},

	// private
	onTrigger2Click: function() {
		if (this.fireEvent('beforetriggerclick', this) === false) {
			return (false);
		}
		{{classname}}.superclass.onTriggerClick.call(this);
	},

	// private
	getTrigger : function(index){
		return this.triggers[index];
	},

	// private
	afterRender: function(){
		{{classname}}.superclass.afterRender.call(this);
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
		{{classname}}.superclass.onDestroy.call(this);
	}
});