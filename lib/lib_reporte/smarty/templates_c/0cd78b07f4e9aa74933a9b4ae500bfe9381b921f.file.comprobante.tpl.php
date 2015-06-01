<?php /* Smarty version Smarty-3.1.14, created on 2015-03-11 03:16:01
         compiled from "/var/www/html/kerp/sis_contabilidad/reportes/tpl_comprobante/comprobante.tpl" */ ?>
<?php /*%%SmartyHeaderCode:203967711254ff8941eca586-99833639%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0cd78b07f4e9aa74933a9b4ae500bfe9381b921f' => 
    array (
      0 => '/var/www/html/kerp/sis_contabilidad/reportes/tpl_comprobante/comprobante.tpl',
      1 => 1420654842,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '203967711254ff8941eca586-99833639',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'transac' => 0,
    'tra' => 0,
    'tot_ejecucion_bs' => 0,
    'tot_importe_debe1' => 0,
    'tot_importe_haber1' => 0,
    'tot_importe_debe' => 0,
    'tot_importe_haber' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_54ff8941efa0a2_98149706',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_54ff8941efa0a2_98149706')) {function content_54ff8941efa0a2_98149706($_smarty_tpl) {?><link rel="stylesheet" href="../../lib/lib_reporte/smarty/styles/ksmarty.css">
<table border="1" cellspacing="0" cellpadding="0" width="100%">
	<?php  $_smarty_tpl->tpl_vars['tra'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tra']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['transac']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tra']->key => $_smarty_tpl->tpl_vars['tra']->value){
$_smarty_tpl->tpl_vars['tra']->_loop = true;
?>
		<tr>
			<td width="50%">
				<b>CC:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['cc'];?>
 <b>Ptda.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['partida'];?>
<br>
	   			<b>Cta.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['cuenta'];?>
<br>
	   			<b>Aux.:</b> <?php echo $_smarty_tpl->tpl_vars['tra']->value['auxiliar'];?>

			</td>
			<td width="10%" class="td_currency"><span><?php echo $_smarty_tpl->tpl_vars['tra']->value['ejecucion_bs'];?>
</span></td>
			<td width="10%" class="td_currency"><span><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_debe1'];?>
</span></td>
			<td width="10%" class="td_currency"><span><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_haber1'];?>
</span></td>
			<td width="10%" class="td_currency"><span><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_debe'];?>
</span></td>
			<td width="10%" class="td_currency"><span><?php echo $_smarty_tpl->tpl_vars['tra']->value['importe_haber'];?>
</span></td>
		</tr>
	<?php } ?>
	<tr>
		<td width="50%" align="right"><b>TOTALES</b></td>
		<td width="10%" class="td_currency"><span><b><?php echo $_smarty_tpl->tpl_vars['tot_ejecucion_bs']->value;?>
</b></span></td>
		<td width="10%" class="td_currency"><span><b><?php echo $_smarty_tpl->tpl_vars['tot_importe_debe1']->value;?>
</b></span></td>
		<td width="10%" class="td_currency"><span><b><?php echo $_smarty_tpl->tpl_vars['tot_importe_haber1']->value;?>
</b></span></td>
		<td width="10%" class="td_currency"><span><b><?php echo $_smarty_tpl->tpl_vars['tot_importe_debe']->value;?>
</b></span></td>
		<td width="10%" class="td_currency"><span><b><?php echo $_smarty_tpl->tpl_vars['tot_importe_haber']->value;?>
</b></span></td>
	</tr>
</table><?php }} ?>