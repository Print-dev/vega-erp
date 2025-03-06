
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