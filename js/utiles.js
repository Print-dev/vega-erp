function redondear(valor) {
  return parseFloat(valor || 0).toFixed(2);
}

const obtenerFechaHoraPeru = () => {
  const fecha = new Date().toLocaleString("en-CA", { timeZone: "America/Lima" });
  const soloFecha = fecha.split(",");
  console.log("Fecha y hora actual en Perú:", soloFecha);
  return soloFecha;
};

function formatearFecha(fechaStr) {
  const partes = fechaStr.split("-");
  const anio = partes[0];
  const mes = partes[1].padStart(2, "0");
  const dia = partes[2].padStart(2, "0");

  return `${dia}-${mes}-${anio}`;
}


function generarCorrelativo(serie, correlativo) {
  // Convertir el correlativo a un número y añadir ceros si es necesario
  let correlativoNum = parseInt(correlativo, 10);

  // Comprobar si el correlativo ha llegado al máximo (99999999)
  if (correlativoNum >= 99999999) {
    // Cambiar a la siguiente serie
    let nuevaSerie = incrementarSerie(serie);
    return { nuevaSerie, nuevoCorrelativo: '00000001' };  // Resetear correlativo a 00000001
  }

  // Si no ha llegado al máximo, simplemente incrementar el correlativo
  correlativoNum++;

  // Asegurarse de que el correlativo tenga 8 dígitos
  let nuevoCorrelativo = correlativoNum.toString().padStart(8, '0');

  return { serie, nuevoCorrelativo };
}

// Función para incrementar la serie (F001 -> F002, etc.)
function incrementarSerie(serie) {
  // Extraer el número de la serie (e.g., "F001" -> "001")
  let numeroSerie = serie.slice(1); // Obtener la parte numérica de la serie (001 de F001)

  // Convertir a número e incrementar
  let nuevaSerieNum = parseInt(numeroSerie, 10) + 1;

  // Si el número de serie es mayor que 999, reseteamos o generamos una nueva letra para la serie.
  if (nuevaSerieNum > 999) {
    nuevaSerieNum = 1;  // Cambiar la serie a 1
  }

  // Devolver la nueva serie, formateada con ceros a la izquierda
  return serie[0] + nuevaSerieNum.toString().padStart(3, '0');
}

/* // Ejemplo de uso:
let serie = 'F001';
let correlativo = '99999999'; // Simulamos el correlativo al máximo

let { nuevaSerie, nuevoCorrelativo } = generarCorrelativo(serie, correlativo);

console.log(`Nueva Serie: ${nuevaSerie}`);
console.log(`Nuevo Correlativo: ${nuevoCorrelativo}`);
 */

function generarNuevoNCotizacion(ultimaCotizacion) {
  const añoActual = new Date().getFullYear(); // Obtiene el año actual

  if (!ultimaCotizacion) {
    // Si no hay registros previos, iniciamos con "0001"
    return `0001-${añoActual}`;
  }

  const ncotizacionAnterior = ultimaCotizacion.ncotizacion || ultimaCotizacion.correlativo; // "0002-2025" || "2025-0000000001"
  const [numeroAnterior, añoAnterior] = ncotizacionAnterior.split("-");

  let nuevoNumero;
  if (parseInt(añoAnterior) === añoActual) {
    // Mismo año, incrementar el número
    nuevoNumero = String(parseInt(numeroAnterior) + 1).padStart(4, "0");
  } else {
    // Nuevo año, reiniciar a "0001"
    nuevoNumero = "0001";
  }

  return `${nuevoNumero}-${añoActual}`;
}

function generarCorrelativoNotaVenta(ultimaCorrelativo, añoCorrelativo) {
  const añoActual = new Date().getFullYear(); // Obtiene el año actual

  if (!ultimaCorrelativo) {
    // Si no hay registros previos, iniciamos con "0001"
    return `0001-${añoActual}`;
  }

  /*   const ncorrelativoAnterior = ultimaCorrelativo.correlativo; // "0002-2025" || "2025-0000000001"
    console.log("ncorrelativoAnterior", ncorrelativoAnterior); */
  /*   const [numeroAnterior, añoAnterior] = ncorrelativoAnterior.split("-");
   */
  let nuevoNumero;
  if (parseInt(añoCorrelativo) === añoActual) {
    // Mismo año, incrementar el número
    nuevoNumero = String(parseInt(ultimaCorrelativo) + 1).padStart(8, "0");
  } else {
    // Nuevo año, reiniciar a "0001"
    nuevoNumero = "0001";
  }

  return {
    nuevoCorrelativo: nuevoNumero,
    nserie: añoCorrelativo,
  }
}

function calcularFechaVencimiento(fechaCreacion, vigenciaDias) {
  if (!(fechaCreacion instanceof Date) || isNaN(fechaCreacion.getTime())) {
    console.error("Fecha inválida:", fechaCreacion);
    return null;
  }

  const fechaVencimiento = new Date(fechaCreacion);
  fechaVencimiento.setDate(fechaVencimiento.getDate() + parseInt(vigenciaDias || 0));

  return fechaVencimiento; // Devuelve un objeto Date
}

function esFechaVencida(fechaVencimiento) {
  if (!(fechaVencimiento instanceof Date) || isNaN(fechaVencimiento.getTime())) {
    console.error("Fecha de vencimiento inválida:", fechaVencimiento);
    return false;
  }

  // Obtener la fecha de hoy en formato "YYYY-MM-DD"
  const hoy = new Date();
  const fechaHoy = hoy.toISOString().split("T")[0]; // "YYYY-MM-DD"
  const fechaVence = fechaVencimiento.toISOString().split("T")[0]; // "YYYY-MM-DD"

  return fechaHoy === fechaVence;
}

