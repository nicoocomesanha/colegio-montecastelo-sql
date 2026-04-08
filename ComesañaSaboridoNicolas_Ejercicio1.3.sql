CREATE DATABASE ColegioMontecastelo

USE ColegioMontecastelo

--Tabla Estudiantes 1
CREATE TABLE Estudiantes(
IDMatricula int,
NombreCompleto varchar (100),
FechaNacimiento date,
Matriculado char(2),

CONSTRAINT PK_Matricula PRIMARY KEY (IDMatricula),
CONSTRAINT CK_Matriculado CHECK ((MATRICULADO = 'SI') OR (MATRICULADO = 'NO'))
);

--Tabla Profesores 2
CREATE TABLE Profesores(
IDProfesor int,
Nombre varchar (20),
Apellidos varchar (40),
Especialidad varchar (20),
AnhosExperiencia int,

CONSTRAINT PK_Profesor PRIMARY KEY (IDProfesor)
);

--Tabla Ciclos 3
CREATE TABLE Ciclos(
IDCiclo int,
Nivel varchar (30),
Nombre varchar(20),

CONSTRAINT PK_Ciclo PRIMARY KEY (IDCiclo),
CONSTRAINT CK_Nivel CHECK ((NIVEL = 'Grado Medio') OR (NIVEL = 'Grado Superior'))
);

--Tabla Modulos 4
CREATE TABLE Modulos(
IDModulo int,
Nombre varchar(20),
NHoras int,
Ciclo int,

CONSTRAINT PK_Modulo PRIMARY KEY (IDModulo),
CONSTRAINT FK_Ciclo_Modulo FOREIGN KEY (Ciclo) REFERENCES Ciclos (IDCiclo)
);

--Tabla Examenes 5
CREATE TABLE Examenes(
IDExamen int,
Fecha date,
Tipo varchar(20),
IDProfesor int,
IDModulo int,

CONSTRAINT PK_Examen PRIMARY KEY (IDExamen),
CONSTRAINT FK_Examen_Profesor FOREIGN KEY(IDProfesor) REFERENCES Profesores (IDProfesor),
CONSTRAINT FK_Examen_Modulo FOREIGN KEY (IDModulo) REFERENCES Modulos (IDModulo),
CONSTRAINT CK_Tipo CHECK ((Tipo = 'Teórico') OR (Tipo = 'Práctico'))
);

--TABLA NOTA_EXAMENES 6
CREATE TABLE NOTA_EXAMENES(
IDMatricula int,
IDExamen int,
Nota float,

CONSTRAINT FK_Matricula_Nota FOREIGN KEY (IDMatricula) REFERENCES Estudiantes (IDMatricula),
CONSTRAINT FK_Matricula_Examen FOREIGN KEY (IDExamen) REFERENCES Examenes (IDExamen),
CONSTRAINT PK_Nota_Examenes PRIMARY KEY (IDMatricula, IDExamen)
);

--TABLA ESTUDIANTES_MODULO 7
CREATE TABLE Estudiantes_Modulo(
IDMatricula int,
IDModulo int,
Convocatoria varchar(20),
Calificacion float,

CONSTRAINT FK_EstudiantesModulo_Matricula FOREIGN KEY (IDMatricula) REFERENCES Estudiantes (IDMatricula),
CONSTRAINT FK_EstudiantesModulo_Modulo FOREIGN KEY (IDModulo) REFERENCES Modulos (IDModulo),
CONSTRAINT PK_EstudiantesModulo PRIMARY KEY (IDMatricula, IDModulo),
CONSTRAINT CK_Convocatoria CHECK ((Convocatoria = 'Ordinaria') OR (Convocatoria = 'Extraordinaria'))
);

--INSERTAR DATOS

INSERT INTO Estudiantes
VALUES (1, 'Nicolas Comesana', '18/06/2002', 'SI'), (12, 'Pedro Domingueza', '14/01/1997', 'SI')

--
INSERT INTO Profesores
VALUES (3, 'Ramon', 'Quiros', 'Inglés', 1),  (1, 'Pedro', 'Dominguez', 'Filosofía', 5)

--
INSERT INTO Ciclos
VALUES (2, 'Grado Medio', 'DAW'),  (1, 'Grado Superior', 'ASIR')

--
INSERT INTO Modulos
VALUES (2, 'Inglés', 70, 2), (1, 'DAW', 20, 1)

--
INSERT INTO Estudiantes_Modulo
VALUES (12, 2, 'Ordinaria', 5), (1, 1, 'Extraordinaria', 8)

--
INSERT INTO Examenes
VALUES (2, '24/03/2026', 'Teórico', 2, 1), (1, '26/03/2026', 'Práctico', 1, 1)

INSERT INTO NOTA_EXAMENES
VALUES (12,2,4), (1, 1, 7)
