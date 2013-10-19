<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 14:38:15
         compiled from "/var/www/html/ERPBOA/pxp/lib/lib_reporte/smarty/templates/header1.tpl" */ ?>
<?php /*%%SmartyHeaderCode:213787653652602e978410f1-62298068%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a36d38dbd99c1cf937a2b5aed4612ff2c8450fb7' => 
    array (
      0 => '/var/www/html/ERPBOA/pxp/lib/lib_reporte/smarty/templates/header1.tpl',
      1 => 1380603350,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '213787653652602e978410f1-62298068',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'main_ruta_logo' => 0,
    'main_title1' => 0,
    'header_key_right1' => 0,
    'header_value_right1' => 0,
    'header_key_right2' => 0,
    'header_value_right2' => 0,
    'main_title2' => 0,
    'header_key_right3' => 0,
    'header_value_right3' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_52602e978debd9_34247969',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52602e978debd9_34247969')) {function content_52602e978debd9_34247969($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1" width="100%">
	<tr>
		<td width="23%" rowspan="4"><img src="<?php echo $_smarty_tpl->tpl_vars['main_ruta_logo']->value;?>
" border="0" width="95%" height="95%"/></td>
		<td width="54%" rowspan="2"><h1><?php echo $_smarty_tpl->tpl_vars['main_title1']->value;?>
</h1></td>
		<td width="23%"><b><?php echo $_smarty_tpl->tpl_vars['header_key_right1']->value;?>
:</b> <?php echo $_smarty_tpl->tpl_vars['header_value_right1']->value;?>
</td>
	</tr>
	<tr>
		<td width="23%"><b><?php echo $_smarty_tpl->tpl_vars['header_key_right2']->value;?>
:</b> <?php echo $_smarty_tpl->tpl_vars['header_value_right2']->value;?>
</td>
	</tr>
	<tr>
		<td width="54%" rowspan="2"><h2><?php echo $_smarty_tpl->tpl_vars['main_title2']->value;?>
<h2></td>
		<td width="23%"><b><?php echo $_smarty_tpl->tpl_vars['header_key_right3']->value;?>
:</b> <?php echo $_smarty_tpl->tpl_vars['header_value_right3']->value;?>
</td>
	</tr>
	<tr>
		<td width="23%"><b>Página</b> **1_** <b>de</b> **_1**</h3></td>
	</tr>
</table><?php }} ?>