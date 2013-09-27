<?php /* Smarty version Smarty-3.1.14, created on 2013-09-17 20:22:41
         compiled from "/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/footer1.tpl" */ ?>
<?php /*%%SmartyHeaderCode:21441268785238f251bf6b20-32356196%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ebbb070593432ef228cfef2ba949766be83368e2' => 
    array (
      0 => '/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/footer1.tpl',
      1 => 1379422805,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '21441268785238f251bf6b20-32356196',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'main_user' => 0,
    'main_date' => 0,
    'main_sistema' => 0,
    'main_barcode' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5238f252193619_05789161',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5238f252193619_05789161')) {function content_5238f252193619_05789161($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1">
	<tr>
		<td width="30%">Usuario: <?php echo $_smarty_tpl->tpl_vars['main_user']->value;?>
<br>Fecha: <?php echo $_smarty_tpl->tpl_vars['main_date']->value;?>
</td>
		<td align="center" width="40%"><?php echo $_smarty_tpl->tpl_vars['main_sistema']->value;?>
</td>
		<td align="right" width="30%">Control: <?php echo $_smarty_tpl->tpl_vars['main_barcode']->value;?>
</td>
	</tr>
</table><?php }} ?>