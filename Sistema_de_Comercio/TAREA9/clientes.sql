CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255),
  descripcion TEXT,
  precio DECIMAL(10, 2),
  cantidad INT,
  foto VARCHAR(255)
);
