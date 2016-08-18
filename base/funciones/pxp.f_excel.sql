CREATE OR REPLACE FUNCTION pxp.f_excel (
  archivo bytea,
  tabla character varying,
  titulo character varying[]
)
RETURNS SETOF text[]
AS 
$body$
DECLARE
  cant_filas	integer; 	--la cantidad de filas del Excel original
  cant_cols		integer; 	--la cantidad de columnas del Excel original
  filas_titulo	integer;
  cols_titulo	integer;
  vector		text[]; 	--contiene las filas del excel
  registros		text[]; 	--contiene una fila de excel separada por comas
  fila			text[];
  i				numeric;	--indice del for para las filas
  j				numeric;	--indice del for para las columnas
  k				numeric;
  aux			text;		-- bytea sin codificacion
  v_consulta	varchar;	--consulta insert
  
BEGIN
 	
    aux := (select decode(archivo::text,'base64')); --se obtiene el bytea y se quita la codificación
        
    vector := string_to_array(aux,'\\015\\012'); --descomponer el bytea en un vector que contenga una fila del CSV cada uno
    											 --\\015\\012 --> ENTER o salto de linea/retorno de carro en el bytea	
	
    fila := string_to_array(vector[1],';');
    select array_upper(fila,1) into cols_titulo;
    
    for k in 1..cols_titulo loop
    	if(titulo[k] <> fila[k]) then
        	raise exception 'El orden de las columnas en el archivo CSV es incorrecto, utilice la Plantilla por favor';
        end if;
    end loop;
    
    select array_upper(vector,1) into cant_filas; --cantidad de registros del CSV
    
    for i in 2..(cant_filas-1) loop
      	
        v_consulta := 'insert into '||tabla||' values ('; --inicio de la consulta del insert

        registros := string_to_array(vector[i],';'); --descomponer cada fila para obtener las columnas del CSV
        select array_upper(registros,1) into cant_cols; --cantidad de columnas del CSV
        
        for j in 1..(cant_cols-1) loop
                        
            registros[j] := (select replace(registros[j]::text,',','.')); --reemplazar las comas por puntos
            v_consulta := v_consulta ||''''|| registros[j] || ''','; --continuar con la insercion hasta la columna N-1
                 	
        end loop;  
        
        v_consulta := v_consulta ||''''||  registros[cant_cols] || ''');'; --insertar la ultima columna 
        execute v_consulta; --ejecutar el insert
        
    end loop;
    
    return;
        
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_existe_parametro (OID = 304226) : 
--
