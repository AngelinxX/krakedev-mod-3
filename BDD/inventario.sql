drop table if exists categorias;
create table categorias(
	codigo_cat serial not null,
	nombre varchar (100) not null,
	categoria_padre int,
	constraint categorias_pk primary key (codigo_cat),
	constraint categorias_fk foreign key (categoria_padre)
	references categorias(codigo_cat)
);
insert into categorias(nombre,categoria_padre)
values ('Materia Prima',null);
insert into categorias(nombre,categoria_padre)
values ('Proteina',1);
insert into categorias(nombre,categoria_padre)
values ('Salsas',1);
insert into categorias(nombre,categoria_padre)
values ('Punto de venta',null);
insert into categorias(nombre,categoria_padre)
values ('Bebidas',4);
insert into categorias(nombre,categoria_padre)
values ('Con alcohol',5);
insert into categorias(nombre,categoria_padre)
values ('Sin alcohol',5);

select * from categorias;

drop table if exists categorias_udm;
create table categorias_udm(
	codigo_cudm char(1) not null,
	nombre varchar (100) not null,
	constraint categorias_udm_pk primary key (codigo_cudm)
);
insert into categorias_udm(codigo_cudm,nombre)
values ('U','Unidades');
insert into categorias_udm(codigo_cudm,nombre)
values ('V','Volumen');
insert into categorias_udm(codigo_cudm,nombre)
values ('P','Peso');

select * from categorias_udm;

drop table if exists unidades_de_medida;
create table unidades_de_medida(
	codigo_udm char(2) not null,
	descripcion varchar (100) not null,
	categoria_cudm char(1) not null,
	constraint unidades_de_medida_pk primary key (codigo_udm),
	constraint unidades_de_medida_categorias_udm_fk foreign key (categoria_cudm)
	references categorias_udm(codigo_cudm)
);
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('ml','militros','V');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('l','litros','V');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('u','unidad','U');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('d','docena','U');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('g','gramos','P');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('kg','kilogramos','P');
insert into unidades_de_medida(codigo_udm,descripcion,categoria_cudm)
values ('lb','libras','P');

select * from unidades_de_medida;

drop table if exists producto;
create table producto(
	codigo_prod serial not null,
	nombre varchar (100) not null,
	udm varchar (2) not null,
	precio_de_venta money,
	tiene_iva boolean,
	coste money,
	categorias_cod int,
	stock int,
	constraint producto_pk primary key (codigo_prod),
	constraint producto_unidades_de_medida_fk foreign key (udm)
	references unidades_de_medida(codigo_udm),
	constraint producto_categorias_fk foreign key (categorias_cod)
	references categorias(codigo_cat)
);
insert into producto(nombre,udm,precio_de_venta,tiene_iva,coste,categorias_cod,stock)
values ('Coca Cola','u',0.5804,true,0.3729,7,110);
insert into producto(nombre,udm,precio_de_venta,tiene_iva,coste,categorias_cod,stock)
values ('Salsa de tomate','kg',0.95,true,0.8736,3,0);
insert into producto(nombre,udm,precio_de_venta,tiene_iva,coste,categorias_cod,stock)
values ('Mostaza','kg',0.95,true,0.89,3,0);
insert into producto(nombre,udm,precio_de_venta,tiene_iva,coste,categorias_cod,stock)
values ('Fuze tea','u',0.80,true,0.7,7,50);

select * from producto;






drop table if exists tipo_documento;
create table tipo_documento(
	codigo_tipo_doc char(1) not null,
	descripcion varchar (100) not null,
	constraint tipo_documento_pk primary key (codigo_tipo_doc)
);
insert into tipo_documento(codigo_tipo_doc,descripcion)
values ('C','CEDULA');
insert into tipo_documento(codigo_tipo_doc,descripcion)
values ('R','RUC');

select * from tipo_documento;

