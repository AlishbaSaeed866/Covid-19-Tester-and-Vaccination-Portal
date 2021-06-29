create database CTVPortal;
use CTVPortal;
 

create table Doctors(
 Doctor_id int(3) unique,
 Dname varchar(30), 
 AgeGroup varchar(30), 
 ApprovedStatus varchar(15), 
 Doc_Remakrs varchar(50), 
 DYear year, 
 Specialist_id int(3) primary key, 
 Disease varchar(30));
 desc Doctors;
 
 create table Domains(
 Domain_id int(5) Primary Key ,
 DName varchar(30) unique , 
 Doc_Mgr int(3),
 Start_date date, 
 foreign key(Doc_Mgr) references Doctors(Specialist_id) 
 on update cascade on delete cascade );
 desc Domains;
 
 
insert into Doctors (Doctor_id, Dname ,AgeGroup ,ApprovedStatus ,Doc_Remakrs ,DYear ,Specialist_id ,Disease )
values(001,'Fareeha Amjad', '70+'   ,'Approved','Fit for Vaccination',2021,003,'None'),
(002,'Iqra Tasawar' , '40-70' ,'Approved','Fit for Vaccination',2022,001,'None') ,
(003,'ALishba Saeed', '18-40' ,'Approved','Fit for Vaccination',2020,002,'None') ;
select * from Doctors;

 

insert into Domains(Domain_id,DName,Doc_Mgr,Start_date) values
(35201, 'Home', 001, '2021-5-21'),
(35202, 'Covid-19', 002, '2019-03-02'),
(35203, 'Covid Vaccine', 002, '2018-04-11'),
(35204, 'QUARANTINE SUPPORT', 003, '2020-07-01'),
(35205, 'SOPs', 001, '2021-4-09');
select * from Domains;

 

create table Patients(
Cnic int(13) primary key, 
PName varchar (30), 
Age int, 
Gender char(1), 
dob date, 
Address varchar(500),
 Temperature  decimal(5),
 BloodPressure int(3),
 DID int(5));
desc Patients;

 

create table Appointment(
 Ap_id int(13) , 
 D_id int(3),
 foreign key(Ap_id) references Patients(Cnic)  on update cascade on delete cascade,
 foreign key(D_id) references Doctors(Doctor_id)  on update cascade on delete cascade);
 desc Appointment;
 

 

insert into Patients (Cnic,PName,Age,Gender,dob,Address,Temperature,BloodPressure,DID)values
( 5329154728, 'Zulfi', 73, 'M', '1945-4-22', 'Lahore 123', 45,120,001),
(1234567891,'Shaheen',23,'M','1998-8-11', 'Lahore 583', 32.9,110,002),
(990746781,'Ayesha',37,'F','1995-3-9', 'Cheechawatni 723', 40.5,90,003),
(876678865,'Rabia',30,'F','1990-4-21', 'Karachi 433', 50.9,120,001),
(980870702,'Fatima',20,'F','2000-5-14', 'Multan 790', 37.9,120,003);
select* from  Patients;

 

insert into Appointment(Ap_id, D_id) values
(5329154728,001),
(1234567891,002),
(990746781,003);
select * from Appointment;

 

create table QarantineSupport(
QS_id int(3)primary key,
P_id int(13), 
S_id int(3), 
start_date date, 
End_date date, 
HealthReport varchar(30),
Major_Symptoms varchar(30));
desc QarantineSupport;

 

create table Monitors(
S_id int(3),QS_id int(3),
foreign key(S_id) references Doctors(Specialist_id) on update cascade on delete cascade,
foreign key (QS_id) references QarantineSupport(QS_id)on update cascade on delete cascade);
desc Monitors;

 

insert into QarantineSupport(QS_id,P_id ,S_id ,start_date ,End_date ,HealthReport ,Major_Symptoms)
values(12,5329154728,003,'2021-03-21','2021-04-30','Recovered','coughing'),
(23,1234567891,002,'2020-12-01','2021-01-25','Recovered','aches, pains'),
(34,990746781,001,'2021-01-25','2021-02-15','Recovered','tiredness');
select*from QarantineSupport;

 

insert into Monitors (QS_id,S_id) values
(12,003),
(23,002),
(34,001);
select * from Monitors;

 


create table PositiveTest(
Affected_id int(3),
id int(13),
foreign key(Affected_id) references Patients(Cnic) on update cascade on delete cascade,
foreign key(id) references QarantineSupport(QS_id) on update cascade on delete cascade);
desc PositiveTest;

 


insert into PositiveTest(Affected_id, id) values
(5329154728,12),
(1234567891,23),
(990746781,34);
select * from PositiveTest; 

 


create table WaitingList(
Waiting_ID int(3) primary key,
Province varchar(20),
Age int);
desc WaitingList;

 

