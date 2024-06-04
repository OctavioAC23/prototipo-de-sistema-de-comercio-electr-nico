<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CarritoComprasWebForms.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Compra de artículos</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Compra de artículos</h1>

            <label for="nombre">Nombre:</label>
            <asp:TextBox ID="nombre" runat="server" required></asp:TextBox><br /><br />

            <label for="precio">Precio:</label>
            <asp:TextBox ID="precio" runat="server" required></asp:TextBox><br /><br />

            <label for="cantidad">Cantidad:</label>
            <asp:TextBox ID="cantidad" runat="server" required></asp:TextBox><br /><br />

            <asp:Button ID="btnAgregar" runat="server" Text="Agregar al carrito" OnClick="btnAgregar_Click" />
        </div>
    </form>
</body>
</html>
