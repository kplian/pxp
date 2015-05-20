<?php /* Smarty version Smarty-3.1.14, created on 2015-03-11 03:16:01
         compiled from "/var/www/html/kerp/sis_contabilidad/reportes/tpl_comprobante/footer.tpl" */ ?>
<?php /*%%SmartyHeaderCode:33133678854ff8941e96e56-83644355%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'efd10f8c249df33b06fa43c5ed82a17b89637dea' => 
    array (
      0 => '/var/www/html/kerp/sis_contabilidad/reportes/tpl_comprobante/footer.tpl',
      1 => 1420654842,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '33133678854ff8941e96e56-83644355',
  'function' => 
  array (
  ),
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
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_54ff8941eb5864_63648873',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_54ff8941eb5864_63648873')) {function content_54ff8941eb5864_63648873($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="0" width="100%">
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