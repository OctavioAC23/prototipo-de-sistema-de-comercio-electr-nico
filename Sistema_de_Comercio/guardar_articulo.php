<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Aplicación de Compras</title>
 
 <link rel="stylesheet" href="styles.css">

</head>
<body>
  <div class="form-body">
    <div class="row">
      <div class="form-holder">
        <div class="form-content">
          <div class="form-items">
            <h3>Aplicación de Compras</h3>
            <p>Guardado exitoso</p>
<?php
$host='localhost';
$bd='TARA9';
$user='postgres';
$pass='Pezuna23';

$conexion=pg_connect("host=$host dbname=$bd user=$user password=$pass");
$query=("INSERT INTO clientes (nombre,descripcion,precio,cantidad,foto) 
        VALUES ('$_REQUEST[nombre]', '$_REQUEST[descripcion]', '$_REQUEST[precio]', '$_REQUEST[cantidad]', '$_REQUEST[foto]')");

$consulta=pg_query($conexion,$query);
pg_close();

?>
<button id="Atras">Atras</button>
                <script src="script.js"></script>
              </div>
            </form>  
          </div>
        </div>
      </div>
    </div>
  </div>
 
</body>
</html>
