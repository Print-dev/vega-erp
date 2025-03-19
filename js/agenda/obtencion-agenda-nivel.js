
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

async function obtenerAgendaArtista(idusuario, iddetalle_presentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgendaArtista");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append(
        "iddetallepresentacion",
        iddetalle_presentacion ? iddetalle_presentacion : ""
    );
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
}
async function obtenerAgendaFilmmaker(idusuario, iddetalle_presentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgendaArtista");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append(
        "iddetallepresentacion",
        iddetalle_presentacion ? iddetalle_presentacion : ""
    );
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
}