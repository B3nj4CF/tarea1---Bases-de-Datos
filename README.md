# Tarea 1 - Base de Datos

## Integrantes

- **Nombre:** Benjamin Antonio Campos Fernandez
    **Rol:** 202473094-0

- **Nombre:** Joaquín Alonso Hormaechea D'arcangeli
    **Rol:** 202473133-5


---

## Instrucciones Detalladas de Ejecución

Para ejecutar correctamente la tarea y trabajar con la base de datos en PostgreSQL, siga los pasos detallados a continuación:

### 1. Preparación

- Asegúrese de tener instalado PostgreSQL 17.6 en su sistema.
- Ubique los siguientes archivos en una misma carpeta:
    - `crear_tablas.sql`
    - `poblar_tablas.sql`
    - `consultas.sql`
    - `revisar_contenidos.sql` (opcional)

### 2. Creación de Tablas y triggers

- Abra la terminal de PostgreSQL (puedes usar `psql`).
- Navegue hasta la carpeta donde están los archivos `.sql`.
- Ejecute el archivo `crear_tablas.sql` para crear todas las tablas y triggers necesarios en la base de datos:
    ```bash
    \i crear_tablas.sql
    ```

### 3. Población de Tablas

- Una vez creadas las tablas y los triggers, ejecute el archivo `poblar_tablas.sql` para insertar los datos iniciales:
    ```bash
    \i poblar_tablas.sql
    ```

### 4. Consultas

- Para realizar las consultas solicitadas en la tarea, ejecute el archivo `consultas.sql`:
    ```bash
    \i consultas.sql
    ```

### 5. Revisión de Contenidos (Opcional)

- Si desea verificar que los datos se hayan insertado correctamente y visualizar el contenido de las tablas, ejecute el archivo `revisar_contenidos.sql`:
    ```bash
    \i revisar_contenidos.sql
    ```

### 6. Notas Adicionales

- Puede ejecutar cada archivo de manera individual desde la terminal de PostgreSQL usando el comando `\i nombre_del_archivo.sql`.
- Asegúrese de ejecutar los archivos en el orden indicado para evitar errores de dependencias entre tablas y datos.
- Dentro de `consultas.sql` en la consulta de `Ingenieros especialistas en un tópico específico (ej. 'Seguridad')` se encuentra la siguiente linea `WHERE e.nombre_especialidad = 'Seguridad'` se puede remplazar seguridad por `Backend`, `UX/UI`, `Mobile`, `Frontend`
---

