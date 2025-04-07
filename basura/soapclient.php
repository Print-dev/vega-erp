<?php
$zipFile = file_get_contents('factura_firmada.zip');
$encodedZip = base64_encode($zipFile);

$xml_envio = '
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:sendBill>
         <fileName>factura_firmada.zip</fileName>
         <contentFile>' . $encodedZip . '</contentFile>
         <party>
            <ruc>20123456789</ruc>
            <user>USUARIO_SOL</user>
            <password>CLAVE_SOL</password>
         </party>
      </ser:sendBill>
   </soapenv:Body>
</soapenv:Envelope>';

$client = new SoapClient('https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService?wsdl'); // Cambiar a la URL de pruebas Beta
$response = $client->__doRequest($xml_envio, 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService', 'sendBill', 1); // URL Beta
var_dump($response); // Imprime la respuesta SOAP
file_put_contents('cdr.zip', base64_decode($response)); // Guarda la respuesta CDR
