-- Tabla de Facultades
CREATE TABLE Facultad (
    ID_Facultad SERIAL,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

-- Tabla de Departamentos
CREATE TABLE Departamento (
    ID_Departamento SERIAL,
    Nombre VARCHAR(100),
    ID_Facultad INT
);

-- Tabla de Programas Académicos
CREATE TABLE Programa_Academico (
    ID_Programa SERIAL,
    Nombre VARCHAR(150),
    Nivel_Estudio VARCHAR(50),
    ID_Departamento INT
);

-- Tabla de Usuarios
CREATE TABLE Usuario (
    ID_Usuario SERIAL,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Correo VARCHAR(150),
    Contrasena VARCHAR(255),
    Activo BOOLEAN,
    Fecha_Registro TIMESTAMP
);

-- Tabla de Roles
CREATE TABLE Rol (
    ID_Rol SERIAL,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

-- Tabla de Permisos
CREATE TABLE Permiso (
    ID_Permiso SERIAL,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

-- Tabla puente Rol-Permiso
CREATE TABLE Rol_Permiso (
    ID_Rol_Permiso SERIAL,
    ID_Rol INT,
    ID_Permiso INT
);

-- Tabla de Usuario-Rol
CREATE TABLE Usuario_Rol (
    ID_Usuario_Rol SERIAL,
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
    ID_Asignatura SERIAL,
    Codigo VARCHAR(20),
    Nombre VARCHAR(150),
    Creditos INT,
    Horas_Teoricas INT,
    Horas_Practicas INT,
    ID_Programa INT
);

-- Tabla de Microcurrículos
CREATE TABLE Microcurriculo (
    ID_Microcurriculo SERIAL,
    ID_Asignatura INT,
    Justificacion TEXT,
    Problematizacion TEXT,
    Objetivo_General TEXT,
    Fecha_Actualizacion DATE
);

-- Tabla de Elementos de Resultado de Aprendizaje
CREATE TABLE Elemento_ERA (
    ID_ERA SERIAL,
    ID_Microcurriculo INT,
    Codigo VARCHAR(20),
    Descripcion TEXT,
    Criterios_Saber TEXT,
    Criterios_Hacer TEXT,
    Criterios_Ser TEXT
);

-- Tabla de Metodologías
CREATE TABLE Metodologia (
    ID_Metodologia SERIAL,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Ejemplos TEXT
);

-- Tabla de Grupos de Investigación
CREATE TABLE Grupo_Investigacion (
    ID_Grupo SERIAL,
    Nombre VARCHAR(150),
    Linea_Investigacion VARCHAR(150),
    ID_Departamento INT
);

-- Tabla de Proyectos
CREATE TABLE Proyecto (
    ID_Proyecto SERIAL,
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
    ID_Proyecto_Asignatura SERIAL,
    ID_Proyecto INT,
    ID_Asignatura INT
);

-- Tabla de relación Proyecto-Metodología
CREATE TABLE Proyecto_Metodologia (
    ID_Proyecto_Metodologia SERIAL,
    ID_Proyecto INT,
    ID_Metodologia INT
);

-- Tabla de relación Proyecto-Grupo Investigación
CREATE TABLE Proyecto_Grupo_Investigacion (
    ID_Proyecto_Grupo SERIAL,
    ID_Proyecto INT,
    ID_Grupo INT
);

-- Tabla de Tipos de Entregables
CREATE TABLE Tipo_Entregable (
    ID_Tipo_Entregable SERIAL,
    Nombre VARCHAR(100),
    Descripcion TEXT
);

-- Tabla de Entregables
CREATE TABLE Entregable (
    ID_Entregable SERIAL,
    ID_Proyecto INT,
    ID_Tipo_Entregable INT,
    Descripcion TEXT,
    Fecha_Entrega DATE,
    Ruta_Archivo VARCHAR(255),
    Estado VARCHAR(20)
);

-- Tabla de Grupos de Trabajo
CREATE TABLE Grupo_Trabajo (
    ID_Grupo_Trabajo SERIAL,
    ID_Proyecto INT,
    Nombre VARCHAR(100),
    ID_Estudiante_Lider INT
);

-- Tabla de relación Estudiante-Grupo_Trabajo
CREATE TABLE Estudiante_Grupo_Trabajo (
    ID_Estudiante_Grupo SERIAL,
    ID_Estudiante INT,
    ID_Grupo_Trabajo INT,
    Rol VARCHAR(50)
);

-- Tabla de Rúbricas de Evaluación
CREATE TABLE Rubrica_Evaluacion (
    ID_Rubrica SERIAL,
    ID_ERA INT,
    Nombre VARCHAR(150),
    Descripcion TEXT,
    Fecha_Creacion DATE
);

-- Tabla de Criterios de Rúbrica
CREATE TABLE Criterio_Rubrica (
    ID_Criterio_Rubrica SERIAL,
    ID_Rubrica INT,
    Descripcion TEXT,
    Ponderacion DECIMAL(5,2),
    Niveles_Desempeno JSONB
);

-- Tabla de Evaluaciones
CREATE TABLE Evaluacion (
    ID_Evaluacion SERIAL,
    ID_Proyecto INT,
    ID_Rubrica INT,
    Tipo_Evaluacion VARCHAR(50),
    Fecha_Evaluacion DATE,
    Periodo_Academico VARCHAR(20)
);

-- Tabla de Resultados de Evaluación
CREATE TABLE Resultado_Evaluacion (
    ID_Resultado SERIAL,
    ID_Evaluacion INT,
    ID_Grupo_Trabajo INT,
    Calificacion DECIMAL(3,1),
    Comentarios TEXT
);

-- Tabla de Calendario de Entregas
CREATE TABLE Calendario_Entrega (
    ID_Calendario SERIAL,
    ID_Proyecto INT,
    Tipo_Evento VARCHAR(50),
    Fecha_Hora_Inicio TIMESTAMP,
    Fecha_Hora_Fin TIMESTAMP,
    Descripcion TEXT,
    Ubicacion VARCHAR(150)
);

-- Tabla de Requerimientos de Insumos
CREATE TABLE Requerimiento_Insumo (
    ID_Requerimiento SERIAL,
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
    ID_Notificacion SERIAL,
    ID_Usuario_Destino INT,
    Titulo VARCHAR(150),
    Mensaje TEXT,
    Fecha_Envio TIMESTAMP,
    Leida BOOLEAN,
    Tipo VARCHAR(50)
);

-- Tabla de Historial de Cambios
CREATE TABLE Historial_Cambio (
    ID_Historial SERIAL,
    ID_Usuario INT,
    Tabla_Afectada VARCHAR(50),
    ID_Registro_Afectado INT,
    Accion VARCHAR(20),
    Datos_Anteriores JSONB,
    Datos_Nuevos JSONB,
    Fecha_Cambio TIMESTAMP,
    IP_Origen VARCHAR(45)
);

-- Primary Keys
ALTER TABLE Facultad ADD PRIMARY KEY (ID_Facultad);
ALTER TABLE Departamento ADD PRIMARY KEY (ID_Departamento);
ALTER TABLE Programa_Academico ADD PRIMARY KEY (ID_Programa);
ALTER TABLE Usuario ADD PRIMARY KEY (ID_Usuario);
ALTER TABLE Rol ADD PRIMARY KEY (ID_Rol);
ALTER TABLE Permiso ADD PRIMARY KEY (ID_Permiso);
ALTER TABLE Rol_Permiso ADD PRIMARY KEY (ID_Rol_Permiso);
ALTER TABLE Usuario_Rol ADD PRIMARY KEY (ID_Usuario_Rol);
ALTER TABLE Docente ADD PRIMARY KEY (ID_Docente);
ALTER TABLE Estudiante ADD PRIMARY KEY (ID_Estudiante);
ALTER TABLE Asignatura ADD PRIMARY KEY (ID_Asignatura);
ALTER TABLE Microcurriculo ADD PRIMARY KEY (ID_Microcurriculo);
ALTER TABLE Elemento_ERA ADD PRIMARY KEY (ID_ERA);
ALTER TABLE Metodologia ADD PRIMARY KEY (ID_Metodologia);
ALTER TABLE Grupo_Investigacion ADD PRIMARY KEY (ID_Grupo);
ALTER TABLE Proyecto ADD PRIMARY KEY (ID_Proyecto);
ALTER TABLE Proyecto_Asignatura ADD PRIMARY KEY (ID_Proyecto_Asignatura);
ALTER TABLE Proyecto_Metodologia ADD PRIMARY KEY (ID_Proyecto_Metodologia);
ALTER TABLE Proyecto_Grupo_Investigacion ADD PRIMARY KEY (ID_Proyecto_Grupo);
ALTER TABLE Tipo_Entregable ADD PRIMARY KEY (ID_Tipo_Entregable);
ALTER TABLE Entregable ADD PRIMARY KEY (ID_Entregable);
ALTER TABLE Grupo_Trabajo ADD PRIMARY KEY (ID_Grupo_Trabajo);
ALTER TABLE Estudiante_Grupo_Trabajo ADD PRIMARY KEY (ID_Estudiante_Grupo);
ALTER TABLE Rubrica_Evaluacion ADD PRIMARY KEY (ID_Rubrica);
ALTER TABLE Criterio_Rubrica ADD PRIMARY KEY (ID_Criterio_Rubrica);
ALTER TABLE Evaluacion ADD PRIMARY KEY (ID_Evaluacion);
ALTER TABLE Resultado_Evaluacion ADD PRIMARY KEY (ID_Resultado);
ALTER TABLE Calendario_Entrega ADD PRIMARY KEY (ID_Calendario);
ALTER TABLE Requerimiento_Insumo ADD PRIMARY KEY (ID_Requerimiento);
ALTER TABLE Notificacion ADD PRIMARY KEY (ID_Notificacion);
ALTER TABLE Historial_Cambio ADD PRIMARY KEY (ID_Historial);

-- Foreign Keys
ALTER TABLE Departamento ADD CONSTRAINT fk_departamento_facultad FOREIGN KEY (ID_Facultad) REFERENCES Facultad(ID_Facultad);
ALTER TABLE Programa_Academico ADD CONSTRAINT fk_programa_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento);
ALTER TABLE Rol_Permiso ADD CONSTRAINT fk_rol_permiso_rol FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol);
ALTER TABLE Rol_Permiso ADD CONSTRAINT fk_rol_permiso_permiso FOREIGN KEY (ID_Permiso) REFERENCES Permiso(ID_Permiso);
ALTER TABLE Usuario_Rol ADD CONSTRAINT fk_usuario_rol_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);
ALTER TABLE Usuario_Rol ADD CONSTRAINT fk_usuario_rol_rol FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol);
ALTER TABLE Docente ADD CONSTRAINT fk_docente_usuario FOREIGN KEY (ID_Docente) REFERENCES Usuario(ID_Usuario);
ALTER TABLE Docente ADD CONSTRAINT fk_docente_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento);
ALTER TABLE Estudiante ADD CONSTRAINT fk_estudiante_usuario FOREIGN KEY (ID_Estudiante) REFERENCES Usuario(ID_Usuario);
ALTER TABLE Estudiante ADD CONSTRAINT fk_estudiante_programa FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa);
ALTER TABLE Asignatura ADD CONSTRAINT fk_asignatura_programa FOREIGN KEY (ID_Programa) REFERENCES Programa_Academico(ID_Programa);
ALTER TABLE Microcurriculo ADD CONSTRAINT fk_microcurriculo_asignatura FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura);
ALTER TABLE Elemento_ERA ADD CONSTRAINT fk_era_microcurriculo FOREIGN KEY (ID_Microcurriculo) REFERENCES Microcurriculo(ID_Microcurriculo);
ALTER TABLE Grupo_Investigacion ADD CONSTRAINT fk_grupo_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento);
ALTER TABLE Proyecto ADD CONSTRAINT fk_proyecto_docente FOREIGN KEY (ID_Docente_Responsable) REFERENCES Docente(ID_Docente);
ALTER TABLE Proyecto_Asignatura ADD CONSTRAINT fk_proyecto_asignatura_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Proyecto_Asignatura ADD CONSTRAINT fk_proyecto_asignatura_asignatura FOREIGN KEY (ID_Asignatura) REFERENCES Asignatura(ID_Asignatura);
ALTER TABLE Proyecto_Metodologia ADD CONSTRAINT fk_proyecto_metodologia_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Proyecto_Metodologia ADD CONSTRAINT fk_proyecto_metodologia_metodologia FOREIGN KEY (ID_Metodologia) REFERENCES Metodologia(ID_Metodologia);
ALTER TABLE Proyecto_Grupo_Investigacion ADD CONSTRAINT fk_proyecto_grupo_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Proyecto_Grupo_Investigacion ADD CONSTRAINT fk_proyecto_grupo_grupo FOREIGN KEY (ID_Grupo) REFERENCES Grupo_Investigacion(ID_Grupo);
ALTER TABLE Entregable ADD CONSTRAINT fk_entregable_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Entregable ADD CONSTRAINT fk_entregable_tipo FOREIGN KEY (ID_Tipo_Entregable) REFERENCES Tipo_Entregable(ID_Tipo_Entregable);
ALTER TABLE Grupo_Trabajo ADD CONSTRAINT fk_grupo_trabajo_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Grupo_Trabajo ADD CONSTRAINT fk_grupo_trabajo_lider FOREIGN KEY (ID_Estudiante_Lider) REFERENCES Estudiante(ID_Estudiante);
ALTER TABLE Estudiante_Grupo_Trabajo ADD CONSTRAINT fk_estudiante_grupo_estudiante FOREIGN KEY (ID_Estudiante) REFERENCES Estudiante(ID_Estudiante);
ALTER TABLE Estudiante_Grupo_Trabajo ADD CONSTRAINT fk_estudiante_grupo_grupo FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo);
ALTER TABLE Rubrica_Evaluacion ADD CONSTRAINT fk_rubrica_era FOREIGN KEY (ID_ERA) REFERENCES Elemento_ERA(ID_ERA);
ALTER TABLE Criterio_Rubrica ADD CONSTRAINT fk_criterio_rubrica FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica);
ALTER TABLE Evaluacion ADD CONSTRAINT fk_evaluacion_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Evaluacion ADD CONSTRAINT fk_evaluacion_rubrica FOREIGN KEY (ID_Rubrica) REFERENCES Rubrica_Evaluacion(ID_Rubrica);
ALTER TABLE Resultado_Evaluacion ADD CONSTRAINT fk_resultado_evaluacion FOREIGN KEY (ID_Evaluacion) REFERENCES Evaluacion(ID_Evaluacion);
ALTER TABLE Resultado_Evaluacion ADD CONSTRAINT fk_resultado_grupo FOREIGN KEY (ID_Grupo_Trabajo) REFERENCES Grupo_Trabajo(ID_Grupo_Trabajo);
ALTER TABLE Calendario_Entrega ADD CONSTRAINT fk_calendario_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Requerimiento_Insumo ADD CONSTRAINT fk_requerimiento_proyecto FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto);
ALTER TABLE Notificacion ADD CONSTRAINT fk_notificacion_usuario FOREIGN KEY (ID_Usuario_Destino) REFERENCES Usuario(ID_Usuario);
ALTER TABLE Historial_Cambio ADD CONSTRAINT fk_historial_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Unique Keys
ALTER TABLE Usuario ADD CONSTRAINT uk_usuario_correo UNIQUE (Correo);
ALTER TABLE Rol ADD CONSTRAINT uk_rol_nombre UNIQUE (Nombre);
ALTER TABLE Permiso ADD CONSTRAINT uk_permiso_nombre UNIQUE (Nombre);
ALTER TABLE Rol_Permiso ADD CONSTRAINT uk_rol_permiso UNIQUE (ID_Rol, ID_Permiso);
ALTER TABLE Usuario_Rol ADD CONSTRAINT uk_usuario_rol UNIQUE (ID_Usuario, ID_Rol);
ALTER TABLE Estudiante ADD CONSTRAINT uk_estudiante_matricula UNIQUE (Matricula);
ALTER TABLE Asignatura ADD CONSTRAINT uk_asignatura_codigo UNIQUE (Codigo);
ALTER TABLE Microcurriculo ADD CONSTRAINT uk_microcurriculo_asignatura UNIQUE (ID_Asignatura);
ALTER TABLE Metodologia ADD CONSTRAINT uk_metodologia_nombre UNIQUE (Nombre);
ALTER TABLE Grupo_Investigacion ADD CONSTRAINT uk_grupo_nombre UNIQUE (Nombre);
ALTER TABLE Elemento_ERA ADD CONSTRAINT uk_era_microcurriculo_codigo UNIQUE (ID_Microcurriculo, Codigo);
ALTER TABLE Proyecto_Asignatura ADD CONSTRAINT uk_proyecto_asignatura UNIQUE (ID_Proyecto, ID_Asignatura);
ALTER TABLE Proyecto_Metodologia ADD CONSTRAINT uk_proyecto_metodologia UNIQUE (ID_Proyecto, ID_Metodologia);
ALTER TABLE Proyecto_Grupo_Investigacion ADD CONSTRAINT uk_proyecto_grupo UNIQUE (ID_Proyecto, ID_Grupo);
ALTER TABLE Grupo_Trabajo ADD CONSTRAINT uk_grupo_trabajo_nombre UNIQUE (ID_Proyecto, Nombre);
ALTER TABLE Estudiante_Grupo_Trabajo ADD CONSTRAINT uk_estudiante_grupo UNIQUE (ID_Estudiante, ID_Grupo_Trabajo);
ALTER TABLE Resultado_Evaluacion ADD CONSTRAINT uk_resultado_evaluacion_grupo UNIQUE (ID_Evaluacion, ID_Grupo_Trabajo);



