SET LINESIZE 120
set serveroutput on
set verify off
set feedback off
set termout on

/*  Procedure to Print Repair Job ID On Terminal */
CREATE OR REPLACE PROCEDURE getRepairJob(id IN number) IS
    CURSOR RepairJobs IS           
    SELECT RepairJobID, RepairItemID, ServiceItemID, CustID, TypeOfRepair, Repair_Date, Fee
    FROM Repair_Jobs 
    JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID
    WHERE RepairJobID = id;
BEGIN 
    dbms_output.put_line('RJID' || '   ' || 'RItemID' || '   ' || 'CustId' ||'     '|| 'ServiceItem#' || '    ' || 'RepairType' || '         ' || 'DueDate' || '     ' || 'Fees'); 
    FOR temp IN RepairJobs LOOP
        dbms_output.put_line(temp.RepairJobID || '          ' || temp.RepairItemID || '      ' || temp.CustID || '          '  || temp.ServiceItemID || '              ' || RPAD(temp.TypeOfRepair, 13, ' ') || '  ' || temp.Repair_Date || '        ' || temp.Fee);  
    END LOOP;     
END; 
/

host printf "\n===================== Repair Job Details Using Repair Job ID =====================\n"

-- Taking input as Repair Job ID
Select distinct RepairJobID from Repair_Jobs ORDER BY RepairJobID ASC;
ACCEPT RepairJID NUMBER PROMPT 'Please enter Repair Job ID : '

-- Change column headings and format number columns
column Repair_Date format a10 heading "DueDate" 
column RepairJobID format 999,999 heading "RepairJobID" 
column CustID format 999,999 heading "CustID"
column RepairItemID format 999,999 heading "RepairItemID" 
column ServiceItemID format a13 heading "ServiceItemID" 
column TypeOfRepair format a15 heading "Service_Type" 
column Fee format 9999.999 heading "Charges"

-- Showing Repair Job's Itemized Bill
BREAK ON REPORT
COMPUTE SUM LABEL 'TOTAL' OF Fee ON REPORT
SELECT RepairJobID, RepairItemID, ServiceItemID, CustID, TypeOfRepair,
            Repair_Date, Fee
    FROM Repair_Jobs 
    JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID
    WHERE RepairJobID = &RepairJID;

host printf "\n============================ Repair Job Revenue By Month ============================\n"

-- Taking input as Repair Job ID
ACCEPT RevenueMonth NUMBER PROMPT 'Please enter Month Number (1-12) : '

-- Change column headings and format number columns
column Repair_Date format a10 heading "DueDate" 
column RepairJobID format 999,999 heading "RepairJobID" 
column CustID format 999,999 heading "CustID"
column RepairItemID format 999,999 heading "RepairItemID" 
column ServiceItemID format a13 heading "ServiceItemID" 
column TypeOfRepair format a15 heading "Service_Type" 
column Fee format 9999.999 heading "Charges"

-- Showing Month and Revenue for that month
SELECT TO_CHAR(TO_DATE(EXTRACT(MONTH FROM Repair_Jobs.Repair_Date), 'MM'), 'MONTH') as Month, SUM(fees.Fee) as Revenue
FROM  Repair_Jobs 
JOIN fees ON Repair_Jobs.TypeOfRepair = fees.TypeID 
WHERE EXTRACT(MONTH FROM Repair_Jobs.Repair_Date) =  &RevenueMonth
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
WHERE EXTRACT(MONTH FROM Repair_Jobs.Repair_Date) =  &RevenueMonth
ORDER BY Repair_Jobs.RepairJobID;


set termout off

start RepairJobReportCreation.sql &RepairJID
start RepairRevenueReportCreation.sql &RevenueMonth

set termout on

host printf "\nReports Generated !"
