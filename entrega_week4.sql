-- ======================================
-- ENTREGA WEEK 4 — TECHMASTER UNIVERSITY
-- Nombre: Priscila Brito  |  Fecha: 29/06/2026
-- ======================================

-- Parte 1 CREAR Base Datos --
CREATE DATABASE universidad_techmaster;
USE universidad_techmaster;

-- SELECT DATABASE();

-- Creando tablas --
-- Departamentos --
/*CREATE TABLE departamentos (
	id INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL UNIQUE,
    presupuesto DECIMAL (12,2),
    fecha_fundacion DATE
);

-- Profesores (con jefe — relación recursiva)
CREATE TABLE profesores (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    departamento_id INT,
    jefe_id INT,
    salario DECIMAL(10,2),
    fecha_contratacion DATE, 
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
	FOREIGN KEY (jefe_id) REFERENCES profesores(id)
);

-- Estudiantes --
CREATE TABLE estudiantes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    fecha_nacimiento DATE,
    fecha_ingreso DATE, 
    promedio_general DECIMAL(4,2),
    estado ENUM('activo', 'graduado', 'baja') DEFAULT 'activo'
);

-- Cursos (cada curso impartido por un profesor, en un departamento)
CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL CHECK (creditos > 0),
    profesor_id INT,
    departamento_id INT NOT NULL,
    cupo_maximo INT DEFAULT 30,
    semestre VARCHAR(10),
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);
    
-- Inscripciones (N:M entre estudiantes y cursos)--
CREATE TABLE inscripciones (
    estudiante_id INT,
    curso_id INT,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    calificacion DECIMAL(4, 2) CHECK (calificacion >= 0 AND calificacion <= 100),
    estado ENUM('cursando', 'aprobado', 'reprobado', 'retirado') DEFAULT 'cursando',
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE
);

-- Parte 2 INSERTAR valores --
-- Departamentos --
INSERT INTO departamentos (nombre, presupuesto, fecha_fundacion) VALUES
    ('Computación', 5000000.00, '1998-08-15'),
    ('Matemáticas', 3500000.00, '1995-01-10'),
    ('Física', 4200000.00, '1995-01-10'),
    ('Humanidades', 2000000.00, '2005-03-22'),
    ('Biología', 3800000.00, '2000-09-01');
    
-- Profesores --
-- (id 1-2: jefes de departamento sin jefe propio — fundadores)
INSERT INTO profesores (nombre, email, departamento_id, jefe_id, salario, fecha_contratacion) VALUES
    ('Dr. Roberto Méndez',  'rmendez@uni.edu', 1, NULL, 95000, '2010-08-01'),  -- Jefe Computación
    ('Dra. Sara López',     'slopez@uni.edu',  2, NULL, 92000, '2008-01-15'),  -- Jefa Matemáticas
    ('Dr. Miguel Vega',     'mvega@uni.edu',   1,    1, 78000, '2015-03-10'),
    ('Dra. Ana Torres',     'atorres@uni.edu', 1,    1, 76000, '2017-09-05'),
    ('Dr. Carlos Ruiz',     'cruiz@uni.edu',   2,    2, 72000, '2018-02-12'),
    ('Dra. Elena Martínez', 'emartinez@uni.edu', 3, NULL, 88000, '2012-08-20'),-- Jefa Física
    ('Dr. Felipe Castro',   'fcastro@uni.edu', 3,    6, 70000, '2019-01-15'),
    ('Dra. Gabriela Pérez', 'gperez@uni.edu',  4, NULL, 75000, '2014-09-01'),  -- Jefa Humanidades
    ('Dr. Héctor Silva',    'hsilva@uni.edu',  5, NULL, 80000, '2013-08-15'),  -- Jefe Biología
    ('Dra. Isabel Ramos',   'iramos@uni.edu',  5,    9, 68000, '2020-03-01'),
    ('Dr. Jorge Núñez',     'jnunez@uni.edu',  4,    8, 65000, '2021-09-10');
    
-- Estudiantes --
INSERT INTO estudiantes (nombre, email, fecha_nacimiento, fecha_ingreso, promedio_general, estado) VALUES
    ('Alicia García',     'agarcia@uni.edu',  '2002-05-15', '2020-08-20', 8.5,  'activo'),
    ('Brian Hernández',   'bhernandez@uni.edu','2001-11-22','2020-08-20', 7.2,  'activo'),
    ('Camila Ruiz',       'cruiz.est@uni.edu', '2003-03-10','2021-08-20', 9.1,  'activo'),
    ('Daniel Torres',     'dtorres@uni.edu',  '2002-07-08', '2020-08-20', 8.8,  'activo'),
    ('Estefania López',   'elopez.est@uni.edu','2001-12-30','2019-08-20', 9.5,  'graduado'),
    ('Federico Salinas',  'fsalinas@uni.edu', '2003-04-25', '2021-08-20', 6.8,  'activo'),
    ('Gabriela Méndez',   'gmendez@uni.edu',  '2002-09-12', '2020-08-20', 8.2,  'activo'),
    ('Hugo Vega',         'hvega@uni.edu',    '2003-06-18', '2022-08-20', 7.9,  'activo'),
    ('Inés Castro',       'icastro@uni.edu',  '2001-10-05', '2019-08-20', 5.5,  'baja'),
    ('Javier Núñez',      'jnunez.est@uni.edu','2002-08-29','2020-08-20', 8.0,  'activo'),
    ('Karla Romero',      'kromero@uni.edu',  '2003-01-17', '2022-08-20', NULL, 'activo'),  -- sin promedio
    ('Lucas Aguilar',     'laguilar@uni.edu', '2004-02-22', '2023-08-20', NULL, 'activo');  -- nuevo, sin notas

-- Cursos --
INSERT INTO cursos (codigo, nombre, creditos, profesor_id, departamento_id, cupo_maximo, semestre) VALUES
    ('COMP101', 'Introducción a la Programación', 4, 1, 1, 30, '2026-1'),
    ('COMP201', 'Estructuras de Datos',           4, 3, 1, 25, '2026-1'),
    ('COMP301', 'Bases de Datos',                 4, 4, 1, 25, '2026-1'),
    ('MATH101', 'Cálculo Diferencial',            5, 2, 2, 35, '2026-1'),
    ('MATH201', 'Álgebra Lineal',                 4, 5, 2, 30, '2026-1'),
    ('PHYS101', 'Física General',                 4, 6, 3, 30, '2026-1'),
    ('PHYS202', 'Mecánica Cuántica',              5, 7, 3, 20, '2026-1'),
    ('HUMA101', 'Filosofía Contemporánea',        3, 8, 4, 40, '2026-1'),
    ('HUMA201', 'Literatura Latinoamericana',     3, 11,4, 40, '2026-1'),
    ('BIOL101', 'Biología Celular',               4, 9, 5, 28, '2026-1'),
    ('BIOL202', 'Genética Molecular',             5, 10,5, 22, '2026-1'),
    ('COMP401', 'Sistemas Distribuidos',          4, NULL, 1, 20, '2026-1');  -- Sin profesor asignado
    
-- Inscripciones (N:M) --
INSERT INTO inscripciones (estudiante_id, curso_id, calificacion, estado) VALUES
    -- Alicia
    (1, 1, 9.0, 'aprobado'),
    (1, 4, 8.5, 'aprobado'),
    (1, 6, NULL, 'cursando'),
    -- Brian
    (2, 1, 7.0, 'aprobado'),
    (2, 4, 6.5, 'reprobado'),
    (2, 8, NULL, 'cursando'),
    -- Camila
    (3, 1, 9.5, 'aprobado'),
    (3, 2, 9.0, 'aprobado'),
    (3, 3, NULL, 'cursando'),
    (3, 4, 9.8, 'aprobado'),
    -- Daniel
    (4, 1, 8.5, 'aprobado'),
    (4, 2, 9.0, 'aprobado'),
    (4, 3, NULL, 'cursando'),
    -- Estefania (ya graduada)
    (5, 1, 9.5, 'aprobado'),
    (5, 2, 9.8, 'aprobado'),
    (5, 3, 9.5, 'aprobado'),
    (5, 4, 10.0,'aprobado'),
    -- Federico
    (6, 4, 5.5, 'reprobado'),
    (6, 8, 7.0, 'aprobado'),
    -- Gabriela
    (7, 6, 8.5, 'aprobado'),
    (7, 7, NULL, 'cursando'),
    -- Hugo
    (8, 1, NULL, 'cursando'),
    (8, 4, NULL, 'cursando'),
    -- Inés (baja, sin inscripciones intencionalmente)
    -- Javier
    (10, 8, 7.5, 'aprobado'),
    (10, 9, NULL, 'cursando'),
    -- Karla (recién ingresada)
    (11, 1, NULL, 'cursando'),
    (11, 4, NULL, 'cursando');
    -- Lucas: sin inscripciones todavía (recién ingresó)

/*INSERT INTO inscripciones (estudiante_id, curso_id, calificacion, estado)
VALUES (2, 1, NULL, 'cursando');*/

