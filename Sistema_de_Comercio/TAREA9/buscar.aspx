using System;
using System.Data.SqlClient;

namespace AplicacionCompras
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Aplicación de Compras");
            Console.WriteLine("Compra de artículos");
            Console.WriteLine();

            string host = "localhost";
            string bd = "TARA9";
            string user = "postgres";
            string pass = "Pezuna23";

            string connectionString = $"Data Source={host};Initial Catalog={bd};User ID={user};Password={pass}";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string busqueda = Console.ReadLine(); // Obtener la palabra de búsqueda del formulario

                string query = $"SELECT * FROM clientes WHERE nombre LIKE '%{busqueda}%' OR descripcion LIKE '%{busqueda}%'";
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("<table>");
                Console.WriteLine("<tr><th style='color: white; text-align: center;'>Imagen</th><th style='color: white; text-align: center;'>Nombre</th><th style='color: white; text-align: center;'>Precio</th><th style='color: white; text-align: center;'>Acciones</th></tr>");
                while (reader.Read())
                {
                    int id = Convert.ToInt32(reader["id"]);
                    string nombre = reader["nombre"].ToString();
                    string descripcion = reader["descripcion"].ToString();
                    decimal precio = Convert.ToDecimal(reader["precio"]);
                    string foto = reader["foto"].ToString();

                    Console.WriteLine("<tr>");
                    Console.WriteLine($"<td><img src='{foto}' alt='Foto del artículo'></td>");
                    Console.WriteLine($"<td style='color: white; text-align: center;'>{nombre}</td>");
                    Console.WriteLine($"<td style='color: white; text-align: center;'>{precio}</td>");
                    Console.WriteLine("<td style='color: white; text-align: center;'>");
                    Console.WriteLine($"<button class='comprar' onclick='agregarAlCarrito({id})'>Compra</button>");
                    Console.WriteLine($"<input type='number' class='cantidad' id='cantidad-{id}' value='1' style='width: 50px;'>");
                    Console.WriteLine("<button class='descripcion'>Descripción</button>");
                    Console.WriteLine($"<p class='descripcion-articulo' style='display: none;'>{descripcion}</p>");
                    Console.WriteLine("</td>");
                    Console.WriteLine("</tr>");
                }
                Console.WriteLine("</table>");

                reader.Close();
            }

            Console.WriteLine("<button id='Atras'>Atrás</button>");

            // Agregar el código JavaScript aquí

            Console.ReadLine();
        }
    }
}
