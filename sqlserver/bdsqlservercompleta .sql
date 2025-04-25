-- Tabla de Facultades
CREATE TABLE Facultad (
    ID_Facultad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT
);

-- Tabla de Departamentos
CREATE TABLE Departamento (
    ID_Departamento INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    ID_Facultad INT NOT NULL,
    FOREIGN KEY (ID_Facultad) REFERENCES Facultad(ID_Facultad)
);

-- Tabla de Programas Académicos
CREATE TABLE Programa_Academico (
    ID_Programa INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Nivel_Estudio VARCHAR(50) NOT NULL,
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento),
    CONSTRAINT chk_nivel_estudio CHECK (Nivel_Estudio IN ('Pregrado', 'Posgrado', 'Técnico', 'Tecnólogo'))
);

-- Tabla de Usuarios
CREATE TABLE Usuario (
    ID_Usuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Correo VARCHAR(150) NOT NULL UNIQUE,
    Contrasena VARCHAR(255) NOT NULL,
    Activo BIT DEFAULT 1,
    Fecha_Registro DATETIME DEFAULT GETDATE()
);

-- Tabla de Roles
CREATE TABLE Rol (
    ID_Rol INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- Tabla de Permisos
CREATE TABLE Permiso (
    ID_Permiso INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- Tabla puente Rol-Permiso
CREATE TABLE Rol_Permiso (
    ID_Rol_Permiso INT IDENTITY(1,1) PRIMARY KEY,
    ID_Rol INT NOT NULL,
    ID_Permiso INT NOT NULL,
    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol),
    FOREIGN KEY (ID_Permiso) REFERENCES Permiso(ID_Permiso),
    CONSTRAINT uq_rol_permiso UNIQUE (ID_Rol, ID_Permiso)
);

-- Tabla de Usuario-Rol
CREATE TABLE Usuario_Rol (
    ID_Usuario_Rol INT IDENTITY(1,1) PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Rol INT NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol),
    CONSTRAINT uq_usuario_rol UNIQUE (ID_Usuario, ID_Rol)
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
    Semestre INT NOT NULL,
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (ID_Estudiante) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa),
    CONSTRAINT chk_semestre CHECK (Semestre > 0)
);

-- Tabla de Asignaturas
CREATE TABLE Asignatura (
    ID_Asignatura INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(150) NOT NULL,
    Creditos INT NOT NULL,
    Horas_Teoricas INT NOT NULL,
    Horas_Practicas INT NOT NULL,
    ID_Programa INT NOT NULL,
    FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa),
    CONSTRAINT chk_creditos CHECK (Creditos > 0)
);

-- Tabla de Microcurrículos
CREATE TABLE Microcurriculo (
    ID_Microcurriculo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Asignatura INT NOT NULL UNIQUE,
    Justificacion TEXT NOT NULL,
    Problematizacion TEXT NOT NULL,
    Objetivo_General TEXT NOT NULL,
    Fecha_Actualizacion DATE DEFAULT CONVERT(date, GETDATE()),
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura)
);

-- Tabla de Elementos de Resultado de Aprendizaje
CREATE TABLE Elemento_ERA (
    ID_ERA INT IDENTITY(1,1) PRIMARY KEY,
    ID_Microcurriculo INT NOT NULL,
    Codigo VARCHAR(20) NOT NULL,
    Descripcion TEXT NOT NULL,
    Criterios_Saber TEXT NOT NULL,
    Criterios_Hacer TEXT NOT NULL,
    Criterios_Ser TEXT NOT NULL,
    FOREIGN KEY (ID_Microcurriculo) REFERENCES Microcurriculo(ID_Microcurriculo),
    CONSTRAINT uq_era_microcurriculo_codigo UNIQUE (ID_Microcurriculo, Codigo)
);

-- Tabla de Metodologías
CREATE TABLE Metodologia (
    ID_Metodologia INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT,
    Ejemplos TEXT
);

