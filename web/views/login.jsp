<%-- 
    Document   : login
    Created on : 9 sept 2024, 16:45:52
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.gloria.DAO.DatabaseConnection" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>  
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");  
    boolean loginExitoso = false;

    Connection conn = null;
    try {
        conn = DatabaseConnection.getConnection();  

        
        String sql = "SELECT * FROM usuarios WHERE correo = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, correo);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Obtener la contraseña almacenada en la base de datos
            String storedPassword = rs.getString("contrasena");

            // Verificar si la contraseña almacenada está encriptada 
            if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
                // Contraseña está encriptada, verificar con bcrypt
                if (BCrypt.checkpw(contrasena, storedPassword)) {
                    loginExitoso = true;
                    session.setAttribute("usuario", rs.getString("usuario"));
                    response.sendRedirect("productos.jsp");  // Redirige a productos.jsp
                } else {
                    out.println("<p style='color:red;'>Contraseña incorrecta</p>");
                }
            } else {
                // Contraseña no está encriptada (caso antiguo), comparar directamente
                if (contrasena.equals(storedPassword)) {
                    loginExitoso = true;
                    session.setAttribute("usuario", rs.getString("usuario"));
                    
                    // Opción avanzada: Encriptar la contraseña antigua y actualizar en la base de datos
                    String newHashedPassword = BCrypt.hashpw(contrasena, BCrypt.gensalt());
                    String updateSql = "UPDATE usuarios SET contrasena = ? WHERE correo = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setString(1, newHashedPassword);
                    updateStmt.setString(2, correo);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                    
                    response.sendRedirect("productos.jsp");  
                } else {
                    out.println("<p style='color:red;'>Contraseña incorrecta</p>");
                }
            }
        } else {
            out.println("<p style='color:red;'>Usuario no encontrado</p>");
        }

        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<% if (!loginExitoso) { %>
    <p style="color:red;">Error al iniciar sesión. Por favor, intenta nuevamente.</p>
<% } %>
