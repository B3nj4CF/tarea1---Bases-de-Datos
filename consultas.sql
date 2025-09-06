-- =====================================
-- Ingenieros con más de 5 solicitudes asignadas (errores + funcionalidades)
-- =====================================

SELECT '===== Tabla: Ingenieros con mas de 5 solicitudes asignadas =====' AS info;
SELECT i.nombre_ingeniero, COUNT(*) AS total_asignaciones
FROM ingeniero i
JOIN (
    SELECT rut_ingeniero FROM asignar_funcionalidad
    UNION ALL
    SELECT rut_ingeniero FROM asignar_error
) AS asignaciones ON i.rut_ingeniero = asignaciones.rut_ingeniero
GROUP BY i.nombre_ingeniero
HAVING COUNT(*) > 5;

-- =====================================
-- Los 10 errores más antiguos
-- =====================================

SELECT '===== Tabla: Los 10 errores mas antiguos =====' AS info;
SELECT e.titulo_error, e.fecha_publicacion, u.nombre_usuario
FROM solicitud_error e
JOIN usuario u ON e.rut_usuario = u.rut_usuario
ORDER BY e.fecha_publicacion ASC
LIMIT 10;

-- =====================================
-- Funcionalidades nuevas para el ambiente “Móvil”
-- =====================================

SELECT '===== Tabla: Funcionalidades nuevas para el ambiente (''Móvil'') =====' AS info;
SELECT f.titulo_funcionalidad, t.nombre_topico, u.nombre_usuario, a.nombre_ambiente
FROM solicitud_funcionalidad f
JOIN topico t ON f.id_topico = t.id_topico
JOIN usuario u ON f.rut_usuario = u.rut_usuario
JOIN ambiente_desarrollo a ON f.id_ambiente = a.id_ambiente
WHERE a.nombre_ambiente = 'Movil';

-- =====================================
-- Tópicos más problemáticos (>10 errores)
-- =====================================

SELECT '===== Tabla: Topicos mas problemáticos (>5 errores) =====' AS info;
SELECT t.nombre_topico, COUNT(*) AS cantidad_errores
FROM solicitud_error e
JOIN topico t ON e.id_topico = t.id_topico
GROUP BY t.nombre_topico
HAVING COUNT(*) > 5;

-- =====================================
-- Funcionalidades de usuarios que ya reportaron un error en el mismo tópico
-- =====================================

SELECT '===== Tabla: Funcionalidades de usuarios que ya reportaron un error en el mismo topico =====' AS info;
SELECT f.titulo_funcionalidad, u.nombre_usuario, t.nombre_topico
FROM solicitud_funcionalidad f
JOIN usuario u ON f.rut_usuario = u.rut_usuario
JOIN topico t ON f.id_topico = t.id_topico
WHERE EXISTS (
    SELECT 1
    FROM solicitud_error e
    WHERE e.rut_usuario = f.rut_usuario
      AND e.id_topico = f.id_topico
);

-- =====================================
-- Verificación de funcionalidades actualizadas a “Archivado”
-- =====================================

SELECT 
    f.id_funcionalidad, 
    f.titulo_funcionalidad, 
    f.fecha_publicacion,
    e_ant.nombre_estado AS estado_antiguo, 
    'Archivado' AS estado_nuevo
FROM 
    solicitud_funcionalidad f
JOIN 
    estado e_ant ON f.id_estado = e_ant.id_estado
WHERE 
    f.fecha_publicacion <= CURRENT_DATE - INTERVAL '3 YEAR'
    AND (e_ant.nombre_estado != 'Archivado' OR e_ant.nombre_estado IS NULL);

-- =====================================
-- Cantidad de ingenieros especialistas por tópico (formato: "Topico: N")
-- =====================================

SELECT '===== Tabla: Cantidad de ingenieros especialistas por tópico (formato: "Topico: N") =====' AS info;


SELECT STRING_AGG(t.topico_conteo, ', ') AS ingenieros_por_topico
FROM (
    SELECT e.nombre_especialidad || ': ' || COUNT(ie.rut_ingeniero) AS topico_conteo
    FROM especialidad e
    LEFT JOIN ingeniero_especialidad ie ON e.id_especialidad = ie.id_especialidad
    GROUP BY e.nombre_especialidad
) t;

-- =====================================
-- Ingenieros especialistas en un tópico específico (ej. 'Seguridad')
-- =====================================

SELECT '===== Tabla: Ingenieros especialistas en un topico especifico (ej. "Seguridad") =====' AS info;

SELECT i.nombre_ingeniero
FROM ingeniero i
JOIN ingeniero_especialidad ie ON i.rut_ingeniero = ie.rut_ingeniero
JOIN especialidad e ON ie.id_especialidad = e.id_especialidad
WHERE e.nombre_especialidad = 'Seguridad'; -- Cambiar 'Seguridad' por el tópico que quieres buscar

-- =====================================
-- Cantidad total de solicitudes creadas por cada usuario
-- =====================================

SELECT '===== Tabla: Cantidad total de solicitudes creadas por cada usuario =====' AS info;

SELECT u.nombre_usuario, 
       (SELECT COUNT(*) FROM solicitud_error e WHERE e.rut_usuario = u.rut_usuario) +
       (SELECT COUNT(*) FROM solicitud_funcionalidad f WHERE f.rut_usuario = u.rut_usuario) AS total_solicitudes
FROM usuario u;

-- =====================================
-- Eliminar solicitudes de error con más de 5 anos y mostrar en terminal
-- =====================================

-- SELECT '===== Tabla: Eliminar solicitudes de error con mas de 5 anos y mostrar en terminal =====' AS info;

-- -- Eliminar y mostrar los errores antiguos (más de 5 años y no archivados)


-- DELETE FROM asignar_error
-- WHERE id_error IN (
--     SELECT id_error
--     FROM solicitud_error
--     WHERE fecha_publicacion <= CURRENT_DATE - INTERVAL '5 YEAR'
--       AND id_estado IN (SELECT id_estado FROM estado WHERE nombre_estado != 'Archivado')
-- );

-- DELETE FROM solicitud_error
-- USING estado e_ant
-- WHERE solicitud_error.id_estado = e_ant.id_estado
--     AND solicitud_error.fecha_publicacion <= CURRENT_DATE - INTERVAL '5 YEAR'
--     AND e_ant.nombre_estado != 'Archivado'
-- RETURNING solicitud_error.id_error, solicitud_error.titulo_error, solicitud_error.fecha_publicacion;
