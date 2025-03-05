
const obtenerFechaHoraPeru = () => {
  const fecha = new Date().toLocaleString("en-CA", { timeZone: "America/Lima" });
  const soloFecha = fecha.split(",");
  console.log("Fecha y hora actual en Perú:", soloFecha);
  return soloFecha;
};