function formatHour(hour) {
  let [hh, mm, ss] = hour.split(':');
  hh = parseInt(hh, 10);
  let period = hh >= 12 ? 'PM' : 'AM';
  hh = hh % 12 || 12; // Convierte 0 a 12 para el formato de 12 horas
  return `${hh}:${mm} ${period}`;
}

function calculateDuration(start, end) {
  let [startH, startM] = start.split(':').map(Number);
  let [endH, endM] = end.split(':').map(Number);

  let startMinutes = startH * 60 + startM;
  let endMinutes = endH * 60 + endM;
  let durationMinutes = endMinutes - startMinutes;

  if (durationMinutes < 0) {
    durationMinutes += 24 * 60; // Si pasa de medianoche, ajustar
  }

  let hours = Math.floor(durationMinutes / 60);
  let minutes = durationMinutes % 60;

  return `${hours} horas ${minutes > 0 ? minutes + 'minutos' : ''}`;
}

function formatDate(fecha) {
  const meses = [
    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
  ];

  let [year, month, day] = fecha.split('-');
  return `${parseInt(day)} de ${meses[parseInt(month) - 1]} de ${year}`;
}

function convertirTiempo(segundos) {
  let minutos = segundos / 60;
  let horas = Math.floor(minutos / 60);
  let minutosRestantes = Math.round(minutos % 60);

  return `${horas} horas y ${minutosRestantes} minutos`;
}

function calcularPrecioCostoBaseDuracion(duracionSegundos, costoBase) {
  // Convertir duración a horas
  let horas = duracionSegundos / 3600;

  let dificultad = "";
  let costoDificultad = 0;

  if (horas >= 3 && horas <= 5) {
    dificultad = "Baja";
    costoDificultad = 1000;
  } else if (horas >= 6 && horas <= 9) {
    dificultad = "Media";
    costoDificultad = 1700;
  } else if (horas >= 10 && horas <= 15) {
    dificultad = "Alta";
    costoDificultad = 2300;
  } else {
    dificultad = "Fuera de rango"; // Si no entra en ninguna categoría
  }

  let precioFinal = costoBase + costoDificultad;

  return {
    horasEstimadas: horas.toFixed(2), // Redondear a 2 decimales
    dificultad: dificultad,
    costoDificultad: costoDificultad,
    precioTotal: precioFinal
  };
}

function calcularPrecio(duracionSegundos) {
  // Convertir duración a horas y minutos
  let horas = Math.floor(duracionSegundos / 3600);
  let minutos = Math.round((duracionSegundos % 3600) / 60);

  let dificultad = "";
  let costoDificultad = 0;

  if (horas >= 3 && horas <= 5) {
    dificultad = "Baja";
    costoDificultad = 1000;
  } else if (horas >= 6 && horas <= 9) {
    dificultad = "Media";
    costoDificultad = 1700;
  } else if (horas >= 10 && horas <= 15) {
    dificultad = "Alta";
    costoDificultad = 2300;
  } else {
    dificultad = "Fuera de rango"; // Si no entra en ninguna categoría
  }

  return {
    horasEstimadas: `${horas} horas y ${minutos} minutos`,
    dificultad: dificultad,
    costoDificultad: costoDificultad,
  };
}

/* 
// Ejemplo de uso
$departamentoBase = 5000; // Precio base por departamento
$duracionSegundos = 13830.2; // Duración obtenida de la API (en segundos)

$resultado = calcularPrecio($departamentoBase, $duracionSegundos);
print_r($resultado);
 */

function calcularTiempoTranscurrido(fechaString) {
  const ahora = new Date();

  // Convertir fecha de entrada y fecha actual a UTC-5 (hora de Lima)
  const fecha = new Date(new Date(fechaString).toLocaleString("en-US", { timeZone: "America/Lima" }));
  const actual = new Date(ahora.toLocaleString("en-US", { timeZone: "America/Lima" }));

  const diferencia = Math.floor((actual - fecha) / 1000); // en segundos

  if (diferencia < 60) {
    return `hace ${diferencia} segundos`;
  } else if (diferencia < 3600) {
    const minutos = Math.floor(diferencia / 60);
    return `hace ${minutos} ${minutos === 1 ? "minuto" : "minutos"}`;
  } else if (diferencia < 86400) {
    const horas = Math.floor(diferencia / 3600);
    return `hace ${horas} ${horas === 1 ? "hora" : "horas"}`;
  } else {
    const dias = Math.floor(diferencia / 86400);
    return `hace ${dias} ${dias === 1 ? "día" : "días"}`;
  }
}

const convertirAHorasTotales = (hora) => {
  const [hh, mm, ss] = hora.split(":").map(Number);
  return hh * 60 + mm; // Convertimos a minutos totales
};

function obtenerSoloFechaHoraPeruSeparadaFormatoMysql() {
  // Obtener la fecha y hora en la zona horaria de Perú
  const fechaHoraPeru = new Date().toLocaleString("en-US", { timeZone: "America/Lima" });

  // Convertir a objeto Date
  const fechaObj = new Date(fechaHoraPeru);

  // Formatear la fecha a 'YYYY-MM-DD' (compatible con MySQL)
  const fechaPeru = fechaObj.toISOString().split("T")[0];

  // Formatear la hora a 'HH:MM:SS'
  const horaPeru = fechaObj.toTimeString().split(" ")[0];

  return { fecha: fechaPeru, hora: horaPeru };
}