-- NOT NULL Constraints
ALTER TABLE Facultad ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Departamento ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Departamento ALTER COLUMN ID_Facultad SET NOT NULL;
ALTER TABLE Programa_Academico ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Programa_Academico ALTER COLUMN Nivel_Estudio SET NOT NULL;
ALTER TABLE Programa_Academico ALTER COLUMN ID_Departamento SET NOT NULL;
ALTER TABLE Usuario ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Usuario ALTER COLUMN Apellido SET NOT NULL;
ALTER TABLE Usuario ALTER COLUMN Correo SET NOT NULL;
ALTER TABLE Usuario ALTER COLUMN Contrasena SET NOT NULL;
ALTER TABLE Rol ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Permiso ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Docente ALTER COLUMN ID_Departamento SET NOT NULL;
ALTER TABLE Estudiante ALTER COLUMN ID_Programa SET NOT NULL;
ALTER TABLE Estudiante ALTER COLUMN Semestre SET NOT NULL;
ALTER TABLE Estudiante ALTER COLUMN Matricula SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN Codigo SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN Creditos SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN Horas_Teoricas SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN Horas_Practicas SET NOT NULL;
ALTER TABLE Asignatura ALTER COLUMN ID_Programa SET NOT NULL;
ALTER TABLE Microcurriculo ALTER COLUMN ID_Asignatura SET NOT NULL;
ALTER TABLE Microcurriculo ALTER COLUMN Justificacion SET NOT NULL;
ALTER TABLE Microcurriculo ALTER COLUMN Problematizacion SET NOT NULL;
ALTER TABLE Microcurriculo ALTER COLUMN Objetivo_General SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN ID_Microcurriculo SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN Codigo SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN Criterios_Saber SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN Criterios_Hacer SET NOT NULL;
ALTER TABLE Elemento_ERA ALTER COLUMN Criterios_Ser SET NOT NULL;
ALTER TABLE Metodologia ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Grupo_Investigacion ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Grupo_Investigacion ALTER COLUMN Linea_Investigacion SET NOT NULL;
ALTER TABLE Grupo_Investigacion ALTER COLUMN ID_Departamento SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Titulo SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Fecha_Inicio SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Fecha_Fin SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Proyecto ALTER COLUMN ID_Docente_Responsable SET NOT NULL;
ALTER TABLE Entregable ALTER COLUMN ID_Proyecto SET NOT NULL;
ALTER TABLE Entregable ALTER COLUMN ID_Tipo_Entregable SET NOT NULL;
ALTER TABLE Entregable ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Entregable ALTER COLUMN Fecha_Entrega SET NOT NULL;
ALTER TABLE Entregable ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Grupo_Trabajo ALTER COLUMN ID_Proyecto SET NOT NULL;
ALTER TABLE Grupo_Trabajo ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Grupo_Trabajo ALTER COLUMN ID_Estudiante_Lider SET NOT NULL;
ALTER TABLE Estudiante_Grupo_Trabajo ALTER COLUMN ID_Estudiante SET NOT NULL;
ALTER TABLE Estudiante_Grupo_Trabajo ALTER COLUMN ID_Grupo_Trabajo SET NOT NULL;
ALTER TABLE Estudiante_Grupo_Trabajo ALTER COLUMN Rol SET NOT NULL;
ALTER TABLE Rubrica_Evaluacion ALTER COLUMN ID_ERA SET NOT NULL;
ALTER TABLE Rubrica_Evaluacion ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Criterio_Rubrica ALTER COLUMN ID_Rubrica SET NOT NULL;
ALTER TABLE Criterio_Rubrica ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Criterio_Rubrica ALTER COLUMN Niveles_Desempeno SET NOT NULL;
ALTER TABLE Evaluacion ALTER COLUMN ID_Proyecto SET NOT NULL;
ALTER TABLE Evaluacion ALTER COLUMN ID_Rubrica SET NOT NULL;
ALTER TABLE Evaluacion ALTER COLUMN Tipo_Evaluacion SET NOT NULL;
ALTER TABLE Evaluacion ALTER COLUMN Fecha_Evaluacion SET NOT NULL;
ALTER TABLE Evaluacion ALTER COLUMN Periodo_Academico SET NOT NULL;
ALTER TABLE Resultado_Evaluacion ALTER COLUMN ID_Evaluacion SET NOT NULL;
ALTER TABLE Resultado_Evaluacion ALTER COLUMN ID_Grupo_Trabajo SET NOT NULL;
ALTER TABLE Resultado_Evaluacion ALTER COLUMN Calificacion SET NOT NULL;
ALTER TABLE Calendario_Entrega ALTER COLUMN ID_Proyecto SET NOT NULL;
ALTER TABLE Calendario_Entrega ALTER COLUMN Tipo_Evento SET NOT NULL;
ALTER TABLE Calendario_Entrega ALTER COLUMN Fecha_Hora_Inicio SET NOT NULL;
ALTER TABLE Calendario_Entrega ALTER COLUMN Fecha_Hora_Fin SET NOT NULL;
ALTER TABLE Calendario_Entrega ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN ID_Proyecto SET NOT NULL;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN Descripcion SET NOT NULL;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN Unidad_Medida SET NOT NULL;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Notificacion ALTER COLUMN ID_Usuario_Destino SET NOT NULL;
ALTER TABLE Notificacion ALTER COLUMN Titulo SET NOT NULL;
ALTER TABLE Notificacion ALTER COLUMN Mensaje SET NOT NULL;
ALTER TABLE Notificacion ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Historial_Cambio ALTER COLUMN ID_Usuario SET NOT NULL;
ALTER TABLE Historial_Cambio ALTER COLUMN Tabla_Afectada SET NOT NULL;
ALTER TABLE Historial_Cambio ALTER COLUMN ID_Registro_Afectado SET NOT NULL;
ALTER TABLE Historial_Cambio ALTER COLUMN Accion SET NOT NULL;

