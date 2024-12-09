package com.gloria.controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.gloria.DAO.DatabaseConnection;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        try {
            // Conexión a la base de datos
            Connection conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, contrasena);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Usuario y contraseña correctos
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                response.sendRedirect("views/productos.jsp");
            } else {        
                // Usuario o contraseña incorrectos
                response.sendRedirect("views/login.jsp?error=1");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/login.jsp?error=1");
        }
    }
}



