create database yy;
use yy;


-- Tabla de Facultades
CREATE TABLE Facultad (
    ID_Facultad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT
);

-- Tabla de Departamentos
CREATE TABLE Departamento (
    ID_Departamento INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    ID_Facultad INT NOT NULL,
    FOREIGN KEY (ID_Facultad) REFERENCES Facultad(ID_Facultad)
);

-- Tabla de Programas Académicos
CREATE TABLE Programa_Academico (
    ID_Programa INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Nivel_Estudio VARCHAR(50) NOT NULL CHECK (Nivel_Estudio IN ('Pregrado', 'Posgrado', 'Técnico', 'Tecnólogo')),
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabla de Usuarios
CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Correo VARCHAR(150) NOT NULL UNIQUE,
    Contrasena VARCHAR(255) NOT NULL,
    Activo BOOLEAN DEFAULT TRUE,
    Fecha_Registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Roles
CREATE TABLE Rol (
    ID_Rol INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- Tabla de Permisos
CREATE TABLE Permiso (
    ID_Permiso INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- Tabla puente Rol-Permiso
CREATE TABLE Rol_Permiso (
    ID_Rol_Permiso INT AUTO_INCREMENT PRIMARY KEY,
    ID_Rol INT NOT NULL,
    ID_Permiso INT NOT NULL,
    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol),
    FOREIGN KEY (ID_Permiso) REFERENCES Permiso(ID_Permiso),
    UNIQUE (ID_Rol, ID_Permiso)
);

-- Tabla de Usuario-Rol
CREATE TABLE Usuario_Rol (
    ID_Usuario_Rol INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Rol INT NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol),
    UNIQUE (ID_Usuario, ID_Rol)
);

-- Tabla de Docentes
CREATE TABLE Docente (
    ID_Docente INT PRIMARY KEY,
    ID_Departamento INT NOT NULL,
    Titulo_Academico VARCHAR(100),
    Fecha_Contratacion DATE,
    FOREIGN KEY (ID_Docente) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabla de Estudiantes
CREATE TABLE Estudiante (
    ID_Estudiante INT PRIMARY KEY,
    ID_Programa INT NOT NULL,
    Semestre INT NOT NULL CHECK (Semestre > 0),
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (ID_Estudiante) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa)
);

-- Tabla de Asignaturas
CREATE TABLE Asignatura (
    ID_Asignatura INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(150) NOT NULL,
    Creditos INT NOT NULL CHECK (Creditos > 0),
    Horas_Teoricas INT NOT NULL,
    Horas_Practicas INT NOT NULL,
    ID_Programa INT NOT NULL,
    FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa)
);

-- Tabla de Microcurrículos
CREATE TABLE Microcurriculo (
    ID_Microcurriculo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Asignatura INT NOT NULL,
    Justificacion TEXT NOT NULL,
    Problematizacion TEXT NOT NULL,
    Objetivo_General TEXT NOT NULL,
    Fecha_Actualizacion DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura),
    UNIQUE (ID_Asignatura)
);

-- Tabla de Elementos de Resultado de Aprendizaje
CREATE TABLE Elemento_ERA (
    ID_ERA INT AUTO_INCREMENT PRIMARY KEY,
    ID_Microcurriculo INT NOT NULL,
    Codigo VARCHAR(20) NOT NULL,
    Descripcion TEXT NOT NULL,
    Criterios_Saber TEXT NOT NULL,
    Criterios_Hacer TEXT NOT NULL,
    Criterios_Ser TEXT NOT NULL,
    FOREIGN KEY (ID_Microcurriculo) REFERENCES Microcurriculo(ID_Microcurriculo),
    UNIQUE (ID_Microcurriculo, Codigo)
);

-- Tabla de Metodologías
CREATE TABLE Metodologia (
    ID_Metodologia INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT,
    Ejemplos TEXT
);

-- Tabla de Grupos de Investigación
CREATE TABLE Grupo_Investigacion (
    ID_Grupo INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL UNIQUE,
    Linea_Investigacion VARCHAR(150) NOT NULL,
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabla de Proyectos
CREATE TABLE Proyecto (
    ID_Proyecto INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(200) NOT NULL,
    Descripcion TEXT NOT NULL,
    Tipo CHAR(3) NOT NULL CHECK (Tipo IN ('PA', 'PIA')),
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL CHECK (Estado IN ('Borrador', 'Activo', 'Finalizado', 'Cancelado')),
    ID_Docente_Responsable INT NOT NULL,
    FOREIGN KEY (ID_Docente_Responsable) REFERENCES Docente(ID_Docente),
    CONSTRAINT chk_fechas_proyecto CHECK (Fecha_Fin > Fecha_Inicio)
);

-- Tabla de relación Proyecto-Asignatura
CREATE TABLE Proyecto_Asignatura (
    ID_Proyecto_Asignatura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Asignatura INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura),
    UNIQUE (ID_Proyecto, ID_Asignatura)
);

-- Tabla de relación Proyecto-Metodología
CREATE TABLE Proyecto_Metodologia (
    ID_Proyecto_Metodologia INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Metodologia INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Metodologia) REFERENCES Metodologia(ID_Metodologia),
    UNIQUE (ID_Proyecto, ID_Metodologia)
);

-- Tabla de relación Proyecto-Grupo Investigación
CREATE TABLE Proyecto_Grupo_Investigacion (
    ID_Proyecto_Grupo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Grupo INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Grupo) REFERENCES Grupo_Investigacion(ID_Grupo),
    UNIQUE (ID_Proyecto, ID_Grupo)
);

