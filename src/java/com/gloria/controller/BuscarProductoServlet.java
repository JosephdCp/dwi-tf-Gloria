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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/BuscarProductoServlet")
public class BuscarProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("query");
        List<Map<String, String>> productResults = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT cod_pro, nom_pro FROM tb_producto WHERE nom_pro LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchQuery + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> product = new HashMap<>();
                product.put("cod_pro", rs.getString("cod_pro"));  // Incluimos el ID del producto
                product.put("nom_pro", rs.getString("nom_pro"));
                productResults.add(product);
            }

            // Convertimos la lista en JSON
            Gson gson = new Gson();
            String json = gson.toJson(productResults);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
        }
    }
}

