DROP TABLE IF EXISTS asignar_funcionalidad CASCADE;
DROP TABLE IF EXISTS asignar_error CASCADE;
DROP TABLE IF EXISTS criterio_aceptacion CASCADE;
DROP TABLE IF EXISTS solicitud_funcionalidad CASCADE;
DROP TABLE IF EXISTS solicitud_error CASCADE;
DROP TABLE IF EXISTS ingeniero_especialidad CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS ingeniero CASCADE;
DROP TABLE IF EXISTS topico CASCADE;
DROP TABLE IF EXISTS estado CASCADE;
DROP TABLE IF EXISTS especialidad CASCADE;
DROP TABLE IF EXISTS ambiente_desarrollo CASCADE;

-- =====================================
-- TABLAS PRINCIPALES DEL PROYECTO
-- =====================================

-- 1. Crear tablas maestras si no existen
CREATE TABLE IF NOT EXISTS usuario(
    rut_usuario VARCHAR(10) NOT NULL PRIMARY KEY CHECK (rut_usuario ~ '^[0-9]{7,8}-[0-9Kk]$'),
    nombre_usuario VARCHAR(100) NOT NULL,
    email_usuario VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ingeniero(
    rut_ingeniero VARCHAR(10) NOT NULL PRIMARY KEY,
    nombre_ingeniero VARCHAR(100) NOT NULL,
    email_ingeniero VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS topico(
    id_topico SERIAL PRIMARY KEY,
    nombre_topico VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS estado(
    id_estado SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ambiente_desarrollo(
    id_ambiente SERIAL PRIMARY KEY,
    nombre_ambiente VARCHAR(100) NOT NULL
);

-- Tabla de especialidades
CREATE TABLE IF NOT EXISTS especialidad(
    id_especialidad SERIAL PRIMARY KEY,
    nombre_especialidad VARCHAR(100) NOT NULL
);

-- Tabla de relación ingeniero-especialidad
CREATE TABLE IF NOT EXISTS ingeniero_especialidad (
    id_especialidad INT NOT NULL REFERENCES especialidad(id_especialidad),
    rut_ingeniero VARCHAR(10) NOT NULL REFERENCES ingeniero(rut_ingeniero),
    PRIMARY KEY (id_especialidad, rut_ingeniero)
);

-- 2. Crear tablas de solicitudes y dependientes
CREATE TABLE IF NOT EXISTS solicitud_funcionalidad (
    id_funcionalidad SERIAL PRIMARY KEY,
    titulo_funcionalidad VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(titulo_funcionalidad) >= 20),
    id_estado INT NOT NULL REFERENCES estado(id_estado),
    resumen_funcionalidad VARCHAR(150) NOT NULL,
    id_topico INT NOT NULL REFERENCES topico(id_topico),
    rut_usuario VARCHAR(10) NOT NULL REFERENCES usuario(rut_usuario),
    id_ambiente INT REFERENCES ambiente_desarrollo(id_ambiente),
    fecha_publicacion DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS solicitud_error (
    id_error SERIAL PRIMARY KEY,
    titulo_error VARCHAR(100) NOT NULL UNIQUE,
    descripcion_error VARCHAR(200) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    id_estado INT NOT NULL REFERENCES estado(id_estado),
    id_topico INT NOT NULL REFERENCES topico(id_topico),
    rut_usuario VARCHAR(10) NOT NULL REFERENCES usuario(rut_usuario)
);

CREATE TABLE IF NOT EXISTS criterio_aceptacion(
    id_criterio SERIAL PRIMARY KEY,
    descripcion_criterio VARCHAR(200) NOT NULL,
    id_funcionalidad INT NOT NULL REFERENCES solicitud_funcionalidad(id_funcionalidad)
);

CREATE TABLE IF NOT EXISTS asignar_funcionalidad (
    id_asignacion_funcionalidad SERIAL PRIMARY KEY,
    rut_ingeniero VARCHAR(10) NOT NULL REFERENCES ingeniero(rut_ingeniero),
    id_funcionalidad INT NOT NULL REFERENCES solicitud_funcionalidad(id_funcionalidad)
);

CREATE TABLE IF NOT EXISTS asignar_error (
    id_asignacion_error SERIAL PRIMARY KEY,
    rut_ingeniero VARCHAR(10) NOT NULL REFERENCES ingeniero(rut_ingeniero),
    id_error INT NOT NULL REFERENCES solicitud_error(id_error)
);


-- =====================================
-- TRIGGERS Y FUNCIONES DE VALIDACIÓN
-- =====================================

-- =====================================
-- MIN 3 CRITERIOS POR FUNCIONALIDAD 
-- =====================================

CREATE OR REPLACE FUNCTION validar_criterios_funcionalidad()
RETURNS TRIGGER AS $$
DECLARE
    numero_criterios INT;
BEGIN
    SELECT COUNT(*) INTO numero_criterios
    FROM criterio_aceptacion
    WHERE id_funcionalidad = NEW.id_funcionalidad;

    IF numero_criterios < 3 THEN
        RAISE EXCEPTION 
            'Una funcionalidad % debe tener al menos tres criterios de aceptación. Actualmente contiene %',
            NEW.id_funcionalidad, numero_criterios;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_criterios_funcionalidad ON criterio_aceptacion;

CREATE TRIGGER trigger_validar_criterios_funcionalidad
AFTER INSERT OR UPDATE ON criterio_aceptacion
FOR EACH ROW
EXECUTE FUNCTION validar_criterios_funcionalidad();

-- =====================================
-- MAX 2 ESPECIALIDADES POR INGENIERO 
-- =====================================
CREATE OR REPLACE FUNCTION max_asignacion_ingeniero()
RETURNS TRIGGER AS $$
DECLARE
    total_especialidades INT;
BEGIN
    SELECT COUNT(*) INTO total_especialidades
    FROM ingeniero_especialidad
    WHERE rut_ingeniero = NEW.rut_ingeniero;

    IF total_especialidades >= 2 THEN
        RAISE EXCEPTION 
            'El ingeniero % ya tiene asignadas 2 especialidades. No se puede agregar otra. Actuales: %',
            NEW.rut_ingeniero, total_especialidades;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_asignar_ingenieros ON ingeniero_especialidad;

CREATE TRIGGER trigger_validar_asignar_ingenieros
BEFORE INSERT ON ingeniero_especialidad
FOR EACH ROW
EXECUTE FUNCTION max_asignacion_ingeniero();

-- =====================================
-- MAX 20 ASIGNACIONES POR INGENIERO 
-- =====================================
CREATE OR REPLACE FUNCTION validar_20_asignaciones_total()
RETURNS TRIGGER AS $$
DECLARE
    total_asignaciones INT;
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM asignar_funcionalidad WHERE rut_ingeniero = NEW.rut_ingeniero) +
        (SELECT COUNT(*) FROM asignar_error WHERE rut_ingeniero = NEW.rut_ingeniero)
    INTO total_asignaciones;

    IF total_asignaciones >= 20 THEN
        RAISE EXCEPTION
            'El ingeniero % ya tiene asignadas 20 solicitudes (funcionalidad + error). No se puede agregar otra.',
            NEW.rut_ingeniero;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_20_asignaciones_total_funcionalidad ON asignar_funcionalidad;
CREATE TRIGGER trigger_validar_20_asignaciones_total_funcionalidad
BEFORE INSERT ON asignar_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION validar_20_asignaciones_total();

DROP TRIGGER IF EXISTS trigger_validar_20_asignaciones_total_error ON asignar_error;
CREATE TRIGGER trigger_validar_20_asignaciones_total_error
BEFORE INSERT ON asignar_error
FOR EACH ROW
EXECUTE FUNCTION validar_20_asignaciones_total();

-- =====================================
-- MAX 3 INGENIEROS POR FUNCIONALIDAD 
-- =====================================

CREATE OR REPLACE FUNCTION validar_max_ingenieros_funcionalidad()
RETURNS TRIGGER AS $$
DECLARE
    total_ingenieros INT;
BEGIN
    SELECT COUNT(*) INTO total_ingenieros
    FROM asignar_funcionalidad
    WHERE id_funcionalidad = NEW.id_funcionalidad;

    IF total_ingenieros >= 3 THEN
        RAISE EXCEPTION
            'La funcionalidad % ya tiene asignados 3 ingenieros. No se puede agregar otro.',
            NEW.id_funcionalidad;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_max_ingenieros_funcionalidad ON asignar_funcionalidad;
CREATE TRIGGER trigger_validar_max_ingenieros_funcionalidad
BEFORE INSERT ON asignar_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION validar_max_ingenieros_funcionalidad();

-- =====================================
-- MAX 3 INGENIEROS POR ERROR 
-- =====================================

CREATE OR REPLACE FUNCTION validar_max_ingenieros_error()
RETURNS TRIGGER AS $$
DECLARE
    total_ingenieros INT;
BEGIN
    SELECT COUNT(*) INTO total_ingenieros
    FROM asignar_error
    WHERE id_error = NEW.id_error;

    IF total_ingenieros >= 3 THEN
        RAISE EXCEPTION
            'El error % ya tiene asignados 3 ingenieros. No se puede agregar otro.',
            NEW.id_error;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_max_ingenieros_error ON asignar_error;
CREATE TRIGGER trigger_validar_max_ingenieros_error
BEFORE INSERT ON asignar_error
FOR EACH ROW
EXECUTE FUNCTION validar_max_ingenieros_error();

-- =====================================
-- MAX 25 SOLICITUDES DE FUNCIONALIDAD POR USUARIO/DÍA 
-- =====================================

CREATE OR REPLACE FUNCTION validar_max_funcionalidades_por_usuario_por_dia()
RETURNS TRIGGER AS $$
DECLARE
    total_funcionalidades INT;
BEGIN
    SELECT COUNT(*) INTO total_funcionalidades
    FROM solicitud_funcionalidad
    WHERE rut_usuario = NEW.rut_usuario
      AND fecha_publicacion = NEW.fecha_publicacion;

    IF total_funcionalidades >= 25 THEN
        RAISE EXCEPTION
            'El usuario % ya ha realizado 25 solicitudes de funcionalidad hoy.',
            NEW.rut_usuario;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_max_funcionalidades_por_usuario_por_dia ON solicitud_funcionalidad;
CREATE TRIGGER trigger_max_funcionalidades_por_usuario_por_dia
BEFORE INSERT ON solicitud_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION validar_max_funcionalidades_por_usuario_por_dia();

-- =====================================
-- MAX 25 SOLICITUDES DE ERROR POR USUARIO/DÍA 
-- =====================================

CREATE OR REPLACE FUNCTION validar_max_errores_por_usuario_por_dia()
RETURNS TRIGGER AS $$
DECLARE
    total_errores INT;
BEGIN
    SELECT COUNT(*) INTO total_errores
    FROM solicitud_error
    WHERE rut_usuario = NEW.rut_usuario
      AND fecha_publicacion = NEW.fecha_publicacion;

    IF total_errores >= 25 THEN
        RAISE EXCEPTION
            'El usuario % ya ha realizado 25 solicitudes de error hoy.',
            NEW.rut_usuario;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_max_errores_por_usuario_por_dia ON solicitud_error;
CREATE TRIGGER trigger_max_errores_por_usuario_por_dia
BEFORE INSERT ON solicitud_error
FOR EACH ROW
EXECUTE FUNCTION validar_max_errores_por_usuario_por_dia();

-- =====================================
-- VALIDACIONES DE CAMBIO DE ESTADO
-- =====================================

-- =====================================
-- Validar criterios antes de cerrar o resolver funcionalidad
-- =====================================

CREATE OR REPLACE FUNCTION validar_cambio_estado_funcionalidad()
RETURNS TRIGGER AS $$
DECLARE
    numero_criterios INT;
    nombre_estado_nuevo TEXT;
BEGIN
    SELECT nombre_estado INTO nombre_estado_nuevo
    FROM estado
    WHERE id_estado = NEW.id_estado;

    IF nombre_estado_nuevo IN ('Resuelto', 'Cerrado') THEN
        SELECT COUNT(*) INTO numero_criterios
        FROM criterio_aceptacion
        WHERE id_funcionalidad = NEW.id_funcionalidad;

        IF numero_criterios < 3 THEN
            RAISE EXCEPTION 
                'La funcionalidad % no puede cambiar a estado "%". Tiene solo % criterios de aceptación (mínimo 3).',
                NEW.id_funcionalidad, nombre_estado_nuevo, numero_criterios;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_cambio_estado_funcionalidad ON solicitud_funcionalidad;
CREATE TRIGGER trigger_validar_cambio_estado_funcionalidad
BEFORE UPDATE OF id_estado ON solicitud_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION validar_cambio_estado_funcionalidad();

-- =====================================
-- Validar ingenieros antes de cerrar o resolver funcionalidad
-- =====================================

CREATE OR REPLACE FUNCTION validar_cambio_estado_funcionalidad_ingenieros()
RETURNS TRIGGER AS $$
DECLARE
    numero_ingenieros INT;
    nombre_estado_nuevo TEXT;
BEGIN
    SELECT nombre_estado INTO nombre_estado_nuevo
    FROM estado
    WHERE id_estado = NEW.id_estado;

    IF nombre_estado_nuevo IN ('Resuelto', 'Cerrado') THEN
        SELECT COUNT(*) INTO numero_ingenieros
        FROM asignar_funcionalidad
        WHERE id_funcionalidad = NEW.id_funcionalidad;

        IF numero_ingenieros <> 3 THEN
            RAISE EXCEPTION 
                'La funcionalidad % no puede cambiar a estado "%". Tiene % ingenieros asignados (deben ser exactamente 3).',
                NEW.id_funcionalidad, nombre_estado_nuevo, numero_ingenieros;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_cambio_estado_funcionalidad_ingenieros ON solicitud_funcionalidad;
CREATE TRIGGER trigger_validar_cambio_estado_funcionalidad_ingenieros
BEFORE UPDATE OF id_estado ON solicitud_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION validar_cambio_estado_funcionalidad_ingenieros();

-- =====================================
-- Validar ingenieros antes de cerrar o resolver error
-- =====================================

CREATE OR REPLACE FUNCTION validar_cambio_estado_error_ingenieros()
RETURNS TRIGGER AS $$
DECLARE
    numero_ingenieros INT;
    nombre_estado_nuevo TEXT;
BEGIN
    SELECT nombre_estado INTO nombre_estado_nuevo
    FROM estado
    WHERE id_estado = NEW.id_estado;

    IF nombre_estado_nuevo IN ('Resuelto', 'Cerrado') THEN
        SELECT COUNT(*) INTO numero_ingenieros
        FROM asignar_error
        WHERE id_error = NEW.id_error;

        IF numero_ingenieros <> 3 THEN
            RAISE EXCEPTION 
                'El error % no puede cambiar a estado "%". Tiene % ingenieros asignados (deben ser exactamente 3).',
                NEW.id_error, nombre_estado_nuevo, numero_ingenieros;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_validar_cambio_estado_error_ingenieros ON solicitud_error;
CREATE TRIGGER trigger_validar_cambio_estado_error_ingenieros
BEFORE UPDATE OF id_estado ON solicitud_error
FOR EACH ROW
EXECUTE FUNCTION validar_cambio_estado_error_ingenieros();