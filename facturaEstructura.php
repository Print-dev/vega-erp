<?php
// Cargar configuración

$xmlContent = '
<?xml version="1.0" encoding="UTF-8"?>
<Invoice xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ds="http://www.w3.org/2000/09/xmldsig#">

    <ext:UBLExtensions>
        <ext:UBLExtension>
            <ext:ExtensionContent>
                <ds:Signature Id="signatureKG">
                    <ds:SignedInfo>
                        <ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
                        <ds:SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
                        <ds:Reference URI="">
                        <ds:Transforms>
                            <ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                        </ds:Transforms>
                        <ds:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
                        <ds:DigestValue>+pruib33lOapq6GSw58GgQLR8VGIGqANloj4EqB1cb4=</ds:DigestValue>
                        </ds:Reference>
                    </ds:SignedInfo>
                    <ds:SignatureValue>Oatv5xMfFInuGqiX9SoLDTy2yuLf0tTlMFkWtkdw1z/Ss6kiDz+vIgZhgKfIaxp+JbVy57GT5
                    0VLMLatdwPVRbrWmz1/NIy5CWp1xWMaM6fC/9SXV0O1Lqopk0UeX2I2yuf05QhmVfjgUu6GnS3m6
                    o6zM9J36iDvMVZyj7vbJTwI8SfWjTSNqxXlqPQ==</ds:SignatureValue>
                    <ds:KeyInfo>
                        <ds:X509Data>
                            <ds:X509Certificate> MIIE8TCCA9mgAwIBAgICIMEwDQYJKoZIhvcNAQEFBQAwggENMRswGQYKCZImiZPy LGQBGRYLTExBTUEuUEUgU0ExCzAJBgNVBAYTAlBFMQ0wCwYDVQQIDARMSU1BMQ0w CwYDVQQHDARMSU1BMRgwFgYDVQQKDA9UVSBFTVBSRVNBIFMuQS4xRTBDBgNVBAsM PEROSSA5OTk5OTk5IFJVQyAyMDU1MzUxMDY2MSAtIENFUlRJRklDQURPIFBBUkEg REVNT1NUUkFDScOTTjFEMEIGA1UEAww7Tk9NQlJFIFJFUFJFU0VOVEFOVEUgTEVH QUwgLSBDRVJUSUZJQ0FETyBQQVJBIERFTU9TVFJBQ0nDk04xHDAaBgkqhkiG9w0B CQEWDWRlbW9AbGxhbWEucGUwHhcNMTgwNjAxMDM1OTQyWhcNMjAwNTMxMDM1OTQy WjCCAQ0xGzAZBgoJkiaJk/IsZAEZFgtMTEFNQS5QRSBTQTELMAkGA1UEBhMCUEUx DTALBgNVBAgMBExJTUExDTALBgNVBAcMBExJTUExGDAWBgNVBAoMD1RVIEVNUFJF U0EgUy5BLjFFMEMGA1UECww8RE5JIDk5OTk5OTkgUlVDIDIwNTUzNTEwNjYxIC0g Q0VSVElGSUNBRE8gUEFSQSBERU1PU1RSQUNJw5NOMUQwQgYDVQQDDDtOT01CUkUg UkVQUkVTRU5UQU5URSBMRUdBTCAtIENFUlRJRklDQURPIFBBUkEgREVNT1NUUkFD ScOTTjEcMBoGCSqGSIb3DQEJARYNZGVtb0BsbGFtYS5wZTCCASIwDQYJKoZIhvcN AQEBBQADggEPADCCAQoCggEBAOcTW/TzaLk8qiVOCekHvo9uLfoEK97dkNrm6jO/ qUF8FdTkxxT+ORHGM9ZkvTJ3N0iWO38AA4z/Pi91pWhD4YgapdqOGp1tcwPnI1Ko S+B6IO4k/Pe4Pn8AU9tao6Wy3ayrGrxHQnU597IlCcZo5i5ts2GEPRjxT9LY/ekk jYTlYif2Yjf2icac9g1XlTWeL4mYxH51p4Hx4/3zfACF6WqN17uVQLwQgPDneehX Myy1ja7MSocopedXmTwGFzO1h41+MBqOb30GbjnRBbSk+g6anFHospNYAWifiEen WYN+uBWV/b8u2H0U0TNCpad/yYu7ZzPIZ3WJO4fVf1my6MUCAwEAAaNXMFUwHQYD VR0OBBYEFDTCxehgCuNRd5lZbmDMWu/NJwO5MB8GA1UdIwQYMBaAFDTCxehgCuNR d5lZbmDMWu/NJwO5MBMGA1UdJQQMMAoGCCsGAQUFBwMBMA0GCSqGSIb3DQEBBQUA A4IBAQDiGBnjqaW+zJHeRvuvjFnPOzvluRh5NNQrbsupZOLAg+IuHepxL2PUUoFm kyXHysHMUtyJNPfpXyUlj0FAR2IJ0L2arnH7lIgH9zmSA7/oePd2XW4dd58HeIg0 S5Wl05ATsc8rgFo5yRw6i86pdBleHMYrDCq1NvPECOszNOsEnvdHcRA2sQsDTDLM xoOs3IN97qVKNE50H+A8FIxu2Mo/0MAm6dvDEYSKLh3HVIcAlJrU8XNW2d6zMydc XLMDpNRAQ3Al2ETRVeX6F4MPP5XVJBaN/G/2pe1SuNN4uOLuNevteRCZfvUkthl1 74yu5W8RhIvhEdKYGIoii5wRb3yc </ds:X509Certificate>
                        </ds:X509Data>
                    </ds:KeyInfo>
                </ds:Signature>
            </ext:ExtensionContent>
        </ext:UBLExtension>
    </ext:UBLExtensions>
    <cbc:UBLVersionID>2.1</cbc:UBLVersionID>
    <cbc:CustomizationID>2.0</cbc:CustomizationID>
    <cbc:ProfileID
        schemeName=" SUNAT:Identificador de Tipo de Operación"
        schemeAgencyName="PE:SUNAT"
        schemeURI=" urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo17" >0101</cbc:ProfileID>
    <cbc:ID>F002-10</cbc:ID>
    <cbc:IssueDate>2017-04-28</cbc:IssueDate>
    <cbc:IssueTime>11:40:21</cbc:IssueTime>
    <cbc:DueDate>2017-05-28</cbc:DueDate>
    <cbc:InvoiceTypeCode
        listAgencyName="PE:SUNAT"
        listName="SUNAT:Identificador de Tipo de Documento"
        listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01">01</cbc:InvoiceTypeCode>
    <cbc:Note
        languageLocaleID="1000">MIL OCHOCIENTOS CINCUENTA Y OCHO CON 59/100 Soles</cbc:Note>
        <cbc:Note
        languageLocaleID="3000">05010020170428000005</cbc:Note>
    <cbc:DocumentCurrencyCode
        listID="ISO 4217 Alpha"
        listName="Currency"
        listAgencyName="United Nations Economic Commission for Europe">PEN</cbc:DocumentCurrencyCode>
    <cac:DespatchDocumentReference>
        <cbc:ID>031-002020</cbc:ID>
        <cbc:DocumentTypeCode
        listAgencyName="PE:SUNAT"
        listName="SUNAT:Identificador de guía relacionada"
        listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01">09</cbc:DocumentTypeCode>
    </cac:DespatchDocumentReference>
    <cac:AdditionalDocumentReference>
        <cbc:ID>024099</cbc:ID>
        <cbc:DocumentTypeCode
        listAgencyName="PE:SUNAT"
        listName="SUNAT: Identificador de documento relacionado"
        listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo12">99</cbc:DocumentTypeCode>
    </cac:AdditionalDocumentReference>
    <cac:AccountingSupplierParty>
        <cac:Party>
            <cac:PartyName>
                <cbc:Name><![CDATA[K&G Laboratorios]]></cbc:Name>
            </cac:PartyName>
            <cac:PartyTaxScheme>
                <cbc:RegistrationName><![CDATA[K&G Asociados S. A.]]></cbc:RegistrationName>
                <CompanyID
                    schemeID="6"
                    schemeName="SUNAT:Identificador de Documento de Identidad"
                    schemeAgencyName="PE:SUNAT"
                    schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">20100113612</CompanyID>
                <cac:TaxScheme>
                    <cbc:ID>-</cbc:ID>
                </cac:TaxScheme>
                <cac:RegistrationAddress>
                    <cbc:AddressTypeCode>0001</cbc:AddressTypeCode>
                </cac:RegistrationAddress>
            </cac:PartyTaxScheme>
        </cac:Party>
    </cac:AccountingSupplierParty>
    <cac:AccountingCustomerParty>
        <cac:Party>
            <cac:PartyTaxScheme>
                <cbc:RegistrationName><![CDATA[CECI FARMA IMPORT S.R.L.]]></cbc:RegistrationName>
                <cbc:CompanyID
                    schemeID="6"
                    schemeName="SUNAT:Identificador de Documento de Identidad"
                    schemeAgencyName="PE:SUNAT"
                    schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">20102420706</cbc:CompanyID>
                <cac:TaxScheme>
                    <cbc:ID>-</cbc:ID>
                </cac:TaxScheme>
            </cac:PartyTaxScheme>
        </cac:Party>
    </cac:AccountingCustomerParty>
    <cac:DeliveryTerms>
        <cac:DeliveryLocation >
            <cac:Address>
                <cbc:StreetName>CALLE NEGOCIOS # 420</cbc:StreetName>
                <cbc:CitySubdivisionName/>
                <cbc:CityName>LIMA</cbc:CityName>
                <cbc:CountrySubentity>LIMA</cbc:CountrySubentity>
                <cbc:CountrySubentityCode>150141</cbc:CountrySubentityCode>
                <cbc:District>SURQUILLO</cbc:District>
                <cac:Country>
                    <cbc:IdentificationCode
                    listID="ISO 3166-1"
                    listAgencyName="United Nations Economic Commission for Europe"
                    listName="Country">PE</cbc:IdentificationCode>
                </cac:Country>
            </cac:Address>
        </cac:DeliveryLocation >
    </cac:DeliveryTerms>
    <cac:AllowanceCharge>
        <cbc:ChargeIndicator>False</cbc:ChargeIndicator>
        <cbc:AllowanceChargeReasonCode>00</cbc:AllowanceChargeReasonCode>
        <cbc:Amount currencyID="PEN">60.00</cbc:Amount>
        <cbc:BaseAmount currencyID="PEN">1439.48</cbc:BaseAmount>
    </cac:AllowanceCharge>
    <cac:TaxTotal>
        <cbc:TaxAmount currencyID="PEN">259.11</cbc:TaxAmount>
        <cac:TaxSubtotal>
            <cbc:TaxableAmount currencyID="PEN">1439.48</cbc:TaxableAmount>
            <cbc:TaxAmount currencyID="PEN">259.11</cbc:TaxAmount>
            <cac:TaxCategory>
                <cbc:ID
                    schemeID="UN/ECE 5305"
                    schemeName="Tax Category Identifier"
                    schemeAgencyName="United Nations Economic Commission for Europe">S</cbc:ID>
                <cac:TaxScheme>
                    <cbc:ID schemeID="UN/ECE 5305" schemeAgencyID="6">1000</cbc:ID>
                    <cbc:Name>IGV</cbc:Name>
                    <cbc:TaxTypeCode>VAT</cbc:TaxTypeCode>
                </cac:TaxScheme>
            </cac:TaxCategory>
        </cac:TaxSubtotal>
        <cac:TaxSubtotal>
            <cbc:TaxableAmount currencyID="PEN">320.00</cbc:TaxableAmount>
            <cbc:TaxAmount currencyID="PEN">0.00</cbc:TaxAmount>
            <cac:TaxCategory>
                <cbc:ID
                schemeID="UN/ECE 5305"
                schemeName="Tax Category Identifier"
                schemeAgencyName="United Nations Economic Commission for Europe">E</cbc:ID>
                <cac:TaxScheme>
                    <cbc:ID schemeID="UN/ECE 5305" schemeAgencyID="6">9997</cbc:ID>
                    <cbc:Name>EXONERADO</cbc:Name>
                    <cbc:TaxTypeCode>VAT</cbc:TaxTypeCode>
                </cac:TaxScheme>
            </cac:TaxCategory>
        </cac:TaxSubtotal>
    </cac:TaxTotal>
    <cac:LegalMonetaryTotal>
        <cbc:LineExtensionAmount currencyID="PEN">1439.48</cbc:LineExtensionAmount>
        <cbc:TaxInclusiveAmount currencyID="PEN">1698.59</cbc:TaxInclusiveAmount>
        <cbc:AllowanceTotalAmount currencyID="PEN">60.00</cbc:AllowanceTotalAmount>
        <cbc:ChargeTotalAmount currencyID="PEN">320.00</cbc:ChargeTotalAmount>
        <cbc:PrepaidAmount currencyID="PEN">100.00</cbc:PrepaidAmount>
        <cbc:PayableAmount currencyID="PEN">1858.59</cbc:PayableAmount>
    </cac:LegalMonetaryTotal>
    
</Invoice>';

$documento = new DOMDocument('1.0', 'UTF-8');
$documento->loadXML($xmlContent);
$documento->formatOutput = true;

// Guardar XML
$xmlFile = 'factura_firmada.xml';
$documento->save($xmlFile);

echo "Factura firmada generada: $xmlFile";
?>
