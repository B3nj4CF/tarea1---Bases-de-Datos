-- =====================
-- Tabla: Topico
-- =====================
TRUNCATE topico RESTART IDENTITY CASCADE;

INSERT INTO topico (nombre_topico) VALUES
('Backend'),
('Seguridad'),
('UX/UI'),
('Mobile'),
('Frontend');

-- =====================
-- Tabla: Especialidad
-- =====================
TRUNCATE especialidad RESTART IDENTITY CASCADE;

INSERT INTO especialidad (nombre_especialidad) VALUES
('Backend'),
('Seguridad'),
('UX/UI'),
('Mobile'),
('Frontend');


-- =====================
-- Tabla: Ambiente Desarrollo
-- =====================
TRUNCATE ambiente_desarrollo RESTART IDENTITY CASCADE;

INSERT INTO ambiente_desarrollo (nombre_ambiente) VALUES
('Web'),
('Movil'),
('Escritorio'),
('Cloud');

-- =====================
-- Tabla: Estado
-- =====================
TRUNCATE estado RESTART IDENTITY CASCADE;

INSERT INTO estado (nombre_estado) VALUES
('Abierto'),
('En Progreso'),
('Resuelto'),
('Cerrado'),
('Archivado');


-- =====================
-- Tabla: Usuario
-- =====================

INSERT INTO usuario (rut_usuario, nombre_usuario, email_usuario) VALUES
('18456327-5', 'Juan Soto', 'juan.soto@email.com'),
('29518436-2', 'Maria Rojas', 'maria.rojas@email.com'),
('37649285-1', 'Pedro Torres', 'pedro.torres@email.com'),
('46813529-7', 'Ana Morales', 'ana.morales@email.com'),
('58134726-4', 'Luis Fernandez', 'luis.fernandez@email.com'),
('69284513-8', 'Carolina Vega', 'carolina.vega@email.com'),
('73825146-9', 'Roberto Silva', 'roberto.silva@email.com'),
('84936275-3', 'Andrea Luna', 'andrea.luna@email.com'),
('91538462-7', 'Diego Herrera', 'diego.herrera@email.com'),
('10238475-6', 'Monica Salas', 'monica.salas@email.com'),
('21349586-2', 'Raul Jimenez', 'raul.jimenez@email.com'),
('32458697-1', 'Isabel Ramos', 'isabel.ramos@email.com'),
('43569728-5', 'Sergio Molina', 'sergio.molina@email.com'),
('54679839-4', 'Valeria Cruz', 'valeria.cruz@email.com'),
('65781924-8', 'Hector Paredes', 'hector.paredes@email.com'),
('76892135-7', 'Camila Ortiz', 'camila.ortiz@email.com'),
('87913246-5', 'Esteban Flores', 'esteban.flores@email.com'),
('98124357-3', 'Paula Navarro', 'paula.navarro@email.com'),
('19235468-1', 'Martin Reyes', 'martin.reyes@email.com'),
('20346579-2', 'Natalia Soto', 'natalia.soto@email.com'),
('31457680-9', 'Gustavo Peña', 'gustavo.pena@email.com'),
('42568791-8', 'Rosa Vargas', 'rosa.vargas@email.com'),
('53679802-7', 'Alberto Fuentes', 'alberto.fuentes@email.com'),
('64780913-6', 'Daniela Bravo', 'daniela.bravo@email.com'),
('75891024-5', 'Francisco León', 'francisco.leon@email.com'),
('86902135-4', 'Teresa Aguirre', 'teresa.aguirre@email.com'),
('97013246-3', 'Oscar Medina', 'oscar.medina@email.com'),
('18224357-2', 'Claudia Muñoz', 'claudia.munoz@email.com'),
('29335468-1', 'Ricardo Torres', 'ricardo.torres@email.com'),
('30446579-9', 'Silvia Carrillo', 'silvia.carrillo@email.com'),
('41557680-8', 'Manuel Espinoza', 'manuel.espinoza@email.com'),
('52668791-7', 'Lorena Castillo', 'lorena.castillo@email.com'),
('63779802-6', 'Eduardo Ramos', 'eduardo.ramos@email.com'),
('74880913-5', 'Gabriela Ponce', 'gabriela.ponce@email.com'),
('85991024-4', 'Julio Romero', 'julio.romero@email.com'),
('96002135-3', 'Marta Herrera', 'marta.herrera@email.com'),
('17213246-2', 'Pablo Salazar', 'pablo.salazar@email.com'),
('28324357-1', 'Veronica Ruiz', 'veronica.ruiz@email.com'),
('39435468-9', 'Felipe Cordero', 'felipe.cordero@email.com'),
('40546579-8', 'Cecilia Guzman', 'cecilia.guzman@email.com'),
('51657680-7', 'Ignacio Soto', 'ignacio.soto@email.com'),
('62768791-6', 'Sandra Morales', 'sandra.morales@email.com'),
('73879802-5', 'Victor Rivas', 'victor.rivas@email.com'),
('84980913-4', 'Elena Vargas', 'elena.vargas@email.com'),
('95091024-3', 'Marcos Peña', 'marcos.pena@email.com'),
('16202135-2', 'Patricia Luna', 'patricia.luna@email.com'),
('27313246-1', 'Fernando Castro', 'fernando.castro@email.com'),
('38424357-9', 'Lucia Diaz', 'lucia.diaz@email.com'),
('49535468-8', 'Javier Soto', 'javier.soto@email.com'),
('50646579-7', 'Monica Salas', 'monica.salas.salasar@email.com');

