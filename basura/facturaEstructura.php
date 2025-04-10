<?php

$xmlContent = '<?xml version="1.0" encoding="UTF-8"?>
<Invoice xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
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
                    <ds:SignatureValue></ds:SignatureValue>
                    <ds:KeyInfo>
                        <ds:X509Data>
                            <ds:X509Certificate></ds:X509Certificate>
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
    <cbc:ID>F002-00001</cbc:ID>
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
    <cac:InvoiceLine>
        <cbc:ID>1</cbc:ID>
        <cbc:InvoicedQuantity
        unitCode="CS"
        unitCodeListID="UN/ECE rec 20"
        unitCodeListAgencyName="United Nations Economic Commission for Europe">50</cbc:InvoicedQuantity>
        <cbc:LineExtensionAmount currencyID="PEN">1439.48</cbc:LineExtensionAmount>
        <cac:PricingReference>
            <cac:AlternativeConditionPrice>
                <cbc:PriceAmount currencyID="PEN">34.99</cbc:PriceAmount>
                <cbc:PriceTypeCode
                listName="SUNAT:Indicador de Tipo de Precio"
                listAgencyName="PE:SUNAT"
                listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo16">01</cbc:PriceTypeCode>
            </cac:AlternativeConditionPrice>
        </cac:PricingReference>
        <cac:PricingReference>
            <cac:AlternativeConditionPrice>
                <cbc:PriceAmount currencyID="PEN">250.00</cbc:PriceAmount>
                <cbc:PriceTypeCode
                listName="SUNAT:Indicador de Tipo de Precio"
                listAgencyName="PE:SUNAT"
                listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo16">02</cbc:PriceTypeCode>
            </cac:AlternativeConditionPrice>
        </cac:PricingReference>
        <cac:AllowanceCharge>
            <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
            <cbc:AllowanceChargeReasonCode>00</cbc:AllowanceChargeReasonCode>
            <cbc:Amount currencyID="PEN">143.95</cbc:Amount>
            <cbc:BaseAmount currencyID="PEN">1439.48</cbc:BaseAmount>
        </cac:AllowanceCharge>
        <cac:AllowanceCharge>
            <cbc:ChargeIndicator>true</cbc:ChargeIndicator>
            <cbc:AllowanceChargeReasonCode>50</cbc:AllowanceChargeReasonCode>
            <cbc:MultiplierFactorNumeric>0.10</cbc:MultiplierFactorNumeric>
            <cbc:Amount currencyID="PEN">44.82</cbc:Amount>
            <cbc:BaseAmount currencyID="PEN">448.20</cbc:BaseAmount>
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
                        <cbc:Percent>18.00</cbc:Percent>
                    <cbc:TaxExemptionReasonCode
                    listAgencyName="PE:SUNAT"
                    listName="SUNAT:Codigo de Tipo de Afectación del IGV"
                    listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo07">10</cbc:TaxExemptionReasonCode>
                    <cac:TaxScheme>
                        <cbc:ID schemeID="UN/ECE 5153" schemeName="Tax Scheme Identifier"
                            schemeAgencyName="United Nations Economic Commission for
                            Europe">1000</cbc:ID>
                        <cbc:Name>IGV</cbc:Name>
                        <cbc:TaxTypeCode>VAT</cbc:TaxTypeCode>
                    </cac:TaxScheme>
                </cac:TaxCategory>
            </cac:TaxSubtotal>
        </cac:TaxTotal>
        <cac:TaxTotal>
            <cbc:TaxAmount currencyID="PEN">1750.52</cbc:TaxAmount>
            <cac:TaxSubtotal>
                <cbc:TaxableAmount currencyID="PEN">8752.60</cbc:TaxableAmount>
                <cbc:TaxAmount currencyID="PEN">1750.52</cbc:TaxAmount>
                <cac:TaxCategory>
                <cbc:ID
                schemeID="UN/ECE 5305"
                schemeName="Tax Category Identifier"
                schemeAgencyName="United Nations Economic Commission for Europe">S</cbc:ID>
                    <cbc:Percent>20.00</cbc:Percent>
                <cbc:TaxExemptionReasonCode
                listAgencyName="PE:SUNAT"
                listName="SUNAT:Codigo de Tipo de Afectación del IGV"
                listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo07">10</cbc:TaxExemptionReasonCode>
                <cac:TierRange>01</cac:TierRange>
                <cac:TaxScheme>
                <cbc:ID schemeID="UN/ECE 5153" schemeName="Tax Scheme Identifier"
                schemeAgencyName="United Nations Economic Commission for
                Europe">2000</cbc:ID>
                <cbc:Name>ISC</cbc:Name>
                <cbc:TaxTypeCode>EXC</cbc:TaxTypeCode>
                </cac:TaxScheme>
                </cac:TaxCategory>
            </cac:TaxSubtotal>
        </cac:TaxTotal>
        <cac:Item>
            <cbc:Description><![CDATA[CAPTOPRIL 1000mg X 30]]></cbc:Description>
            <cbc:SellersItemIdentification>
                <ID>Cap-258963</ID>
            </cbc:SellersItemIdentification>
            <cac:CommodityClassification>
                <ItemClassificationCode
                listID="UNSPSC"
                listAgencyName="GS1 US"
                listName="Item Classification">51121703</ItemClassificationCode>
            </cac:CommodityClassification>
            <cac:AdditionalItemProperty >
                <Name>Gastos Art. 37 Renta: Número de Placa</Name>
                <NameCode
                listName="SUNAT :Identificador de la propiedad del ítem"
                listAgencyName="PE:SUNAT">7000</NameCode>
                <Value>B6F-045</Value>
            </cac:AdditionalItemProperty>
        </cac:Item>
        <cac:Price>            
            <cbc:PriceAmount CurrencyID="PEN">785.20</cbc:PriceAmount>            
        </cac:Price>
    </cac:InvoiceLine>
</Invoice>';

$documento = new DOMDocument('1.0', 'UTF-8');
$documento->loadXML($xmlContent);
$documento->formatOutput = true;



// Guardar XML
$xmlFile = '20608627422-01-F001-000001.xml';
$documento->save($xmlFile);

echo "Factura firmada generada: $xmlFile";
