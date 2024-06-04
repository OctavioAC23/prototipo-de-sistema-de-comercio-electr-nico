<?php
$host = 'localhost';
$bd = 'TARA9';
$user = 'postgres';
$pass = 'Pezuna23';

$conexion = pg_connect("host=$host dbname=$bd user=$user password=$pass");

if (isset($_GET['eliminar'])) {
  $idArticuloEliminar = $_GET['eliminar'];

  $infoArticuloQuery = "SELECT clientes.nombre, carrito_compra.cantidad FROM carrito_compra INNER JOIN clientes ON carrito_compra.id_articulo = clientes.id WHERE carrito_compra.id_articulo = $idArticuloEliminar";
  $infoArticuloResult = pg_query($conexion, $infoArticuloQuery);
  $articulo = pg_fetch_assoc($infoArticuloResult);
  $nombreArticulo = $articulo['nombre'];
  $cantidadArticulo = $articulo['cantidad'];

  echo "<script>
    var confirmacion = confirm('¿Estás seguro de eliminar el artículo \"$nombreArticulo\" del carrito de compra? Cantidad: $cantidadArticulo');

    if (confirmacion) {
      window.location.href = 'carrito.php?eliminarConfirmado=$idArticuloEliminar';
    } else {
      alert('La eliminación del artículo ha sido cancelada.');
      window.location.href = 'carrito.php';
    }
  </script>";
} elseif (isset($_POST['actualizar'])) {
  $idArticuloActualizar = $_POST['id'];
  $nuevaCantidad = $_POST['cantidad'];

  // Obtener la cantidad actual del artículo en el carrito
  $cantidadActualQuery = "SELECT cantidad FROM carrito_compra WHERE id_articulo = $idArticuloActualizar";
  $cantidadActualResult = pg_query($conexion, $cantidadActualQuery);
  $cantidadActual = pg_fetch_assoc($cantidadActualResult)['cantidad'];

  // Verificar si hay suficientes artículos en la tabla "clientes"
  $articuloQuery = "SELECT cantidad FROM clientes WHERE id = $idArticuloActualizar";
  $articuloResult = pg_query($conexion, $articuloQuery);
  $articulo = pg_fetch_assoc($articuloResult);
  $cantidadDisponible = $articulo['cantidad'];

  if ($nuevaCantidad > $cantidadActual) {
    // Incrementar la cantidad en el carrito
    $cantidadIncrementar = $nuevaCantidad - $cantidadActual;
    if ($cantidadIncrementar > $cantidadDisponible) {
      echo "<script>alert('No hay suficientes artículos disponibles.'); window.location.href = 'Compra de artículos.html';</script>";
      exit;
    } else {
      // Iniciar transacción
      pg_query($conexion, 'BEGIN');

      // Actualizar la cantidad en el carrito
      $actualizarCarritoQuery = "UPDATE carrito_compra SET cantidad = $nuevaCantidad WHERE id_articulo = $idArticuloActualizar";
      pg_query($conexion, $actualizarCarritoQuery);

      // Actualizar la cantidad en la tabla "clientes"
      $actualizarClientesQuery = "UPDATE clientes SET cantidad = cantidad - $cantidadIncrementar WHERE id = $idArticuloActualizar";
      pg_query($conexion, $actualizarClientesQuery);

      // Confirmar transacción
      pg_query($conexion, 'COMMIT');

      echo "<script>alert('La cantidad del artículo ha sido actualizada.'); window.location.href = 'Compra de artículos.html';</script>";
      exit;
    }
  } elseif ($nuevaCantidad < $cantidadActual) {
    // Decrementar la cantidad en el carrito
    $cantidadDecrementar = $cantidadActual - $nuevaCantidad;

    // Iniciar transacción
    pg_query($conexion, 'BEGIN');

    // Actualizar la cantidad en el carrito
    $actualizarCarritoQuery = "UPDATE carrito_compra SET cantidad = $nuevaCantidad WHERE id_articulo = $idArticuloActualizar";
    pg_query($conexion, $actualizarCarritoQuery);

    // Actualizar la cantidad en la tabla "clientes"
    $actualizarClientesQuery = "UPDATE clientes SET cantidad = cantidad + $cantidadDecrementar WHERE id = $idArticuloActualizar";
    pg_query($conexion, $actualizarClientesQuery);

    // Confirmar transacción
    pg_query($conexion, 'COMMIT');

    echo "<script>alert('La cantidad del artículo ha sido actualizada.'); window.location.href = 'Compra de artículos.html';</script>";
    exit;
  } else {
    // La cantidad no ha cambiado, no es necesario hacer ninguna actualización
    echo "<script>window.location.href = 'Compra de artículos.html';</script>";
    exit;
  }
} elseif (isset($_GET['eliminarConfirmado'])) {
  // Iniciar transacción
  pg_query($conexion, 'BEGIN');

  // Obtener la cantidad de cada artículo en el carrito
  $articulosCarritoQuery = "SELECT id_articulo, cantidad FROM carrito_compra";
  $articulosCarritoResult = pg_query($conexion, $articulosCarritoQuery);

  while ($articuloCarrito = pg_fetch_assoc($articulosCarritoResult)) {
    $idArticulo = $articuloCarrito['id_articulo'];
    $cantidadArticulo = $articuloCarrito['cantidad'];

    // Devolver la cantidad a la tabla "clientes"
    $devolverCantidadQuery = "UPDATE clientes SET cantidad = cantidad + $cantidadArticulo WHERE id = $idArticulo";
    pg_query($conexion, $devolverCantidadQuery);
  }

  // Eliminar los registros de la tabla "carrito_compra"
  $eliminarCarritoQuery = "DELETE FROM carrito_compra";
  pg_query($conexion, $eliminarCarritoQuery);

  // Confirmar transacción
  pg_query($conexion, 'COMMIT');

  echo "<script>alert('El carrito de compra ha sido eliminado.'); window.location.href = 'Compra de artículos.html';</script>";
  exit;
}

