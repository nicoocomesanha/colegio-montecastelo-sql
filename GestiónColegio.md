# 📚 Sistema de Gestión Escolar - Colegio Montecastelo

## 📝 Descripción
Este repositorio contiene el diseño y la implementación técnica de una base de datos para la gestión de un centro educativo. El proyecto ha sido desarrollado como parte del módulo **Gestión de Bases de Datos (1º ASIR)**.

El objetivo es administrar de forma eficiente la información de alumnos, ciclos formativos, profesores y el registro histórico de exámenes y calificaciones.

---

## 🗺️ Diseño Lógico (Modelo Entidad-Relación)
![Modelo Entidad Relación](./diagrama.png)

La base de datos está diseñada siguiendo principios de normalización para evitar redundancias. 

**Características principales:**
* **Restricciones de Integridad:** Uso de `CHECK` para validar niveles educativos (Grado Medio/Superior), tipos de examen y estados de matriculación.
* **Relaciones N:M:** Gestión de matrículas en módulos y notas de exámenes mediante tablas intermedias.
* **Trazabilidad:** Cada nota está vinculada inequívocamente a un alumno y a un evento de examen específico.

---

## 🚀 Implementación SQL

### 1. Estructura de la Base de Datos (DDL)
El script crea 7 tablas interconectadas:
1. `Estudiantes`: Datos personales y estado de matrícula.
2. `Profesores`: Datos docentes y experiencia.
3. `Ciclos`: Clasificación por niveles.
4. `Modulos`: Asignaturas vinculadas a ciclos.
5. `Examenes`: Programación de pruebas vinculadas a módulos y profesores.
6. `NOTA_EXAMENES`: Calificaciones por examen.
7. `Estudiantes_Modulo`: Actas finales por convocatoria.

### 2. Consultas de Verificación (DML)
Para validar el sistema, he diseñado las siguientes consultas que extraen información clave:

#### A. Acta de calificaciones por módulo
Esta consulta permite ver qué nota tiene cada alumno:
```sql
SELECT E.NombreCompleto, M.Nombre AS Modulo, EM.Calificacion
FROM Estudiantes E
JOIN Estudiantes_Modulo EM ON E.IDMatricula = EM.IDMatricula
JOIN Modulos M ON EM.IDModulo = M.IDModulo;
```

#### B. Control de Exámenes y Docencia
Útil para la jefatura de estudios para saber quién evalúa cada prueba:
```sql
SELECT EX.Fecha, EX.Tipo, P.Nombre AS Profesor, P.Apellidos, M.Nombre AS Asignatura
FROM Examenes EX
JOIN Profesores P ON EX.IDProfesor = P.IDProfesor
JOIN Modulos M ON EX.IDModulo = M.IDModulo;
```

#### C. Estadísticas de rendimiento
Calcula la nota media obtenida en cada módulo
```sql
SELECT M.Nombre AS Modulo, AVG(EM.Calificacion) AS Nota_Media
FROM Modulos M
JOIN Estudiantes_Modulo EM ON M.IDModulo = EM.IDModulo
GROUP BY M.Nombre;
```


## 🛠️ Cómo ejecutar el laboratorio
1. Disponer de un servidor **SQL Server**.
2. Crear la base de datos: `CREATE DATABASE ColegioMontecastelo;`.
3. Ejecutar el script `ComesañaSaboridoNicolas_Ejercicio1.3.sql` para generar la estructura y los datos de prueba.