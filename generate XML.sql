--GFE_XML
--SELECT XML_FORMAT, DOCUMENT_ID FROM GFE_DOCUMENTS ;

--CREATE TABLE test_xml(xml_blob BLOB);
SELECT * FROM test_xml


DECLARE
  xmldoc xmldom.DOMDocument;
  root_node xmldom.DOMNode;
BEGIN
  gfe_xml.getInvoiceType(p_xmldoc => xmldoc
                        ,p_root_node => root_node
                        ,p_organization_id => 101
                        ,p_document_id => 1);
END;

DECLARE
  l_xmltype XMLTYPE;
  xmldoc xmldom.DOMDocument;
  main_node xmldom.DOMNode;
  root_node xmldom.DOMNode;
  user_node xmldom.DOMNode;
  item_node xmldom.DOMNode;
  root_elmt xmldom.DOMElement;
  item_elmt xmldom.DOMElement;
  item_text xmldom.DOMText;

  xmlblob BLOB;

  clobdoc CLOB := ' ';
  CURSOR get_users(p_deptno NUMBER) IS
    SELECT empno
         , ename
         , deptno
         , rownum
      FROM demo.emp
     WHERE deptno = p_deptno;
BEGIN
  -- get document
  xmldoc := dbms_xmldom.newDOMDocument;  
  -- define prolog
  dbms_xmldom.setVersion( xmldoc, '1.0" encoding="UTF-8" standalone="no' );
  dbms_xmldom.setCharset( xmldoc, 'UTF-8' );
  -- create root element
  main_node := xmldom.makeNode(xmldoc);
  root_elmt := xmldom.createElement(xmldoc, 'fe:Invoice');
   xmldom.setAttribute(root_elmt, 'xmlns:fe', 'http://www.dian.gov.co/contratos/facturaelectronica/v1');
   xmldom.setAttribute(root_elmt, 'xmlns:cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2');
   xmldom.setAttribute(root_elmt, 'xmlns:cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2');
   xmldom.setAttribute(root_elmt, 'xmlns:clm54217', 'urn:un:unece:uncefact:codelist:specification:54217:2001');
   xmldom.setAttribute(root_elmt, 'xmlns:clm66411', 'urn:un:unece:uncefact:codelist:specification:66411:2001');
   xmldom.setAttribute(root_elmt, 'xmlns:clmIANAMIMEMediaType', 'urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003');
   xmldom.setAttribute(root_elmt, 'xmlns:ext', 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2');
   xmldom.setAttribute(root_elmt, 'xmlns:qdt', 'urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2');
   xmldom.setAttribute(root_elmt, 'xmlns:sts', 'http://www.dian.gov.co/contratos/facturaelectronica/v1/Structures');
   xmldom.setAttribute(root_elmt, 'xmlns:udt', 'urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2');
   xmldom.setAttribute(root_elmt, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
   xmldom.setAttribute(root_elmt, 'xsi:schemaLocation', 'http://www.dian.gov.co/contratos/facturaelectronica/v1 ../xsd/DIAN_UBL.xsd urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2 ../../ubl2/common/UnqualifiedDataTypeSchemaModule-2.0.xsd urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2 ../../ubl2/common/UBL-QualifiedDatatypes-2.0.xsd');
   --xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
   xmldom.setAttribute(root_elmt, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
  root_node := xmldom.appendChild(main_node, xmldom.makeNode(root_elmt));
  
  
  /*ext:UBLExtensions*/  user_node := xmldom.appendChild(root_node, gfe_xml.getUBLExtensions(p_xmldoc => xmldoc, p_root_node => root_node));
  /*cbc:UBLVersionID*/   user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:UBLVersionID'
                                                                                              ,p_element_text => 'UBL 2.0'
                                                                                              ,x_element => item_elmt));
  /*cbc:ProfileID*/      user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:ProfileID'
                                                                                              ,p_element_text => 'DIAN 1.0' 
                                                                                              ,x_element => item_elmt));
  /*cbc:ID*/             user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:ID'
                                                                                              ,p_element_text => '4171263356' 
                                                                                              ,x_element => item_elmt));
  /*cbc:UUID => @@@@@@@*/user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:UUID'
                                                                                              ,p_element_text => 'c1db672511b492915a6f88a2aeed9f2f7eae0f38' 
                                                                                              ,x_element => item_elmt));
                         xmldom.setAttribute(item_elmt, 'schemeAgencyID', '195');
                         xmldom.setAttribute(item_elmt, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');
  /*cbc:IssueDate*/      user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:IssueDate'
                                                                                              ,p_element_text => '2015-06-26' 
                                                                                              ,x_element => item_elmt));
  /*cbc:IssueTime*/      user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:IssueTime'
                                                                                              ,p_element_text => '22:19:12' 
                                                                                              ,x_element => item_elmt));
  /*cbc:InvoiceTypeCode*/user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:InvoiceTypeCode'
                                                                                              ,p_element_text => '1' 
                                                                                              ,x_element => item_elmt));
                                      xmldom.setAttribute(item_elmt, 'listAgencyID', '195');
                                      xmldom.setAttribute(item_elmt, 'listAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');
                                      xmldom.setAttribute(item_elmt, 'listSchemeURI', 'http://www.dian.gov.co/contratos/facturaelectronica/v1/InvoiceType');
  /*cbc:Note => @@@@@@@*/user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                              ,p_root_node => root_node
                                                                                              ,p_element_name => 'cbc:Note'
                                                                                              ,p_element_text => 'Lorem Ipsum dolor sit amet...' 
                                                                                              ,x_element => item_elmt));
  /*cbc:DocumentCurrencyCode*/user_node := xmldom.appendChild(root_node, gfe_xml.getTextOnlyElement(p_xmldoc => xmldoc
                                                                                                   ,p_root_node => root_node
                                                                                                   ,p_element_name => 'cbc:DocumentCurrencyCode'
                                                                                                   ,p_element_text => 'COP' 
                                                                                                   ,x_element => item_elmt));
  /*fe:AccountingSupplierParty*/user_node := xmldom.appendChild(root_node, gfe_xml.getAccountingSupplierParty(p_xmldoc => xmldoc, p_root_node => root_node, p_organization_id => 101));
  /*fe:AccountingCustomerParty*/user_node := xmldom.appendChild(root_node, gfe_xml.getAccountingCustomerParty(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id =>  1));
  /*fe:TaxTotal*/               user_node := xmldom.appendChild(root_node, gfe_xml.getTaxTotal(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => 1));
  /*fe:LegalMonetaryTotal*/     user_node := xmldom.appendChild(root_node, gfe_xml.getLegalMonetaryTotal(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => 1));
  /*fe:InvoiceLine*/            user_node := xmldom.appendChild(root_node, gfe_xml.getInvoiceLine(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => 1));
  --
  /*-- write document to file using default character set from database
    dbms_xmldom.writeCharacterOutputStream( (xmldoc, buf);
    xmldom.writeToFile(xmldoc,'C:\docSample.xml');*/

  --write document to Output
    l_xmltype := dbms_xmldom.getXmlType(xmldoc);
    --dbms_output.put_line(l_xmltype.getClobVal);
    --dbms_output.put_line(dbms_xmldom.getlength(l_xmltype));
    
    UPDATE gfe_documents SET xml_format = l_xmltype WHERE document_id = 1;
    COMMIT;

    --Convert XMLTYPE to BLOB
    xmlblob := utl_raw.cast_to_raw(l_xmltype.getClobVal());
    --INSERT INTO test_xml (xml_blob) VALUES (xmlblob);
    

  -- free resources
  dbms_xmldom.freeDocument(xmldoc);
  
