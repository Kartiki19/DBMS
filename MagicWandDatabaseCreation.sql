/* ======================================== Customer Table ======================================== */
-- CustId will be automatically incremented due to sequence and trigger used in Schema Creation
-- (CustID, Phone_No, Name, Address)
insert into Customer values('1', '5559821234', 'Kartiki', 'Santa Clara'); 
insert into Customer values('2', '5559821231', 'Akshara', 'Santa Monica'); 
insert into Customer values('3', '5559821232', 'John', 'Santa Barbara'); 
insert into Customer values('4', '5559821233', 'Vishu', 'San Jose');
insert into Customer values('5', '5559821235', 'Joe', 'Sunnyvale');
insert into Customer values('6', '5559821236', 'Cian', 'Seattle');
insert into Customer values('7', '5559821237', 'Steve', 'Cupertino');
insert into Customer values('8', '5559821238', 'Rob', 'Dublin');
insert into Customer values('9', '5559821239', 'Ron', 'Santa Clara');
insert into Customer values('10', '5559821211', 'Sally', 'Santa Monica');
insert into Customer values('11', '5559821221', 'Nathan', 'Sunnyvale');
insert into Customer values('12', '5559821251', 'Sam', 'Dublin');
insert into Customer values('13', '5559821241', 'Collin', 'Sunnyvale');

/* ======================================== fees Table ======================================== */
-- (TypeID, Fee)
insert into fees values('Software', 10.0);
insert into fees values('Hardware', 15.0);
insert into fees values('PHardware', 5.0);
insert into fees values('Labour', 25.0);
insert into fees values('LabourAndPart', 100.0);
insert into fees values('Part', 75.0);
insert into fees values('None', 0.0);

/* ======================================== ServiceItems Table ======================================== */
-- (ServiceItemID, ServiceItemName, TypeOfService, Model, Make, ModelYear)
insert into ServiceItems values('S01', 'Laptop', 'Software', 'AB', 'Oracle', 2011);
insert into ServiceItems values('S02', 'Desktop','Software', 'CD', 'IBM', 2003);
insert into ServiceItems values('S03', 'Desktop', 'Hardware', 'MC', 'DELL', 2022);
insert into ServiceItems values('S04', 'Printer', 'PHardware', 'INK', 'HP', 2007);
insert into ServiceItems values('S05', 'Printer', 'PHardware', 'INK', 'Canon', 2008);
insert into ServiceItems values('S06', 'Laptop', 'Software', 'AB', 'Oracle', 2015);
insert into ServiceItems values('S07', 'Desktop','Software', 'CD', 'IBM', 2003);
insert into ServiceItems values('S08', 'DesktopMonitor','Hardware', 'MC', 'DELL', 2022);
insert into ServiceItems values('S09', 'Printer', 'PHardware', 'INK', 'HP', 2007);
insert into ServiceItems values('S10', 'Laptop', 'Hardware', 'CD', 'Mac', 2008);
insert into ServiceItems values('S11', 'Printer', 'PHardware', 'CD', 'Mac', 2008);
insert into ServiceItems values('S12', 'Laptop', 'Hardware', 'CD', 'Mac', 2008);
insert into ServiceItems values('S13', 'DesktopMonitor', 'Hardware', 'CD', 'Mac', 2009);
insert into ServiceItems values('S14', 'Laptop', 'Hardware', 'CD', 'Mac', 2008);
insert into ServiceItems values('S15', 'Printer', 'PHardware', 'CD', 'Mac', 2008);
insert into ServiceItems values('S16', 'DesktopMonitor', 'Hardware', 'CD', 'Mac', 2010);
insert into ServiceItems values('S17', 'Laptop', 'Hardware', 'CD', 'Mac', 2008);


/* ======================================== Monitor Table ======================================== */
-- (ServiceItemID, Model, Make, ModelYear, MonitorSize)
insert into Monitor values('S08', 'MC', 'DELL', 2011, 14.5);
insert into Monitor values('S13', 'M2', 'MAC', 2013, 16.5);
insert into Monitor values('S16', 'M1', 'MAC', 2007, 13);