-- Tabla de Tipos de Entregables
CREATE TABLE Tipo_Entregable (
    ID_Tipo_Entregable INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- Tabla de Entregables
CREATE TABLE Entregable (
    ID_Entregable INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Tipo_Entregable INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha_Entrega DATE NOT NULL,
    Ruta_Archivo VARCHAR(255),
    Estado VARCHAR(20) NOT NULL CHECK (Estado IN ('Pendiente', 'Entregado', 'Aprobado', 'Rechazado')),
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Tipo_Entregable) REFERENCES Tipo_Entregable(ID_Tipo_Entregable)
);

-- Tabla de Grupos de Trabajo
CREATE TABLE Grupo_Trabajo (
    ID_Grupo_Trabajo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    ID_Estudiante_Lider INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Estudiante_Lider) REFERENCES Estudiante(ID_Estudiante),
    UNIQUE (ID_Proyecto, Nombre)
);

-- Tabla de relación Estudiante-Grupo_Trabajo
CREATE TABLE Estudiante_Grupo_Trabajo (
    ID_Estudiante_Grupo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Estudiante INT NOT NULL,
    ID_Grupo_Trabajo INT NOT NULL,
    Rol VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Estudiante) REFERENCES Estudiante(ID_Estudiante),
    FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo),
    UNIQUE (ID_Estudiante, ID_Grupo_Trabajo)
);

-- Tabla de Rúbricas de Evaluación
CREATE TABLE Rubrica_Evaluacion (
    ID_Rubrica INT AUTO_INCREMENT PRIMARY KEY,
    ID_ERA INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Descripcion TEXT,
    Fecha_Creacion DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (ID_ERA) REFERENCES Elemento_ERA(ID_ERA)
);

-- Tabla de Criterios de Rúbrica
CREATE TABLE Criterio_Rubrica (
    ID_Criterio_Rubrica INT AUTO_INCREMENT PRIMARY KEY,
    ID_Rubrica INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Ponderacion DECIMAL(5,2) NOT NULL CHECK (Ponderacion > 0 AND Ponderacion <= 100),
    Niveles_Desempeno JSON NOT NULL,
    FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica)
);

-- Tabla de Evaluaciones
CREATE TABLE Evaluacion (
    ID_Evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Rubrica INT NOT NULL,
    Tipo_Evaluacion VARCHAR(50) NOT NULL CHECK (Tipo_Evaluacion IN ('Autoevaluación', 'Coevaluación', 'Heteroevaluación')),
    Fecha_Evaluacion DATE NOT NULL,
    Periodo_Academico VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica)
);

-- Tabla de Resultados de Evaluación
CREATE TABLE Resultado_Evaluacion (
    ID_Resultado INT AUTO_INCREMENT PRIMARY KEY,
    ID_Evaluacion INT NOT NULL,
    ID_Grupo_Trabajo INT NOT NULL,
    Calificacion DECIMAL(3,1) NOT NULL CHECK (Calificacion >= 0 AND Calificacion <= 5.0),
    Comentarios TEXT,
    FECHA VARCHAR(10),
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion),
    FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo),
    UNIQUE (ID_Evaluacion, ID_Grupo_Trabajo)
);

-- Tabla de Calendario de Entregas
CREATE TABLE Calendario_Entrega (
    ID_Calendario INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Tipo_Evento VARCHAR(50) NOT NULL CHECK (Tipo_Evento IN ('Entrega', 'Revisión', 'Sesión', 'Presentación')),
    Fecha_Hora_Inicio DATETIME NOT NULL,
    Fecha_Hora_Fin DATETIME NOT NULL,
    Descripcion TEXT NOT NULL,
    Ubicacion VARCHAR(150),
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    CONSTRAINT chk_fechas_calendario CHECK (Fecha_Hora_Fin > Fecha_Hora_Inicio)
);

-- Tabla de Requerimientos de Insumos
CREATE TABLE Requerimiento_Insumo (
    ID_Requerimiento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Unidad_Medida VARCHAR(20) NOT NULL,
    Estado VARCHAR(20) NOT NULL CHECK (Estado IN ('Solicitado', 'Aprobado', 'Rechazado', 'Entregado')),
    Fecha_Solicitud DATE DEFAULT (CURRENT_DATE),
    Fecha_Entrega DATE,
    Observaciones TEXT,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto)
);

-- Tabla de Notificaciones
CREATE TABLE Notificacion (
    ID_Notificacion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario_Destino INT NOT NULL,
    Titulo VARCHAR(150) NOT NULL,
    Mensaje TEXT NOT NULL,
    Fecha_Envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Leida BOOLEAN DEFAULT FALSE,
    Tipo VARCHAR(50) NOT NULL CHECK (Tipo IN ('Sistema', 'Mensaje', 'Alerta', 'Recordatorio')),
    FOREIGN KEY (ID_Usuario_Destino) REFERENCES Usuario(ID_Usuario)
);

-- Tabla de Historial de Cambios
CREATE TABLE Historial_Cambio (
    ID_Historial INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    Tabla_Afectada VARCHAR(50) NOT NULL,
    ID_Registro_Afectado INT NOT NULL,
    Accion VARCHAR(20) NOT NULL CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE')),
    Datos_Anteriores JSON,
    Datos_Nuevos JSON,
    IP_Origen VARCHAR(45),
    fecha DATETIME NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

show tables;
