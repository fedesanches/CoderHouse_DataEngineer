-- Creamos 2 bases de datos
CREATE DATABASE BDE
CREATE DATABASE BDE_DW


-- Creamos el schema 'articulos' en la base de datos BDE
USE BDE
CREATE SCHEMA articulos


-- Creamos las tablas 'titulos' y 'autores' dentro del schema 'articulos
CREATE TABLE articulos.titulos (
	titulo_id char(6) NOT NULL,
	titulo varchar(80) NOT NULL,
	tipo char(20) NOT NULL
)

CREATE TABLE articulos.autores (
	titulo_id char(6) NOT NULL,
	nombre_autor nvarchar(100) NOT NULL,
	apellidos_autor nvarchar(100) NOT NULL,
	telefono_autor nvarchar(25)
)


-- Insertamos data dummy en las tablas 
INSERT INTO articulos.titulos VALUES ('1', 'Consultas SQL','bbdd');
INSERT INTO articulos.titulos VALUES ('3', 'Grupo recursos Azure','administracion');
INSERT INTO articulos.titulos VALUES ('4', '.NET Framework 4.5','programacion');
INSERT INTO articulos.titulos VALUES ('5', 'Programacion C#','dev');
INSERT INTO articulos.titulos VALUES ('7', 'Power BI','BI');
INSERT INTO articulos.titulos VALUES ('8', 'Administracion Sql server','administracion');

INSERT INTO articulos.autores VALUES ('3', 'David', 'Saenz', '99897867');
INSERT INTO articulos.autores VALUES ('8', 'Ana', 'Ruiz', '99897466');
INSERT INTO articulos.autores VALUES ('2', 'Julian', 'Perez', '99897174');
INSERT INTO articulos.autores VALUES ('1', 'Andres', 'Calamaro', '99876869');
INSERT INTO articulos.autores VALUES ('4', 'Cidys', 'Castillo', '998987453');
INSERT INTO articulos.autores VALUES ('5', 'Pedro', 'Molina', '99891768');


-- Creamos la tabla DimTitulo para informes
USE BDE_DW 

CREATE TABLE dbo.dim_titulos (
	titulo_id char(6) NOT NULL,
	titulo_nombre nVarChar(100) NOT NULL,
	titulo_tipo nVarChar(100) NOT NULL,
	nombre_completo nVarChar(200),
	telefono_autor nVarchar(25)
)


-- Creamos un procedure (en este caso solo escribi el codigo del procedure) para insertar los datos de titulos y autores en la tabla dim_titulos

TRUNCATE TABLE BDE_DW.dbo.dim_titulos

INSERT INTO BDE_DW.dbo.dim_titulos
SELECT 
	titulos.titulo_id as titulo_id,
	titulos.titulo as titulo_nombre,
	titulos.tipo as titulo_tipo,
	CONCAT(autores.nombre_autor, ' ', autores.apellidos_autor) as nombre_completo,
	autores.telefono_autor as telefono_autor
FROM BDE.articulos.titulos titulos
LEFT JOIN BDE.articulos.autores autores on autores.titulo_id = titulos.titulo_id

SELECT * FROM BDE_DW.dbo.dim_titulos