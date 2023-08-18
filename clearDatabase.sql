delete from Customer;
delete from fees;
delete from ServiceItems;
delete from Monitor;
delete from Service_Contract;
delete from Repair_Jobs;
delete from Past_Service_Contracts;

drop sequence CustIDSeq;
drop sequence RepairItemIDSeq;

alter trigger CustIDAutoIncrement disable;
alter trigger RepairItemIDAutoIncrement disable;
alter trigger CustIDUpdate_1 disable;
alter trigger CustIDUpdate_2 disable;
alter trigger ServiceItemIDUpdate_1 disable;
alter trigger ServiceItemIDUpdate_2 disable;
alter trigger checkRepairJobs disable;
alter trigger ContractsAfterDelete disable;

drop trigger CustIDAutoIncrement;
drop trigger RepairItemIDAutoIncrement;
drop trigger CustIDUpdate_1;
drop trigger CustIDUpdate_2;
drop trigger ServiceItemIDUpdate_1;
drop trigger ServiceItemIDUpdate_2;
drop trigger checkRepairJobs;
drop trigger ContractsAfterDelete;

drop table Past_Service_Contracts;
drop table Repair_Jobs;
drop table Service_Contract;
drop table Monitor;
drop table ServiceItems;
drop table fees;
drop table Customer;