$carritoQuery = "SELECT carrito_compra.id_articulo, carrito_compra.cantidad, carrito_compra.fecha_compra, clientes.nombre, clientes.descripcion, clientes.precio, clientes.foto FROM carrito_compra INNER JOIN clientes ON carrito_compra.id_articulo = clientes.id";
$carritoResult = pg_query($conexion, $carritoQuery);

$carritoHTML = '<h4 style="color: white;">Artículos en el carrito</h4>';
$carritoHTML .= '<table>';
$carritoHTML .= '<tr><th style="color: white;">Imagen</th><th style="color: white;">Nombre</th><th style="color: white;">Descripción</th><th style="color: white;">Cantidad</th><th style="color: white;">Precio</th><th style="color: white;">Costo</th><th style="color: white;">Acciones</th></tr>';

$totalCompra = 0;

while ($articulo = pg_fetch_assoc($carritoResult)) {
  $idArticulo = $articulo['id_articulo'];
  $nombre = $articulo['nombre'];
  $descripcion = $articulo['descripcion'];
  $cantidad = $articulo['cantidad'];
  $precio = $articulo['precio'];
  $costo = $cantidad * $precio;
  $foto = $articulo['foto'];

  $carritoHTML .= '<tr>';
  $carritoHTML .= "<td><img src='$foto' alt='Foto del artículo'></td>";
  $carritoHTML .= "<td style='color: white;'>$nombre</td>";
  $carritoHTML .= "<td style='color: white;'>$descripcion</td>";
  $carritoHTML .= "<td><form method='post' action='carrito.php'><input type='number' name='cantidad' min='1' value='$cantidad' style='width: 50px;'><input type='hidden' name='id' value='$idArticulo'><input type='submit' name='actualizar' value='Actualizar'></form></td>";
  $carritoHTML .= "<td style='color: white;'>$$precio</td>";
  $carritoHTML .= "<td style='color: white;'>$$costo</td>";
  $carritoHTML .= "<td><button style='color: white;'><a href='carrito.php?eliminar=$idArticulo'>Eliminar artículo</a></button></td>";
  $carritoHTML .= '</tr>';

  $totalCompra += $costo;
}

$carritoHTML .= '</table>';
$carritoHTML .= '<p style="color: white;">Total de la compra: $' . $totalCompra . '</p>';

$eliminarCarritoButton = '<button onclick="eliminarCarrito()">Eliminar carrito de compra</button>';
$seguirComprandoButton = '<button><a href="Compra de artículos.html">Seguir comprando</a></button>';

echo $carritoHTML;
echo $eliminarCarritoButton;
echo $seguirComprandoButton;

pg_close($conexion);
?>

<script>
function eliminarCarrito() {
  var confirmacion = confirm('¿Estás seguro de eliminar el carrito de compra? Esta acción no se puede deshacer.');

  if (confirmacion) {
    window.location.href = 'carrito.php?eliminarConfirmado=1';
  } else {
    alert('La eliminación del carrito de compra ha sido cancelada.');
  }
}
</script>
