CREATE OR REPLACE PACKAGE gfe_xml IS

  -- Author  : ediaz@gsg-sa.com
  -- Created : 29/03/2017 3:57:35 p. m.
  -- Purpose : 
  
  FUNCTION getDocumentCurrencyCode(p_document_id IN NUMBER) RETURN VARCHAR2;

  FUNCTION getTextOnlyElement( p_xmldoc xmldom.DOMDocument 
                              ,p_root_node xmldom.DOMNode
                              ,p_element_name VARCHAR2
                              ,p_element_text VARCHAR2
                              ,x_element OUT xmldom.DOMElement
                             ) RETURN xmldom.DOMNode; 

  FUNCTION getUBLExtensions( p_xmldoc xmldom.DOMDocument, p_root_node xmldom.DOMNode) RETURN xmldom.DOMNode;
  
  FUNCTION getAccountingSupplierParty( p_xmldoc IN xmldom.DOMDocument
                                     , p_root_node IN xmldom.DOMNode
                                     , p_organization_id IN NUMBER) RETURN xmldom.DOMNode;

  FUNCTION getAccountingCustomerParty( p_xmldoc IN xmldom.DOMDocument
                                     , p_root_node IN xmldom.DOMNode
                                     , p_document_id IN NUMBER) RETURN xmldom.DOMNode;
  
  FUNCTION getTaxTotal( p_xmldoc IN xmldom.DOMDocument
                      , p_root_node IN xmldom.DOMNode
                      , p_document_id IN NUMBER) RETURN xmldom.DOMNode;
  
  FUNCTION getLegalMonetaryTotal( p_xmldoc IN xmldom.DOMDocument
                                , p_root_node IN xmldom.DOMNode
                                , p_document_id IN NUMBER ) RETURN xmldom.DOMNode;
  
  FUNCTION getInvoiceLine( p_xmldoc IN xmldom.DOMDocument
                         , p_root_node IN xmldom.DOMNode
                         , p_document_id IN NUMBER) RETURN xmldom.DOMNode;

  PROCEDURE getInvoiceType(p_xmldoc IN xmldom.DOMDocument
                          ,p_root_node IN xmldom.DOMNode
                          ,p_organization_id IN NUMBER
                          ,p_document_id IN NUMBER);


