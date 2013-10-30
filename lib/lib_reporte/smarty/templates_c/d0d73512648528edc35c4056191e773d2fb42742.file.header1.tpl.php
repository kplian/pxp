<?php /* Smarty version Smarty-3.1.14, created on 2013-09-18 02:25:15
         compiled from "/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/header1.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16513997905238eb764b38f0-84949949%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd0d73512648528edc35c4056191e773d2fb42742' => 
    array (
      0 => '/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/header1.tpl',
      1 => 1379545934,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16513997905238eb764b38f0-84949949',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5238eb765c31f2_61061686',
  'variables' => 
  array (
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
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5238eb765c31f2_61061686')) {function content_5238eb765c31f2_61061686($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1">
	<tr>
		<td width="23%" rowspan="4"><img src="../../../images/logo.png" border="0" width=156 height=117 /></td>
		<td align="center" width="54%" rowspan="2"><?php echo $_smarty_tpl->tpl_vars['main_title1']->value;?>
</td>
		<td width="23%"><?php echo $_smarty_tpl->tpl_vars['header_key_right1']->value;?>
: <?php echo $_smarty_tpl->tpl_vars['header_value_right1']->value;?>
</td>
	</tr>
	<tr>
		<td width="23%"><?php echo $_smarty_tpl->tpl_vars['header_key_right2']->value;?>
: <?php echo $_smarty_tpl->tpl_vars['header_value_right2']->value;?>
</td>
	</tr>
	<tr>
		<td align="center" width="54%" rowspan="2"><?php echo $_smarty_tpl->tpl_vars['main_title2']->value;?>
</td>
		<td width="23%"><?php echo $_smarty_tpl->tpl_vars['header_key_right3']->value;?>
: <?php echo $_smarty_tpl->tpl_vars['header_value_right3']->value;?>
</td>
	</tr>
	<tr>
		<td width="23%">Página **main_pagina_actual** de **main_pagina_total**</td>
	</tr>
</table><?php }} ?>