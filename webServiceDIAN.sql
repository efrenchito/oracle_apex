--gfe_xml
--as_zip

--https://docs.oracle.com/cd/E59726_01/doc.50/e39149/apex_web_service.htm#AEAPI1932
--http://stackoverflow.com/questions/16829681/need-a-oracle-function-to-conver-string-to-bytes-array

--The following is an example of using the BLOB2CLOBBASE64 function to encode a parameter, MAKE_REQUEST procedure to call a Web service, 
--and the PARSE_RESPONSE function to extract a specific value from the response.

--drop table test_xml;
--CREATE TABLE test_xml(xml_blob BLOB, xml_clob CLOB);
--truncate table test_xml;
--SELECT * FROM test_xml;
DECLARE
  l_xml_type XMLTYPE;
  l_xml_doc DBMS_XMLDOM.DOMDocument;
  
  l_xml_blob BLOB;
  l_xml_clob CLOB;
  l_zipped_file BLOB;
  l_unzipped_file blob;
  l_files apex_zip.t_files;

  l_file      UTL_FILE.FILE_TYPE;
  l_pos       INTEGER := 1;
  l_blob_len  INTEGER;
  l_buffer    RAW(32767);
  l_amount    BINARY_INTEGER := 32767;
BEGIN
      --Get XMLTYPE
      SELECT xml_format
        INTO l_xml_type
        FROM gfe_documents 
       WHERE document_id = 1;

      --Transform XMLTYPE to XMLDOM
        l_xml_doc := DBMS_XMLDOM.NewDOMDocument(l_xml_type);      
          --CREATE OR REPLACE DIRECTORY MY_DIR AS 'Z:\';
          --GRANT READ,WRITE ON DIRECTORY MY_DIR TO GFE;
        ----DBMS_XMLDOM.WRITETOFILE(l_xml_doc, 'MY_DIR\XMLWebServiceDian.xml');
      
      --Transform XMLTYPE to CLOB Base64
        l_xml_blob := utl_raw.cast_to_raw(l_xml_type.getClobVal());
        l_xml_clob := apex_web_service.blob2clobbase64(l_xml_blob);
      --Generate ZIP_FILE from BLOB (Anton-Scheffer)
        as_zip.add1file(p_zipped_blob => l_zipped_file
                       ,p_name => 'XMLWebServiceDian.xml'
                       ,p_content => gfe_xml.getBlobFromClob(l_xml_clob));
        as_zip.finish_zip(p_zipped_blob => l_zipped_file );
        -->BLOB to BYTE[]
        --***DBMS_OUTPUT.PUT_LINE(UTL_RAW.CAST_TO_RAW(dbms_lob.substr(l_zipped_file)));
        -->Export BLOB to OS PATH (Anton-Scheffer)
        as_zip.save_zip(p_zipped_blob => l_zipped_file
                       ,p_filename => 'AS_XMLWebServiceDian.zip');

      --Generate ZIP_FILE from BLOB (APEX_ZIP)
        /*APEX_ZIP.ADD_FILE(p_zipped_blob => l_zipped_file
                         ,p_file_name   => 'XMLWebServiceDian.xml'
                         ,p_content     => gfe_xml.getBlobFromClob(l_xml_clob));
        APEX_ZIP.FINISH(p_zipped_blob  => l_zipped_file );
        ----DBMS_OUTPUT.PUT_LINE(UTL_RAW.CAST_TO_RAW(dbms_lob.substr(l_zipped_file)));
        -->BLOB to BYTE[]
        --***DBMS_OUTPUT.PUT_LINE(UTL_RAW.CAST_TO_RAW(dbms_lob.substr(l_zipped_file)));
        -->Export BLOB to OS_PATH(UTL_FILE)
          l_file := UTL_FILE.fopen('MY_DIR','AZ_XMLWebServiceDian.zip','wb', 32767);
          l_blob_len := DBMS_LOB.getlength(l_zipped_file);
          -- Read chunks of the BLOB and write them to the file
          -- until complete.
          WHILE l_pos < l_blob_len LOOP
            DBMS_LOB.READ(l_zipped_file, l_amount, l_pos, l_buffer);
            UTL_FILE.put_raw(l_file, l_buffer, TRUE);
            l_pos := l_pos + l_amount;
          END LOOP;  
          -- Close the file.
          UTL_FILE.fclose(l_file);*/

          -->GET FILES from ZIP
          /*l_files := apex_zip.get_files (p_zipped_blob => l_zipped_file );
          FOR i IN 1 .. l_files.count LOOP
              l_unzipped_file := apex_zip.get_file_content(p_zipped_blob => l_zipped_file
                                                          ,p_file_name   => l_files(i) );

              --::( file_name, file_content ) <-> ( l_files(i), l_unzipped_file )::
              -->Export BLOB to PATH(UTL_FILE)
              l_file := UTL_FILE.fopen('MY_DIR','XMLWebServiceDianUNZIPPED.xml','wb', 32767);
              l_blob_len := DBMS_LOB.getlength(l_unzipped_file);
              -- Read chunks of the BLOB and write them to the file until complete.
              WHILE l_pos < l_blob_len LOOP
                DBMS_LOB.READ(l_unzipped_file, l_amount, l_pos, l_buffer);
                UTL_FILE.put_raw(l_file, l_buffer, TRUE);
                l_pos := l_pos + l_amount;
              END LOOP;  
              -- Close the file.
              UTL_FILE.fclose(l_file);
          END LOOP;*/
        
        --LENGTHB( string1 ): The Oracle/PLSQL LENGTHB function returns the length of the specified string, using bytes instead of characters.
        --DBMS_OUTPUT.PUT_LINE(UTL_RAW.CAST_TO_RAW(dbms_lob.substr(l_zipped_file)));
        --Convert STRING to BYTES_ARRAY: UTL_RAW.CAST_TO_RAW(l_zipped_file)
        --Convert BYTES_ARRAY TO String: UTL_RAW.CAST_TO_VARCHAR2(LOGIN_PWD)
        
        /*public byte[] getFicheroAdjunto() {
          String ruta = "Z:\\XMLWebServiceDian.zip"
          File file = new File(ruta);
          try{
            FileInputStream fis = new FileInputStream(file);
            BufferedInputStream input = new BufferedInputStream(fis);
            byte[] salida = new byte[(int) file.length()];
            input.read(salida);
            input.close();
            return salida;
          }catch (IOException exc){
            return null;
          }
        }*/
        
        --http://stackoverflow.com/questions/33100570/how-to-get-specific-byte-value-from-raw-in-pl-sql
