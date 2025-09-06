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
    - `CREATE.sql`
    - ``Script.sql`
    - `consultas.sql`
    - `revisar_contenidos.sql` (opcional)

### 2. Creación de Tablas y triggers

- Abra la terminal de PostgreSQL (puedes usar `psql`).
- Navegue hasta la carpeta donde están los archivos `.sql`.
- Ejecute el archivo `CREATE.sql` para crear todas las tablas y triggers necesarios en la base de datos:
    ```bash
    \i crear_tablas.sql
    ```

### 3. Población de Tablas

- Una vez creadas las tablas y los triggers, ejecute el archivo `Script.sql` para insertar los datos iniciales:
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

### Nota Importante

- En la solicitud de `Eliminar solicitudes de error con más de 5 años` (La cual se encuentra al final del archivo), esta se encuentra comentada ya que elimina los datos del años solicita, lo que borra datos que se encuentran en las tablas anteriores y posteriores.
- Se recomienda ejecutar `consultas.sql` tal como viene por defecto y luego repetir los pasos `2.-`, `3.-`, `4.-` nuevamente, pero descomentando la sección previamente mencionada.
- Así, el código elimina las solicitudes de más de 5 años y funciona de la mejor manera.

### 6. Notas Adicionales

- Puede ejecutar cada archivo de manera individual desde la terminal de PostgreSQL usando el comando `\i nombre_del_archivo.sql`.
- Asegúrese de ejecutar los archivos en el orden indicado para evitar errores de dependencias entre tablas y datos.
- Dentro de `consultas.sql` en la consulta de `Ingenieros especialistas en un tópico específico (ej. 'Seguridad')` se encuentra la siguiente linea `WHERE e.nombre_especialidad = 'Seguridad'` se puede remplazar seguridad por `Backend`, `UX/UI`, `Mobile`, `Frontend`
- - Dentro de `consultas.sql` en la consulta de `Funcionalidades nuevas para el ambiente “Móvil”` se encuentra la siguiente linea `WHERE a.nombre_ambiente = 'Movil'` se puede remplazar Movil por `Web`, `Movil`, `Escritorio`, `Cloud`
- Se recomienda la extencion de VSCode `PostgreSQL` de microsoft ya que esta permite visualizar de manera facil las tablas que crean las consultas
- El `Script.sql` realiza todo de manera automatica al momneto de la ejecucion, por ende si se desean agregar datos manuales, en ese caso, el codigo tendra una falla, ya que no se le asignara a otra tabla. (insertar usuario, no creara solicitud) a menos que se haga modificanco las listas usuario e ingeniero en `Script.sql`
- En el`Script.sql` al final aparece el apartaado `INYECCION DE 25 SOLICITUDES DE FUNCIONALIDAD Y 25 DE ERROR EN EL MISMO DIA` este apartado fue creado para verificar el maximo de solicitudes por dia (25 + 25), si descomentas ese apartado y luego repetir los pasos `2.-`, `3.-`, `4.-` nuevamente, salta el error de `El usuario 21836702-0 ya ha realizado 25 solicitudes de funcionalidad hoy.` comprobado que funciona el codigo.
---