<?php
/**
 Revision: RAC - KPLIAN
 Fecha: 08-06-2018
 
 **/

class CTSort
{
	var $sort = array();
	var $formulario;
	var $limite=3;
	var $criterio;
	
	

	function __construct($cadena_sort, $sortdir, $formulario)
	{		
		$this->criterio = "";
		if (isset($cadena_sort) && $cadena_sort !='')
		{
			     if (!isset($sortdir)   ||  $sortdir==''){
			        	$sortdir = 'ASC';
			      }
				
				if (!isset($_SESSION["'$formulario'"]))
				{   //si no existe la variable en la sesión
					$_SESSION["'$formulario'"] = array();
					$_SESSION["'$formulario'"][0] = $cadena_sort. ' '. $sortdir;
					$this->sort = $_SESSION["'$formulario'"];
					$this->formulario=$formulario;
				}
				else
				{
			
			        //si existe la variable en la sesión
					$existe=false;
					$this->sort = $_SESSION["'$formulario'"];
		
					//Reordenación del array
					if(sizeof($this->sort)<$this->limite)
					{
						//Si el vector está aún debajo del límite
						//Verifica si la columna ya está en el vector
						$lim = sizeof($this->sort)-1;
						for($i=0;$i<=$lim;$i++)
						{
							$aux = explode(" ",$this->sort[$i]);
							if($aux[0]==$cadena_sort)
							{
								$existe=true;
								//Si existe ya la columna
								if($i==$lim)
								{
									//Es el último elemento, solo lo reemplaza
									$this->sort[$i]=$cadena_sort. " ". $sortdir;
								}
								else
								{
									//Es un elmento del medio
									for($j=$i;$j<$lim;$j++)
									{
										$this->sort[$j]=$this->sort[$j+1];
									}
									//Coloca la columna nueva
									$this->sort[$lim]=$cadena_sort. " ". $sortdir;
								}
							}
						}
						if(!$existe)
						{
							array_push($this->sort,$cadena_sort." ".$sortdir);
						}
						$_SESSION["'$formulario'"] = $this->sort;
						/*echo "1".$this->sort[0]."---";
						echo "2".$this->sort[1]."---";
						echo "3".$this->sort[2]."---";
						echo "4".$this->sort[3]."---";*/
					}
					else
					{  //Si el vector ya está lleno hasta el límite
						$existe=false;
						//Verifica si la columna ya existe en el vector
						$lim = sizeof($this->sort)-1;
						for($i=0;$i<=$lim;$i++)
						{
							$aux = explode(" ",$this->sort[$i]);
							if($aux[0]==$cadena_sort)
							{
								$existe=true;
								//Si existe ya la columna
								if($i==$lim)
								{
									//Es el último elemento, solo lo reemplaza
									$this->sort[$i]=$cadena_sort. " ". $sortdir;
								}
								else
								{
									//Es un elmento del medio
									for($j=$i;$j<$lim;$j++)
									{
										$this->sort[$j]=$this->sort[$j+1];
									}
									//Coloca la columna nueva
									$this->sort[$lim]=$cadena_sort. " ". $sortdir;
								}
							}
						}
		
						if(!$existe)
						{
							//Elimina la primera columna, recorre todo lo demás a comienzo y agrega la nueva columna
							for($i=0;$i<$this->limite-1;$i++)
							{
								$this->sort[$i]=$this->sort[$i+1];
							}
							$this->sort[sizeof($this->sort)-1]=$cadena_sort." ".$sortdir;
						}
						/*echo "1->".$this->sort[0];
						echo "2->".$this->sort[1];
						echo "3->".$this->sort[2];
						echo "4->".$this->sort[3];
						echo "5->".$this->sort[4];*/
						$_SESSION["'$formulario'"] = $this->sort;
					}
			
		       }
		 }
	}

	function get_sort()
	{
		return $this->sort;
	}

	function set_sort($sort)
	{
		push($this->sort,$sort);
	}

	function get_criterio_sort()
	{
		$this->criterio = "";
		for($i=sizeof($this->sort)-1;$i>=0;$i--)
		{
			if($i==0)
			{
				$this->criterio .= $this->sort[$i];
			}
			else
			{
				$this->criterio .= $this->sort[$i] . ",";
			}

		}
		return $this->criterio;
	}
}

?>