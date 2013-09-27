{*
	Ejemplo de uso:
	$arrLabels[]=array('label'=>'Transacción','width'=>'50%');
	$arrLabels[]=array('label'=>'Ejecución Bs','width'=>'10%');
	$arrLabels[]=array('label'=>'Debe USD','width'=>'10%');
	$arrLabels[]=array('label'=>'Haber USD','width'=>'10%');
	$arrLabels[]=array('label'=>'Debe Bs','width'=>'10%');
	$arrLabels[]=array('label'=>'Haber Bs','width'=>'10%');
	$repCbte->assign('labels',$arrLabels); 
*}
<table border="1" cellspacing="0" cellpadding="1" width="100%">
	<tr>
	{foreach from=$labels item=p}
		<td width="{$p['width']}" class="td_label">{$p['label']}</td>
	{/foreach}
	</tr>
</table>