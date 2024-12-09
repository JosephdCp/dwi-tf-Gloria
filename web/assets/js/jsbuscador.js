/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.getElementById('search-box').addEventListener('input', function() {
    const query = this.value.trim();  // Captura el valor del input de búsqueda y elimina espacios en blanco

    if (query.length > 2) {  // Solo buscar si hay más de 2 caracteres
        fetch('/Gloria2/BuscarProductoServlet?query=' + query)
        .then(response => response.json())
        .then(data => {
            const suggestions = document.getElementById('suggestions');
            suggestions.innerHTML = '';  // Limpiar las sugerencias anteriores

            if (data.length === 0) {
                const noResultItem = document.createElement('li');
                noResultItem.classList.add('list-group-item', 'text-danger');
                noResultItem.textContent = 'No se encontraron productos';
                suggestions.appendChild(noResultItem);
            } else {
                data.forEach(product => {
                    const li = document.createElement('li');
                    li.classList.add('list-group-item');
                    li.textContent = product.nom_pro;  // Mostrar el nombre del producto
                    li.dataset.id = product.cod_pro;   // Guardar el ID del producto

                    // Agregar evento para desplazarse al producto al hacer clic
                    li.addEventListener('click', function() {
                        const productId = li.dataset.id;
                        const productElement = document.getElementById('product-' + productId);  // Buscar el elemento por su ID
                        if (productElement) {
                            productElement.scrollIntoView({ behavior: 'smooth' });  // Desplazarse suavemente
                        }
                        document.getElementById('search-box').value = product.nom_pro;  // Establecer el valor en el campo de búsqueda
                        suggestions.innerHTML = '';  // Limpiar las sugerencias
                    });
                    suggestions.appendChild(li);
                });
            }
        })
        .catch(error => {
            console.error('Error al obtener los datos:', error);
        });
    } else {
        document.getElementById('suggestions').innerHTML = '';  // Limpiar sugerencias si no hay suficiente texto
    }
});

