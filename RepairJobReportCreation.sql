/* =============== Creating a Repair Job Report =============== */

-- the size of one page
SET PAGESIZE 20
-- the size of a line
SET LINESIZE 90

BREAK ON TODAY

/* Heading - Repair Job ID ID, Date, Customer ID, Customer Name, Customer Address, Customer Phone No */
COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;

COLUMN CUSTOMER# NEW_VALUE CustID
SELECT CustID CUSTOMER# FROM Repair_Jobs WHERE RepairJobID = &1;

COLUMN CUSTOMER_NAME NEW_VALUE NAME
COLUMN CUSTOMER_ADDRESS NEW_VALUE Address
COLUMN CUSTOMER_PHONE NEW_VALUE Phone_No

SELECT Name CUSTOMER_NAME, Address CUSTOMER_ADDRESS,Phone_No CUSTOMER_PHONE
FROM Customer 
JOIN Repair_Jobs ON Repair_Jobs.CustID = Customer.CustID
WHERE RepairJobID = &1;

-- Sets terminal output off
set termout off

-- Title as the Company Name
TTITLE CENTER "Magic Wand Inc." skip 1 -
CENTER ============================================================================================ SKIP 1 -
CENTER "Repair Job Report" skip 1 -
LEFT "Repair Job ID :" &1 RIGHT "Date : " report_date skip 1 -
LEFT "Customer ID :"CustID RIGHT "Customer Name : " NAME skip 1 -
LEFT "Customer PhoneNo : " Phone_No RIGHT "Customer Address : " Address skip 3

-- Change column headings and format number columns
column Repair_Date format a10 heading "DueDate" 
column RepairItemID format 999,999 heading "RepairItemID" 
column ServiceItemID format a13 heading "ServiceItemID" 
column TypeOfRepair format a15 heading "Service_Type" 
column Fee format 9999.999 heading "Charges"

-- Saving the Report
column ReportFilename new_val ReportFilename
select 'RepairJob_' || &1 || '_' || to_char(sysdate, 'yyyymmdd') || '.txt' ReportFilename from dual;
spool &ReportFilename

-- Showing Repair Item ID, Service Item ID (If Applicable), Repair Type, 
-- Repair Date, Fees Charged and Total Charges for that Repair Job

BREAK ON REPORT
COMPUTE SUM LABEL 'TOTAL' OF Fee ON REPORT

SELECT Repair_Jobs.RepairItemID, Repair_Jobs.ServiceItemID, Repair_Jobs.TypeOfRepair,
        Repair_Jobs.Repair_Date, fees.Fee
FROM Repair_Jobs 
JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID
WHERE RepairJobID = &1;

spool off;

--clear all formatting commands ...

CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
SET termout ON