/*SELECT 'departamentos' AS tabla, COUNT(*) AS filas FROM departamentos
UNION ALL SELECT 'profesores', COUNT(*) FROM profesores
UNION ALL SELECT 'estudiantes', COUNT(*) FROM estudiantes
UNION ALL SELECT 'cursos', COUNT(*) FROM cursos
UNION ALL SELECT 'inscripciones', COUNT(*) FROM inscripciones;*/

-- Fase 2 INNER JOIN --
-- Query 1. Lista todos los profesores con el nombre de su departamento
/*SELECT
	p.nombre AS nombre_profesores,
    d.nombre AS nombre_departamentos
FROM profesores p
INNER JOIN departamentos d ON p.departamento_id = d.id
ORDER BY d.nombre, p.nombre;

-- Query 2.  Lista cursos con el nombre del profesor que los imparte y del departamento
-- (Excluye cursos sin profesor asignado (COMP401))*/

/*SELECT
	c.codigo,
    c.nombre AS nombre_curso,
    p.nombre AS nombre_profesor,
    d.nombre AS nombre_departamento
FROM cursos c
INNER JOIN profesores p ON c.profesor_id = p.id
INNER JOIN departamentos d ON c.departamento_id = d.id
ORDER BY d.nombre, c.codigo;*/

