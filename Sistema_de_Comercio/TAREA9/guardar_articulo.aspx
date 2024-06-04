using System;
using System.Data.SqlClient;

namespace AplicacionCompras
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Aplicación de Compras");
            Console.WriteLine("Guardado exitoso");
            Console.WriteLine();

            string host = "localhost";
            string bd = "TARA9";
            string user = "postgres";
            string pass = "Pezuna23";

            string connectionString = $"Data Source={host};Initial Catalog={bd};User ID={user};Password={pass}";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string nombre = Console.ReadLine();
                string descripcion = Console.ReadLine();
                decimal precio = Convert.ToDecimal(Console.ReadLine());
                int cantidad = Convert.ToInt32(Console.ReadLine());
                string foto = Console.ReadLine();

                string query = $"INSERT INTO clientes (nombre, descripcion, precio, cantidad, foto) VALUES ('{nombre}', '{descripcion}', {precio}, {cantidad}, '{foto}')";
                SqlCommand command = new SqlCommand(query, connection);
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("Guardado exitoso");
                }
                else
                {
                    Console.WriteLine("Error al guardar");
                }
            }

            Console.WriteLine("<button id='Atras'>Atrás</button>");

            // Agregar el código JavaScript aquí

            Console.ReadLine();
        }
    }
}
