document.addEventListener('DOMContentLoaded', function() {
    function $q(object = null) {
        return document.querySelector(object);
    }

    function $all(object = null) {
        return document.querySelectorAll(object);
    }

    async function getDatos(link, params) {
        let data = await fetch(`${link}?${params}`);
        return data.json();
    }

    $q("#btnGuardarAC").addEventListener("click", async function() {
        /* let id_producto = $q("#id_producto").value;
        let cantidad = $q("#cantidad").value; */
        alert("PREVIA COTIZAION");   
    });


});