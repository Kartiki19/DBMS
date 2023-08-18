/* =============== Creating a Revenue of Given Month by Repair Jobs Report =============== */

-- the size of one page
SET PAGESIZE 20
-- the size of a line
SET LINESIZE 90

BREAK ON TODAY

/* Heading - Date, Revenue Month */
COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;

COLUMN MonthID NEW_VALUE MonthName
SELECT TO_CHAR(TO_DATE(&1, 'MM'), 'MONTH') MonthID 
FROM DUAL;


-- Sets terminal output off
set termout off

-- Title as the Company Name
TTITLE CENTER "Magic Wand Inc." skip 1 -
CENTER ============================================================================================ SKIP 1 -
CENTER "Revenue - Repair Jobs Report" skip 1 -
LEFT "Revenue of Month : " MonthName RIGHT "Date : " report_date skip 3

-- Change column headings and format number columns
column Repair_Date format a10 heading "DueDate" 
column RepairItemID format 999,999 heading "RepairItemID"
column RepairJobID format 999,999 heading "RepairJobID" 
column CustID format 999,999 heading "CustomerID" 
column ServiceItemID format a13 heading "ServiceItemID" 
column TypeOfRepair format a15 heading "Service_Type" 
column Fee format 9999.99 heading "Charges"

-- Saving the Report
column ReportFilename new_val ReportFilename
select 'RepairJobRevenueMonth' || &1 || '_' || to_char(sysdate, 'yyyymmdd') || '.txt' ReportFilename from dual;
spool &ReportFilename

-- Showing Month and Revenue for that month
SELECT TO_CHAR(TO_DATE(EXTRACT(MONTH FROM Repair_Jobs.Repair_Date), 'MM'), 'MONTH') as Month, SUM(fees.Fee) as Revenue
FROM  Repair_Jobs 
JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID 
WHERE EXTRACT(MONTH FROM Repair_Jobs.Repair_Date) =  &1
GROUP BY EXTRACT(MONTH FROM Repair_Jobs.Repair_Date);

-- Showing Detailed Revenue Report 
-- Repair Job ID, Repair Item ID, Customer ID, Service Item ID (If Applicable), Repair Type, 
-- Repair Date, Fees Charged and Total Revenue

BREAK ON REPORT
COMPUTE SUM LABEL 'TOTAL' OF Fee ON REPORT

SELECT Repair_Jobs.RepairJobID, Repair_Jobs.RepairItemID, Repair_Jobs.CustID, Repair_Jobs.ServiceItemID, Repair_Jobs.TypeOfRepair,
        Repair_Jobs.Repair_Date, fees.Fee
FROM Repair_Jobs 
JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID
WHERE EXTRACT(MONTH FROM Repair_Jobs.Repair_Date) =  &1
ORDER BY Repair_Jobs.RepairJobID;

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

