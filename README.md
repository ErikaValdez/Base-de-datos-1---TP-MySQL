# Base-de-datos-1---TP-MySQL
Bases de Datos 1 Licenciatura en Sistemas .Federico Ribeiro Trabajo integrador - 2020


Licenciatura en Sistemas
Ing Federico Ribeiro
Trabajo integrador - 2020

Una empresa terminal automotriz (fábrica de automóviles) nos contrató para informatizar
su negocio. Las operaciones de la misma se desarrollan de la siguiente manera: La terminal se
dedica a ensamblar automóviles, es decir, compra las distintas autopartes (motor, llantas,
neumáticos, puertas, etc.) a distintos proveedores y con las mismas procede al pintado, armado
y prueba del vehículo.
En una línea de montaje se fabrica un sólo modelo de vehículo, la fábrica tiene tantas
líneas de montaje como modelos de vehículos se fabrican; también se conoce la capacidad
productiva promedio de cada línea de montaje (en vehículos por mes).
Cada una de las líneas de montaje se compone de varias estaciones de trabajo según
requiera cada modelo. En cada estación se realiza una única tarea determinada, como por
ejemplo: pintura, ensamblado de chapa, mecánica motor, mecánica rodaje, electricidad y prueba,
donde en estas tareas se consume una serie de insumos, los que son provistos por distintas
empresas. Se sabe qué cantidad de estos insumos se necesita para cada modelo de vehículo
(litros de pintura, metros de cable, cubiertas, lámparas, etc.) Una empresa proveedora puede
fabricar más de un insumo y para más de una estación. Además, un mismo insumo puede ser
provisto por más de una empresa.
En el momento en que se inicia la producción se asigna a cada automóvil un número de
chasis que lo identifica. Se registra la fecha y hora en que el vehículo ingresa y egresa de cada
estación, a fin de conocer el tiempo que tardó en producirse un vehículo completo y poder llevar
estadísticas de productividad de cada estación y cada línea de montaje.
La empresa trabaja del modo determinado “Justo a tiempo” (just in time). Esto implica que
no mantiene grandes stocks de las partes necesarias para fabricar un vehículo, sino que realiza
los pedidos sus proveedores con una frecuencia semanal.
La terminal cuenta con una serie de empresas concesionarias, que son las que se
dedican a vender los vehículos fabricados. Estas concesionarias reportan a la terminal las ventas
realizadas y la terminal les informa la fecha de entrega esperada. Esta fecha de entrega
dependerá de la cantidad de pedidos que la empresa tenga a la fecha y de la capacidad de
producción de cada línea de montaje más una semana por cualquier imprevisto.
Cada insumo de producción tiene un código que lo identifica, una descripción y un precio.
El precio lo fija cada uno de los proveedores, con lo cual de acuerdo al proveedor el mismo
insumo puede tener diferente precio.
 
Primera etapa - Diseño del modelo
1) Diagrama Entidad Relación (DER) del modelo de datos que representa formalmente
lo expuesto en el punto (1)

2) Script SQL de creación de la base de datos en MySQL.

3) Construcción Stored Procedures para el Alta, la Baja y la Modificación de las
entidades principales.

4) Construcción de Stored Procedures con lógica de negocio relacionada con algunas
de las entidades (según se desprenda del análisis del enunciado)

Segunda etapa - Construcción de los ABMs importantes

5) Se solicita la construcción de los ABMs de las siguientes entidades:
a) Concesionarios b) Pedidos
(Cabecera + Detalle) c)
Proveedores d) Insumos

6) Se requiere que los Altas y Modificaciones anteriores informen anomalías posibles, por
ejemplo intento de ingreso elementos con la misma clave primaria, lo mismo en la
modificación.

7) Se requiere que las bajas informe si se está requiriendo eliminar un elemento que no
existen, o si no se puede eliminar por alguna razón del negocio.

El formato de la respuesta debe ser el mismo en todos los casos:
a) Un campo nResultado entero, donde 0=exito, < 0 algun problema b) Un
campo cMensaje varchar, donde será vacío en caso de éxito y tendrá
el mensaje correspondiente en caso de algun problema
Tercera etapa - Construcción de procedimientos de negocio

8) Se requiere crear un procedimiento que dada la información de un pedido en
particular, se generan los automóviles con la patente asignada al azar en la tabla
correspondiente según el modelo. La idea es que se deben generar los automóviles y
dejarlos en el estado inicial, es decir, con la línea de montaje asignada, pero sin
ingresar a la primer estación de dicha línea. 
a) Pista 1: se deben recorrer los detalles del pedido y en cada uno de ellos se
deben crear los vehiculos por modelo que se indican según el campo
“cantidad”. Un acercamiento posible puede ser la utilización de cursores;
http://www.mysqltutorial.org/mysql-cursor/
b) Pista 2: La patente puede ser calculada como deseen, lo único que deben
tener en cuenta es que no debe repetirse.

9) Se requiere crear un procedimiento que al recibir como parámetro la patente del
automóvil, se le dé inicio al montaje del mismo, es decir, que al ejecutar dicho
procedimiento el automóvil con la patente indicada es “posicionado” en la primer
estación de la línea de montaje que le fue asignada al crear el vehículo con el
procedimiento (8)
Nota: No puede ingresarse el vehículo en la estación de trabajo si es que hay otro
automóvil en dicho lugar. En caso de no ser posible la inserción del vehículo en la
primer estación por encontrarse ocupada, deberá retornar un resultado informando esta
situación, además del chasis del vehículo que está ocupando dicha estación.

10) Se requiere crear un procedimiento que al recibir como parámetro la patente del
automóvil, se finaliza la labor de la estación en la que se encuentra y se le ingresa en
la estación siguiente.
De la misma manera que se realizó en el punto anterior debe analizarse si es posible
ingresar el automóvil en dicha estación. En caso de o ser posible deberá informarse la
situación.

IMPORTANTE: En caso de que la estación en la que estoy finalizando la labor sea
la última de la línea de montaje, debemos marcar el automóvil como finalizado, lo
que implica modificar la fecha de finalización del registro de la tabla vehiculos.
El formato de la respuesta debe ser el mismo en todos los casos:
c) Un campo nResultado entero, donde 0=exito, < 0 algun problema d) Un
campo cMensaje varchar, donde será vacío en caso de éxito y tendrá
el mensaje correspondiente en caso de algun problema


Cuarta etapa - Construcción de procedimientos de reportes

11) Dado un número de pedido, se requiere listar los vehículos indicando el chasis, si se
encuentra finalizado, y si no esta terminado, indicar en qué estación se encuentra. 

12) Dado un número de pedido, se requiere listar los insumos que será necesario
solicitar, indicando código de insumo y cantidad requerida para ese pedido.

13) Dada una línea de montaje, indicar el tiempo promedio de construcción de los
vehículos (tener en cuenta sólo los vehículos terminados).

Quinta etapa - Optimización de reportes

14) Teniendo en cuenta las consultas anteriores construir algún índice que pueda
facilitar la lectura de los datos. 