-- Tabla de Grupos de Investigación
CREATE TABLE Grupo_Investigacion (
    ID_Grupo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL UNIQUE,
    Linea_Investigacion VARCHAR(150) NOT NULL,
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabla de Proyectos
CREATE TABLE Proyecto (
    ID_Proyecto INT IDENTITY(1,1) PRIMARY KEY,
    Titulo VARCHAR(200) NOT NULL,
    Descripcion TEXT NOT NULL,
    Tipo CHAR(3) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    ID_Docente_Responsable INT NOT NULL,
    FOREIGN KEY (ID_Docente_Responsable) REFERENCES Docente(ID_Docente),
    CONSTRAINT chk_tipo_proyecto CHECK (Tipo IN ('PA', 'PIA')),
    CONSTRAINT chk_estado_proyecto CHECK (Estado IN ('Borrador', 'Activo', 'Finalizado', 'Cancelado')),
    CONSTRAINT chk_fechas_proyecto CHECK (Fecha_Fin > Fecha_Inicio)
);

-- Tabla de relación Proyecto-Asignatura
CREATE TABLE Proyecto_Asignatura (
    ID_Proyecto_Asignatura INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Asignatura INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura),
    CONSTRAINT uq_proyecto_asignatura UNIQUE (ID_Proyecto, ID_Asignatura)
);

-- Tabla de relación Proyecto-Metodología
CREATE TABLE Proyecto_Metodologia (
    ID_Proyecto_Metodologia INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Metodologia INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Metodologia) REFERENCES Metodologia(ID_Metodologia),
    CONSTRAINT uq_proyecto_metodologia UNIQUE (ID_Proyecto, ID_Metodologia)
);

-- Tabla de relación Proyecto-Grupo Investigación
CREATE TABLE Proyecto_Grupo_Investigacion (
    ID_Proyecto_Grupo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Grupo INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Grupo) REFERENCES Grupo_Investigacion(ID_Grupo),
    CONSTRAINT uq_proyecto_grupo UNIQUE (ID_Proyecto, ID_Grupo)
);

-- Tabla de Tipos de Entregables
CREATE TABLE Tipo_Entregable (
    ID_Tipo_Entregable INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

-- Tabla de Entregables
CREATE TABLE Entregable (
    ID_Entregable INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Tipo_Entregable INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha_Entrega DATE NOT NULL,
    Ruta_Archivo VARCHAR(255),
    Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Tipo_Entregable) REFERENCES Tipo_Entregable(ID_Tipo_Entregable),
    CONSTRAINT chk_estado_entregable CHECK (Estado IN ('Pendiente', 'Entregado', 'Aprobado', 'Rechazado'))
);

-- Tabla de Grupos de Trabajo
CREATE TABLE Grupo_Trabajo (
    ID_Grupo_Trabajo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    ID_Estudiante_Lider INT NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Estudiante_Lider) REFERENCES Estudiante(ID_Estudiante),
    CONSTRAINT uq_grupo_trabajo_nombre UNIQUE (ID_Proyecto, Nombre)
);

-- Tabla de relación Estudiante-Grupo_Trabajo
CREATE TABLE Estudiante_Grupo_Trabajo (
    ID_Estudiante_Grupo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Estudiante INT NOT NULL,
    ID_Grupo_Trabajo INT NOT NULL,
    Rol VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Estudiante) REFERENCES Estudiante(ID_Estudiante),
    FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo),
    CONSTRAINT uq_estudiante_grupo UNIQUE (ID_Estudiante, ID_Grupo_Trabajo)
);

-- Tabla de Rúbricas de Evaluación
CREATE TABLE Rubrica_Evaluacion (
    ID_Rubrica INT IDENTITY(1,1) PRIMARY KEY,
    ID_ERA INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Descripcion TEXT,
    Fecha_Creacion DATE DEFAULT CONVERT(date, GETDATE()),
    FOREIGN KEY (ID_ERA) REFERENCES Elemento_ERA(ID_ERA)
);

