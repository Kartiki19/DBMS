SET LINESIZE 120
set serveroutput on
set verify off
set feedback off
set termout on

/* ============================================================== Procedures ============================================================== */
/*  Procedure to Print Service Contract ID On Terminal */
CREATE OR REPLACE PROCEDURE getServiceContract(id IN number) IS
     CURSOR ServiceContract IS   
        SELECT CustID, ContractID, SC.Start_Date, End_Date, SC.ServiceItemID, TypeOfService, Fee, M.Model, M.Make, M.ModelYear, M.MonitorSize  
        FROM Service_Contract SC
        JOIN ServiceItems SI ON SC.ServiceItemID = SI.ServiceItemID 
        JOIN fees ON SI.TypeOfService = fees.TypeID
        LEFT JOIN Monitor M ON SI.ServiceItemID = M.ServiceItemID
        WHERE ContractID = id;
BEGIN 
    dbms_output.put_line('CustID' || '   ' || 'ContractID' || '   ' || 'StartDate' || '   ' || 'EndDate' || '     ' || 'ItemID' || '   ' || 'ServiceType' || '   ' || 'Fee/Month'|| '   ' || 'MModel' || '   ' || 'MMake' || '  ' || 'MYear' || '  ' || 'MSize'); 
    FOR temp IN ServiceContract LOOP
        dbms_output.put_line(temp.CustID || '          ' || temp.ContractID || '          ' || temp.Start_Date || '   ' || temp.End_Date || '    ' || temp.ServiceItemID || '      ' || temp.TypeOfService || '      ' || temp.Fee || '         ' || temp.Model || '       ' || temp.Make || '    ' || temp.ModelYear || '   ' || temp.MonitorSize);  
    END LOOP;     
END; 
/

/*  Procedure to Print Service Contracts based on PhoneNumber On Terminal */
CREATE OR REPLACE PROCEDURE getServiceContractByPhone(phone IN varchar2) IS
     CURSOR ServiceContract IS   
        SELECT CustID, ContractID, SC.Start_Date, End_Date, SC.ServiceItemID, TypeOfService, Fee 
        FROM Service_Contract SC
        JOIN ServiceItems SI ON SC.ServiceItemID = SI.ServiceItemID 
        JOIN fees ON SI.TypeOfService = fees.TypeID
        WHERE CustID IN (SELECT DISTINCT CustID from Customer where Phone_No = phone);
BEGIN 
    dbms_output.put_line('Cust#' || '   ' || 'Contract#' || '   ' || 'StartDate' || '   ' || 'EndDate' || '     ' || 'Item#' || '   ' || 'ServiceType' || '   ' || 'Fee/Month'); 
    FOR temp IN ServiceContract LOOP
        dbms_output.put_line(temp.CustID || '         ' || temp.ContractID || '         ' || temp.Start_Date || '   ' || temp.End_Date || '    ' || temp.ServiceItemID || '      ' || temp.TypeOfService || '      ' || temp.Fee);  
    END LOOP;       
END; 
/

/*  Procedure to Print Active Service Contracts On Terminal */
CREATE OR REPLACE PROCEDURE getActiveServiceContracts AS
     CURSOR ServiceContract IS   
        SELECT CustID, ContractID, Start_Date, End_Date, SC.ServiceItemID, TypeOfService, Fee, Status 
        FROM Service_Contract SC
        JOIN ServiceItems SI ON SC.ServiceItemID = SI.ServiceItemID 
        JOIN fees ON SI.TypeOfService = fees.TypeID
        WHERE Status ='Active';

BEGIN 
    dbms_output.put_line('Cust#' || '   ' || 'Contract#' || '   ' || 'StartDate' || '   ' || 'EndDate' || '     ' || 'Item#' || '   ' || 'ServiceType' || '   ' || 'Fee/Month' || '  ' || 'Status'); 
    FOR temp IN ServiceContract LOOP
        dbms_output.put_line(RPAD(temp.CustID, 3, ' ') || '         ' || temp.ContractID || '         ' || temp.Start_Date || '   ' || temp.End_Date || '    ' || temp.ServiceItemID || '      ' || temp.TypeOfService || '      ' || temp.Fee || '     ' || temp.Status);  
    END LOOP;       
END; 
/

/* ============================================================== Operations ============================================================== */

host printf "\n===================== Service Contract Details Using Contract ID =====================\n"
-- Taking input as Service Contract ID
Select distinct ContractID from Service_Contract ORDER BY ContractID ASC;
ACCEPT ServiceContractID NUMBER PROMPT 'Please enter Service Contract ID : '

DECLARE
BEGIN 
    getServiceContract(&ServiceContractID); 
END; 
/ 

host printf "\n===================== Service Contract Details Using Phone Number =====================\n"
ACCEPT PhoneNumber CHAR PROMPT 'Please enter Phone Number : '

DECLARE
BEGIN 
    getServiceContractByPhone(&PhoneNumber); 
END; 
/ 

host printf "\n=============================== Active Service Contracts ===============================\n"
DECLARE
BEGIN 
    getActiveServiceContracts; 
END; 
/ 

host printf "\n===================== Update the Service Contract Status =====================\n"
Select distinct ContractID, Status from Service_Contract where Status = 'Active' ORDER BY ContractID ASC;
ACCEPT CID CHAR PROMPT 'Please enter Contract ID you want to update : '

DECLARE
BEGIN 
    UPDATE Service_Contract SET Status = 'Inactive' WHERE ContractID = &CID;
    commit;
END; 
/ 

select distinct ContractID, Status from Service_Contract where ContractID = &CID;

host printf "\n===================== Delete the Service Contract =====================\n"
Select distinct ContractID from Service_Contract ORDER BY ContractID ASC;
ACCEPT CID CHAR PROMPT 'Please enter Contract ID you want to DELETE : '

DECLARE
BEGIN 
    DELETE FROM Service_Contract WHERE ContractID = &CID;
    commit;
END; 
/ 

select distinct ContractID from Service_Contract ORDER BY ContractID ASC;
select * from Past_Service_Contracts;


set termout off
start ServiceContractReportCreation.sql &ServiceContractID
start ServiceContractReportCreationPhone.sql &PhoneNumber
set termout on

host printf "\nReports Generated !"