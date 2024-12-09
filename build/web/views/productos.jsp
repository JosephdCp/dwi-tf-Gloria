<%-- 
    Document   : productos.jsp
    Created on : 6 sept 2024, 1:16:06
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.gloria.DAO.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Productos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/prod.css">
    
</head>
<body>

    <div class="container">
        <h1 class="mt-4 mb-4">Lista de Productos</h1>
        <a href="nuevoProducto.jsp" class="btn btn-primary mb-3">Agregar Nuevo Producto</a>

        <!-- Tabla para mostrar productos -->
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Fecha Vencimiento</th>
                    <th>Imagen</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DatabaseConnection.getConnection(); 
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM tb_producto")) {

                        
                        while (rs.next()) {
                            int codigo = rs.getInt("cod_pro");
                            String nombre = rs.getString("nom_pro");
                            String tipo = rs.getString("tipo_pro");
                            String descripcion = rs.getString("des_pro");
                            double precio = rs.getDouble("pre_pro");
                            int stock = rs.getInt("stock_pro");
                            String fechaVencimiento = rs.getString("fec_ven_pro");
                            String imagen = rs.getString("tam_pro");
                %>
                <tr>
                    <td><%= codigo %></td>
                    <td><%= nombre %></td>
                    <td><%= tipo %></td>
                    <td><%= descripcion %></td>
                    <td>S/ <%= precio %></td>
                    <td><%= stock %></td>
                    <td><%= fechaVencimiento %></td>
                    <td><%= imagen %></td>
                    
                    <td>
                        <a href="modificarProducto.jsp?cod_pro=<%= codigo %>" class="btn btn-warning">Modificar</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <tr>
                    <td colspan="9" class="text-center text-danger">Error al cargar los productos.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>





