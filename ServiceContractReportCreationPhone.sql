/* =============== Creating a Service Contract Report for Customer ID 10 =============== */
-- the size of one page
SET PAGESIZE 20
-- the size of a line
SET LINESIZE 90

/* Heading - Service Contract ID, Date, Customer ID, Customer Name */
BREAK ON TODAY
COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;

COLUMN CUSTOMER# NEW_VALUE CustID
SELECT CustID CUSTOMER# 
FROM Customer 
WHERE Phone_No = '&1';


COLUMN CUSTOMER_NAME NEW_VALUE Name
SELECT Name CUSTOMER_NAME 
FROM Customer 
WHERE Phone_No = '&1';

-- Title as the Company Name
TTITLE CENTER "Magic Wand Inc." skip 1 -
CENTER ================================================================================================ SKIP 2 -
LEFT "Customer ID : " CustID CENTER "Customer Name : " Name RIGHT "Date : " report_date skip 3 -


-- Change column headings and format number columns
column ContractID format 9999 heading "ContractID"
column Start_Date format a10 heading "Start_Date"
column End_Date format a10 heading "End_End"
column ServiceItemID format a10 heading "Machine_ID"
column TypeOfService format a12 heading "Service_Type"
column Fee format 9999.99 heading "Fees/Month"

-- Saving Report
column ReportFilename new_val ReportFilename
select 'CustID_' || &CustID || '_' || to_char(sysdate, 'yyyymmdd') || '.txt' ReportFilename from dual;
spool &ReportFilename

-- Showing Machine ID (Service Item ID), Service Type (TypeOfService), 
-- Start and End Date of the service and Fees Charged per Month
SELECT Service_Contract.ContractID, Service_Contract.ServiceItemID, ServiceItems.TypeOfService, 
        Service_Contract.Start_Date, Service_Contract.End_Date, fees.Fee
FROM Service_Contract 
JOIN ServiceItems ON ServiceItems.ServiceItemID = Service_Contract.ServiceItemID 
JOIN fees ON ServiceItems.TypeOfService = fees.TypeID
WHERE Service_Contract.CustID = &CustID;

spool off;

--clear all formatting commands ...

CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