END;
/
--#@#

UPDATE gfe_documents 
SET xml_format = XMLTYPE('<Warehouse whNo="100"> 
                           <Building>Owned</Building>
                          </Warehouse>')
WHERE document_id = 1;                          

-- deal with exceptions
EXCEPTION

WHEN xmldom.INDEX_SIZE_ERR THEN
  raise_application_error(-20120, 'Index Size error');
WHEN xmldom.DOMSTRING_SIZE_ERR THEN
  raise_application_error(-20120, 'String Size error');
WHEN xmldom.HIERARCHY_REQUEST_ERR THEN
  raise_application_error(-20120, 'Hierarchy request error');
WHEN xmldom.WRONG_DOCUMENT_ERR THEN
  raise_application_error(-20120, 'Wrong doc error');
WHEN xmldom.INVALID_CHARACTER_ERR THEN
  raise_application_error(-20120, 'Invalid Char error');
WHEN xmldom.NO_DATA_ALLOWED_ERR THEN
  raise_application_error(-20120, 'Nod data allowed error');
WHEN xmldom.NO_MODIFICATION_ALLOWED_ERR THEN
  raise_application_error(-20120, 'No mod allowed error');
WHEN xmldom.NOT_FOUND_ERR THEN
  raise_application_error(-20120, 'Not found error');
WHEN xmldom.NOT_SUPPORTED_ERR THEN
  raise_application_error(-20120, 'Not supported error');
WHEN xmldom.INUSE_ATTRIBUTE_ERR THEN
  raise_application_error(-20120, 'In use attr error');
END;
/




SELECT * FROM user_tables;
---
SELECT * FROM GFE_LOVS;
SELECT * FROM GFE_LOV_TRANSLATION;
SELECT * FROM GFE_LOV_VALUES;
SELECT * FROM GFE_ORG_PARAMETERS;
SELECT * FROM GFE_ORGS;


SELECT * FROM GFE_REQUESTED_DOCUMENTS;
SELECT * FROM GFE_REQ_DOCUMENT_LINES ; 
SELECT * FROM GFE_REQ_DOCUMENT_CUSTOMER ; 
SELECT * FROM GFE_REQ_DOCUMENT_TAXES ;
SELECT * FROM GFE_REQUEST_LOGS ;
SELECT * FROM GFE_REQUESTS ;  
SELECT * FROM GFE_DOCUMENTS ;

/*GFE_DOCUMENTS
select * from GFE_LOVS;
GFE_LOV_TRANSLATION
select * from GFE_LOV_VALUES;
select * from GFE_ORG_PARAMETERS FOR UPDATE;
select * from GFE_ORGS for update;
select * from GFE_REQ_DOCUMENT_CUSTOMER
select * from GFE_REQ_DOCUMENT_LINES;
SELECT * FROM GFE_REQ_DOCUMENT_TAXES for update
GFE_REQUESTED_DOCUMENTS
GFE_REQUEST_LOGS
GFE_REQUESTS*/

SELECT * FROM gsg.gsg_orgs


      SELECT org.type_code AdditionalAccountID
            ,org.fiscal_code||org.verification_digit ID
            ,orgs.name
            ,org.department Department
            --,[0..1]NULL CitySubdivisionName 
            ,org.city CityName
            ,org.legal_address AddressLine
            ,org.country CountryIdCode
            ,org.clasification_code TaxLevelCode --> 2.2.3.8 - Régimen: Régimen al que pertenece. (Común/Simplificado/No aplica)
            --,[0..1]NULL RegistrationNamE
        FROM gfe.gfe_orgs org
            ,gsg.gsg_orgs orgs
       WHERE org.organization_id = pn_organization_id
         AND orgs.organization_id = org.organization_id;
       

5e48e26456aa71cd1be102ea4a8de3b7038f409f37c21dc34  f6a5e441885f6a80369af74016b909f9a4ac73ada2d2d93

--[1..1]UBLExtensions
--[1..1]UBLVersionID
  --[0..1]CustomizationID
--[1..1]ProfileID
--[1..1]ID
--[1..1]UUID
--[1..1]IssueDate
--[1..1]IssueTime
--[1..1]InvoiceTypeCode
  --[0..*]Note
--[1.1]DocumentCurrencyCode
/*[1..1]AccountingSupplierParty>>>
    [1:1:]AdditionalAccountID: --GFE_LOVS:'Tipos de personas'_(persona natural/jurídica/gran contribuyente/otros)
    [1..1]Party
      [1..*]PartyIdentification:ID
      [0..1]PartyName:Name
      [1..1]PhysicalLocation
        [1..1]PhysicalLocation:Address:Department
        [0..1]PhysicalLocation:Address:CitySubdivisionName: 
        [0..1]PhysicalLocation:Address:CityName
        [0..1]PhysicalLocation:Address:AddressLine:Line
        [0..1]PhysicalLocation:Address:Country:IdentificationCode
      [1:1:]PartyTaxScheme
        [1..1]PartyTaxScheme:TaxLevelCode --GFE_LOVS:'Tipos de personas'_(Común/Simplificado/No aplica)
        [1..1]PartyTaxScheme:TaxScheme --> No usado por la DIAN, las partes pueden definir un significado o simplemente poner un elemento vacío ya que es obligatorio en UBL 
        [0..1]PartyLegalEntity:RegistrationName*/
      --> Es importante validar el TaxLevelCode y como se relaciona con AccountingCustomerParty ?
    SELECT rdc.type_code AdditionalAccountID  --*
          ,rdc.fiscal_code||rdc.verification_digit ID -->2.2.3.1 - Identificador fiscal: Número completo de Identificación Tributaria o similar. En Colombia, el NIT
          ,rdc.first_name||' '||rdc.middle_name||' '||rdc.last_name NAME --> 2.1.10 / 2.2.10 - Nombre Comercial: Nombre comercial, por ejemplo, si es una persona física el nombre de su establecimiento, debe incluir la referencia completa
          ,rdc.department Department
          --,NULL CitySubdivisionName [0:1]
          ,rdc.city CityName
          ,rdc.legal_address AddressLine
          ,rdc.country CountryIdCode
          ,rdc.clasification_code TaxLevelCode --> 2.2.3.8 - Régimen: Régimen al que pertenece. (Común/Simplificado/No aplica)
          --,NULL RegistrationName [0:1]
      FROM gfe_req_document_customer rdc
     WHERE rdc.document_id = 1;
/*[1..1]AccountingCustomerParty>>>
  */

SELECT * FROM gfe_req_document_customer rdc WHERE rdc.document_id = 1

cbc:TaxAmount
cbc:TaxEvidenceIndicator
cbc:TaxableAmount
cbc:TaxAmount
cbc:Percent
cac:TaxCategory

SELECT rt.tax_amount AS TaxAmount
      ,rt.tax_indicator AS TaxEvidenceIndicator
      ,rt.base_amount AS TaxableAmount
      ,rt.tax_amount AS TaxAmount
      ,rt.percent_value AS Percent
      ,rt.tax_category AS TaxCategory
  FROM gfe_req_document_taxes rt
 WHERE rt.document_id = p_document_id
;


--LegalMonetaryTotal
  --LineExtensionAmount -> SUM(importes_brutos_lineas)
  --TaxExclusiveAmount  -> Importe Bruto+Cargos-Descuentos
  --PayableAmount       -> Total importe bruto+Total Impuestos-Total Impuesto Retenidos

SELECT (rdl.quanqity*rdl.amount)
  FROM GFE_REQ_DOCUMENT_LINES rdl
     ;


cbc:LineExtensionAmount
cbc:TaxExclusiveAmount
cbc:PayableAmount


--InvoiceLineType
  --cbc:ID                   -> # Linea
  --cbc:InvoicedQuantity     -> Cantidad del artículo solicitado
  --cbc:LineExtensionAmount  -> Unidad de Medida x Precio Unidad
  --cbc:Description          -> Descripción del artículo
  --cbc:PriceAmount          -> Precio unitario de la unidad de bien o servicio servido/prestado
  --SELECT gfe_xml.getDocumentCurrencyCode(1) FROM dual;
  SELECT rdl.line_number AS ID                 
        ,rdl.quantity    AS InvoicedQuantity   
        ,rdl.amount      AS LineExtensionAmount
        ,rdl.description AS Description       
        ,NULL /*rdl.unit_price*/ AS PriceAmount        
    FROM gfe_req_document_lines rdl
   WHERE rdl.document_id = 1
   ORDER BY rdl.line_number;
  --cbc:currency             -> 


/*
SELECT * FROM sys.utl:file;
CREATE DIRECTORY MY_DIR AS 'C:\';
GRANT READ ON DIRECTORY MY_DIR TO demo;
http://www.akadia.com/download/documents/create_xml_docs_xmldom.txt
*/
