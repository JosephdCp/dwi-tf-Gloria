<%-- 
    Document   : register.jsp
    Created on : 9 sept 2024, 12:03:00
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.gloria.DAO.DatabaseConnection" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>  
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nombre_completo = request.getParameter("nombre_completo");
    String correo = request.getParameter("correo");
    String usuario = request.getParameter("usuario");
    String contrasena = request.getParameter("contrasena");

   
    if (nombre_completo == null || nombre_completo.trim().isEmpty() ||
        correo == null || correo.trim().isEmpty() ||
        usuario == null || usuario.trim().isEmpty() ||
        contrasena == null || contrasena.trim().isEmpty()) {

        out.println("<script>alert('Todos los campos son obligatorios.'); window.location.href='register.jsp';</script>");
    } else {
        
        String hashedPassword = BCrypt.hashpw(contrasena, BCrypt.gensalt());

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();  

            
            String sql = "INSERT INTO usuarios (nombre_completo, correo, usuario, contrasena) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre_completo);
            stmt.setString(2, correo);
            stmt.setString(3, usuario);
            stmt.setString(4, hashedPassword);  

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirigir al usuario al inicio de sesión después del registro exitoso
                response.sendRedirect("index.jsp?success=1");
            } else {
                out.println("<script>alert('Error en el registro, inténtalo nuevamente.'); window.location.href='register.jsp';</script>");
            }

            
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error en la conexión o base de datos.'); window.location.href='register.jsp';</script>");
        } finally {
            
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>