-- =====================
-- Tabla: Ingeniero
-- =====================

INSERT INTO ingeniero (rut_ingeniero, nombre_ingeniero, email_ingeniero) VALUES
('18456327-6', 'Juan Paredes', 'juan.paredes@email.com'),
('29518436-3', 'Maria Guzman', 'maria.guzman@email.com'),
('37649285-2', 'Pedro Salas', 'pedro.salas@email.com'),
('46813529-8', 'Ana Castillo', 'ana.castillo@email.com'),
('58134726-5', 'Luis Espinoza', 'luis.espinoza@email.com'),
('69284513-9', 'Carolina Romero', 'carolina.romero@email.com'),
('73825146-1', 'Roberto Rivas', 'roberto.rivas@email.com'),
('84936275-4', 'Andrea Peña', 'andrea.pena@email.com'),
('91538462-8', 'Diego Vargas', 'diego.vargas@email.com'),
('10238475-7', 'Monica Bravo', 'monica.bravo@email.com'),
('21349586-3', 'Raul León', 'raul.leon@email.com'),
('32458697-2', 'Isabel Aguirre', 'isabel.aguirre@email.com'),
('43569728-6', 'Sergio Medina', 'sergio.medina@email.com'),
('54679839-5', 'Valeria Muñoz', 'valeria.munoz@email.com'),
('65781924-9', 'Hector Torres', 'hector.torres@email.com'),
('76892135-8', 'Camila Carrillo', 'camila.carrillo@email.com'),
('87913246-6', 'Esteban Espinoza', 'esteban.espinoza@email.com'),
('98124357-4', 'Paula Castillo', 'paula.castillo@email.com'),
('19235468-2', 'Martin Ramos', 'martin.ramos@email.com'),
('20346579-3', 'Natalia Ponce', 'natalia.ponce@email.com'),
('31457680-1', 'Gustavo Romero', 'gustavo.romero@email.com'),
('42568791-9', 'Rosa Herrera', 'rosa.herrera@email.com'),
('53679802-8', 'Alberto Salazar', 'alberto.salazar@email.com'),
('64780913-7', 'Daniela Ruiz', 'daniela.ruiz@email.com'),
('75891024-6', 'Francisco Cordero', 'francisco.cordero@email.com'),
('86902135-5', 'Teresa Guzman', 'teresa.guzman@email.com'),
('97013246-4', 'Oscar Soto', 'oscar.soto@email.com'),
('18224357-3', 'Claudia Morales', 'claudia.morales@email.com'),
('29335468-2', 'Ricardo Vargas', 'ricardo.vargas@email.com'),
('30446579-1', 'Silvia Peña', 'silvia.pena@email.com'),
('41557680-9', 'Manuel Bravo', 'manuel.bravo@email.com'),
('52668791-8', 'Lorena León', 'lorena.leon@email.com'),
('63779802-7', 'Eduardo Aguirre', 'eduardo.aguirre@email.com'),
('74880913-6', 'Gabriela Medina', 'gabriela.medina@email.com'),
('85991024-5', 'Julio Muñoz', 'julio.munoz@email.com'),
('96002135-4', 'Marta Torres', 'marta.torres@email.com'),
('17213246-3', 'Pablo Carrillo', 'pablo.carrillo@email.com'),
('28324357-2', 'Veronica Espinoza', 'veronica.espinoza@email.com'),
('39435468-1', 'Felipe Castillo', 'felipe.castillo@email.com'),
('40546579-9', 'Cecilia Ramos', 'cecilia.ramos@email.com'),
('51657680-8', 'Ignacio Ponce', 'ignacio.ponce@email.com'),
('62768791-7', 'Sandra Romero', 'sandra.romero@email.com'),
('73879802-6', 'Victor Herrera', 'victor.herrera@email.com'),
('84980913-5', 'Elena Salazar', 'elena.salazar@email.com'),
('95091024-4', 'Marcos Ruiz', 'marcos.ruiz@email.com'),
('16202135-3', 'Patricia Cordero', 'patricia.cordero@email.com'),
('27313246-2', 'Fernando Guzman', 'fernando.guzman@email.com'),
('38424357-1', 'Lucia Soto', 'lucia.soto@email.com'),
('49535468-9', 'Javier Morales', 'javier.morales@email.com'),
('50646579-8', 'Monica Vargas', 'monica.vargas@email.com');

