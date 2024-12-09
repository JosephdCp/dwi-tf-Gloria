<%-- 
    Document   : index
    Created on : 9 sept 2024, 16:56:52
    Author     : DELL
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login y Registro</title>

    <!-- Fuentes y Estilos -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/estilos.css">
</head>
<body>

    
    <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
    %>
        <div style="color: green; font-weight: bold; text-align: center; margin-top: 10px;">
            ¡Registro exitoso! Ahora puedes iniciar sesión.
        </div>
    <%
        }
    %>

    <main>
        <div class="contenedor__todo">
            <div class="caja__trasera">
                <div class="caja__trasera-login">
                    <h3>¿Ya tienes una cuenta?</h3>
                    <p>Inicia sesión para entrar en la página</p>
                    <button id="btn__iniciar-sesion">Iniciar Sesión</button>
                </div>
                <div class="caja__trasera-register">
                    <h3>¿Aún no tienes una cuenta?</h3>
                    <p>Regístrate para que puedas iniciar sesión</p>
                    <button id="btn__registrarse">Regístrarse</button>
                </div>
            </div>
            <!--Formulario de Login y registro-->
            <div class="contenedor__login-register">
                <!--Login-->
                <form action="<%=request.getContextPath()%>/views/login.jsp" method="POST" class="formulario__login">
                    <h2>Iniciar Sesión</h2>
                    <input type="text" name="correo" placeholder="Correo Electronico" required>
                    <input type="password" name="contrasena" placeholder="Contraseña" required>
                    <button type="submit">Entrar</button>
                </form>
                <!--Register-->
                <form action="<%=request.getContextPath()%>/views/register.jsp" method="POST" class="formulario__register">
                    <h2>Regístrarse</h2>
                    <input type="text" name="nombre_completo" placeholder="Nombre completo" required>
                    <input type="text" name="correo" placeholder="Correo Electronico" required>
                    <input type="text" name="usuario" placeholder="Usuario" required>
                    <input type="password" name="contrasena" placeholder="Contraseña" required>
                    <button type="submit">Regístrarse</button>
                </form>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script src="<%=request.getContextPath()%>/assets/js/script.js"></script>
</body>
</html>

