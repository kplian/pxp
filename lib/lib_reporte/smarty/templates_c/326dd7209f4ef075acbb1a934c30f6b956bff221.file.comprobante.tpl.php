<?php /* Smarty version Smarty-3.1.14, created on 2013-09-18 03:54:47
         compiled from "/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/comprobante.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12285866935238f37177c991-32842541%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '326dd7209f4ef075acbb1a934c30f6b956bff221' => 
    array (
      0 => '/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/comprobante.tpl',
      1 => 1379561007,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12285866935238f37177c991-32842541',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5238f3717d4693_66405287',
  'variables' => 
  array (
    'transac' => 0,
    'tra' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5238f3717d4693_66405287')) {function content_5238f3717d4693_66405287($_smarty_tpl) {?><table>
	<?php  $_smarty_tpl->tpl_vars['tra'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tra']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['transac']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tra']->key => $_smarty_tpl->tpl_vars['tra']->value){
$_smarty_tpl->tpl_vars['tra']->_loop = true;
?>
		<tr>
			<td>
				<b>CC:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['cc'];?>
 <b>Ptda.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['partida'];?>
<br>
	   			<b>Cta.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['cuenta'];?>
<br>
	   			<b>Aux.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['auxiliar'];?>

			</td>
			<td><?php echo $_smarty_tpl->tpl_vars['tra']->value['ejecucion_bs'];?>
</td>
			<td><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_debe1'];?>
</td>
			<td><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_haber1'];?>
</td>
			<td><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_debe'];?>
</td>
			<td><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_haber'];?>
</td>
		</tr>
	<?php } ?>
</table><?php }} ?>