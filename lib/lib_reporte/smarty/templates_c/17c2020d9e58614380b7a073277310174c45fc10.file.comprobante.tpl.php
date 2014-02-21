<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 14:38:15
         compiled from "/var/www/html/ERPBOA/sis_contabilidad/reportes/tpl_comprobante/comprobante.tpl" */ ?>
<?php /*%%SmartyHeaderCode:8669934352602e97abb7f7-92244981%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '17c2020d9e58614380b7a073277310174c45fc10' => 
    array (
      0 => '/var/www/html/ERPBOA/sis_contabilidad/reportes/tpl_comprobante/comprobante.tpl',
      1 => 1380696100,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '8669934352602e97abb7f7-92244981',
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
  'unifunc' => 'content_52602e97c10279_62352096',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52602e97c10279_62352096')) {function content_52602e97c10279_62352096($_smarty_tpl) {?><link rel="stylesheet" href="../../lib/lib_reporte/smarty/styles/ksmarty.css">
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