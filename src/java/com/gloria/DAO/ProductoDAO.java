/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gloria.DAO;

import com.gloria.models.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    private Connection connection;

    // Constructor que recibe la conexión a la base de datos
    public ProductoDAO(Connection connection) {
        this.connection = connection;
    }

    // Método para obtener todos los productos
    public List<Producto> obtenerTodosLosProductos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT * FROM tb_producto"; // Corregir el nombre de la tabla
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setCodPro(rs.getInt("cod_pro"));
                producto.setNomPro(rs.getString("nom_pro"));
                producto.setTipoPro(rs.getString("tipo_pro"));
                producto.setDesPro(rs.getString("des_pro"));
                producto.setPrePro(rs.getDouble("pre_pro"));
                producto.setStockPro(rs.getInt("stock_pro"));
                producto.setFecVenPro(rs.getString("fec_ven_pro"));
                producto.setTamPro(rs.getString("tam_pro"));
                productos.add(producto);
            }
        }
        return productos;
    }

    // Método para agregar un nuevo producto
    public void agregarProducto(Producto producto) throws SQLException {
        String query = "INSERT INTO tb_producto (nom_pro, tipo_pro, des_pro, pre_pro, stock_pro, fec_ven_pro, tam_pro) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, producto.getNomPro());
            stmt.setString(2, producto.getTipoPro());
            stmt.setString(3, producto.getDesPro());
            stmt.setDouble(4, producto.getPrePro());
            stmt.setInt(5, producto.getStockPro());
            stmt.setString(6, producto.getFecVenPro());
            stmt.setString(7, producto.getTamPro());
            stmt.executeUpdate();
        }
    }

    // Método para actualizar un producto existente
    public void actualizarProducto(Producto producto) throws SQLException {
        String query = "UPDATE tb_producto SET nom_pro = ?, tipo_pro = ?, des_pro = ?, pre_pro = ?, stock_pro = ?, fec_ven_pro = ?, tam_pro = ? WHERE cod_pro = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, producto.getNomPro());
            stmt.setString(2, producto.getTipoPro());
            stmt.setString(3, producto.getDesPro());
            stmt.setDouble(4, producto.getPrePro());
            stmt.setInt(5, producto.getStockPro());
            stmt.setString(6, producto.getFecVenPro());
            stmt.setString(7, producto.getTamPro());
            stmt.setInt(8, producto.getCodPro());
            stmt.executeUpdate();
        }
    }

   
    // Método para buscar productos por nombre
public List<Producto> buscarProductosPorNombre(String nombre) throws SQLException {
    List<Producto> productos = new ArrayList<>();
    String query = "SELECT cod_pro, nom_pro FROM tb_producto WHERE nom_pro LIKE ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setString(1, "%" + nombre + "%");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Producto producto = new Producto();
            producto.setCodPro(rs.getInt("cod_pro"));
            producto.setNomPro(rs.getString("nom_pro"));
            productos.add(producto);
        }
    }
    return productos;
}

    // Método para obtener un producto por su ID
    public Producto obtenerProductoPorId(int id) throws SQLException {
        Producto producto = null;
        String query = "SELECT * FROM tb_producto WHERE cod_pro = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    producto.setCodPro(rs.getInt("cod_pro"));
                    producto.setNomPro(rs.getString("nom_pro"));
                    producto.setTipoPro(rs.getString("tipo_pro"));
                    producto.setDesPro(rs.getString("des_pro"));
                    producto.setPrePro(rs.getDouble("pre_pro"));
                    producto.setStockPro(rs.getInt("stock_pro"));
                    producto.setFecVenPro(rs.getString("fec_ven_pro"));
                    producto.setTamPro(rs.getString("tam_pro"));
                }
            }
        }
        return producto;
    }
}

