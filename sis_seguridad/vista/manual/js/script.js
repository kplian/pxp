$(document).ready(function() {
    
	//this will fire once the page has been fully
	$('#comment-post-btn').click(function(){
	comment_post_btn_click();
	
	});
});

function comment_post_btn_click()
{
	
		//text within textarea the persona enter
		var _text = $('#comment-post-text').val();
		
		var _userName = $('#user-name').val();
		
		if(_text.length >0 && _userName != null)
		{
			//procedimiento ajax
			$('#comment-post-text').css('border','1px solid #e1e1e1');
			
			$.post("../../../../kerp-boa/lib/lib_control/Intermediario.php",
			{
				
				p : '{"id_gui":"'+_text+'"}',
				x : "../../sis_seguridad/control/Gui/getGui"
			}
			)
			.error(
				function()
				{
					console.log("Error : ");
				})
			.success(
			
				function(data)
				{
					
					console.log("responsetext....",data);
					
					var jsontext = '{"firstname":"Jesper","surname":"Aaberg","phone":["555-0100","555-0120"]}';
					
					
					var contact = JSON.parse(jsontext);
					console.log(contact);
															
					/*var jsonp = data;
					console.log(data);
					var obj = $.parseJSON(jsonp);*/
					
					 /* var lang = '';
					
					  var obj = $.parseJSON(jsonp);
					
					  $.each(obj, function() {
					
					      lang += this['Lang'] + "<br/>";
					
					  });
					
					  $('span').html(lang);*/

					
				}

			);
			

			console.log(_text+" "+_userName+" ");
		}
		else
		{
			//textarea se encuentra vacio
			$('#comment-post-text').css('border','1px solid #ff0000');
			console.log("text tarea vacio");
		}
		
		
		
		//borrar lo que esta en el textarea
		$('#comment-post-text').val("");
}


