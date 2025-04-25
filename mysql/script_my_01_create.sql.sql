-- Tabla de Facultades
CREATE TABLE Facultad (
    ID_Facultad INT,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

-- Tabla de Departamentos
CREATE TABLE Departamento (
    ID_Departamento INT,
    Nombre VARCHAR(100),
    ID_Facultad INT
);

-- Tabla de Programas Académicos
CREATE TABLE Programa_Academico (
    ID_Programa INT,
    Nombre VARCHAR(150),
    Nivel_Estudio VARCHAR(50),
    ID_Departamento INT
);

-- Tabla de Usuarios
CREATE TABLE Usuario (
    ID_Usuario INT,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Correo VARCHAR(150),
    Contrasena VARCHAR(255),
    Activo BOOLEAN,
    Fecha_Registro TIMESTAMP
);

-- Tabla de Roles
CREATE TABLE Rol (
    ID_Rol INT,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

-- Tabla de Permisos
CREATE TABLE Permiso (
    ID_Permiso INT,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

-- Tabla puente Rol-Permiso
CREATE TABLE Rol_Permiso (
    ID_Rol_Permiso INT,
    ID_Rol INT,
    ID_Permiso INT
);

-- Tabla de Usuario-Rol
CREATE TABLE Usuario_Rol (
    ID_Usuario_Rol INT,
    ID_Usuario INT,
    ID_Rol INT
);

-- Tabla de Docentes
CREATE TABLE Docente (
    ID_Docente INT,
    ID_Departamento INT,
    Titulo_Academico VARCHAR(100),
    Fecha_Contratacion DATE
);

-- Tabla de Estudiantes
CREATE TABLE Estudiante (
    ID_Estudiante INT,
    ID_Programa INT,
    Semestre INT,
    Matricula VARCHAR(20)
);

-- Tabla de Asignaturas
CREATE TABLE Asignatura (
    ID_Asignatura INT,
    Codigo VARCHAR(20),
    Nombre VARCHAR(150),
    Creditos INT,
    Horas_Teoricas INT,
    Horas_Practicas INT,
    ID_Programa INT
);

-- Tabla de Microcurrículos
CREATE TABLE Microcurriculo (
    ID_Microcurriculo INT,
    ID_Asignatura INT,
    Justificacion TEXT,
    Problematizacion TEXT,
    Objetivo_General TEXT,
    Fecha_Actualizacion DATE
);

-- Tabla de Elementos de Resultado de Aprendizaje
CREATE TABLE Elemento_ERA (
    ID_ERA INT,
    ID_Microcurriculo INT,
    Codigo VARCHAR(20),
    Descripcion TEXT,
    Criterios_Saber TEXT,
    Criterios_Hacer TEXT,
    Criterios_Ser TEXT
);

-- Tabla de Metodologías
CREATE TABLE Metodologia (
    ID_Metodologia INT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Ejemplos TEXT
);

-- Tabla de Grupos de Investigación
CREATE TABLE Grupo_Investigacion (
    ID_Grupo INT,
    Nombre VARCHAR(150),
    Linea_Investigacion VARCHAR(150),
    ID_Departamento INT
);

-- Tabla de Proyectos
CREATE TABLE Proyecto (
    ID_Proyecto INT,
    Titulo VARCHAR(200),
    Descripcion TEXT,
    Tipo CHAR(3),
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Estado VARCHAR(20),
    ID_Docente_Responsable INT
);

-- Tabla de relación Proyecto-Asignatura
CREATE TABLE Proyecto_Asignatura (
    ID_Proyecto_Asignatura INT,
    ID_Proyecto INT,
    ID_Asignatura INT
);

-- Tabla de relación Proyecto-Metodología
CREATE TABLE Proyecto_Metodologia (
    ID_Proyecto_Metodologia INT,
    ID_Proyecto INT,
    ID_Metodologia INT
);

-- Tabla de relación Proyecto-Grupo Investigación
CREATE TABLE Proyecto_Grupo_Investigacion (
    ID_Proyecto_Grupo INT,
    ID_Proyecto INT,
    ID_Grupo INT
);

-- Tabla de Tipos de Entregables
CREATE TABLE Tipo_Entregable (
    ID_Tipo_Entregable INT,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

-- Tabla de Entregables
CREATE TABLE Entregable (
    ID_Entregable INT,
    ID_Proyecto INT,
    ID_Tipo_Entregable INT,
    Descripcion TEXT,
    Fecha_Entrega DATE,
    Ruta_Archivo VARCHAR(255),
    Estado VARCHAR(20)
);

-- Tabla de Grupos de Trabajo
CREATE TABLE Grupo_Trabajo (
    ID_Grupo_Trabajo INT,
    ID_Proyecto INT,
    Nombre VARCHAR(100),
    ID_Estudiante_Lider INT
);

-- Tabla de relación Estudiante-Grupo_Trabajo
CREATE TABLE Estudiante_Grupo_Trabajo (
    ID_Estudiante_Grupo INT,
    ID_Estudiante INT,
    ID_Grupo_Trabajo INT,
    Rol VARCHAR(50)
);

-- Tabla de Rúbricas de Evaluación
CREATE TABLE Rubrica_Evaluacion (
    ID_Rubrica INT,
    ID_ERA INT,
    Nombre VARCHAR(150),
    Descripcion TEXT,
    Fecha_Creacion DATE
);

-- Tabla de Criterios de Rúbrica
CREATE TABLE Criterio_Rubrica (
    ID_Criterio_Rubrica INT,
    ID_Rubrica INT,
    Descripcion TEXT,
    Niveles_Desempeno JSON
);

-- Tabla de Evaluaciones
CREATE TABLE Evaluacion (
    ID_Evaluacion INT,
    ID_Proyecto INT,
    ID_Rubrica INT,
    Tipo_Evaluacion VARCHAR(50),
    Fecha_Evaluacion DATE,
    Periodo_Academico VARCHAR(20)
);

-- Tabla de Resultados de Evaluación
CREATE TABLE Resultado_Evaluacion (
    ID_Resultado INT,
    ID_Evaluacion INT,
    ID_Grupo_Trabajo INT,
    Calificacion DECIMAL(3,1),
    Comentarios TEXT,
    FECHA VARCHAR(10)
);

-- Tabla de Calendario de Entregas
CREATE TABLE Calendario_Entrega (
    ID_Calendario INT,
    ID_Proyecto INT,
    Tipo_Evento VARCHAR(50),
    Fecha_Hora_Inicio DATETIME,
    Fecha_Hora_Fin DATETIME,
    Descripcion TEXT,
    Ubicacion VARCHAR(150)
);

-- Tabla de Requerimientos de Insumos
CREATE TABLE Requerimiento_Insumo (
    ID_Requerimiento INT,
    ID_Proyecto INT,
    Descripcion TEXT,
    Cantidad INT,
    Unidad_Medida VARCHAR(20),
    Estado VARCHAR(20),
    Fecha_Solicitud DATE,
    Fecha_Entrega DATE,
    Observaciones TEXT
);

-- Tabla de Notificaciones
CREATE TABLE Notificacion (
    ID_Notificacion INT,
    ID_Usuario_Destino INT,
    Titulo VARCHAR(150),
    Mensaje TEXT,
    Fecha_Envio TIMESTAMP,
    Leida BOOLEAN,
    Tipo VARCHAR(50)
);

-- Tabla de Historial de Cambios
CREATE TABLE Historial_Cambio (
    ID_Historial INT,
    ID_Usuario INT,
    Tabla_Afectada VARCHAR(50),
    ID_Registro_Afectado INT,
    Accion VARCHAR(20),
    Datos_Anteriores JSON,
    Datos_Nuevos JSON,
    IP_Origen VARCHAR(45),
    fecha DATETIME
);