/* ======================================== Service_Contract Table ======================================== */
-- (ContractID, CustID, ServiceItemID, Start_Date, End_Date, Status
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(1, 1, 'S09', TO_DATE('2022-04-09','YYYY-MM-DD'), TO_DATE('2023-03-09','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(1, 1, 'S08', TO_DATE('2022-04-10','YYYY-MM-DD'), TO_DATE('2023-03-10','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(2, 3, 'S01',  TO_DATE('2022-05-09','YYYY-MM-DD'), TO_DATE('2023-03-09','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(3, 2, 'S02',  TO_DATE('2022-06-02','YYYY-MM-DD'), TO_DATE('2023-02-02','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(4, 10, 'S03',  TO_DATE('2022-11-19','YYYY-MM-DD'), TO_DATE('2023-03-19','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(8, 10, 'S04',  TO_DATE('2022-11-05','YYYY-MM-DD'), TO_DATE('2023-03-05','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(7, 10, 'S07',  TO_DATE('2023-01-02','YYYY-MM-DD'), TO_DATE('2023-03-02','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(5, 13, 'S06',  TO_DATE('2023-02-21','YYYY-MM-DD'), TO_DATE('2023-03-29','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(5, 13, 'S05',  TO_DATE('2023-02-28','YYYY-MM-DD'), TO_DATE('2023-03-28','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(6, 4, 'S10',  TO_DATE('2023-03-25','YYYY-MM-DD'), TO_DATE('2023-06-25','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(8, 5, 'S11',  TO_DATE('2023-03-27','YYYY-MM-DD'), TO_DATE('2023-07-27','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(9, 6, 'S12',  TO_DATE('2023-01-11','YYYY-MM-DD'), TO_DATE('2023-03-11','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(10, 7, 'S13',  TO_DATE('2023-01-19','YYYY-MM-DD'), TO_DATE('2023-03-19','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(11, 8, 'S14',  TO_DATE('2023-02-22','YYYY-MM-DD'), TO_DATE('2023-03-22','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(12, 9, 'S15',  TO_DATE('2023-02-25','YYYY-MM-DD'), TO_DATE('2023-03-25','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(13, 11, 'S16',  TO_DATE('2023-03-25','YYYY-MM-DD'), TO_DATE('2023-08-25','YYYY-MM-DD'));
insert into Service_Contract (ContractID, CustID, ServiceItemID, Start_Date, End_Date) values(14, 12, 'S17',  TO_DATE('2023-03-15','YYYY-MM-DD'), TO_DATE('2023-09-15','YYYY-MM-DD'));


/* ======================================== Repair_Jobs Table ======================================== */
-- RepairItemID will be automatically incremented due to sequence and trigger used in Schema Creation
-- (RepairJobID, CustID, RepairItemID, ServiceItemID, TypeOfRepair, Repair_Date)
insert into Repair_Jobs values(1, 3, 1, 'S01', 'None', TO_DATE('2023-02-19','YYYY-MM-DD'));
insert into Repair_Jobs values(2, 2, 1, 'S02', 'Labour', TO_DATE('2023-08-11','YYYY-MM-DD'));
insert into Repair_Jobs values(2, 2, 1, NULL, 'LabourAndPart', TO_DATE('2023-08-17','YYYY-MM-DD'));
insert into Repair_Jobs values(2, 2, 1, NULL, 'LabourAndPart', TO_DATE('2023-08-11','YYYY-MM-DD'));
insert into Repair_Jobs values(7, 10, 1, 'S03', 'Part', TO_DATE('2023-01-09','YYYY-MM-DD'));
insert into Repair_Jobs values(7, 10, 1, 'S04', 'None', TO_DATE('2023-01-09','YYYY-MM-DD'));
insert into Repair_Jobs values(3, 1, 1, NULL, 'Labour', TO_DATE('2023-12-20','YYYY-MM-DD'));
insert into Repair_Jobs values(3, 1, 1, 'S09', 'LabourAndPart', TO_DATE('2023-12-12','YYYY-MM-DD'));
insert into Repair_Jobs values(3, 1, 1, NULL, 'LabourAndPart', TO_DATE('2023-12-21','YYYY-MM-DD'));
insert into Repair_Jobs values(4, 12, 1, NULL, 'LabourAndPart', TO_DATE('2023-03-09','YYYY-MM-DD'));
insert into Repair_Jobs values(4, 12, 1, 'S10', 'Labour', TO_DATE('2023-03-09','YYYY-MM-DD'));
insert into Repair_Jobs values(5, 9, 1, NULL, 'Labour', TO_DATE('2023-04-25','YYYY-MM-DD'));
insert into Repair_Jobs values(6, 11, 1, NULL, 'LabourAndPart', TO_DATE('2023-05-21','YYYY-MM-DD'));
insert into Repair_Jobs values(7, 4, 1, NULL, 'LabourAndPart', TO_DATE('2023-06-09','YYYY-MM-DD'));
insert into Repair_Jobs values(8, 5, 1, 'S11', 'Labour', TO_DATE('2023-07-09','YYYY-MM-DD'));
insert into Repair_Jobs values(9, 7, 1, NULL, 'Labour', TO_DATE('2023-09-25','YYYY-MM-DD'));
insert into Repair_Jobs values(10, 6, 1, NULL, 'LabourAndPart', TO_DATE('2023-10-09','YYYY-MM-DD'));
insert into Repair_Jobs values(10, 6, 1, 'S12', 'Labour', TO_DATE('2023-10-09','YYYY-MM-DD'));
insert into Repair_Jobs values(11, 8, 1, NULL, 'Labour', TO_DATE('2023-11-25','YYYY-MM-DD'));
Commit;