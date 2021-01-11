CREATE DEFINER=`root`@`localhost` PROCEDURE `abm_estacion_vehiculosa`(IN chasis int,
out nResultado int, out chasis_ocupando int, cMensaje
varchar(50) )
BEGIN
 declare estacion int;
 declare estacion_siguiente int;
 declare cantidad_estaciones int;
 declare linea int;
 declare modelo int;
 declare estado int;


 select count(*) into estacion from estacion_vehiculo ev where
ev.vehiculo_id_chasis = chasis;
 select modelo_id_modelo into modelo from vehiculo where
id_chasis = chasis;
 select id_linea into linea from linea_montaje where
modelo_id_modelo=modelo;
 if linea = 2 then
 set estacion = estacion + 5;
 end if;
 set estacion_siguiente = estacion+1;

 if estacion = 0 or estacion = 5 then
 select count(*) into estado from estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = estacion_siguiente and
ev.egreso is null;
 else
 set nResultado = -1;
 set cMensaje = 'El automovil ya se inicializo';
 set estado = -1;
 end if;

 if estado = 0 then
 insert into estacion_vehiculo values (chasis, estacion_siguiente,
curdate(), null);
 elseif estado = 1 then
 set nResultado = -1;
 set cMensaje = 'Estacion ocupada';
 select vehiculo_id_chasis into chasis_ocupando from
estacion_vehiculo ev where ev.estacion_trabajo_id_estacion =
estacion_siguiente and
ev.egreso is null;
 end if;

END