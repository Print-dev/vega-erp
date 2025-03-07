
const obtenerFechaHoraPeru = () => {
  const fecha = new Date().toLocaleString("en-CA", { timeZone: "America/Lima" });
  const soloFecha = fecha.split(",");
  console.log("Fecha y hora actual en Perú:", soloFecha);
  return soloFecha;
};

function generarNuevoNCotizacion(ultimaCotizacion) {
  const añoActual = new Date().getFullYear(); // Obtiene el año actual

  if (!ultimaCotizacion) {
      // Si no hay registros previos, iniciamos con "0001"
      return `0001-${añoActual}`;
  }

  const ncotizacionAnterior = ultimaCotizacion.ncotizacion; // "0002-2025"
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