-- Query 3. Lista estudiantes inscritos en "Cálculo Diferencial" (MATH101) con su calificación
-- (Solo los que ya tienen calificación asignada (no cursando).

/*SELECT 
	c.nombre AS nombre_curso,
    e.nombre AS nombre_estudiante,
    i.calificacion AS calificacion_estudiante,
    i.estado AS estado_estudiantes
FROM estudiantes e
INNER JOIN inscripciones i ON e.id = i.estudiante_id
INNER JOIN cursos c ON i.curso_id = c.id
WHERE c.nombre = 'Cálculo Diferencial' AND i.calificacion IS NOT NULL
ORDER BY i.calificacion DESC;*/

-- Fase 3 (LEFT JOIN, multiple JOINs)
-- Query 4. Lista TODOS los cursos, incluyendo los que no tienen profesor asignado
 
/*SELECT 
	c.codigo,
    c.nombre AS nombre_curso,
    coalesce(p.nombre, 'no asignado') AS profesor
FROM cursos c
LEFT JOIN profesores p ON c.profesor_id = p.id
ORDER BY c.codigo;*/

-- Query 5. Lista TODOS los estudiantes con el número de cursos en los que están inscritos (incluyendo los que no tienen ninguno)
-- Lucas e Inés deberían aparecer con 0.

/*SELECT 
    e.nombre AS nombre_estudiante,
    COUNT(i.curso_id) AS numero_cursos
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id = i.estudiante_id
GROUP BY e.id, e.nombre
ORDER BY numero_cursos DESC, e.nombre;*/

-- Query 6 — Profesores que NO tienen cursos asignados (caza de huérfanos)

/*SELECT 
	p.nombre AS nombre_profesor, 
    d.nombre AS nombre_departamento
FROM profesores p
LEFT JOIN cursos c      ON p.id = c.profesor_id
INNER JOIN departamentos d ON p.departamento_id = d.id
WHERE c.id IS NULL
ORDER BY p.nombre;*/

-- Query 7. Para cada departamento, ¿cuántos profesores tiene y cuántos cursos imparte?

/*SELECT 
    d.nombre AS nombre_departamento,
    COUNT(DISTINCT p.id) AS numero_profesores,
    COUNT(DISTINCT c.codigo) AS numero_cursos
FROM departamentos d
LEFT JOIN profesores p ON d.id = p.departamento_id
LEFT JOIN cursos c ON d.id = c.departamento_id
GROUP BY d.id, d.nombre
ORDER BY d.nombre;*/

-- Query 8. Qué cursos tiene cada estudiante (estudiante, código, curso, nota)
-- Solo estudiantes con al menos una inscripción.

/*SELECT
    c.codigo,
    e.nombre AS estudiante,
    c.nombre AS curso,
    i.calificacion,
    i.estado
FROM estudiantes e
INNER JOIN inscripciones i ON e.id = i.estudiante_id
INNER JOIN cursos c ON i.curso_id = c.id
ORDER BY e.nombre, c.codigo;*/

-- Query 9 — Estudiantes inscritos en cursos de Computacion (con curso y profesor)

/*SELECT
	c.codigo,
    e.nombre AS nombre_estudiante,
    c.nombre AS nombre_curso,
    p.nombre AS nombre_profesor
FROM estudiantes e
INNER JOIN inscripciones i ON e.id = i.estudiante_id
INNER JOIN cursos c ON i.curso_id = c.id
INNER JOIN departamentos d ON c.departamento_id = d.id
LEFT JOIN profesores p ON c.profesor_id = p.id
WHERE d.nombre = 'Computación'
ORDER BY e.nombre, c.codigo;*/

-- Fase 5 — SELF JOIN: la tabla consigo misma

-- Query 10. Cada profesor con el nombre de su jefe 

/*SELECT 
    p.nombre AS nombre_profesor,
    coalesce(j.nombre, 'Sin jefe') AS jefe_directo
FROM profesores p
LEFT JOIN profesores j ON p.jefe_id = j.id
ORDER BY p.nombre;*/

-- Query 11. Profesores que ganan más que su jefe

/*SELECT 
    p.nombre AS nombre_profesor,
    p.salario AS salario_profesor,
    j.nombre AS nombre_jefe,
    j.salario AS salario_jefe
FROM profesores p
INNER JOIN profesores j ON p.jefe_id = j.id
WHERE p.salario > j.salario;*/

-- Query 12. Pares de profesores del mismo departamento (sin duplicados ni auto-pares)

/*SELECT 
    p1.nombre AS profesor_1,
    p2.nombre AS profesor_2,
    p1.departamento_id AS id_departamento
FROM profesores p1
INNER JOIN profesores p2 ON p1.departamento_id = p2.departamento_id
   AND p1.id < p2.id
INNER JOIN departamentos d ON p1.departamento_id = d.id
ORDER BY p1.nombre, p2.nombre, p1.departamento_id;*/

/*SELECT e.nombre AS estudiante, c.codigo
FROM estudiantes e
CROSS JOIN cursos c
ORDER BY e.nombre, c.codigo;*/

-- Fase 6 — Queries de negocio + entrega

-- Query 13 — Top 3 cursos con más estudiantes inscritos

SELECT 
	c.codigo,
	c.nombre AS nombre_curso,
    COUNT(i.estudiante_id) AS total_inscritos
FROM cursos c
INNER JOIN inscripciones i ON c.id = i.curso_id
WHERE i.estado <> 'retirado'
GROUP BY c.id, c.nombre, c.codigo
ORDER BY total_inscritos DESC
LIMIT 3;

-- Query 14 — Estudiantes inscritos en cursos de 2+ departamentos distintos

/*SELECT
	e.nombre AS estudiante,
    COUNT(DISTINCT c.departamento_id) AS num_departamentos
FROM estudiantes e
INNER JOIN inscripciones i ON e.id = i.estudiante_id
INNER JOIN cursos c ON i.curso_id = c.id
GROUP BY e.id, e.nombre
HAVING COUNT(DISTINCT c.departamento_id) >= 2;*/

-- Query 15. Reporte completo: para cada departamento, lista total de profesores, total de cursos, total de estudiantes únicos inscritos en cursos del departamento

/*SELECT
	d.nombre AS departamento,
    COUNT(DISTINCT p.id) AS total_profesores,
    COUNT(DISTINCT c.id) AS total_cursos,
    COUNT(DISTINCT i.estudiante_id) AS estudiantes_unicos
FROM departamentos d
LEFT JOIN profesores p ON d.id = p.departamento_id
LEFT JOIN cursos c ON d.id = c.departamento_id
LEFT JOIN inscripciones i ON c.id = i.curso_id
GROUP BY d.id, d.nombre
ORDER BY total_profesores DESC;



    