END;


SELECT * FROM APEX_APPLICATION_FILES

DECLARE
   --l_filename varchar2(255);
   l_xmltype XMLTYPE;
   
   l_BLOB BLOB;
   l_CLOB CLOB;
   l_envelope CLOB;
   l_response_msg varchar2(32767);
BEGIN
	 /*IF :P1_FILE IS NOT NULL THEN
	    SELECT filename, BLOB_CONTENT
	      INTO l_filename, l_BLOB
	      FROM APEX_APPLICATION_FILES
	      WHERE name = :P1_FILE;*/  
        
	  BEGIN
      SELECT xml_format
        INTO l_xmltype
        FROM gfe_documents 
       WHERE document_id = 1;
    END;

      l_BLOB := utl_raw.cast_to_raw(l_xmltype.getClobVal()); 
      --INSERT INTO test_xml (xml_blob) VALUES (l_BLOB);
	    l_CLOB := apex_web_service.blob2clobbase64(l_BLOB);
	 
	   l_envelope := q'!<?xml version='1.0' encoding='UTF-8'?>!';
	   l_envelope := l_envelope || '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:chec="http://www.stellent.com/CheckIn/">
	  <soapenv:Header/>
	  <soapenv:Body>
	     <chec:CheckInUniversal>
	        <chec:dDocName>'||l_filename||'</chec:dDocName>
	        <chec:dDocTitle>'||l_filename||'</chec:dDocTitle>
	        <chec:dDocType>Document</chec:dDocType>
	        <chec:dDocAuthor>GM</chec:dDocAuthor>
	        <chec:dSecurityGroup>Public</chec:dSecurityGroup>
	        <chec:dDocAccount></chec:dDocAccount>
	        <chec:CustomDocMetaData>
	           <chec:property>
	              <chec:name></chec:name>
	              <chec:value></chec:value>
	           </chec:property>
	        </chec:CustomDocMetaData>
	        <chec:primaryFile>
	           <chec:fileName>'||l_filename'||</chec:fileName>
	           <chec:fileContent>'||l_CLOB||'</chec:fileContent>
	        </chec:primaryFile>
	        <chec:alternateFile>
	           <chec:fileName></chec:fileName>
	           <chec:fileContent></chec:fileContent>
	        </chec:alternateFile>
	        <chec:extraProps>
	           <chec:property>
	              <chec:name></chec:name>
	              <chec:value></chec:value>
	           </chec:property>
	        </chec:extraProps>
	     </chec:CheckInUniversal>
	  </soapenv:Body>
	</soapenv:Envelope>';
	 
	apex_web_service.make_request(
	   p_url               => 'http://127.0.0.1/idc/idcplg',
	   p_action            => 'http://www.stellent.com/CheckIn/',
	   p_collection_name   => 'STELLENT_CHECKIN',
	   p_envelope          => l_envelope,
	   p_username          => 'sysadmin',
	   p_password          => 'welcome1' );
	 
	 l_response_msg := apex_web_service.parse_response(
	   p_collection_name=>'STELLENT_CHECKIN'
	  ,p_xpath=>'//idc:CheckInUniversalResponse/idc:CheckInUniversalResult/idc:StatusInfo/idc:statusMessage/text()'
	  ,p_ns=>'xmlns:idc="http://www.stellent.com/CheckIn/"');
	 
	 :P1_RES_MSG := l_response_msg;

 --END IF;
END;




/*
SELECT * FROM sys.utl:file;
CREATE OR REPLACE DIRECTORY MY_DIR AS 'Z:\';
GRANT READ,WRITE ON DIRECTORY MY_DIR TO demo;
http://www.akadia.com/download/documents/create_xml_docs_xmldom.txt
*/
