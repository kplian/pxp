// private {{classname}} tooltip.
{{classname}} = Ext.apply({{classname}}, {
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