create table waiting_line (
cnic int(13),
Waiting_ID int(3),
foreign key(cnic) references Patients(Cnic) on update cascade on delete cascade,
foreign key(Waiting_ID) references WaitingList(Waiting_ID) on update cascade on delete cascade);
desc waiting_line;

 


insert into WaitingList (Waiting_ID,Province,Age) values
(111,'Punjab',50),
(222,'balochistan',23),
(333,'KPK',40),
(444,'Sindh',30);
select * from WaitingList;

 

insert into waiting_line (cnic,Waiting_ID) values
(876678865,222),
(980870702,333),
(990746781,444),
(1234567891,111);
select * from waiting_line;

 

create table Vaccine(
Vaccine_id int(2) Primary key , 
Vname varchar (20) unique, 
Country varchar(30), 
Duration year, 
noOfDose int, 
Expire_date date, 
Temperature float);
desc Vaccine;

 

create table Dose1(Dose_id int primary key, injectedDate date,Waiting_ID int(3),Vaccine_id int(2),
foreign key(Waiting_ID) references WaitingList(Waiting_ID) on update cascade on delete cascade,
foreign key(Vaccine_id) references Vaccine(Vaccine_id) on update cascade on delete cascade);
desc Dose1;

 


insert into Vaccine(Vaccine_id,Vname,Country,Duration,noOfDose,Expire_date,Temperature) values
(1,'Pfizer','Europe','3 Weeks',2,'2022-01-01',-25.5),
(2,'Sinopharm','China','3-4 Weeks',2,'2022-01-01',4),
(3,'AstraZeneca','Oxford','8-12 Weeks',2,'2022-01-14',21),
(4,'SinoVac','China','2-4 Weeks',2,'2021-12-30',26);
select *from Vaccine;

 

insert into Dose1(Dose_id,injectedDate,Waiting_ID,Vaccine_id) values
(1,'2021-05-23',111,2),
(2,'2021-06-11',222,1),
(3,'2021-04-02',333,4),
(4,'2021-04-30',444,3);
select * from Dose1;

 

create table Dose2(Dose2_id int primary key, injectedDate2 date,Waiting_ID int(3),Vaccine_id int(2),d1 int,
foreign key(Vaccine_id) references Vaccine(Vaccine_id) on update cascade on delete cascade,
 foreign key (d1) references Dose1(Dose_id) on update cascade on delete cascade);

 


insert into Dose2(Dose2_id,injectedDate2,Waiting_ID,Vaccine_id,d1) values
(5,'2021-06-23',111,2,1),
(6,'2021-06-30',222,1,2),
(7,'2021-05-9',333,4,3),
(8,'2021-05-29',444,3,4);
select * from Dose2;

 


create table CheckOut(
Checkout_ID int(3) primary key,
VaccinatedDate date, 
location varchar(50), 
VaccinatedTime time);
desc CheckOut;
 
create table ManagingTeam(
M_id int unique,
Province varchar(30) unique, 
Province_id int(5)
primary key );
desc ManagingTeam;

 

create table Records(Checkout_ID int(3), M_id int, P_id int,
foreign key (Checkout_ID) references CheckOut(Checkout_ID) on update cascade on delete cascade ,
foreign key (M_id) references ManagingTeam(M_id) on update cascade on delete cascade ,
foreign key (P_id) references ManagingTeam(Province_id) on update cascade on delete cascade );
desc Records;

 

create table Vaccinated(id2 int, ckOut_id int(3),
foreign key (ckOut_id) references CheckOut(Checkout_ID) on update cascade on delete cascade ,
foreign key (id2) references Dose2(Dose2_id) on update cascade on delete cascade);
desc Vaccinated;

 


insert into CheckOut (Checkout_ID,VaccinatedDate,location,VaccinatedTime) values
(997,'2021-03-03','ExpoCenter Lahore','553'),
(347,'2021-02-04','Government School Gujjarpura','765'),
(667,'2021-11-06','Islamia High School Cantt','239'),
(568,'2021-05-10','ExpoCenter Karachi','453'),
(778,'2021-06-12','Government APS Boys High School Model Town','553');
select * from CheckOut;

 

insert into ManagingTeam(M_id,Province,Province_id) values
(1,'Gilgit Baldistan',00001),
(2,'Punjab',00002),
(3,'Sindh',00003),
(4,'Balochistan',00004),
(5,'KPK',00005);
select * from ManagingTeam;

 

insert into Records(Checkout_ID, M_id, P_id) values 
(997,1,00001),
(778,2,00002),
(347,3,00003),
(667,4,00004),
(568,5,00005);
select * from Records;

 

insert into Vaccinated (id2,ckOut_id) values
(5,997),
(6,347),
(7,667),
(8,568);
select * from Vaccinated;