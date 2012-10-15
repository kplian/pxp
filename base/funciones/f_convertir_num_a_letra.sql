CREATE OR REPLACE FUNCTION pxp.f_convertir_num_a_letra (
  par_numero numeric
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 documento: 	pxp.f_convertir_num_a_letra
 DESCRIPCION:   Funcion que convierte un numero a letra
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************/

declare

       ptotal  numeric;

       total numeric;
       total1 numeric;
       cent2  numeric;
       cent   numeric;
       cent1  char(2);
       mil    numeric;
       millon numeric;
       millones numeric;
       sav    numeric;
       unit   numeric;
       deci   numeric;
       centi  numeric;
       factor numeric;
       sav1   numeric;
       depesos numeric;
       lletra  varchar;
       letras varchar;

       begin
            ptotal:=par_numero;
            total := ptotal;

            total1:= total;
            total := trunc(total);
            cent2 := total1 - total;
            cent  := cent2*100;
            cent1 := '0';

                  if (total=0) then
                     lletra := 'CERO';
                     cent1:=cast(cent as char(2));
                     return 'CERO  ,'||cent1||'/100 ';
                  end if;

                  mil:=0;
                  millon:=0;
                  millones:=0;
                  depesos:=0;
                  sav:=1;
                  unit:=1;
                  deci:=1;
                  centi:=1;
                  factor:=1;
                  sav1:=1;
                  letras:='';

                            while (total > 0) loop
                                if (total > 1999999) then
                                   depesos  := 1;
                                   factor   := 1000000;
                                   millones := 1;
                                   millon   := 0;
                                else
                                   if (total > 999999) then
                                      depesos := 1;
                                      factor  := 1000000;
                                      millon  := 1;
                                   else
                                       if (total > 999) then
                                          factor := 1000;
                                          mil    := 1;
                                       else
                                          factor := 1;
                                          mil := 0;
                                       end if;
                                   end if;
                                end if;

                                sav := total;

                                total := trunc(total/factor);
                                sav  := sav-(total*factor);
                                if (sav=0) then
                                   depesos := 0;
                                end if;

                                centi:=TRUNC(total/100);

                                if centi = 0 then
                                   letras := rtrim(letras)||'';
                                end if;
                                if centi = 1 then
                                   if total = 100 then
                                      letras := rtrim(letras)|| ' CIEN';
                                   else
                                       letras := rtrim(letras)||' CIENTO';
                                   end if;
                                end if;
                                if centi = 2 then
                                   letras := rtrim(letras)||' DOSCIENTOS';
                                end if;
                                if centi = 3 then
                                   letras := rtrim(letras)||' TRESCIENTOS';
                                end if;
                                if centi = 4 then
                                   letras := rtrim(letras)||' CUATROCIENTOS';
                                end if;
                                if centi = 5 then
                                   letras := rtrim(letras)||' QUINIENTOS';
                                end if;
                                if centi = 6 then
                                   letras := rtrim(letras)||' SEISCIENTOS';
                                end if;
                                if centi = 7 then
                                   letras := rtrim(letras)||' SETECIENTOS';
                                end if;
                                if centi = 8 then
                                   letras := rtrim(letras)||' OCHOCIENTOS';
                                end if;
                                if centi = 9 then
                                   letras := rtrim(letras)||' NOVECIENTOS';
                                end if;

                                total:=total - (centi*100);
                                deci :=trunc(total/10);
                                unit :=total-(deci*10);

                                if total >= 30 then
                                   if deci = 3 then
                                      letras := rtrim(letras)||' TREINTA';
                                   end if;
                                   if deci = 4 then
                                      letras := rtrim(letras)||' CUARENTA';
                                   end if;
                                   if deci = 5 then
                                      letras := rtrim(letras)||' CINCUENTA';
                                   end if;
                                   if deci = 6 then
                                      letras := rtrim(letras)||' SESENTA';
                                   end if;
                                   if deci = 7 then
                                      letras := rtrim(letras)||' SETENTA';
                                   end if;
                                   if deci = 8 then
                                      letras := rtrim(letras)||' OCHENTA';
                                   end if;
                                   if deci = 9 then
                                      letras := rtrim(letras)||' NOVENTA';
                                   end if;
                                   if unit > 0 then
                                      letras := rtrim(letras)||' Y';
                                   end if;
                                else
                                    unit := total;
                                end if;

                                if unit = 0 then
                                   letras := rtrim(letras)||'';
                                end if;
                                if unit = 1 then
                                   letras := rtrim(letras)||' UN';
                                end if;
                                if unit = 2 then
                                   letras := rtrim(letras)||' DOS';
                                end if;
                                if unit = 3 then
                                   letras := rtrim(letras)||' TRES';
                                end if;
                                if unit = 4 then
                                   letras := rtrim(letras)||' CUATRO';
                                end if;
                                if unit = 5 then
                                   letras := rtrim(letras)||' CINCO';
                                end if;
                                if unit = 6 then
                                   letras := rtrim(letras)||' SEIS';
                                end if;
                                if unit = 7 then
                                   letras := rtrim(letras)||' SIETE';
                                end if;
                                if unit = 8 then
                                   letras := rtrim(letras)||' OCHO';
                                end if;
                                if unit = 9 then
                                   letras := rtrim(letras)||' NUEVE';
                                end if;
                                if unit = 10 then
                                   letras := rtrim(letras)||' DIEZ';
                                end if;
                                if unit = 11 then
                                   letras := rtrim(letras)||' ONCE';
                                end if;
                                if unit = 12 then
                                   letras := rtrim(letras)||' DOCE';
                                end if;
                                if unit = 13 then
                                   letras := rtrim(letras)||' TRECE';
                                end if;
                                if unit = 14 then
                                   letras := rtrim(letras)||' CATORCE';
                                end if;
                                if unit = 15 then
                                   letras := rtrim(letras)||' QUINCE';
                                end if;
                                if unit = 16 then
                                   letras := rtrim(letras)||' DIECISEIS';
                                end if;
                                if unit = 17 then
                                   letras := rtrim(letras)||' DIECISIETE';
                                end if;
                                if unit = 18 then
                                   letras := rtrim(letras)||' DIECIOCHO';
                                end if;
                                if unit = 19 then
                                   letras := rtrim(letras)||' DIECINUEVE';
                                end if;
                                if unit = 20 then
                                   letras := rtrim(letras)||' VEINTE';
                                end if;
                                if unit = 21 then
                                   letras := rtrim(letras)||' VEINTIUNO';
                                end if;
                                if unit = 22 then
                                   letras := rtrim(letras)||' VEINTIDOS';
                                end if;
                                if unit = 23 then
                                   letras := rtrim(letras)||' VEINTITRES';
                                end if;
                                if unit = 24 then
                                   letras := rtrim(letras)||' VEINTICUATRO';
                                end if;
                                if unit = 25 then
                                   letras := rtrim(letras)||' VEINTICINCO';
                                end if;
                                if unit = 26 then
                                   letras := rtrim(letras)||' VEINTISEIS';
                                end if;
                                if unit = 27 then
                                   letras := rtrim(letras)||' VEINTISIETE';
                                end if;
                                if unit = 28 then
                                   letras := rtrim(letras)||' VEINTIOCHO';
                                end if;
                                if unit = 29 then
                                   letras := rtrim(letras)||' VEINTINUEVE';
                                end if;
                                if millones=1 then
                                   letras := rtrim(letras)||' MILLONES';
                                   millones := 0;
                                else
                                    if millon=1 then
                                       letras := rtrim(letras)||' MILLON';
                                       millon := 0;
                                    else
                                        if mil=1 then
                                           letras := rtrim(letras)||' MIL';
                                           mil := 0;
                                        end if;
                                    end if;
                                end if;
                                total:=sav;
  end loop;

  if cent=0 then
     cent1:='00';
  else
     if cent <10
     THEN
     raise notice '%',cent;
     cent1:= '0'||cast(cent as char(1));
	ELSE
     cent1:=cast(cent as char(2));
     END IF;
  end if;
  if depesos=1 then
     letras := rtrim(letras)||' ,'||cent1||'/100 ';
  else
     letras := rtrim(letras)||' ,'||cent1||'/100 ';
  end if;

--  lletra := '('||ltrim(letras)||')';
    lletra := ltrim(letras);

return lletra;
end
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_copy (OID = 304222) : 
--
