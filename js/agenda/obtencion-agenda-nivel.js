
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

async function obtenerAgenda(idusuario, iddetalle_presentacion, idnivelacceso) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgenda");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append("iddetallepresentacion", iddetalle_presentacion ? iddetalle_presentacion : "");
    params.append("idnivelacceso", idnivelacceso ? idnivelacceso : "");
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
}
/* async function obtenerAgendaFilmmaker(idusuario, iddetalle_presentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgenda");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append(
        "iddetallepresentacion",
        iddetalle_presentacion ? iddetalle_presentacion : ""
    );
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
} */