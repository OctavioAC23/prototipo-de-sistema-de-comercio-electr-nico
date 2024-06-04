Atras.addEventListener('click',()=>{
    window.location.href = 'Menu.html';
});

compraBtn.addEventListener('click', () => {
  // Implementa la lógica para mostrar la sección de compra de artículos
});



// Función para mostrar una sección y ocultar las demás
function mostrarSeccion(seccion) {
  const secciones = document.querySelectorAll('div[id^="seccion"]');
  secciones.forEach((seccion) => {
    seccion.style.display = 'none';
  });
  seccion.style.display = 'block';
}

// Implementa el resto de la lógica necesaria para los botones, eventos y funcionalidades del front-end
 // Función para enviar los datos del formulario al servidor
 
  