-- ======================================================
-- POBLACIÓN Y TRIGGERS
-- ======================================================

-- =====================
-- Asignar 1-2 especialidades a cada ingeniero
-- =====================
DO $$
DECLARE
    esp_ids INT[] := ARRAY(SELECT id_especialidad FROM especialidad);
    ing RECORD;
    cantidad INT;
    pick INT;
    elegidos INT[];
BEGIN
    FOR ing IN SELECT rut_ingeniero FROM ingeniero LOOP
        cantidad := 1 + floor(random()*2)::INT;
        elegidos := ARRAY[]::INT[];

        WHILE array_length(elegidos,1) IS DISTINCT FROM cantidad LOOP
            pick := esp_ids[1+floor(random()*array_length(esp_ids,1))::INT];
            IF NOT pick = ANY(elegidos) THEN
                elegidos := array_append(elegidos,pick);
            END IF;
        END LOOP;

        FOREACH pick IN ARRAY elegidos LOOP
            INSERT INTO ingeniero_especialidad(rut_ingeniero,id_especialidad)
            VALUES(ing.rut_ingeniero,pick);
        END LOOP;
    END LOOP;
END$$;

-- =====================
-- Insertar 300 errores
-- =====================
DO $$
DECLARE
    i INT;
    u RECORD;
    est INT;
    top INT;
    f DATE;
BEGIN
    FOR i IN 1..300 LOOP
        SELECT * INTO u FROM usuario ORDER BY random() LIMIT 1;
        SELECT id_estado INTO est 
        FROM estado 
        WHERE nombre_estado <> 'Archivado' 
        ORDER BY random() LIMIT 1;

        SELECT id_topico INTO top FROM topico ORDER BY random() LIMIT 1;

        f := DATE '2019-01-01' + (random() * (CURRENT_DATE - DATE '2019-01-01'))::int;

        INSERT INTO solicitud_error(
            titulo_error,
            descripcion_error,
            fecha_publicacion,
            id_estado,
            id_topico,
            rut_usuario
        )
        VALUES(
            'Error ' || i,
            'Descripción error ' || i,
            f,
            est,
            top,
            u.rut_usuario
        );
    END LOOP;