END gfe_xml;
/
CREATE OR REPLACE PACKAGE BODY gfe_xml IS

  FUNCTION getDocumentCurrencyCode(p_document_id IN NUMBER) RETURN VARCHAR2 IS
    x_currency_code gfe_requested_documents.currency_code%TYPE;
  BEGIN

    BEGIN
      SELECT grd.currency_code
        INTO x_currency_code
        FROM gfe_requested_documents grd
       WHERE grd.document_id = p_document_id;
    EXCEPTION
      WHEN OTHERS THEN   
        x_currency_code := '';
    END;
    
    RETURN x_currency_code;
    
  END getDocumentCurrencyCode;

  FUNCTION getTextOnlyElement( p_xmldoc IN xmldom.DOMDocument 
                              ,p_root_node in xmldom.DOMNode
                              ,p_element_name IN VARCHAR2
                              ,p_element_text IN VARCHAR2
                              ,x_element OUT xmldom.DOMElement
                              ) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    user_node xmldom.DOMNode;
    item_node xmldom.DOMNode;
    item_text xmldom.DOMText;
  BEGIN
    --xyz:ElementName>>>
    item_elmt := xmldom.createElement(p_xmldoc, p_element_name);
    user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
    item_text := xmldom.createTextNode(p_xmldoc, p_element_text);
    item_node := xmldom.appendChild(user_node, xmldom.makeNode(item_text));
    x_element := item_elmt;
    --xyz:ElementName<<<
    RETURN user_node;
  END getTextOnlyElement;

  FUNCTION getUBLExtensions( p_xmldoc xmldom.DOMDocument, p_root_node xmldom.DOMNode) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    item_elmt_sub6 xmldom.DOMElement;
    item_elmt_sub7 xmldom.DOMElement;
    item_elmt_sub8 xmldom.DOMElement;
    item_elmt_sub9 xmldom.DOMElement;
    item_elmt_sub10 xmldom.DOMElement;
    item_elmt_sub11 xmldom.DOMElement;
    item_elmt_sub12 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    user_node_sub6 xmldom.DOMNode;
    user_node_sub7 xmldom.DOMNode;
    user_node_sub8 xmldom.DOMNode;
    user_node_sub9 xmldom.DOMNode;
    user_node_sub10 xmldom.DOMNode;
    user_node_sub11 xmldom.DOMNode;
    user_node_sub12 xmldom.DOMNode;    
  BEGIN
    --ext:UBLExtensions>>>
    item_elmt := xmldom.createElement(p_xmldoc, 'ext:UBLExtensions');
    user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));

      --ext:UBLExtension>>>
      item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'ext:UBLExtension');
      user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
        --ext:ExtensionContent
        item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'ext:ExtensionContent');
        user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
          --sts:DianExtensions
          item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'sts:DianExtensions');
          user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub3));
            --sts:InvoiceControl
            item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'sts:InvoiceControl');
            user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
              --sts:InvoiceAuthorization
              user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub4
                                                  ,p_element_name => 'sts:InvoiceAuthorization'
                                                  ,p_element_text => '545939'
                                                  ,x_element => item_elmt_sub5);
              --sts:AuthorizationPeriod
              item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'sts:AuthorizationPeriod');
              user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
                --cbc:StartDate
                user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub5
                                                    ,p_element_name => 'cbc:StartDate'
                                                    ,p_element_text => '2013-09-06'
                                                    ,x_element => item_elmt_sub6);
                --cbc:EndDate
                user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub5
                                                    ,p_element_name => 'cbc:EndDate'
                                                    ,p_element_text => '2015-09-06'
                                                    ,x_element => item_elmt_sub6);
              --sts:AuthorizedInvoices
              item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'sts:AuthorizedInvoices');
              user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
                --sts:Prefix
                user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub5
                                                    ,p_element_name => 'sts:Prefix'
                                                    ,p_element_text => '41'
                                                    ,x_element => item_elmt_sub6);
                --sts:From
                user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub5
                                                    ,p_element_name => 'sts:From'
                                                    ,p_element_text => '70263356'
                                                    ,x_element => item_elmt_sub6);
                --sts:To
                user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub5
                                                    ,p_element_name => 'sts:To'
                                                    ,p_element_text => '79999999'
                                                    ,x_element => item_elmt_sub6);
            --sts:InvoiceSource
            item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'sts:InvoiceSource');
            user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
              --cbc:IdentificationCode
              user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub4
                                                  ,p_element_name => 'cbc:IdentificationCode'
                                                  ,p_element_text => 'CO'
                                                  ,x_element => item_elmt_sub5);
              xmldom.setAttribute(item_elmt_sub5, 'listAgencyID', '6');
              xmldom.setAttribute(item_elmt_sub5, 'listAgencyName', 'United Nations Economic Commission for Europe');
              xmldom.setAttribute(item_elmt_sub5, 'listSchemeURI', 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdent  ificationCode-2.0');
            --sts:SoftwareProvider
            item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'sts:SoftwareProvider');
            user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
              --sts:ProviderID
              user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub4
                                                  ,p_element_name => 'sts:ProviderID'
                                                  ,p_element_text => '700085371'
                                                  ,x_element => item_elmt_sub5);
                                xmldom.setAttribute(item_elmt_sub5, 'schemeAgencyID', '195');
                                xmldom.setAttribute(item_elmt_sub5, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');
              --sts:SoftwareID
              user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub4
                                                  ,p_element_name => 'sts:SoftwareID'
                                                  ,p_element_text => '248c088c-abae-49d5-864f-00f3bba701e3'
                                                  ,x_element => item_elmt_sub5);
                                xmldom.setAttribute(item_elmt_sub5, 'schemeAgencyID', '195');
                                xmldom.setAttribute(item_elmt_sub5, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');

            --sts:SoftwareSecurityCode
            user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                ,p_root_node => user_node_sub3
                                                ,p_element_name => 'sts:SoftwareSecurityCode'
                                                ,p_element_text => '5e48e26456aa71cd1be102ea4a8de3b7038f409f37c21dc34  f6a5e441885f6a80369af74016b909f9a4ac73a da2d2d93'
                                                ,x_element => item_elmt_sub4);
                              xmldom.setAttribute(item_elmt_sub4, 'schemeAgencyID', '195');
                              xmldom.setAttribute(item_elmt_sub4, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');

      --ext:UBLExtension>>>
      item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'ext:UBLExtension');
      user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
        --ext:ExtensionContent
        item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'ext:ExtensionContent');
        user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
        --ds:Signature
        item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'ds:Signature');
        user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub3));
        --xmldom.setAttribute(item_elmt_sub3, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');       
        xmldom.setAttribute(item_elmt_sub3, 'Id', 'xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466d');
          --ds:SignedInfo
          item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'ds:SignedInfo');
          user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
            --ds:CanonicalizationMethod
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:CanonicalizationMethod');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'Algorithm', 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315');
            --ds:SignatureMethod
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:SignatureMethod');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#rsa-sha1');
            --ds:Reference
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:Reference');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'Id', 'xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466d-ref0');
            xmldom.setAttribute(item_elmt_sub5, 'URI', '');
              --ds:Transforms
              item_elmt_sub6 := xmldom.createElement(p_xmldoc, 'ds:Transforms');
              user_node_sub6 := xmldom.appendChild(user_node_sub5, xmldom.makeNode(item_elmt_sub6));
                --ds:Transform
                item_elmt_sub7 := xmldom.createElement(p_xmldoc, 'ds:Transform');
                user_node_sub7 := xmldom.appendChild(user_node_sub6, xmldom.makeNode(item_elmt_sub7));
                xmldom.setAttribute(item_elmt_sub7, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#enveloped-signature');
              --ds:DigestMethod
              item_elmt_sub6 := xmldom.createElement(p_xmldoc, 'ds:DigestMethod');
              user_node_sub6 := xmldom.appendChild(user_node_sub5, xmldom.makeNode(item_elmt_sub6));
              xmldom.setAttribute(item_elmt_sub6, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');
              --ds:DigestValue
              user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub5
                                                  ,p_element_name => 'ds:DigestValue'
                                                  ,p_element_text => '21GME6Y4G7l+35aMpi+nzB/Di88='
                                                  ,x_element => item_elmt_sub6);
            --ds:Reference
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:Reference');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'URI', '#xmldsig-87d128b5-aa31-4f0b-8e45-3d9cfa0eec26-keyinfo');
              --ds:DigestMethod
              item_elmt_sub6 := xmldom.createElement(p_xmldoc, 'ds:DigestMethod');
              user_node_sub6 := xmldom.appendChild(user_node_sub5, xmldom.makeNode(item_elmt_sub6));
              xmldom.setAttribute(item_elmt_sub6, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');
              --ds:DigestValue
              user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub5
                                                  ,p_element_name => 'ds:DigestValue'
                                                  ,p_element_text => '0iE/FGZgLfbnV9DhUaDBBVPjn44='
                                                  ,x_element => item_elmt_sub6);
           --ds:Reference
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:Reference');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'Type', 'http://uri.etsi.org/01903#SignedProperties');
            xmldom.setAttribute(item_elmt_sub5, 'URI', '#xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466d-signedprops');
              --ds:DigestMethod
              item_elmt_sub6 := xmldom.createElement(p_xmldoc, 'ds:DigestMethod');
              user_node_sub6 := xmldom.appendChild(user_node_sub5, xmldom.makeNode(item_elmt_sub6));
              xmldom.setAttribute(item_elmt_sub6, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');
              --ds:DigestValue
              user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub5
                                                  ,p_element_name => 'ds:DigestValue'
                                                  ,p_element_text => 'k/NyUxvsY6yGVV61NofEz5FaNmU='
                                                  ,x_element => item_elmt_sub6);
          --ds:SignatureValue
          user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub3
                                              ,p_element_name => 'ds:SignatureValue'
                                              ,p_element_text => '5e48e26456aa71cd1be102ea4a8de3b7038f409f37c21dc34  f6a5e441885f6a80369af74016b909f9a4ac73a da2d2d93'
                                              ,x_element => item_elmt_sub4);
                            xmldom.setAttribute(item_elmt_sub4, 'Id', 'xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466dsigvalue');
          --ds:KeyInfo
          item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'ds:KeyInfo');
          user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
          xmldom.setAttribute(item_elmt_sub4, 'Id', 'xmldsig-87d128b5-aa31-4f0b-8e45-3d9cfa0eec26-keyinfo');
            --ds:X509Data
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'ds:X509Data');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
              --ds:X509Certificate
              user_node_sub6 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub5
                                                  ,p_element_name => 'ds:X509Certificate'
                                                  ,p_element_text => 'MIIILDCCBhSgAwIBAgIIfq9P6xyRMBEwDQYJKoZIhvcNAQELBQAwgbQxIzAhBgkqhkiG9w0BCQEW'
                                                  ,x_element => item_elmt_sub6);
                            xmldom.setAttribute(item_elmt_sub6, 'Id', 'xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466dsigvalue');
          --ds:Object
          item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'ds:Object');
          user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
            --xades:QualifyingProperties
            item_elmt_sub5 := xmldom.createElement(p_xmldoc, 'xades:QualifyingProperties');
            user_node_sub5 := xmldom.appendChild(user_node_sub4, xmldom.makeNode(item_elmt_sub5));
            xmldom.setAttribute(item_elmt_sub5, 'xmlns:xades', 'http://uri.etsi.org/01903/v1.3.2#');
            xmldom.setAttribute(item_elmt_sub5, 'xmlns:xades141', 'http://uri.etsi.org/01903/v1.4.1#');
            xmldom.setAttribute(item_elmt_sub5, 'Target', '#xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466d');
              --xades:SignedProperties
              item_elmt_sub6 := xmldom.createElement(p_xmldoc, 'xades:SignedProperties');
              user_node_sub6 := xmldom.appendChild(user_node_sub5, xmldom.makeNode(item_elmt_sub6));
              xmldom.setAttribute(item_elmt_sub6, 'Id', 'xmldsig-79c270e3-50bb-4fcf-b9bc-3a95bcf2466d-signedprops');
                --xades:SignedSignatureProperties
                item_elmt_sub7 := xmldom.createElement(p_xmldoc, 'xades:SignedSignatureProperties');
                user_node_sub7 := xmldom.appendChild(user_node_sub6, xmldom.makeNode(item_elmt_sub7));
                  --xades:SigningTime
                  user_node_sub8 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                      ,p_root_node => user_node_sub7
                                                      ,p_element_name => 'xades:SigningTime'
                                                      ,p_element_text => '2015-06-30T20:56:11.675-05:00'
                                                      ,x_element => item_elmt_sub8);
                  --xades:SigningCertificate
                  item_elmt_sub8 := xmldom.createElement(p_xmldoc, 'xades:SigningCertificate');
                  user_node_sub8 := xmldom.appendChild(user_node_sub7, xmldom.makeNode(item_elmt_sub8));
                    --xades:Cert
                    item_elmt_sub9 := xmldom.createElement(p_xmldoc, 'xades:Cert');
                    user_node_sub9 := xmldom.appendChild(user_node_sub8, xmldom.makeNode(item_elmt_sub9));
                      --xades:CertDigest
                      item_elmt_sub10 := xmldom.createElement(p_xmldoc, 'xades:CertDigest');
                      user_node_sub10 := xmldom.appendChild(user_node_sub9, xmldom.makeNode(item_elmt_sub10));
                        --ds:DigestMethod
                        item_elmt_sub11 := xmldom.createElement(p_xmldoc, 'ds:DigestMethod');
                        user_node_sub11 := xmldom.appendChild(user_node_sub10, xmldom.makeNode(item_elmt_sub11));
                        xmldom.setAttribute(item_elmt_sub11, 'Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');
                        --ds:DigestValue
                        user_node_sub11 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                             ,p_root_node => user_node_sub10
                                                             ,p_element_name => 'ds:DigestValue'
                                                             ,p_element_text => '2el6MfWvYsvEaa/TV513a7tVK0g='
                                                             ,x_element => item_elmt_sub11);
                      --xades:IssuerSerial
                      item_elmt_sub10 := xmldom.createElement(p_xmldoc, 'xades:IssuerSerial');
                      user_node_sub10 := xmldom.appendChild(user_node_sub9, xmldom.makeNode(item_elmt_sub10));
                        --ds:X509IssuerName
                        user_node_sub11 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                             ,p_root_node => user_node_sub10
                                                             ,p_element_name => 'ds:X509IssuerName'
                                                             ,p_element_text => 'C=CO,L=Bogota D.C.,O=Andes SCD.,OU=Division de certificacion entidad final,CN=CA ANDES SCD S.A. Clase II,1.2.840.113549.1.9.1=#1614696e666f40616e6465737363642e636f6d2e636f'
                                                             ,x_element => item_elmt_sub11);
                        --ds:X509SerialNumber
                        user_node_sub11 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                             ,p_root_node => user_node_sub10
                                                             ,p_element_name => 'ds:X509SerialNumber'
                                                             ,p_element_text => '9128602840918470673'
                                                             ,x_element => item_elmt_sub11);
                  --xades:SignaturePolicyIdentifier
                  item_elmt_sub8 := xmldom.createElement(p_xmldoc, 'xades:SignaturePolicyIdentifier');
                  user_node_sub8 := xmldom.appendChild(user_node_sub7, xmldom.makeNode(item_elmt_sub8));
                  --xades:SignerRole
                  item_elmt_sub8 := xmldom.createElement(p_xmldoc, 'xades:SignerRole');
                  user_node_sub8 := xmldom.appendChild(user_node_sub7, xmldom.makeNode(item_elmt_sub8));
  --ext:UBLExtensions<<<
    RETURN user_node;
  END getUBLExtensions;

  FUNCTION getAccountingSupplierParty( p_xmldoc IN xmldom.DOMDocument
                                     , p_root_node IN xmldom.DOMNode
                                     , p_organization_id IN NUMBER) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    
    CURSOR c_accntSupplierParty(p_org_id IN NUMBER) IS
      SELECT org.type_code AdditionalAccountID
            ,org.fiscal_code||org.verification_digit ID
            ,org.department Department
            ,org.city CityName
            ,org.legal_address AddressLine
            ,org.country CountryIdCode
            ,org.clasification_code TaxLevelCode
        FROM gfe.gfe_orgs org
       WHERE org.organization_id = p_org_id
           ;
       
    r_accntSupplierParty  c_accntSupplierParty%ROWTYPE;
    
  BEGIN

    --[1..1]fe:AccountingSupplierParty>>>
    FOR r_accntSupplierParty IN c_accntSupplierParty(p_organization_id) LOOP
      item_elmt := xmldom.createElement(p_xmldoc, 'fe:AccountingSupplierParty');
      user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
        --[1..1]cbc:AdditionalAccountID
        /*UBL->Debe referenciar a una lista de códigos con los siguientes valores:(persona natural;jurídica;gran contribuyente;otros)*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:AdditionalAccountID'
                                            ,p_element_text => r_accntSupplierParty.Additionalaccountid
                                            ,x_element => item_elmt_sub1);
        --[1..1]fe:Party
        item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'fe:Party');
        user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
          --cac:PartyIdentification[1..*] 
          --UBL->Tipo: Debe referenciar a una lista de códigos con los siguientes valores:(persona natural/jurídica/gran contribuyente/otros)_GFE_LOVS:'Tipos de personas'
          item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'cac:PartyIdentification');
          user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
            --cbc:ID
            --UBL->Party Identification. Identifier
            user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                ,p_root_node => user_node_sub2
                                                ,p_element_name => 'cbc:ID'
                                                ,p_element_text => r_accntSupplierParty.Id
                                                ,x_element => item_elmt_sub3);
            xmldom.setAttribute(item_elmt_sub3, 'schemeAgencyID', '195');
            xmldom.setAttribute(item_elmt_sub3, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');
            xmldom.setAttribute(item_elmt_sub3, 'schemeID', '31');
          --fe:PhysicalLocation[1..1]
          item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:PhysicalLocation');
          user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
            --fe:Address[0..1]
            item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'fe:Address');
            user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub3));
              --cbc:Department
              user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub3
                                                  ,p_element_name => 'cbc:Department'
                                                  ,p_element_text => r_accntSupplierParty.Department
                                                  ,x_element => item_elmt_sub4);
              --cbc:CityName
              user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub3
                                                  ,p_element_name => 'cbc:CityName'
                                                  ,p_element_text => r_accntSupplierParty.Cityname
                                                  ,x_element => item_elmt_sub4);
              --cac:AddressLine
              item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'cac:AddressLine');
              user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
                --cbc:Line
                user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub4
                                                    ,p_element_name => 'cbc:Line'
                                                    ,p_element_text => r_accntSupplierParty.Addressline
                                                    ,x_element => item_elmt_sub5);
              --cac:Country
              item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'cac:Country');
              user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
                --cbc:IdentificationCode
                user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub4
                                                    ,p_element_name => 'cbc:IdentificationCode'
                                                    ,p_element_text => r_accntSupplierParty.Countryidcode
                                                    ,x_element => item_elmt_sub5);
            --[1..*]fe:PartyTaxScheme
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:PartyTaxScheme');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
            --cbc:TaxLevelCode
            user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                ,p_root_node => user_node_sub2
                                                ,p_element_name => 'cbc:TaxLevelCode'
                                                ,p_element_text => r_accntSupplierParty.Taxlevelcode
                                                ,x_element => item_elmt_sub3);
              --cac:TaxScheme
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cac:TaxScheme'
                                                  ,p_element_text => NULL
                                                  ,x_element => item_elmt_sub3);
            /*--fe:PartyLegalEntity
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:PartyLegalEntity');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
              --cbc:RegistrationName
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:RegistrationName'
                                                  ,p_element_text => 'PJ - 700085371'
                                                  ,x_element => item_elmt_sub3);*/
   END LOOP;
    --[1..1]fe:AccountingSupplierParty<<<
    RETURN user_node;
  END getAccountingSupplierParty;

  FUNCTION getAccountingCustomerParty( p_xmldoc IN xmldom.DOMDocument
                                     , p_root_node IN xmldom.DOMNode
                                     , p_document_id IN NUMBER) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    
    CURSOR c_accntCustomerParty(p_doc_id IN NUMBER) IS
      SELECT rdc.type_code AdditionalAccountID
            ,rdc.fiscal_code||rdc.verification_digit ID
            --,[0..1]NAME
              ,rdc.first_name
              ,rdc.middle_name
              ,rdc.last_name
            ,rdc.department Department
            ,rdc.city CityName
            ,rdc.legal_address AddressLine
            ,rdc.country CountryIdCode
            ,rdc.clasification_code TaxLevelCode
        FROM gfe_req_document_customer rdc
       WHERE rdc.document_id = p_document_id;

    r_accntCustomerParty  c_accntCustomerParty%ROWTYPE;

  BEGIN
    --[1..1]fe:AccountingCustomerParty>>>
    FOR r_accntCustomerParty IN c_accntCustomerParty(p_document_id) LOOP
      item_elmt := xmldom.createElement(p_xmldoc, 'fe:AccountingCustomerParty');
      user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
        --cbc:AdditionalAccountID
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:AdditionalAccountID'
                                            ,p_element_text => r_accntCustomerParty.Additionalaccountid
                                            ,x_element => item_elmt_sub1);
          --fe:Party
          item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'fe:Party');
          user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
            --cac:PartyIdentification
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'cac:PartyIdentification');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
              --cbc:ID
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:ID'
                                                  ,p_element_text => r_accntCustomerParty.Id
                                                  ,x_element => item_elmt_sub3);
              xmldom.setAttribute(item_elmt_sub3, 'schemeAgencyID', '195');
              xmldom.setAttribute(item_elmt_sub3, 'schemeAgencyName', 'CO, DIAN (Direccion de Impuestos y Aduanas Nacionales)');
              xmldom.setAttribute(item_elmt_sub3, 'schemeID', '22');
            --fe:PhysicalLocation 
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:PhysicalLocation');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
              --fe:Address
              item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'fe:Address');
              user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub3));
                --cbc:Department
                user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub3
                                                    ,p_element_name => 'cbc:Department'
                                                    ,p_element_text => r_accntCustomerParty.Department
                                                    ,x_element => item_elmt_sub4);
                --cbc:CityName
                user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                    ,p_root_node => user_node_sub3
                                                    ,p_element_name => 'cbc:CityName'
                                                    ,p_element_text => r_accntCustomerParty.Cityname
                                                    ,x_element => item_elmt_sub4);
                --cac:AddressLine
                item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'cac:AddressLine');
                user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
                  --cbc:Line
                  user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                      ,p_root_node => user_node_sub4
                                                      ,p_element_name => 'cbc:Line'
                                                      ,p_element_text => r_accntCustomerParty.Addressline
                                                      ,x_element => item_elmt_sub5);
                --cac:Country
                item_elmt_sub4 := xmldom.createElement(p_xmldoc, 'cac:Country');
                user_node_sub4 := xmldom.appendChild(user_node_sub3, xmldom.makeNode(item_elmt_sub4));
                  --cbc:IdentificationCode
                  user_node_sub5 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                      ,p_root_node => user_node_sub4
                                                      ,p_element_name => 'cbc:IdentificationCode'
                                                      ,p_element_text => r_accntCustomerParty.Countryidcode
                                                      ,x_element => item_elmt_sub5);
            --fe:PartyTaxScheme
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:PartyTaxScheme');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
              --cbc:TaxLevelCode
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:TaxLevelCode'
                                                  ,p_element_text => r_accntCustomerParty.Taxlevelcode
                                                  ,x_element => item_elmt_sub3);
              --cac:TaxScheme
              item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'cac:TaxScheme');
              user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub2));
              
            --fe:Person
            item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'fe:Person');
            user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
              --cbc:FirstName
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:FirstName'
                                                  ,p_element_text => r_accntCustomerParty.First_Name
                                                  ,x_element => item_elmt_sub3);
              --cbc:FamilyName
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:FamilyName'
                                                  ,p_element_text => r_accntCustomerParty.Last_Name
                                                  ,x_element => item_elmt_sub3);
              --cbc:MiddleName
              user_node_sub3 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub2
                                                  ,p_element_name => 'cbc:MiddleName'
                                                  ,p_element_text => r_accntCustomerParty.Middle_Name
                                                  ,x_element => item_elmt_sub3);
  END LOOP;
    --[1..1]fe:AccountingCustomerParty<<<
    RETURN user_node;
  END getAccountingCustomerParty;

  FUNCTION getTaxTotal( p_xmldoc IN xmldom.DOMDocument
                      , p_root_node IN xmldom.DOMNode
                      , p_document_id IN NUMBER) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    
    CURSOR c_taxTotal (p_doc_id IN NUMBER) IS
     SELECT rt.tax_amount AS TaxAmount
           ,rt.tax_indicator AS TaxEvidenceIndicator
           ,rt.base_amount AS TaxableAmount
           ,rt.percent_value AS Percent
           ,rt.tax_category AS TaxCategory
       FROM gfe_req_document_taxes rt
      WHERE rt.document_id = p_doc_id;
    
    r_taxTotal c_taxTotal%ROWTYPE;
        
  BEGIN
    --[0..*]fe:TaxTotal>>>
    FOR r_taxTotal IN c_taxTotal(p_document_id) LOOP
      item_elmt := xmldom.createElement(p_xmldoc, 'fe:TaxTotal');
      user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
        --[1..1]cbc:TaxAmount
        /*UBL:7.1.1.4 - Importe Impuesto: Importe del impuesto retenido*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:TaxAmount'
                                            ,p_element_text => r_taxTotal.Taxamount
                                            ,x_element => item_elmt_sub1);
                          xmldom.setAttribute(item_elmt_sub1, 'currencyID', 'COP');
        --[0..1]cbc:RoundingAmount
        --[1..1]cbc:TaxEvidenceIndicator
        /*UBL:Indica que el elemento es un Impuesto retenido (7.1.1) y no un impuesto (8.1.1)*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:TaxEvidenceIndicator'
                                            ,p_element_text => r_taxTotal.Taxevidenceindicator
                                            ,x_element => item_elmt_sub1);
        --[1..*]fe:TaxSubtotal
        item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'fe:TaxSubtotal');
        user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
          --cbc:TaxableAmount
          user_node_sub2 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub1
                                              ,p_element_name => 'cbc:TaxableAmount'
                                              ,p_element_text => r_taxTotal.Taxableamount
                                              ,x_element => item_elmt_sub2);
                            xmldom.setAttribute(item_elmt_sub2, 'currencyID', 'COP');
          --cbc:TaxAmount
          user_node_sub2 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub1
                                              ,p_element_name => 'cbc:TaxAmount'
                                              ,p_element_text => r_taxTotal.Taxamount
                                              ,x_element => item_elmt_sub2);
                            xmldom.setAttribute(item_elmt_sub2, 'currencyID', 'COP'); 
          --cbc:Percent
          user_node_sub2 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub1
                                              ,p_element_name => 'cbc:Percent'
                                              ,p_element_text => r_taxTotal.Percent
                                              ,x_element => item_elmt_sub2);
          --cac:TaxCategory
          item_elmt_sub2 := xmldom.createElement(p_xmldoc, 'cac:TaxCategory');
          user_node_sub2 := xmldom.appendChild(user_node_sub1, xmldom.makeNode(item_elmt_sub2));
            --cac:TaxScheme
            item_elmt_sub3 := xmldom.createElement(p_xmldoc, 'cac:TaxScheme');
            user_node_sub3 := xmldom.appendChild(user_node_sub2, xmldom.makeNode(item_elmt_sub3));
              --cbc:ID
              user_node_sub4 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                                  ,p_root_node => user_node_sub3
                                                  ,p_element_name => 'cbc:ID'
                                                  ,p_element_text => r_taxTotal.Taxcategory
                                                  ,x_element => item_elmt_sub4);
    END LOOP;        
    --[0..*]fe:TaxTotal<<<
    RETURN user_node;
  END getTaxTotal;

  FUNCTION getLegalMonetaryTotal( p_xmldoc IN xmldom.DOMDocument
                                , p_root_node IN xmldom.DOMNode
                                , p_document_id IN NUMBER ) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    
    CURSOR c_legalmonetarytotal IS
      SELECT rd.gross_amount AS LineExtensionAmount
            ,rd.base_amount AS TaxExclusiveAmount
            ,rd.net_amount AS PayableAmount
        FROM gfe_requested_documents rd;
    
    r_legalmonetarytotal c_legalmonetarytotal%ROWTYPE;
    
  BEGIN
    --[1..1]fe:LegalMonetaryTotal>>>
    FOR r_legalmonetarytotal IN c_legalmonetarytotal LOOP
      item_elmt := xmldom.createElement(p_xmldoc, 'fe:LegalMonetaryTotal');
      user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
        --[1..1]cbc:LineExtensionAmount
        /*UBL-> 9.4 - Total Importe bruto antes de impuestos: Total importe bruto, suma de los importes brutos de las líneas de la factura.*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:LineExtensionAmount'
                                            ,p_element_text => r_legalmonetarytotal.LineExtensionAmount
                                            ,x_element => item_elmt_sub1);
                          xmldom.setAttribute(item_elmt_sub1, 'currencyID', gfe_xml.getDocumentCurrencyCode(p_document_id));
        --[1..1]cbc:TaxExclusiveAmount
        /*UBL-> 9.5 - Total Base Imponible (Importe Bruto+Cargos-Descuentos): Base imponible para el cálculo de los impuestos.*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:TaxExclusiveAmount'
                                            ,p_element_text => r_legalmonetarytotal.TaxExclusiveAmount
                                            ,x_element => item_elmt_sub1);
                          xmldom.setAttribute(item_elmt_sub1, 'currencyID', gfe_xml.getDocumentCurrencyCode(p_document_id));
        --[1.1]cbc:PayableAmount
        /*9.8 - Total de Factura: Total importe bruto + Total Impuestos-Total Impuesto Retenidos*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:PayableAmount'
                                            ,p_element_text => r_legalmonetarytotal.PayableAmount
                                            ,x_element => item_elmt_sub1);
                          xmldom.setAttribute(item_elmt_sub1, 'currencyID', gfe_xml.getDocumentCurrencyCode(p_document_id));
    END LOOP;
    --fe:LegalMonetaryTotal<<<
    RETURN user_node;
  END getLegalMonetaryTotal;


  FUNCTION getInvoiceLine( p_xmldoc IN xmldom.DOMDocument
                         , p_root_node IN xmldom.DOMNode
                         , p_document_id IN NUMBER) RETURN xmldom.DOMNode IS
    item_elmt xmldom.DOMElement;
    item_elmt_sub1 xmldom.DOMElement;
    item_elmt_sub2 xmldom.DOMElement;
    item_elmt_sub3 xmldom.DOMElement;
    item_elmt_sub4 xmldom.DOMElement;
    item_elmt_sub5 xmldom.DOMElement;
    user_node xmldom.DOMNode;
    user_node_sub1 xmldom.DOMNode;
    user_node_sub2 xmldom.DOMNode;
    user_node_sub3 xmldom.DOMNode;
    user_node_sub4 xmldom.DOMNode;
    user_node_sub5 xmldom.DOMNode;
    
    CURSOR c_InvoiceLine(p_doc_id IN NUMBER) IS
      SELECT rdl.line_number AS ID                 
            ,rdl.quantity    AS InvoicedQuantity   
            ,rdl.amount      AS LineExtensionAmount
            ,rdl.description AS Description       
            ,NULL /*rdl.unit_price*/ AS PriceAmount        
        FROM gfe_req_document_lines rdl
       WHERE rdl.document_id = p_doc_id
       ORDER BY rdl.line_number;

    r_InvoiceLine c_InvoiceLine%ROWTYPE;

  BEGIN
    --[1..*]fe:InvoiceLine>>>
    FOR r_InvoiceLine IN c_InvoiceLine(p_document_id) LOOP
      item_elmt := xmldom.createElement(p_xmldoc, 'fe:InvoiceLine');
      user_node := xmldom.appendChild(p_root_node, xmldom.makeNode(item_elmt));
        --[1..1]cbc:ID
        /*13.1.1.1 - Número de Línea: Número de Línea*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:ID'
                                            ,p_element_text => r_InvoiceLine.Id
                                            ,x_element => item_elmt_sub1);
        --[1..1]cbc:InvoicedQuantity
        /*13.1.1.9 - Cantidad: Cantidad del artículo solicitado. Número de unidades servidas/prestadas.*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:InvoicedQuantity'
                                            ,p_element_text => r_InvoiceLine.Invoicedquantity
                                            ,x_element => item_elmt_sub1);
        --[1..1]cbc:LineExtensionAmount
        /*13.1.1.12 - Costo Total: Coste Total. Resultado: Unidad de Medida x Precio Unidad.*/
        user_node_sub1 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                            ,p_root_node => user_node
                                            ,p_element_name => 'cbc:LineExtensionAmount'
                                            ,p_element_text => r_InvoiceLine.Lineextensionamount
                                            ,x_element => item_elmt_sub1);
                          xmldom.setAttribute(item_elmt_sub1, 'currencyID', 'COP');
        --[1..1]fe:Item>>>
        item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'fe:Item');
        user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
          --cbc:Description
          /*13.1.1.3 - Descripción: Descripción del artículo que pertenece a la línea de la factura*/
          user_node_sub2 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub1
                                              ,p_element_name => 'cbc:Description'
                                              ,p_element_text => r_InvoiceLine.Description
                                              ,x_element => item_elmt_sub2);
        --[1..1]fe:Price>>>
        item_elmt_sub1 := xmldom.createElement(p_xmldoc, 'fe:Price');
        user_node_sub1 := xmldom.appendChild(user_node, xmldom.makeNode(item_elmt_sub1));
          --cbc:PriceAmount
          /*13.1.1.11 - Precio Unitario: Precio unitario de la unidad de bien o servicio servido/prestado, en la moneda indicada en la Cabecera de la Factura. Siempre sin Impuestos*/
          user_node_sub2 := getTextOnlyElement(p_xmldoc => p_xmldoc
                                              ,p_root_node => user_node_sub1
                                              ,p_element_name => 'cbc:PriceAmount'
                                              ,p_element_text => r_InvoiceLine.Priceamount
                                              ,x_element => item_elmt_sub2);
                            xmldom.setAttribute(item_elmt_sub2, 'currencyID', 'COP');
    END LOOP;
    --fe:InvoiceLine<<<
    RETURN user_node;
  END getInvoiceLine;

  PROCEDURE getInvoiceType(p_xmldoc IN xmldom.DOMDocument
                          ,p_root_node IN xmldom.DOMNode
                          ,p_organization_id IN NUMBER
                          ,p_document_id IN NUMBER) IS
    l_xmltype XMLTYPE;
    xmldoc xmldom.DOMDocument;
    main_node xmldom.DOMNode;
    root_node xmldom.DOMNode;
    user_node xmldom.DOMNode;
    item_node xmldom.DOMNode;
    root_elmt xmldom.DOMElement;
    item_elmt xmldom.DOMElement;
    item_text xmldom.DOMText;


    clobdoc CLOB := ' ';
    /*CURSOR get_users(p_deptno NUMBER) IS
      SELECT empno
           , ename
           , deptno
           , rownum
        FROM demo.emp
       WHERE deptno = p_deptno;*/
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
    /*fe:AccountingSupplierParty*/user_node := xmldom.appendChild(root_node, gfe_xml.getAccountingSupplierParty(p_xmldoc => xmldoc, p_root_node => root_node, p_organization_id => p_organization_id));
    /*fe:AccountingCustomerParty*/user_node := xmldom.appendChild(root_node, gfe_xml.getAccountingCustomerParty(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id =>  p_document_id));
    /*fe:TaxTotal*/               user_node := xmldom.appendChild(root_node, gfe_xml.getTaxTotal(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => p_document_id));
    /*fe:LegalMonetaryTotal*/     user_node := xmldom.appendChild(root_node, gfe_xml.getLegalMonetaryTotal(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => p_document_id));
    /*fe:InvoiceLine*/            user_node := xmldom.appendChild(root_node, gfe_xml.getInvoiceLine(p_xmldoc => xmldoc, p_root_node => root_node, p_document_id => p_document_id));
    --
    /*-- write document to file using default character set from database
      dbms_xmldom.writeCharacterOutputStream( (xmldoc, buf);
      xmldom.writeToFile(xmldoc,'C:\docSample.xml');*/

    --write document to Output
      l_xmltype := dbms_xmldom.getXmlType(xmldoc);
      --dbms_output.put_line(l_xmltype.getClobVal);
      --dbms_output.put_line(dbms_xmldom.getlength(l_xmltype));
      
      UPDATE gfe_documents SET xml_format = l_xmltype WHERE document_id = p_document_id;
      COMMIT;

    -- free resources
    dbms_xmldom.freeDocument(xmldoc);
    
  END getInvoiceType;
    
BEGIN
  NULL;
END gfe_xml;
/
