/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gloria.controller;

import com.gloria.DAO.DatabaseConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener los datos del formulario de registro
        String nombre_completo = request.getParameter("nombre_completo");
        String correo = request.getParameter("correo");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Encriptar la contraseña usando jBCrypt
        String hashedPassword = BCrypt.hashpw(contrasena, BCrypt.gensalt());

        // Conectar a la base de datos y realizar la inserción
        try {
            Connection conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO usuarios (nombre_completo, correo, usuario, contrasena) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre_completo);
            stmt.setString(2, correo);
            stmt.setString(3, usuario);
            stmt.setString(4, hashedPassword);  // Guardar la contraseña encriptada
            
            // Ejecutar la inserción
            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            conn.close();
            
            if (rowsInserted > 0) {
                // Redirigir a la página de inicio de sesión si el registro fue exitoso
                response.sendRedirect("/views/index.jsp");
            } else {
                // Si ocurre un error en la inserción
                response.getWriter().println("Error en el registro. Intente nuevamente.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al conectar con la base de datos.");
        }
    }
}


