<?php /* Smarty version Smarty-3.1.14, created on 2013-09-18 04:49:29
         compiled from "/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/footer.tpl" */ ?>
<?php /*%%SmartyHeaderCode:14431916652396919244d32-38268852%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ee0ba01db2e74ef36942d4589bf94dbd5e9ee321' => 
    array (
      0 => '/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/footer.tpl',
      1 => 1379423502,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '14431916652396919244d32-38268852',
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
  'unifunc' => 'content_523969192aefa4_60294217',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_523969192aefa4_60294217')) {function content_523969192aefa4_60294217($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1">
	<tr>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['etiqueta1']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['etiqueta2']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['etiqueta3']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['etiqueta4']->value;?>
</td>
	</tr>
	<tr>
		<td width="25%"><br><br><br></td>
		<td width="25%"><br><br><br></td>
		<td width="25%"><br><br><br></td>
		<td width="25%"><br><br><br></td>
	</tr>
	<tr>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['firma1']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['firma2']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['firma3']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['firma4']->value;?>
</td>
	</tr>
	<tr>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['cargo1']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['cargo2']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['cargo3']->value;?>
</td>
		<td width="25%"><?php echo $_smarty_tpl->tpl_vars['cargo4']->value;?>
</td>
	</tr>
</table><?php }} ?>