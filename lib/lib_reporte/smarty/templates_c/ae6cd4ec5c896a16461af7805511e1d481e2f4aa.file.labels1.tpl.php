<?php /* Smarty version Smarty-3.1.14, created on 2013-09-17 20:44:19
         compiled from "/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/labels1.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9380868965238f7636ec809-24858995%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ae6cd4ec5c896a16461af7805511e1d481e2f4aa' => 
    array (
      0 => '/var/www/html/kerp-boa/pxp/lib/lib_reporte/smarty/views/labels1.tpl',
      1 => 1379513649,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9380868965238f7636ec809-24858995',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'labels' => 0,
    'p' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5238f763742732_27049733',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5238f763742732_27049733')) {function content_5238f763742732_27049733($_smarty_tpl) {?><table>
	<tr>
	<?php  $_smarty_tpl->tpl_vars['p'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['p']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['labels']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['p']->key => $_smarty_tpl->tpl_vars['p']->value){
$_smarty_tpl->tpl_vars['p']->_loop = true;
?>
		<td><?php echo $_smarty_tpl->tpl_vars['p']->value;?>
</td>
	<?php } ?>
	</tr>
</table><?php }} ?>