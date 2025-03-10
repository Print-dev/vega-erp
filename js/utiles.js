
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