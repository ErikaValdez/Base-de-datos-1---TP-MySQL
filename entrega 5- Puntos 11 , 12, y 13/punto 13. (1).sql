USE `terminal_automotriz`;
DROP procedure IF EXISTS `ejercicio_13`;


DELIMITER |
CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio_13`(IN linea int,out total int)
BEGIN
declare _ingreso datetime;
declare _egreso datetime;
declare _chasis int;
declare cont int;
declare i int;
declare est_inicio int;
declare est_fin int;
declare tiempo int;
declare finished int default 0;
-- ** EL CURSOR TIENE UNA LISTA DE LOS CHASIS FINALIZADOS SEGUN UNA LINEA DE
-- MONTAJE ESPECIFICA
DECLARE cur CURSOR FOR SELECT ev.vehiculo_id_chasis
 FROM estacion_vehiculo ev inner join estacion_trabajo et on
ev.estacion_trabajo_id_estacion=id_estacion WHERE egreso >0 and
 et.linea_id_linea = linea and (ev.estacion_trabajo_id_estacion = 5 or
ev.estacion_trabajo_id_estacion = 10) ;
DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;
set i = 0;
set total=0;
-- ** ASIGNO LAS ESTACIONES DE INICIO Y FIN PARA LUEGO SELECCIONAR INGRESO Y AGRESO
if linea = 1 then
set est_inicio ='1';
set est_fin = '5';
elseif linea =2 then
set est_inicio ='6';
set est_fin = '10';
end if;
open cur;
beg : loop
fetch cur into _chasis ;
-- ***ASIGNO LA FECHA DE INGRESO DEL CHASIS DEL CURSOR
select ingreso into _ingreso from estacion_vehiculo where vehiculo_id_chasis = _chasis and
estacion_trabajo_id_estacion = est_inicio;
-- *** ASIGNO LA FECHA DE EGRESO DEL CHASIS DEL CURSOR
select egreso into _egreso from estacion_vehiculo where vehiculo_id_chasis = _chasis and
estacion_trabajo_id_estacion = est_fin;
-- *** CALCULO LA DIFERENCIA ENTRE EL INGRESO Y EGRESO DE 1 CHASIS
SELECT TIMESTAMPDIFF(MINUTE,_ingreso,_egreso) into tiempo;
-- *** SUMO LAS DIFERENCIAS TEMPORALES
set total = total + tiempo;
-- ***cuento la cantidad de registros para calcular el promedio
 set i = i+1;
 -- *** PASO AL SIGUIENTE CHASIS DEL CURSOR
IF finished = 1 THEN
LEAVE beg;
END IF;
end loop ;
 CLOSE cur;

-- *** CALCULO EL PROMEDIO
set total = total/i;
END
|

call ejercicio_13(1,@mensaje);
Select @mensaje;
call ejercicio_13(2,@mensaje);
Select @mensaje;