/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gloria.controller;

import com.gloria.DAO.DatabaseConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ModificarProductoServlet")
public class ModificarProductoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codPro = request.getParameter("cod_pro");
        String nombre = request.getParameter("nom_pro");
        String tipo = request.getParameter("tipo_pro");
        String descripcion = request.getParameter("des_pro");
        String precioString = request.getParameter("pre_pro");
        String stockString = request.getParameter("stock_pro");
        String fechaVencimiento = request.getParameter("fec_ven_pro");
        String imagen = request.getParameter("tam_pro");

        if (codPro == null || nombre == null || tipo == null || descripcion == null ||
            precioString == null || stockString == null || fechaVencimiento == null || imagen == null) {
            response.sendRedirect("views/error.jsp");
            return;
        }

        double precio;
        int stock;
        try {
            precio = Double.parseDouble(precioString);
            stock = Integer.parseInt(stockString);
        } catch (NumberFormatException e) {
            response.sendRedirect("views/error.jsp");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                "UPDA+TE tb_producto SET nom_pro = ?, tipo_pro = ?, des_pro = ?, pre_pro = ?, stock_pro = ?, fec_ven_pro = ?, tam_pro = ? WHERE cod_pro = ?")) {
            statement.setString(1, nombre);
            statement.setString(2, tipo);
            statement.setString(3, descripcion);
            statement.setDouble(4, precio);
            statement.setInt(5, stock);
            statement.setString(6, fechaVencimiento);
            statement.setString(7, imagen);
            statement.setInt(8, Integer.parseInt(codPro));

            int filasActualizadas = statement.executeUpdate();
            if (filasActualizadas > 0) {
                response.sendRedirect("views/productos.jsp");
            } else {
                response.sendRedirect("views/error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("views/error.jsp");
        }
    }
}


