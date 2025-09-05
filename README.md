# 🗃️ Tarea1-Bases-de-Datos
**Proyecto universitario de Bases de Datos**. Modela un sistema para gestionar solicitudes de funcionalidades y reportes de errores. Incluye modelo ER, scripts SQL (tablas, inserts, consultas) y documentación.

---

## 🧑‍🤝‍🧑 Integrantes
- **Alumno 1:** Benjamin Campos, 202473094-0  
- **Alumno 2:** Nombre, ROL  

---

## 📄 Descripción
Este proyecto contiene la base de datos para la Tarea 1 del curso de Bases de Datos, incluyendo:  
- **Solicitudes de nuevas funcionalidades**  
- **Gestión de errores (bugs)**  
- **Usuarios y asignación de ingenieros por especialidad**  

El proyecto permite **generar datos aleatorios mediante Node.js** y poblar la base de datos para cumplir con la población mínima requerida:  
- 50 Autores  
- 50 Ingenieros  
- 300 Solicitudes de Gestión de Errores  
- 200 Solicitudes de Nuevas Funcionalidades  

---

## ✅ Requisitos
- **PostgreSQL** instalado (versión 17.6 recomendada)  
- Usuario `postgres` con contraseña  
- **Node.js** instalado (versión 18 o superior)  
- SQLTools u otra extensión para ejecutar SQL desde VS Code (opcional)  
- Git (para clonar el repositorio)  

---

## ⚙️ Instalación y ejecución

### 1️⃣ Clonar el repositorio
```bash
git clone https://github.com/B3nj4CF/Tarea1-Bases-de-Datos.git
cd Tarea1-Bases-de-Datos
```

### 2️⃣ Crear la base de datos en PostgreSQL
```bash
-- Abrir psql en terminal
psql -h localhost -p 5432 -U postgres
CREATE DATABASE tarea1_base_datos;
\q
```
### 3️⃣ Configurar conexión en index.js
```bash
const { Pool } = require('pg');
const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  password: 'TU_CONTRASEÑA', // Cambiar por tu contraseña
  database: 'tarea1_base_datos',
  port: 5432
});
```
### 4️⃣ Instalar dependencias Node.js
```bash
npm install
```

### 5️⃣ Ejecutar script para generar datos aleatorios
```bash
node index.js
```
### 6️⃣ Ejecutar scripts SQL
```bash
-- Desde psql o SQLTools
\i sql/01_create_tables.sql
\i sql/02_insert_data.sql
\i sql/03_queries.sql
```

## 📦 Dependencias Node.js
```bash
faker@7.6.0 → Para generar datos aleatorios
pg@8.11.0 → Cliente PostgreSQL para Node.js
Todas las dependencias se instalan con npm install.
```