drop table if exists proveedores;
create table proveedores(
	identificador char(13) not null,
	tipo_documento char (1) not null,
	nombre varchar (100) not null,
	telefono int,
	correo varchar (100) not null,
	direccion varchar (100) not null,
	constraint proveedores_pk primary key (identificador),
	constraint proveedores_tpd_fk foreign key (tipo_documento)
	references tipo_documento(codigo_tipo_doc)
);
insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)
values ('1798562245','C','SANTIAGO MOSQUERA',0997675617,'santiago.mosquera@gmail.com','Cumbayork');
insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)
values ('1765354623001','R','SNACKS SA',0987865764,'987865764','La Tola');

select * from proveedores;

drop table if exists estado_pedido;
create table estado_pedido(
	codigo_estado_pedido char(1) not null,
	descripcion varchar (100) not null,
	constraint estado_pedido_pk primary key (codigo_estado_pedido)
);
insert into estado_pedido(codigo_estado_pedido,descripcion)
values ('S','Solicitado');
insert into estado_pedido(codigo_estado_pedido,descripcion)
values ('R','Recibido');

select * from estado_pedido;

drop table if exists cabecera_pedido;
create table cabecera_pedido(
	numero serial not null,
	proveedor char(13) not null,
	fecha date,
	estado char(1) not null,
	constraint cabecera_pedido_pk primary key (numero),
	constraint cabecera_pedido_proveedores_fk foreign key (proveedor)
	references proveedores(identificador),
	constraint cabecera_pedido_estado_pedido_fk foreign key (estado)
	references estado_pedido(codigo_estado_pedido)
);
insert into cabecera_pedido(proveedor,fecha,estado)
values ('1798562245','30/11/2023','R');
insert into cabecera_pedido(proveedor,fecha,estado)
values ('1798562245','30/11/2023','R');

select * from cabecera_pedido;

drop table if exists detalle_pedido;
create table detalle_pedido(
	codigo_detalle_pedido serial not null,
	cabecera_pedido int not null,
	producto int not null,
	cantidad_solicitada int not null,
	subtotal money,
	cantidad_recibida int not null,
	constraint detalle_pedido_pk primary key (codigo_detalle_pedido),
	constraint detalle_pedido_cabecera_pedido_fk foreign key (cabecera_pedido)
	references cabecera_pedido(numero),
	constraint detalle_pedido_producto_fk foreign key (producto)
	references producto(codigo_prod)
);
insert into detalle_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values (1,1,100,37.29,100);
insert into detalle_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values (1,4,50,11.80,50);
insert into detalle_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values (2,1,10,3.73,10);

select * from detalle_pedido;

drop table if exists cabecera_ventas;
create table cabecera_ventas(
	codigo_cabecera_ventas serial,
	fecha timestamp,
	total_sin_iva money not null,
	iva money not null,
	total money not null,
	constraint cabecera_ventas_pk primary key (codigo_cabecera_ventas)
);
insert into cabecera_ventas(fecha,total_sin_iva,iva,total)
values ('20/11/2023 20:00:00',3.26,0.39,3.65);

select * from cabecera_ventas;

drop table if exists detalle_ventas;
create table detalle_ventas(
	codigo_detalle_ventas serial not null,
	cabecera_ventas int not null,
	producto int not null,
	cantidad int not null,
	precio money,
	subtotal money,
	subtotal_con_iva money,
	constraint detalle_ventas_pk primary key (codigo_detalle_ventas),
	constraint detalle_ventas_cabecera_ventas_fk foreign key (cabecera_ventas)
	references cabecera_ventas(codigo_cabecera_ventas),
	constraint detalle_ventas_producto_fk foreign key (producto)
	references producto(codigo_prod)
);
insert into detalle_ventas(cabecera_ventas,producto,cantidad,precio,subtotal,subtotal_con_iva)
values (1,1,5,0.58,2.9,3.25);
insert into detalle_ventas(cabecera_ventas,producto,cantidad,precio,subtotal,subtotal_con_iva)
values (1,4,1,0.04,0.36,0.40);

select * from detalle_ventas;