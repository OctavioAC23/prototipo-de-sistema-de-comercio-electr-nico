<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Aplicación de Compras</title>
  <link rel="stylesheet" href="styles.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <div class="form-body">
    <div class="row">
      <div class="form-holder">
        <div class="form-content">
          <div class="form-items">
            <h3>Aplicación de Compras</h3>
            <p>Compra de artículos</p>
            <?php
            $host = 'localhost';
            $bd = 'TARA9';
            $user = 'postgres';
            $pass = 'Pezuna23';

            $conexion = pg_connect("host=$host dbname=$bd user=$user password=$pass");

            $busqueda = $_POST['busqueda']; // Obtener la palabra de búsqueda del formulario

            $query = "SELECT * FROM clientes WHERE nombre LIKE '%$busqueda%' OR descripcion LIKE '%$busqueda%'";
            $resultado = pg_query($conexion, $query);

            // Generar el contenido HTML con los resultados de la búsqueda
            $contenidoHTML = '<table>';
            $contenidoHTML .= '<tr><th style="color: white; text-align: center;">Imagen</th><th style="color: white; text-align: center;">Nombre</th><th style="color: white; text-align: center;">Precio</th><th style="color: white; text-align: center;">Acciones</th></tr>';
            while ($articulo = pg_fetch_assoc($resultado)) {
              $id = $articulo['id'];
              $nombre = $articulo['nombre'];
              $descripcion = $articulo['descripcion'];
              $precio = $articulo['precio'];
              $foto = $articulo['foto'];

              // Agrega aquí tu código HTML para mostrar los datos del artículo
              $contenidoHTML .= '<tr>';
              $contenidoHTML .= "<td><img src='$foto' alt='Foto del artículo'></td>";
              $contenidoHTML .= "<td style='color: white; text-align: center;'>$nombre</td>";
              $contenidoHTML .= "<td style='color: white; text-align: center;'>$precio</td>";
              $contenidoHTML .= "<td style='color: white; text-align: center;'>";
              $contenidoHTML .= "<button class='comprar' onclick='agregarAlCarrito($id)'>Compra</button>";
              $contenidoHTML .= "<input type='number' class='cantidad' id='cantidad-$id' value='1' style='width: 50px;'>";
              $contenidoHTML .= "<button class='descripcion'>Descripción</button>";
              $contenidoHTML .= "<p class='descripcion-articulo' style='display: none;'>$descripcion</p>";
              $contenidoHTML .= "</td>";
              $contenidoHTML .= '</tr>';
            }
            $contenidoHTML .= '</table>';

            echo $contenidoHTML;

            pg_close($conexion);
            ?>

            <button id="Atras">Atrás</button>
            <script src="script.js"></script>
            <script>
              function agregarAlCarrito(id) {
                var cantidadInput = document.getElementById('cantidad-' + id);
                var cantidad = parseInt(cantidadInput.value);

                if (isNaN(cantidad) || cantidad <= 0) {
                  alert('Ingrese una cantidad válida.');
                  return;
                }

                 // Realizar la petición al servidor para agregar al carrito
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'agregar_carrito.php', true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
        var response = xhr.responseText;
        if (response === 'success') {
          alert('Artículo agregado al carrito.');
          window.location.href = 'Compra de artículos.html'; // Redireccionar a Compra de Articulos.html
          // Actualizar la cantidad en la página
          // Puedes implementar esta funcionalidad si lo deseas
        } else if (response === 'insufficient_quantity') {
          alert('No hay suficientes artículos disponibles.');
        } else {
          alert('Error al agregar el artículo al carrito.');
        }
      }
    };
    xhr.send('id=' + id + '&cantidad=' + cantidad);
  }

              // Obtener todos los botones "Descripción"
              var descripcionButtons = document.querySelectorAll('.descripcion');

              // Agregar evento de clic a cada botón "Descripción"
              descripcionButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                  // Obtener la descripción del artículo correspondiente
                  var descripcion = this.parentNode.querySelector('.descripcion-articulo').textContent;

                  // Crear una ventana emergente con la descripción del artículo
                  var popupWindow = window.open('', 'Descripción del artículo', 'width=400,height=300');
                  popupWindow.document.write('<html><head><title>Descripción del artículo</title><link rel="stylesheet" href="styles.css"></head><body style="text-align: center; color: white;">');
                  popupWindow.document.write('<h4>Descripción:</h4>');
                  popupWindow.document.write('<p>' + descripcion + '</p>');
                  popupWindow.document.write('<button onclick="window.close()">Cerrar</button>');
                  popupWindow.document.write('</body></html>');
                });
              });
            </script>
            <style>
              table {
                width: 100%;
                overflow-x: auto;
              }

              th, td {
                white-space: nowrap;
              }
            </style>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
