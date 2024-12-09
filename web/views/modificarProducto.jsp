<%-- 
    Document   : modificarProducto
    Created on : 7 sept 2024, 2:40:19
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.gloria.DAO.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Producto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/productos.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Modificar Producto</h1>
        <%
            String cod_pro = request.getParameter("cod_pro");
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM tb_producto WHERE cod_pro = ?")) {
                ps.setInt(1, Integer.parseInt(cod_pro));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
        %>
        <form action="../ModificarProductoServlet" method="POST">
            <input type="hidden" name="cod_pro" value="<%= rs.getInt("cod_pro") %>">
            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" class="form-control" name="nom_pro" value="<%= rs.getString("nom_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo</label>
                <input type="text" id="tipo" class="form-control" name="tipo_pro" value="<%= rs.getString("tipo_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción</label>
                <input type="text" id="descripcion" class="form-control" name="des_pro" value="<%= rs.getString("des_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="precio">Precio</label>
                <input type="number" step="0.01" id="precio" class="form-control" name="pre_pro" value="<%= rs.getDouble("pre_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="stock">Stock</label>
                <input type="number" id="stock" class="form-control" name="stock_pro" value="<%= rs.getInt("stock_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="fecha_vencimiento">Fecha de Vencimiento</label>
                <input type="date" id="fecha_vencimiento" class="form-control" name="fec_ven_pro" value="<%= rs.getString("fec_ven_pro") %>" required>
            </div>
            <div class="form-group">
                <label for="imagen">Imagen</label>
                <input type="text" id="imagen" class="form-control" name="tam_pro" value="<%= rs.getString("tam_pro") %>">

            </div>
            <button type="submit" class="btn btn-primary">Modificar Producto</button>
        </form>
        <%
                    } else {
                        out.println("<p>Producto no encontrado.</p>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




