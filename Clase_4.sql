/* 
Crear proceudre pETL_Desastres, que de:
    promedio Temperatura
    promedio Oxigeno
    suma eventos
por cuatrienios (2023-2026 y 2027-2030)

Insertar los datos en una tabla llamada "desastres_final" en una base de datos llamada "DESASTRES_BDE"
*/

CREATE DATABASE DESASTRES_BDE
CREATE DATABASE DESASTRES

USE DESASTRES

-- 2. crear tabla clima futuro global
CREATE TABLE clima (
    año INT NOT NULL PRIMARY KEY,
    temperatura FLOAT NOT NULL,
    oxigeno FLOAT NOT NULL
)

-- 3. crear tabla desastres proyectados globales
CREATE TABLE desastres (
    año INT NOT NULL PRIMARY KEY,
    tsunamis INT NOT NULL,
    olas_calor INT NOT NULL,
    terremotos INT NOT NULL,
    erupciones INT NOT NULL,
    incendios INT NOT NULL
)

-- 4. crear tabla muertes proyectadas por rangos de edad
CREATE TABLE muertes (
    año INT NOT NULL PRIMARY KEY,
    r_menor15 INT NOT NULL,
    r_15_a_30 INT NOT NULL,
    r_30_a_45 INT NOT NULL,
    r_45_a_60 INT NOT NULL,
    r_m_a_60 INT NOT NULL
)

-- Insertar valores manualmente
INSERT INTO clima VALUES (2023, 22.5,230);
INSERT INTO clima VALUES (2024, 22.7,228.6);
INSERT INTO clima VALUES (2025, 22.9,227.5);
INSERT INTO clima VALUES (2026, 23.1,226.7);
INSERT INTO clima VALUES (2027, 23.2,226.4);
INSERT INTO clima VALUES (2028, 23.4,226.2);
INSERT INTO clima VALUES (2029, 23.6,226.1);
INSERT INTO clima VALUES (2030, 23.8,225.1);

INSERT INTO desastres VALUES (2023, 2,15, 6,7,50);
INSERT INTO desastres VALUES (2024, 1,12, 8,9,46);
INSERT INTO desastres VALUES (2025, 3,16, 5,6,47);
INSERT INTO desastres VALUES (2026, 4,12, 10,13,52);
INSERT INTO desastres VALUES (2027, 5,12, 6,5,41);
INSERT INTO desastres VALUES (2028, 4,18, 3,2,39);
INSERT INTO desastres VALUES (2029, 2,19, 5,6,49);
INSERT INTO desastres VALUES (2030, 4,20, 6,7,50);

INSERT INTO muertes VALUES (2023, 1000,1300, 1200,1150,1500);
INSERT INTO muertes VALUES (2024, 1200,1250, 1260,1678,1940);
INSERT INTO muertes VALUES (2025, 987,1130, 1160,1245,1200);
INSERT INTO muertes VALUES (2026, 1560,1578, 1856,1988,1245);
INSERT INTO muertes VALUES (2027, 1002,943, 1345,1232,986);
INSERT INTO muertes VALUES (2028, 957,987, 1856,1567,1756);
INSERT INTO muertes VALUES (2029, 1285,1376, 1465,1432,1236);
INSERT INTO muertes VALUES (2030, 1145,1456, 1345,1654,1877);


-- 5 creamos tabla final
USE DESASTRES_BDE

CREATE TABLE desastres_final (
    cuatrenio varchar(20) NOT NULL PRIMARY KEY,
    temperatura_avg FLOAT NOT NULL, 
    oxigeno_avg FLOAT NOT NULL,
    t_tsunamis INT NOT NULL, 
    t_olas_calor INT NOT NULL,
    t_terremotos INT NOT NULL, 
    t_erupciones INT NOT NULL, 
    t_incendios INT NOT NULL,
    m_jovenes_avg FLOAT NOT NULL,
    m_adutos_avg FLOAT NOT NULL,
    m_ancianos_avg FLOAT NOT NULL
)

--6 creamos procedure
TRUNCATE TABLE desastres_final

INSERT INTO desastres_final
SELECT
	CASE WHEN clima.año BETWEEN '2023' AND '2026' THEN 'C1' ELSE 'C2' END as cuatrenio,
	avg(temperatura) as temperatura_avg,
	avg(oxigeno) as oxigeno_avg,

	sum(tsunamis) as t_tsunamis,
	sum(olas_calor) as t_olas_calor,
	sum(terremotos) as t_terremotos,
	sum(erupciones) as t_erupciones,
	sum(incendios) as t_incendios,

	avg(r_menor15 + r_15_a_30) as m_jovenes_avg,
	avg(r_30_a_45 + r_45_a_60) as m_adutos_avg,
	avg(r_m_a_60) as m_ancianos_avg
FROM DESASTRES.dbo.clima 
LEFT JOIN DESASTRES.dbo.desastres on clima.año = desastres.año
LEFT JOIN DESASTRES.dbo.muertes on clima.año = muertes.año

GROUP BY CASE WHEN clima.año BETWEEN '2023' AND '2026' THEN 'C1' ELSE 'C2' END


SELECT * FROM desastres_final