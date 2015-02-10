<?php /* Smarty version Smarty-3.1.14, created on 2014-02-21 11:52:18
         compiled from "/var/www/html/kerp-boa/sis_contabilidad/reportes/tpl_comprobante/footer.tpl" */ ?>
<?php /*%%SmartyHeaderCode:828372610523971c332cc89-23728399%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4395e38001939d224bea064ca9e161fa969c9427' => 
    array (
      0 => '/var/www/html/kerp-boa/sis_contabilidad/reportes/tpl_comprobante/footer.tpl',
      1 => 1383163893,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '828372610523971c332cc89-23728399',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_523971c3372ee6_40340383',
  'variables' => 
  array (
    'etiqueta1' => 0,
    'etiqueta2' => 0,
    'etiqueta3' => 0,
    'etiqueta4' => 0,
    'firma1' => 0,
    'firma2' => 0,
    'firma3' => 0,
    'firma4' => 0,
    'cargo1' => 0,
    'cargo2' => 0,
    'cargo3' => 0,
    'cargo4' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_523971c3372ee6_40340383')) {function content_523971c3372ee6_40340383($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['etiqueta1']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['etiqueta2']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['etiqueta3']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['etiqueta4']->value;?>
</span></td>
	</tr>
	<tr>
		<td width="25%" class="td_label"><br><br><br></td>
		<td width="25%" class="td_label"><br><br><br></td>
		<td width="25%" class="td_label"><br><br><br></td>
		<td width="25%" class="td_label"><br><br><br></td>
	</tr>
	<tr>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['firma1']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['firma2']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['firma3']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['firma4']->value;?>
</span></td>
	</tr>
	<tr>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['cargo1']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['cargo2']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['cargo3']->value;?>
</span></td>
		<td width="25%" class="td_label"><span><?php echo $_smarty_tpl->tpl_vars['cargo4']->value;?>
</span></td>
	</tr>
</table><?php }} ?>