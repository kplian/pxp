



//saldo de cuenta
https://siga.congregacao.org.br/TES/DespesaWS.asmx/SelecionarValorDisponivel

{"codigoConta":"8","data":"01/08/2017"}

Content-Type	
application/json; charset=UTF-8




https://siga.congregacao.org.br/UTIL/UtilWS.asmx/ValidaDataMaiorOuIgual

{"f_data1":"01/08/2017","f_data2":"01/08/2017","l_data1":"Data Documento <span class='red'>*</span>"
,"l_data2":"Data Pagamento <span class='red'>*</span>","mensagemPadrao":"A data do pagamento não pode
 ser anterior a data do documento."}





https://siga.congregacao.org.br/TES/TES00802.aspx


-----------------------------14455224730379
Content-Disposition: form-data; name="f_codigo"


-----------------------------14455224730379
Content-Disposition: form-data; name="tarefa"


-----------------------------14455224730379
Content-Disposition: form-data; name="gravar"

S
-----------------------------14455224730379
Content-Disposition: form-data; name="f_data"

01/08/2017
-----------------------------14455224730379
Content-Disposition: form-data; name="f_tipodocumento"

1
-----------------------------14455224730379
Content-Disposition: form-data; name="f_documento"     //nro de documento

2
-----------------------------14455224730379
Content-Disposition: form-data; name="f_valor"

100,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_despesa_rateio"    //concepto de gasto cuenta contable

169
-----------------------------14455224730379
Content-Disposition: form-data; name="f_centrocusto_rateio"  //centor de costo

BO 01-0010 - BARRIO PETROLERO
-----------------------------14455224730379
Content-Disposition: form-data; name="f_percentualRateio"   //porcentaje prorrateo

100,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_valorRateio"    //costo concepto

100,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_fornecedor"   //proveedor

469147
-----------------------------14455224730379
Content-Disposition: form-data; name="f_historico"

99
-----------------------------14455224730379
Content-Disposition: form-data; name="f_complemento"


-----------------------------14455224730379
Content-Disposition: form-data; name="f_datapagamento"

01/08/2017
-----------------------------14455224730379
Content-Disposition: form-data; name="f_conta"

8
-----------------------------14455224730379
Content-Disposition: form-data; name="f_disponivel"

1.025,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_multa"

0,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_juros"

0,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_desconto"

0,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_total"  //total pago

100,00
-----------------------------14455224730379
Content-Disposition: form-data; name="f_anexos"; filename=""
Content-Type: application/octet-stream


-----------------------------14455224730379
Content-Disposition: form-data; name="f_comando"

F
-----------------------------14455224730379
Content-Disposition: form-data; name="__initPage__"

S
-----------------------------14455224730379
Content-Disposition: form-data; name="__jqSubmit__"

S
-----------------------------14455224730379--



//seleccionar el plan de cuenta

https://siga.congregacao.org.br/CTB/CTB00301.asmx/Selecionar

{"codigoEstabelecimento":"24150","indice":"3","ativo":"True","config":{"sEcho":2,"iDisplayStart":0,"iDisplayLength"
:100,"sSearch":"","iSortCol":0,"sSortDir":"asc"}}





