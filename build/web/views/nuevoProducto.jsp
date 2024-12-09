<%-- 
    Document   : nuevoProducto
    Created on : 7 sept 2024, 2:39:50
    Author     : DELL
--%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Nuevo Producto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/productos.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Agregar Nuevo Producto</h1>
        <form action="../AgregarProductoServlet" method="POST">
            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" class="form-control" name="nom_pro" maxlength="25" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo</label>
                <select id="tipo" class="form-control" name="tipo_pro" required>
                    <option value="TARRO">TARRO</option>
                    <option value="UHT">UHT</option>
                    <option value="YOGURT">YOGURT</option>
                    <option value="POLVO">POLVO</option>
                    <option value="JUGO/BEBIDA">JUGO/BEBIDA</option>
                    <option value="ALIMENTO">ALIMENTO</option>
                </select>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción</label>
                <input type="text" id="descripcion" class="form-control" name="des_pro" maxlength="250" required>
            </div>
            <div class="form-group">
                <label for="precio">Precio</label>
                <input type="number" step="0.01" id="precio" class="form-control" name="pre_pro" required>
            </div>
            <div class="form-group">
                <label for="stock">Stock</label>
                <input type="number" id="stock" class="form-control" name="stock_pro" required>
            </div>
            <div class="form-group">
                <label for="fecha_vencimiento">Fecha de Vencimiento</label>
                <input type="date" id="fecha_vencimiento" class="form-control" name="fec_ven_pro" required>
            </div>
            <div class="form-group">
                <label for="imagen">Imagen</label>
                <input type="text" id="imagen" class="form-control" name="tam_pro" maxlength="25">

            </div>
            <button type="submit" class="btn btn-primary">Agregar Producto</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>






