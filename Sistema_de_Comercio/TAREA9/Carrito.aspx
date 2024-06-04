<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="CarritoComprasWebForms.Carrito" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Carrito de compras</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string host = "localhost";
            string bd = "TARA9";
            string user = "postgres";
            string pass = "Pezuna23";

            string connectionString = $"host={host} dbname={bd} user={user} password={pass}";

            if (!IsPostBack)
            {
                if (Request.QueryString["eliminar"] != null)
                {
                    int idArticuloEliminar = Convert.ToInt32(Request.QueryString["eliminar"]);

                    string infoArticuloQuery = $"SELECT clientes.nombre, carrito_compra.cantidad FROM carrito_compra INNER JOIN clientes ON carrito_compra.id_articulo = clientes.id WHERE carrito_compra.id_articulo = {idArticuloEliminar}";
                    // Aquí debes ejecutar la consulta y obtener los datos del artículo a eliminar
                    // Luego, puedes utilizar los datos para mostrar la confirmación utilizando JavaScript
                    // y redirigir a la página adecuada según la confirmación del usuario
                    // Ejemplo:
                    /*
                    string nombreArticulo = "";
                    int cantidadArticulo = 0;

                    // ... Obtener los datos del artículo a eliminar ...

                    string confirmacionScript = $@"
                        <script>
                            var confirmacion = confirm('¿Estás seguro de eliminar el artículo \"{nombreArticulo}\" del carrito de compra? Cantidad: {cantidadArticulo}');

                            if (confirmacion) {{
                                window.location.href = 'Carrito.aspx?eliminarConfirmado={idArticuloEliminar}';
                            }} else {{
                                alert('La eliminación del artículo ha sido cancelada.');
                                window.location.href = 'Carrito.aspx';
                            }}
                        </script>
                    ";

                    ClientScript.RegisterStartupScript(GetType(), "confirmacionScript", confirmacionScript);
                    */
                }
                else if (Request.Form["actualizar"] != null)
                {
                    int idArticuloActualizar = Convert.ToInt32(Request.Form["id"]);
                    int nuevaCantidad = Convert.ToInt32(Request.Form["cantidad"]);

                    // Obtener la cantidad actual del artículo en el carrito
                    string cantidadActualQuery = $"SELECT cantidad FROM carrito_compra WHERE id_articulo = {idArticuloActualizar}";
                    // Aquí debes ejecutar la consulta y obtener la cantidad actual del artículo en el carrito
                    // Luego, puedes realizar la lógica de actualización según la nueva cantidad
                    // y las verificaciones necesarias con la tabla "clientes"
                    // Ejemplo:
                    /*
                    int cantidadActual = 0;
                    int cantidadDisponible = 0;

                    // ... Obtener las cantidades del artículo actual ...

                    if (nuevaCantidad > cantidadActual)
                    {
                        // Incrementar la cantidad en el carrito
                        int cantidadIncrementar = nuevaCantidad - cantidadActual;
                        if (cantidadIncrementar > cantidadDisponible)
                        {
                            string mensajeScript = "<script>alert('No hay suficientes artículos disponibles.'); window.location.href = 'Compra de artículos.html';</script>";
                            ClientScript.RegisterStartupScript(GetType(), "mensajeScript", mensajeScript);
                            return;
                        }
                        else
                        {
                            // Iniciar transacción
                            // ...

                            // Actualizar la cantidad en el carrito
                            string actualizarCarritoQuery = $"UPDATE carrito_compra SET cantidad = {nuevaCantidad} WHERE id_articulo = {idArticuloActualizar}";
                            // ...

                            // Actualizar la cantidad en la tabla "clientes"
                            string actualizarClientesQuery = $"UPDATE clientes SET cantidad = cantidad - {cantidadIncrementar} WHERE id = {idArticuloActualizar}";
                            // ...

                            // Confirmar transacción
                            // ...

                            string mensajeScript = "<script>alert('La cantidad del artículo ha sido actualizada.'); window.location.href = 'Compra de artículos.html';</script>";
                            ClientScript.RegisterStartupScript(GetType(), "mensajeScript", mensajeScript);
                            return;
                        }
                    }
                    else if (nuevaCantidad < cantidadActual)
                    {
                        // Decrementar la cantidad en el carrito
                        int cantidadDecrementar = cantidadActual - nuevaCantidad;

                        // Iniciar transacción
                        // ...

                        // Actualizar la cantidad en el carrito
                        string actualizarCarritoQuery = $"UPDATE carrito_compra SET cantidad = {nuevaCantidad} WHERE id_articulo = {idArticuloActualizar}";
                        // ...

                        // Actualizar la cantidad en la tabla "clientes"
                        string actualizarClientesQuery = $"UPDATE clientes SET cantidad = cantidad + {cantidadDecrementar} WHERE id = {idArticuloActualizar}";
                        // ...

                        // Confirmar transacción
                        // ...

                        string mensajeScript = "<script>alert('La cantidad del artículo ha sido actualizada.'); window.location.href = 'Compra de artículos.html';</script>";
                        ClientScript.RegisterStartupScript(GetType(), "mensajeScript", mensajeScript);
                        return;
                    }
                    else
                    {
                        // La cantidad no ha cambiado, no es necesario hacer ninguna actualización
                        string redireccionScript = "<script>window.location.href = 'Compra de artículos.html';</script>";
                        ClientScript.RegisterStartupScript(GetType(), "redireccionScript", redireccionScript);
                        return;
                    }
                    */
                }
                else if (Request.QueryString["eliminarConfirmado"] != null)
                {
                    // Iniciar transacción
                    // ...

                    string articulosCarritoQuery = "SELECT id_articulo, cantidad FROM carrito_compra";
                    // Aquí debes ejecutar la consulta y obtener los datos de los artículos en el carrito

                    while (/* Leer los registros de los artículos en el carrito */)
                    {
                        int idArticulo = 0;
                        int cantidadArticulo = 0;

                        // ... Obtener los datos del artículo ...

                        // Devolver la cantidad a la tabla "clientes"
                        string devolverCantidadQuery = $"UPDATE clientes SET cantidad = cantidad + {cantidadArticulo} WHERE id = {idArticulo}";
                        // ...
                    }

                    // Eliminar los registros de la tabla "carrito_compra"
                    string eliminarCarritoQuery = "DELETE FROM carrito_compra";
                    // ...

                    // Confirmar transacción
                    // ...

                    string mensajeScript = "<script>alert('El carrito de compra ha sido eliminado.'); window.location.href = 'Compra de artículos.html';</script>";
                    ClientScript.RegisterStartupScript(GetType(), "mensajeScript", mensajeScript);
                    return;
                }

                string carritoQuery = "SELECT carrito_compra.id_articulo, carrito_compra.cantidad, carrito_compra.fecha_compra, clientes.nombre, clientes.descripcion, clientes.precio, clientes.foto FROM carrito_compra INNER JOIN clientes ON carrito_compra.id_articulo = clientes.id";
                // Aquí debes ejecutar la consulta y obtener los datos de los artículos en el carrito

                string carritoHTML = "<h4 style='color: white;'>Artículos en el carrito</h4>";
                carritoHTML += "<table>";
                carritoHTML += "<tr><th style='color: white;'>Imagen</th><th style='color: white;'>Nombre</th><th style='color: white;'>Descripción</th><th style='color: white;'>Cantidad</th><th style='color: white;'>Precio</th><th style='color: white;'>Costo</th><th style='color: white;'>Acciones</th></tr>";

                decimal totalCompra = 0;

                while (/* Leer los registros de los artículos en el carrito */)
                {
                    int idArticulo = 0;
                    string nombre = "";
                    string descripcion = "";
                    int cantidad = 0;
                    decimal precio = 0;
                    decimal costo = 0;
                    string foto = "";

                    // ... Obtener los datos del artículo ...

                    carritoHTML += "<tr>";
                    carritoHTML += $"<td><img src='{foto}' alt='Foto del artículo'></td>";
                    carritoHTML += $"<td style='color: white;'>{nombre}</td>";
                    carritoHTML += $"<td style='color: white;'>{descripcion}</td>";
                    carritoHTML += "<td>";
                    carritoHTML += "<form method='post' action='carrito.php'>";
                    carritoHTML += $"<input type='number' name='cantidad' min='1' value='{cantidad}' style='width: 50px;'>";
                    carritoHTML += $"<input type='hidden' name='id' value='{idArticulo}'>";
                    carritoHTML += "<input type='submit' name='actualizar' value='Actualizar'>";
                    carritoHTML += "</form>";
                    carritoHTML += "</td>";
                    carritoHTML += $"<td style='color: white;'>${precio}</td>";
                    carritoHTML += $"<td style='color: white;'>${costo}</td>";
                    carritoHTML += "<td><button style='color: white;'><a href='carrito.php?eliminar=" + idArticulo + "'>Eliminar artículo</a></button></td>";
                    carritoHTML += "</tr>";

                    totalCompra += costo;
                }

                carritoHTML += "</table>";
                carritoHTML += $"<p style='color: white;'>Total de la compra: ${totalCompra}</p>";

                string eliminarCarritoButton = "<button onclick='eliminarCarrito()'>Eliminar carrito de compra</button>";
                string seguirComprandoButton = "<button><a href='Compra de artículos.html'>Seguir comprando</a></button>";

                Response.Write(carritoHTML);
                Response.Write(eliminarCarritoButton);
                Response.Write(seguirComprandoButton);

                // ...

                pg_close($conexion);
            }

            protected void eliminarCarrito()
            {
                bool confirmacion = /* Obtener confirmación del usuario */;

                if (confirmacion)
                {
                    string redireccionScript = "<script>window.location.href = 'carrito.php?eliminarConfirmado=1';</script>";
                    ClientScript.RegisterStartupScript(GetType(), "redireccionScript", redireccionScript);
                }
                else
                {
                    string mensajeScript = "<script>alert('La eliminación del carrito de compra ha sido cancelada.');</script>";
                    ClientScript.RegisterStartupScript(GetType(), "mensajeScript", mensajeScript);
                }
            }
        }
    }
}