-- Tabla de Criterios de Rúbrica
CREATE TABLE Criterio_Rubrica (
    ID_Criterio_Rubrica INT IDENTITY(1,1) PRIMARY KEY,
    ID_Rubrica INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Niveles_Desempeno NVARCHAR(MAX) NOT NULL, -- JSON is stored as NVARCHAR(MAX) in SQL Server
    FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica)
);

-- Tabla de Evaluaciones
CREATE TABLE Evaluacion (
    ID_Evaluacion INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    ID_Rubrica INT NOT NULL,
    Tipo_Evaluacion VARCHAR(50) NOT NULL,
    Fecha_Evaluacion DATE NOT NULL,
    Periodo_Academico VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica),
    CONSTRAINT chk_tipo_evaluacion CHECK (Tipo_Evaluacion IN ('Autoevaluación', 'Coevaluación', 'Heteroevaluación'))
);

-- Tabla de Resultados de Evaluación
CREATE TABLE Resultado_Evaluacion (
    ID_Resultado INT IDENTITY(1,1) PRIMARY KEY,
    ID_Evaluacion INT NOT NULL,
    ID_Grupo_Trabajo INT NOT NULL,
    Calificacion DECIMAL(3,1) NOT NULL,
    Comentarios TEXT,
    FECHA VARCHAR(10),
    FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion),
    FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo),
    CONSTRAINT uq_resultado_evaluacion UNIQUE (ID_Evaluacion, ID_Grupo_Trabajo),
    CONSTRAINT chk_calificacion CHECK (Calificacion >= 0 AND Calificacion <= 5.0)
);

-- Tabla de Calendario de Entregas
CREATE TABLE Calendario_Entrega (
    ID_Calendario INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Tipo_Evento VARCHAR(50) NOT NULL,
    Fecha_Hora_Inicio DATETIME NOT NULL,
    Fecha_Hora_Fin DATETIME NOT NULL,
    Descripcion TEXT NOT NULL,
    Ubicacion VARCHAR(150),
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    CONSTRAINT chk_tipo_evento CHECK (Tipo_Evento IN ('Entrega', 'Revisión', 'Sesión', 'Presentación')),
    CONSTRAINT chk_fechas_calendario CHECK (Fecha_Hora_Fin > Fecha_Hora_Inicio)
);

-- Tabla de Requerimientos de Insumos
CREATE TABLE Requerimiento_Insumo (
    ID_Requerimiento INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Cantidad INT NOT NULL,
    Unidad_Medida VARCHAR(20) NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    Fecha_Solicitud DATE DEFAULT CONVERT(date, GETDATE()),
    Fecha_Entrega DATE,
    Observaciones TEXT,
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    CONSTRAINT chk_cantidad CHECK (Cantidad > 0),
    CONSTRAINT chk_estado_requerimiento CHECK (Estado IN ('Solicitado', 'Aprobado', 'Rechazado', 'Entregado'))
);

-- Tabla de Notificaciones
CREATE TABLE Notificacion (
    ID_Notificacion INT IDENTITY(1,1) PRIMARY KEY,
    ID_Usuario_Destino INT NOT NULL,
    Titulo VARCHAR(150) NOT NULL,
    Mensaje TEXT NOT NULL,
    Fecha_Envio DATETIME DEFAULT GETDATE(),
    Leida BIT DEFAULT 0,
    Tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Usuario_Destino) REFERENCES Usuario(ID_Usuario),
    CONSTRAINT chk_tipo_notificacion CHECK (Tipo IN ('Sistema', 'Mensaje', 'Alerta', 'Recordatorio'))
);

-- Tabla de Historial de Cambios
CREATE TABLE Historial_Cambio (
    ID_Historial INT IDENTITY(1,1) PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    Tabla_Afectada VARCHAR(50) NOT NULL,
    ID_Registro_Afectado INT NOT NULL,
    Accion VARCHAR(20) NOT NULL,
    Datos_Anteriores NVARCHAR(MAX),
    Datos_Nuevos NVARCHAR(MAX),
    IP_Origen VARCHAR(45),
    fecha DATETIME NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    CONSTRAINT chk_accion CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE'))
);