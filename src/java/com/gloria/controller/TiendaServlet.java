/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gloria.controller;

import com.gloria.DAO.DatabaseConnection;
import com.gloria.models.Producto;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/TiendaServlet")
public class TiendaServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Producto> productos = new ArrayList<>();

        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT tam_pro, cod_pro, nom_pro, des_pro, pre_pro, tipo_pro FROM tb_producto WHERE stock_pro > 1";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setTamPro(rs.getString("tam_pro"));
                producto.setCodPro(rs.getInt("cod_pro"));
                producto.setNomPro(rs.getString("nom_pro"));
                producto.setDesPro(rs.getString("des_pro"));
                producto.setPrePro(rs.getDouble("pre_pro"));
                producto.setTipoPro(rs.getString("tipo_pro"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Enviamos la lista de productos al JSP
        request.setAttribute("productos", productos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tienda.jsp");
        dispatcher.forward(request, response);
    }
}


