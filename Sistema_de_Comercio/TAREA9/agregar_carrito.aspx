using System;
using System.Data.SqlClient;

namespace EjemploTransaccion
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString = "Data Source=localhost;Initial Catalog=TARA9;User ID=postgres;Password=Pezuna23";

            int id = Convert.ToInt32(Request.Form["id"]);
            int cantidad = Convert.ToInt32(Request.Form["cantidad"]);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Iniciar la transacción
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    // Obtener la cantidad actual del artículo
                    string obtenerCantidadQuery = $"SELECT cantidad FROM clientes WHERE id = {id}";
                    SqlCommand obtenerCantidadCommand = new SqlCommand(obtenerCantidadQuery, connection, transaction);
                    int cantidadActual = Convert.ToInt32(obtenerCantidadCommand.ExecuteScalar());

                    if (cantidad <= cantidadActual)
                    {
                        // Insertar en la tabla "carrito_compra"
                        string insertarCarritoQuery = $"INSERT INTO carrito_compra (id_articulo, cantidad) VALUES ({id}, {cantidad})";
                        SqlCommand insertarCarritoCommand = new SqlCommand(insertarCarritoQuery, connection, transaction);
                        insertarCarritoCommand.ExecuteNonQuery();

                        // Actualizar la cantidad en la tabla "articulos"
                        int nuevaCantidad = cantidadActual - cantidad;
                        string actualizarCantidadQuery = $"UPDATE clientes SET cantidad = {nuevaCantidad} WHERE id = {id}";
                        SqlCommand actualizarCantidadCommand = new SqlCommand(actualizarCantidadQuery, connection, transaction);
                        actualizarCantidadCommand.ExecuteNonQuery();

                        // Confirmar la transacción
                        transaction.Commit();

                        Console.WriteLine("success");
                    }
                    else
                    {
                        // No hay suficientes artículos disponibles
                        Console.WriteLine("insufficient_quantity");
                    }
                }
                catch (Exception ex)
                {
                    // Ocurrió un error, deshacer la transacción
                    transaction.Rollback();
                    Console.WriteLine("error");
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
}