-- CHECK Constraints
ALTER TABLE Programa_Academico ADD CONSTRAINT chk_nivel_estudio CHECK (Nivel_Estudio IN ('Pregrado', 'Posgrado', 'Técnico', 'Tecnólogo'));
ALTER TABLE Estudiante ADD CONSTRAINT chk_semestre CHECK (Semestre > 0);
ALTER TABLE Asignatura ADD CONSTRAINT chk_creditos CHECK (Creditos > 0);
ALTER TABLE Proyecto ADD CONSTRAINT chk_tipo_proyecto CHECK (Tipo IN ('PA', 'PIA'));
ALTER TABLE Proyecto ADD CONSTRAINT chk_estado_proyecto CHECK (Estado IN ('Borrador', 'Activo', 'Finalizado', 'Cancelado'));
ALTER TABLE Proyecto ADD CONSTRAINT chk_fechas_proyecto CHECK (Fecha_Fin > Fecha_Inicio);
ALTER TABLE Entregable ADD CONSTRAINT chk_estado_entregable CHECK (Estado IN ('Pendiente', 'Entregado', 'Aprobado', 'Rechazado'));
ALTER TABLE Criterio_Rubrica ADD CONSTRAINT chk_ponderacion CHECK (Ponderacion > 0 AND Ponderacion <= 100);
ALTER TABLE Evaluacion ADD CONSTRAINT chk_tipo_evaluacion CHECK (Tipo_Evaluacion IN ('Autoevaluación', 'Coevaluación', 'Heteroevaluación'));
ALTER TABLE Resultado_Evaluacion ADD CONSTRAINT chk_calificacion CHECK (Calificacion >= 0 AND Calificacion <= 5.0);
ALTER TABLE Calendario_Entrega ADD CONSTRAINT chk_tipo_evento CHECK (Tipo_Evento IN ('Entrega', 'Revisión', 'Sesión', 'Presentación'));
ALTER TABLE Calendario_Entrega ADD CONSTRAINT chk_fechas_calendario CHECK (Fecha_Hora_Fin > Fecha_Hora_Inicio);
ALTER TABLE Requerimiento_Insumo ADD CONSTRAINT chk_cantidad CHECK (Cantidad > 0);
ALTER TABLE Requerimiento_Insumo ADD CONSTRAINT chk_estado_requerimiento CHECK (Estado IN ('Solicitado', 'Aprobado', 'Rechazado', 'Entregado'));
ALTER TABLE Notificacion ADD CONSTRAINT chk_tipo_notificacion CHECK (Tipo IN ('Sistema', 'Mensaje', 'Alerta', 'Recordatorio'));
ALTER TABLE Historial_Cambio ADD CONSTRAINT chk_accion CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE'));

-- DEFAULT Values
ALTER TABLE Usuario ALTER COLUMN Activo SET DEFAULT TRUE;
ALTER TABLE Usuario ALTER COLUMN Fecha_Registro SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Microcurriculo ALTER COLUMN Fecha_Actualizacion SET DEFAULT CURRENT_DATE;
ALTER TABLE Rubrica_Evaluacion ALTER COLUMN Fecha_Creacion SET DEFAULT CURRENT_DATE;
ALTER TABLE Requerimiento_Insumo ALTER COLUMN Fecha_Solicitud SET DEFAULT CURRENT_DATE;
ALTER TABLE Notificacion ALTER COLUMN Fecha_Envio SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Notificacion ALTER COLUMN Leida SET DEFAULT FALSE;
ALTER TABLE Historial_Cambio ALTER COLUMN Fecha_Cambio SET DEFAULT CURRENT_TIMESTAMP;