<?php
require_once '../vendor/autoload.php';

//use Mpdf\Mpdf;

try {
    // Crear instancia de mPDF
    
    // Configurar marca de agua de texto
    $mpdf = new \Mpdf\Mpdf();
    $mpdf->SetWatermarkText('CONFIDENCIAL');
    $mpdf->showWatermarkText = true;
    $mpdf->watermarkTextAlpha = 0.1; // Transparencia

    // Contenido del PDF (puedes incluir HTML y CSS)
    $html = '
        <h1>Reporte de Cotización</h1>
        <p>Cliente: <strong>Juan Pérez</strong></p>
        <p>Fecha: <strong>' . date('d/m/Y') . '</strong></p>
        <p>Detalles de la cotización:</p>
        <ul>
            <li>Servicio 1 - $100</li>
            <li>Servicio 2 - $200</li>
            <li>Servicio 3 - $150</li>
        </ul>
        <p>Total: <strong>$450</strong></p>
    ';

    // Agregar contenido al PDF
    $mpdf->WriteHTML($html);

    // Descargar el PDF
    $mpdf->Output('cotizacion.pdf', 'D'); // 'D' para descargar, 'I' para mostrar en navegador
} catch (\Mpdf\MpdfException $e) {
    echo "Error al generar el PDF: " . $e->getMessage();
}
?>
