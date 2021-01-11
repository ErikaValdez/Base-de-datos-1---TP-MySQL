USE `terminal_automotriz`;
DROP procedure IF EXISTS `ejercicio_12`;

DELIMITER |
CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio_12`(IN pedido int)
BEGIN
declare _insumo int;
declare _cantidad int;
declare _pedido int;
declare _linea_pedido int;
declare cont int;
declare _codigo int;
declare _nombre varchar(50);
declare _total int;
declare pedido_modelo int;
declare finished int default 0;
-- ** EL CURSOR CONTIENE TODOS LOS INSUMOS NESESARIOS PARA TODAS LAS ESTACIONES
-- DE LAS LINEA DE MONTAJE
DECLARE cur CURSOR FOR select pm.pedido_id_pedido,
i.id_insumo,i.nombre,pm.cantidad,ei.cantidad from
pedido_del_modelo pm inner join modelo m on pm.modelo_id_modelo = m.id_modelo inner
join linea_montaje lm on
m.id_modelo = lm.modelo_id_modelo inner join estacion_trabajo et on lm.id_linea =
et.linea_id_linea inner join
estacion_insumo ei on et.id_estacion = ei.estacion_id_estacion inner join insumo i on
ei.insumo_id_insumo = i.id_insumo;
DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;
set pedido_modelo = pedido;
create temporary table if not exists tabl(
num_pedido int,
codigo_insumo int ,
nombre_insumo varchar(50),
cantidad_total int
);
open cur;
beg : loop
fetch cur into _pedido,_insumo,_nombre,_cantidad,_total ;
-- ** MULTIPLICO LA CANTIDAD DE INSUMOS POR LA CANTIDAD AUTOMOVILES DEL PEDIDO
set _total = _total*_cantidad;
if _pedido = pedido then
insert into tabl(num_pedido,codigo_insumo , nombre_insumo, cantidad_total)
values (_pedido,_insumo,_nombre,_total);
end if;
IF finished = 1 THEN
LEAVE beg;
END IF;
end loop ;
 CLOSE cur;

 select num_pedido,codigo_insumo,nombre_insumo,cantidad_total from tabl;
truncate tabl;
END
|

call ejercicio_12(789);