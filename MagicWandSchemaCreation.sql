/* ======================================== Customer Table ======================================== */
create table Customer(
    CustID int primary key, 
    Phone_No varchar2(10) unique, 
    Name varchar2(30), 
    Address varchar2(30)
);

/* ===== Creating Sequence and trigger for AUTO_INCREMENT CustID ===== */
CREATE SEQUENCE CustIDSeq START WITH 1;

CREATE OR REPLACE TRIGGER CustIDAutoIncrement
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
  SELECT CustIDSeq.NEXTVAL
  INTO   :new.CustID
  FROM   dual;
END;
/
alter trigger CustIDAutoIncrement enable;

/* ======================================== fees Table ======================================== */
create table fees
(
    TypeID varchar2(20) primary key,
    Fee float
);

/* ======================================== ServiceItems Table ======================================== */
create table ServiceItems
(
    ServiceItemID varchar2(10) primary key, 
    ServiceItemName varchar2(20),
    TypeOfService varchar2(30), 
    Model varchar2(10),
    Make varchar2(10),
    ModelYear int,
    foreign key(TypeOfService) references fees(TypeID) on delete set null
);

/* ======================================== Monitor Table ======================================== */
create table Monitor
(
    ServiceItemID varchar2(10) primary key,
    Model varchar2(10),
    Make varchar2(10),
    ModelYear int,
    MonitorSize float,
    foreign key(ServiceItemID) references ServiceItems(ServiceItemID) on delete cascade
);

/* ===== On Update Cascade Trigger for ServiceItemID ===== */
CREATE OR REPLACE TRIGGER ServiceItemIDUpdate_1
AFTER UPDATE OF ServiceItemID ON ServiceItems FOR EACH ROW
BEGIN
    UPDATE Monitor
       SET ServiceItemID = :new.ServiceItemID
     WHERE ServiceItemID = :old.ServiceItemID;
END;
/
alter trigger ServiceItemIDUpdate_1 enable;

/* ======================================== Service_Contract Table ======================================== */
create table Service_Contract
(
    ContractID int, 
    CustID int, 
    ServiceItemID varchar2(10),
    Start_Date date, 
    End_Date date, 
    Status varchar2(10) DEFAULT 'Active', 
    primary key(ContractID, ServiceItemID),
    foreign key(CustID) references Customer(CustID) ON DELETE CASCADE,
    foreign key(ServiceItemID) references ServiceItems(ServiceItemID) ON DELETE SET NULL,
    check(Start_Date <= End_Date)
);

/* ===== On Update Cascade Trigger for CustID ===== */
CREATE OR REPLACE TRIGGER CustIDUpdate_1
AFTER UPDATE OF CustID ON Customer FOR EACH ROW
BEGIN
    UPDATE Service_Contract
       SET CustID = :new.CustID
     WHERE CustID = :old.CustID;
END;
/
alter trigger CustIDUpdate_1 enable;

/* ======================================== Repair_Jobs Table ======================================== */
create table Repair_Jobs
(
    RepairJobID int, 
    CustID int, 
    RepairItemID int unique, 
    ServiceItemID varchar2(10), 
    TypeOfRepair varchar2(30), 
    Repair_Date date, 
    primary key(RepairJobID, RepairItemID),
    foreign key(CustID) references Customer(CustID) on delete cascade,
    foreign key(ServiceItemID) references ServiceItems(ServiceItemID) on delete set null,
    foreign key(TypeOfRepair) references fees(TypeID) on delete set null
);

/* ===== Creating Sequence and trigger for AUTO_INCREMENT RepairItemID ===== */
CREATE SEQUENCE RepairItemIDSeq START WITH 1;

CREATE OR REPLACE TRIGGER RepairItemIDAutoIncrement
BEFORE INSERT ON Repair_Jobs
FOR EACH ROW

BEGIN
  SELECT RepairItemIDSeq.NEXTVAL
  INTO   :new.RepairItemID
  FROM   dual;
END;
/
alter trigger RepairItemIDAutoIncrement enable;

/* ===== On Update Cascade Trigger for CustID ===== */
CREATE OR REPLACE TRIGGER CustIDUpdate_2
AFTER UPDATE OF CustID ON Customer FOR EACH ROW
BEGIN
    UPDATE Service_Contract
       SET CustID = :new.CustID
     WHERE CustID = :old.CustID;
END;
/
alter trigger CustIDUpdate_2 enable;
    
/* ===== On Update Cascade Trigger for ServiceItemID ===== */
CREATE OR REPLACE TRIGGER ServiceItemIDUpdate_2
AFTER UPDATE OF ServiceItemID ON ServiceItems FOR EACH ROW
BEGIN
    UPDATE Monitor
       SET ServiceItemID = :new.ServiceItemID
     WHERE ServiceItemID = :old.ServiceItemID;
END;
/
alter trigger ServiceItemIDUpdate_2 enable;

/* ===== Trigger to check whether repair item is in Service Contract ===== */
CREATE OR REPLACE TRIGGER checkRepairJobs
    AFTER INSERT ON Repair_Jobs
    DECLARE 
        CURSOR repairType IS
            SELECT Repair_Jobs.ServiceItemID, Repair_Jobs.TypeOfRepair FROM Repair_Jobs INNER JOIN Service_Contract ON Repair_Jobs.ServiceItemID = Service_Contract.ServiceItemID WHERE Service_Contract.Status = 'Active';
    BEGIN
        FOR repairJob in repairType LOOP
            UPDATE Repair_Jobs SET TypeOfRepair = 'Part' WHERE TypeOfRepair = 'LabourAndPart' AND Repair_Jobs.ServiceItemID = repairJob.ServiceItemID;
            UPDATE Repair_Jobs SET TypeOfRepair = 'None' WHERE TypeOfRepair = 'Labour' AND Repair_Jobs.ServiceItemID = repairJob.ServiceItemID;
        END LOOP;
    END;
    /
alter trigger checkRepairJobs enable;

/* ======================================== Past_Service_Contracts Table ======================================== */
create table Past_Service_Contracts
(
    CustID int,
    ContractID int, 
    Deletion_date date
);

CREATE OR REPLACE TRIGGER ContractsAfterDelete
AFTER DELETE ON Service_Contract
FOR EACH ROW
    DECLARE 
    BEGIN
        INSERT INTO Past_Service_Contracts VALUES(:old.CustID, :old.ContractID, sysdate);
    END;
    /
alter trigger ContractsAfterDelete enable;

