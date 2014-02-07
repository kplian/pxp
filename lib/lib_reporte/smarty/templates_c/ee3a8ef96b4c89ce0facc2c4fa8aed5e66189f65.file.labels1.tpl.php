<?php /* Smarty version Smarty-3.1.14, created on 2013-09-18 06:09:39
         compiled from "/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/templates/labels1.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1841132944523971c3312246-33569791%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ee3a8ef96b4c89ce0facc2c4fa8aed5e66189f65' => 
    array (
      0 => '/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/templates/labels1.tpl',
      1 => 1379602107,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1841132944523971c3312246-33569791',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_523971c3329002_69005513',
  'variables' => 
  array (
    'labels' => 0,
    'p' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_523971c3329002_69005513')) {function content_523971c3329002_69005513($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1" width="100%">
	<tr>
	<?php  $_smarty_tpl->tpl_vars['p'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['p']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['labels']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['p']->key => $_smarty_tpl->tpl_vars['p']->value){
$_smarty_tpl->tpl_vars['p']->_loop = true;
?>
		<td width="<?php echo $_smarty_tpl->tpl_vars['p']->value['width'];?>
"><?php echo $_smarty_tpl->tpl_vars['p']->value['label'];?>
</td>
	<?php } ?>
	</tr>
</table><?php }} ?>