END;
$$;


-- =====================
-- Insertar 200 funcionalidades
-- =====================
DO $$
DECLARE i INT;
    u RECORD;
    est INT;
    top INT;
    amb INT;
    f DATE;
BEGIN
    FOR i IN 1..200 LOOP
        SELECT * INTO u FROM usuario ORDER BY random() LIMIT 1;
        SELECT id_estado INTO est FROM estado WHERE nombre_estado <> 'Archivado' ORDER BY random() LIMIT 1;
        SELECT id_topico INTO top FROM topico ORDER BY random() LIMIT 1;
        SELECT id_ambiente INTO amb FROM ambiente_desarrollo ORDER BY random() LIMIT 1;
        
        f := DATE '2019-01-01' + (random() * (CURRENT_DATE - DATE '2019-01-01'))::int;

        INSERT INTO solicitud_funcionalidad(
            titulo_funcionalidad,id_estado,resumen_funcionalidad,
            id_topico,rut_usuario,id_ambiente,fecha_publicacion
        ) VALUES(
            'Funcionalidad '||i||' con título suficientemente largo',
            est,
            'Resumen de funcionalidad '||i,
            top, u.rut_usuario, amb, f
        );
    END LOOP;
END$$;

-- =====================
-- Insertar 3 criterios de aceptación por funcionalidad
-- =====================
DO $$
DECLARE f RECORD;
BEGIN
    FOR f IN SELECT id_funcionalidad FROM solicitud_funcionalidad LOOP
        INSERT INTO criterio_aceptacion (descripcion_criterio,id_funcionalidad)
        SELECT 'Criterio '||g||' de funcionalidad '||f.id_funcionalidad, f.id_funcionalidad
        FROM generate_series(1,3) g;
    END LOOP;
END$$;

-- =====================
-- Elegir ingenieros disponibles
-- =====================
CREATE OR REPLACE FUNCTION pick_ingenieros(_id_topico INT)
RETURNS TABLE(rut TEXT) LANGUAGE sql AS $$
    SELECT ie.rut_ingeniero
    FROM ingeniero_especialidad ie
    JOIN especialidad e ON e.id_especialidad=ie.id_especialidad
    JOIN topico t ON t.nombre_topico=e.nombre_especialidad
    WHERE t.id_topico=_id_topico
      AND (
          (SELECT COUNT(*) FROM asignar_funcionalidad af WHERE af.rut_ingeniero=ie.rut_ingeniero) +
          (SELECT COUNT(*) FROM asignar_error ae WHERE ae.rut_ingeniero=ie.rut_ingeniero)
      ) < 20
    ORDER BY random()
    LIMIT 3;
$$;

-- =====================
-- Asignar ingenieros a funcionalidades
-- =====================
DO $$
DECLARE f RECORD;
    ing RECORD;
BEGIN
    FOR f IN SELECT id_funcionalidad,id_topico FROM solicitud_funcionalidad LOOP
        FOR ing IN SELECT * FROM pick_ingenieros(f.id_topico) LOOP
            INSERT INTO asignar_funcionalidad(rut_ingeniero,id_funcionalidad)
            VALUES(ing.rut,f.id_funcionalidad);
        END LOOP;
    END LOOP;
END$$;

-- =====================
-- Asignar ingenieros a errores
-- =====================
DO $$
DECLARE e RECORD;
    ing RECORD;
BEGIN
    FOR e IN SELECT id_error,id_topico FROM solicitud_error LOOP
        FOR ing IN SELECT * FROM pick_ingenieros(e.id_topico) LOOP
            INSERT INTO asignar_error(rut_ingeniero,id_error)
            VALUES(ing.rut,e.id_error);
        END LOOP;
    END LOOP;
END$$;