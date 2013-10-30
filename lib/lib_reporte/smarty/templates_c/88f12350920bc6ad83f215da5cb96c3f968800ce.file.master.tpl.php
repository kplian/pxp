<?php /* Smarty version Smarty-3.1.14, created on 2013-09-18 04:51:19
         compiled from "/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/master.tpl" */ ?>
<?php /*%%SmartyHeaderCode:466061745238f37122c893-20108877%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '88f12350920bc6ad83f215da5cb96c3f968800ce' => 
    array (
      0 => '/var/www/html/kerp-boa/sis_contabilidad/reportes/comprobante/master.tpl',
      1 => 1379597410,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '466061745238f37122c893-20108877',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5238f371779098_62461462',
  'variables' => 
  array (
    'acreedor' => 0,
    'conformidad' => 0,
    'operacion' => 0,
    'tipo_cambio' => 0,
    'facturas' => 0,
    'pedido' => 0,
    'aprobacion' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5238f371779098_62461462')) {function content_5238f371779098_62461462($_smarty_tpl) {?><table border="1" cellspacing="0" cellpadding="1" width="100%">
	<tr>
		<td width="50%">Acreedor: <?php echo $_smarty_tpl->tpl_vars['acreedor']->value;?>
</td>
		<td width="50%"><b>Conformidad: <?php echo $_smarty_tpl->tpl_vars['conformidad']->value;?>
</b></td>
	</tr>
	<tr>
		<td width="50%" rowspan=3>Operación: <?php echo $_smarty_tpl->tpl_vars['operacion']->value;?>
</td>
		<td width="50%">T/C: <?php echo $_smarty_tpl->tpl_vars['tipo_cambio']->value;?>
</td>
	</tr>
	<tr>
		<td width="50%"><b>Facturas: <?php echo $_smarty_tpl->tpl_vars['facturas']->value;?>
</b></td>
	</tr>
	<tr>
		<td width="50%">Pedido: <?php echo $_smarty_tpl->tpl_vars['pedido']->value;?>
</td>
	</tr>
	<tr>
		<td width="100%" colspan=2>Aprobación: <?php echo $_smarty_tpl->tpl_vars['aprobacion']->value;?>
</td>
	</tr>
</table><?php }} ?>