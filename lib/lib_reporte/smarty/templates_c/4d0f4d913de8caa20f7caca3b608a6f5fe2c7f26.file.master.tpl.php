<?php /* Smarty version Smarty-3.1.14, created on 2014-02-21 11:52:18
         compiled from "/var/www/html/kerp-boa/sis_contabilidad/reportes/tpl_comprobante/master.tpl" */ ?>
<?php /*%%SmartyHeaderCode:117248218523971c33797d4-47113325%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4d0f4d913de8caa20f7caca3b608a6f5fe2c7f26' => 
    array (
      0 => '/var/www/html/kerp-boa/sis_contabilidad/reportes/tpl_comprobante/master.tpl',
      1 => 1383163893,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '117248218523971c33797d4-47113325',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_523971c339b960_06789874',
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
<?php if ($_valid && !is_callable('content_523971c339b960_06789874')) {function content_523971c339b960_06789874($_smarty_tpl) {?><link rel="stylesheet" href="../../lib/lib_reporte/smarty/styles/ksmarty.css">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="50%" ><b>Acreedor:</b> <?php echo $_smarty_tpl->tpl_vars['acreedor']->value;?>
</td>
			<td width="50%"><b>Conformidad:</b> <?php echo $_smarty_tpl->tpl_vars['conformidad']->value;?>
</td>
		</tr>
		<tr>
			<td width="50%" rowspan=3><b>Operación:</b> <?php echo $_smarty_tpl->tpl_vars['operacion']->value;?>
</td>
			<td width="50%"><b>T/C:</b> <?php echo $_smarty_tpl->tpl_vars['tipo_cambio']->value;?>
</td>
		</tr>
		<tr>
			<td width="50%"><b>Facturas:</b> <?php echo $_smarty_tpl->tpl_vars['facturas']->value;?>
</td>
		</tr>
		<tr>
			<td width="50%"><b>Pedido:</b> <?php echo $_smarty_tpl->tpl_vars['pedido']->value;?>
</td>
		</tr>
		<tr>
			<td width="100%" colspan=2><b>Aprobación:</b> <?php echo $_smarty_tpl->tpl_vars['aprobacion']->value;?>
</td>
		</tr>
	</table>
</table><?php }} ?>