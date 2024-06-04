<?php
$host = 'localhost';
$bd = 'TARA9';
$user = 'postgres';
$pass = 'Pezuna23';

$conexion = pg_connect("host=$host dbname=$bd user=$user password=$pass");

$id = $_POST['id'];
$cantidad = $_POST['cantidad'];

// Iniciar la transacción
pg_query($conexion, 'BEGIN');

// Obtener la cantidad actual del artículo
$query = "SELECT cantidad FROM clientes WHERE id = $id";
$resultado = pg_query($conexion, $query);
$articulo = pg_fetch_assoc($resultado);
$cantidadActual = $articulo['cantidad'];

if ($cantidad <= $cantidadActual) {
  // Insertar en la tabla "carrito_compra"
  $query = "INSERT INTO carrito_compra (id_articulo, cantidad) VALUES ($id, $cantidad)";
  pg_query($conexion, $query);

  // Actualizar la cantidad en la tabla "articulos"
  $nuevaCantidad = $cantidadActual - $cantidad;
  $query = "UPDATE clientes SET cantidad = $nuevaCantidad WHERE id = $id";
  pg_query($conexion, $query);

  // Confirmar la transacción
  pg_query($conexion, 'COMMIT');

  echo 'success';
} else {
  // No hay suficientes artículos disponibles
  echo 'insufficient_quantity';
}

pg_close($conexion);
?>
