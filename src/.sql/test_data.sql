
/* INSERT DATA */
INSERT INTO Room(RoomNum, IsOccupied) VALUES (101, 1);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (102, 0);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (103, 1);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (104, 0);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (105, 0);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (201, 0);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (202, 1);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (203, 0);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (301, 1);
INSERT INTO Room(RoomNum, IsOccupied) VALUES (302, 0);

INSERT INTO RoomService(RoomNum, Service) VALUES (101, 'ICU');
INSERT INTO RoomService(RoomNum, Service) VALUES (101, 'Consulting');
INSERT INTO RoomService(RoomNum, Service) VALUES (102, 'Ward');
INSERT INTO RoomService(RoomNum, Service) VALUES (103, 'Ward');
INSERT INTO RoomService(RoomNum, Service) VALUES (103, 'Operating');
INSERT INTO RoomService(RoomNum, Service) VALUES (201, 'Ward');
INSERT INTO RoomService(RoomNum, Service) VALUES (201, 'Emergency');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (1, 'Alice', 'King', 150000, 'General Manager', 1, 'General Manager', NULL, '1 Main St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (2, 'Bob', 'Queen', 150000, 'General Manager', 2, 'General Manager', NULL, '2 Main St', 'Townsville');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (10, 'Carol', 'Smith', 120000, 'Division Manager', 10, 'Division Manager', 1, '10 Div Ave', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (11, 'David', 'Jones', 120000, 'Division Manager', 11, 'Division Manager', 1, '11 Div Ave', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (12, 'Eve', 'Brown', 120000, 'Division Manager', 12, 'Division Manager', 2, '12 Div Ave', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (13, 'Frank', 'White', 120000, 'Division Manager', 13, 'Division Manager', 2, '13 Div Ave', 'Townsville');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (20, 'Greg', 'Miller', 90000, 'Doctor', 201, 'Regular', 10, '20 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (21, 'Hannah', 'Davis', 92000, 'Doctor', 202, 'Regular', 10, '21 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (22, 'Ian', 'Wilson', 88000, 'Doctor', 203, 'Regular', 11, '22 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (23, 'Jane', 'Moore', 94000, 'Doctor', 204, 'Regular', 11, '23 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (24, 'Kyle', 'Taylor', 91000, 'Doctor', 205, 'Regular', 12, '24 Doc St', 'Townsville');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (35, 'Victor', 'Stone', 95000, 'Doctor', 206, 'Regular', 12, '25 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (36, 'Wendy', 'Shaw', 93000, 'Doctor', 207, 'Regular', 13, '26 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (37, 'Xander', 'Cole', 72000, 'Equipment Technician', 306, 'Regular', 10, '27 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (38, 'Yara', 'Lopez', 65000, 'Nurse', 407, 'Regular', 11, '28 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (39, 'Zack', 'Reed', 75000, 'Technician', 408, 'Regular', 12, '29 Doc St', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (40, 'Ava', 'Price', 70000, 'Accountant', 409, 'Regular', 13, '30 Doc St', 'Townsville');

INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (20, 'M', 'Cardiology', 'WPI');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (21, 'F', 'Neurology', 'Harvard');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (22, 'M', 'Cardiology', 'WPI');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (23, 'F', 'Pediatrics', 'Stanford');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (24, 'M', 'Orthopedics', 'WPI');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (35, 'M', 'Oncology', 'UCLA');
INSERT INTO Doctor(EmployeeID, Gender, Specialty, GraduatedFrom) VALUES (36, 'F', 'Dermatology', 'WPI');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (25, 'Liam', 'Harris', 70000, 'Equipment Technician', 301, 'Regular', 12, '25 Tech Rd', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (26, 'Mia', 'Clark', 72000, 'Equipment Technician', 302, 'Regular', 13, '26 Tech Rd', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (27, 'Noah', 'Lewis', 71000, 'Equipment Technician', 303, 'Regular', 13, '27 Tech Rd', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (28, 'Olivia', 'Walker', 73000, 'Equipment Technician', 304, 'Regular', 10, '28 Tech Rd', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (29, 'Paul', 'Hall', 70000, 'Equipment Technician', 305, 'Regular', 11, '29 Tech Rd', 'Townsville');

INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (30, 'Quinn', 'Allen', 60000, 'Nurse', 401, 'Regular', 10, '30 Nurse Ln', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (31, 'Rita', 'Young', 61000, 'Receptionist', 402, 'Regular', 11, '31 Rec Ave', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (32, 'Sam', 'Scott', 62000, 'Technician', 403, 'Regular', 12, '32 Tech Ave', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (33, 'Tina', 'Adams', 63000, 'Accountant', 404, 'Regular', 13, '33 Acct Blvd', 'Townsville');
INSERT INTO Employee(EmployeeID, FName, LName, Salary, JobTitle, OfficeNum, EmployeeRank, SupervisorID, AddressStreet, AddressCity)
VALUES (34, 'Uma', 'Baker', 64000, 'Pharmacist', 405, 'Regular', 10, '34 Pharm Rd', 'Townsville');

INSERT INTO EquipmentType(EquipID, EquipDesc, EquipModel, Instructions, NumberOfUnits)
VALUES (100, 'X-Ray Machine', 'XR-200', 'Handle with care', 3);
INSERT INTO EquipmentType(EquipID, EquipDesc, EquipModel, Instructions, NumberOfUnits)
VALUES (101, 'Heart Monitor', 'HM-10', 'Check wires', 3);
INSERT INTO EquipmentType(EquipID, EquipDesc, EquipModel, Instructions, NumberOfUnits)
VALUES (102, 'Ventilator', 'VNT-5', 'Sanitize', 3);

INSERT INTO EquipmentType(EquipID, EquipDesc, EquipModel, Instructions, NumberOfUnits)
VALUES(103, 'Ultrasound Machine', 'US-500', 'Gel required', 4);
INSERT INTO EquipmentType(EquipID, EquipDesc, EquipModel, Instructions, NumberOfUnits)
VALUES (104, 'ECG Monitor', 'ECG-12', 'Electrodes required', 5);

INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (25, 100);
INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (26, 100);
INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (27, 101);
INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (37, 103);
INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (37, 104);
INSERT INTO CanRepairEquipment(EmployeeID, EquipmentType) VALUES (26, 103);

INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('A01-02X', 100, 2010, TO_DATE('2024-10-01','YYYY-MM-DD'), 103);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('X100-001', 100, 2011, TO_DATE('2024-09-15','YYYY-MM-DD'), 101);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('X100-002', 100, 2010, TO_DATE('2024-01-10','YYYY-MM-DD'), 102);

INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('HM10-01', 101, 2011, TO_DATE('2024-08-20','YYYY-MM-DD'), 201);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('HM10-02', 101, 2009, TO_DATE('2024-02-05','YYYY-MM-DD'), 202);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('HM10-03', 101, 2012, TO_DATE('2024-06-01','YYYY-MM-DD'), 301);

INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('VNT5-01', 102, 2010, TO_DATE('2024-07-01','YYYY-MM-DD'), 203);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('VNT5-02', 102, 2011, TO_DATE('2024-05-12','YYYY-MM-DD'), 302);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('VNT5-03', 102, 2008, TO_DATE('2024-03-03','YYYY-MM-DD'), 301);

INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('US500-01', 103, 2013, TO_DATE('2024-04-01','YYYY-MM-DD'), 104);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('US500-02', 103, 2016, TO_DATE('2024-06-15','YYYY-MM-DD'), 201);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('ECG12-01', 104, 2014, TO_DATE('2024-08-09','YYYY-MM-DD'), 105);
INSERT INTO Equipment(SerialNumber, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('ECG12-02', 104, 2012, TO_DATE('2024-07-20','YYYY-MM-DD'), 203);

INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('111-22-3333','Adam','Lee','100 Oak St','555-0100');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('222-33-4444','Beth','Kim','200 Pine St','555-0101');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('333-44-5555','Carl','Ng','300 Maple St','555-0102');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('444-55-6666','Dora','Park','400 Birch St','555-0103');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('555-66-7777','Ethan','Fox','500 Elm St','555-0104');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('666-77-8888','Fay','Green','600 Spruce St','555-0105');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('777-88-9999','Gary','Hall','700 Cedar St','555-0106');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('888-99-0000','Holly','Ives','800 Ash St','555-0107');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('999-00-1111','Ian','Jones','900 Poplar St','555-0108');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('000-11-2222','Jill','King','1000 Willow St','555-0109');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('123-45-6789', 'Kevin', 'Summers', '1100 Birch Rd', '555-0110');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('234-56-7890', 'Laura', 'Miles', '1200 Aspen Ln', '555-0111');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('345-67-8901', 'Marcus', 'Vega', '1300 Cedar Rd', '555-0112');
INSERT INTO Patient(SSN, FName, LName, Address, TelNum) VALUES ('555-11-2223', 'Rosa', 'Diaz', '1400 Oak Ridge', '555-0123');

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1000, TO_DATE('2010-01-10','YYYY-MM-DD'), TO_DATE('2010-01-15','YYYY-MM-DD'), 5000, 3000, '111-22-3333', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1001, TO_DATE('2011-02-05','YYYY-MM-DD'), TO_DATE('2011-02-10','YYYY-MM-DD'), 4500, 2500, '111-22-3333', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1002, TO_DATE('2012-03-10','YYYY-MM-DD'), TO_DATE('2012-03-12','YYYY-MM-DD'), 2000, 1000, '222-33-4444', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1003, TO_DATE('2013-04-11','YYYY-MM-DD'), TO_DATE('2013-04-13','YYYY-MM-DD'), 3000, 1500, '222-33-4444', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1004, TO_DATE('2014-05-01','YYYY-MM-DD'), TO_DATE('2014-05-05','YYYY-MM-DD'), 3500, 2000, '333-44-5555', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1005, TO_DATE('2015-06-07','YYYY-MM-DD'), TO_DATE('2015-06-10','YYYY-MM-DD'), 4000, 2500, '333-44-5555', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1006, TO_DATE('2016-07-09','YYYY-MM-DD'), TO_DATE('2016-07-11','YYYY-MM-DD'), 1500, 500, '444-55-6666', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1007, TO_DATE('2017-08-12','YYYY-MM-DD'), TO_DATE('2017-08-14','YYYY-MM-DD'), 2500, 1500, '444-55-6666', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1008, TO_DATE('2018-09-15','YYYY-MM-DD'), TO_DATE('2018-09-16','YYYY-MM-DD'), 1800, 800, '555-66-7777', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1009, TO_DATE('2019-10-20','YYYY-MM-DD'), TO_DATE('2019-10-22','YYYY-MM-DD'), 2200, 1000, '555-66-7777', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1010, TO_DATE('2020-11-01','YYYY-MM-DD'), TO_DATE('2020-11-03','YYYY-MM-DD'), 2600, 1300, '666-77-8888', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1011, TO_DATE('2021-12-02','YYYY-MM-DD'), TO_DATE('2021-12-04','YYYY-MM-DD'), 2700, 1200, '666-77-8888', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1012, TO_DATE('2022-01-05','YYYY-MM-DD'), TO_DATE('2022-01-07','YYYY-MM-DD'), 3200, 1600, '777-88-9999', NULL);
INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1013, TO_DATE('2023-02-06','YYYY-MM-DD'), TO_DATE('2023-02-08','YYYY-MM-DD'), 3300, 1700, '777-88-9999', NULL);

INSERT INTO Admission(Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1014, TO_DATE('2018-03-03','YYYY-MM-DD'), TO_DATE('2018-03-05','YYYY-MM-DD'), 2100, 1100, '111-22-3333', TO_DATE('2025-12-01','YYYY-MM-DD'));

INSERT INTO Admission (Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1015, TO_DATE('2024-01-10','YYYY-MM-DD'), TO_DATE('2024-01-11','YYYY-MM-DD'), 2100, 1100, '123-45-6789', NULL);

INSERT INTO Admission (Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1016, TO_DATE('2024-02-15','YYYY-MM-DD'), TO_DATE('2024-02-17','YYYY-MM-DD'), 3200, 1600, '234-56-7890', TO_DATE('2025-12-05','YYYY-MM-DD'));

INSERT INTO Admission (Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1017, TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2024-03-03','YYYY-MM-DD'), 2800, 1200, '345-67-8901', NULL);

INSERT INTO Admission (Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1018, TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-03','YYYY-MM-DD'), 3500, 2000, '555-11-2223', NULL);

INSERT INTO Admission (Num, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FutureVisit)
VALUES (1019, TO_DATE('2024-05-10','YYYY-MM-DD'), TO_DATE('2024-05-12','YYYY-MM-DD'), 3600, 2100, '555-11-2223', NULL);

INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (20, 1000, 'Checkup A');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (20, 1001, 'Checkup B');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (20, 1014, 'Follow-up C');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (21, 1002, 'Neurology eval');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (22, 1003, 'Cardio consult');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (23, 1004, 'Pediatrics');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (24, 1005, 'Ortho consult');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (35, 1015, 'Oncology evaluation');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (36, 1016, 'Dermatology follow-up');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (35, 1017, 'General exam');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (20, 1018, 'ICU observation');
INSERT INTO Examine(DoctorID, AdmissionNum, DoctorNotes) VALUES (20, 1019, 'Follow-up ICU evaluation');

INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1000, 101, TO_DATE('2010-01-10','YYYY-MM-DD'), TO_DATE('2010-01-15','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1001, 102, TO_DATE('2011-02-05','YYYY-MM-DD'), TO_DATE('2011-02-10','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1014, 103, TO_DATE('2018-03-03','YYYY-MM-DD'), TO_DATE('2018-03-05','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1015, 102, TO_DATE('2024-01-10','YYYY-MM-DD'), TO_DATE('2024-01-11','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1016, 101, TO_DATE('2024-02-15','YYYY-MM-DD'), TO_DATE('2024-02-17','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1017, 201, TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2024-03-03','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1018, 101, TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-03','YYYY-MM-DD'));
INSERT INTO StayIn(AdmissionNum, RoomNum, StartDate, EndDate) VALUES (1019, 101, TO_DATE('2024-05-10','YYYY-MM-DD'), TO_DATE('2024-05-12','YYYY-MM-DD'));

INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (101, 30);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (102, 30);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (103, 30);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (104, 30);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (105, 30);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (101, 20);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (201, 25);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (202, 26);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (203, 27);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (301, 28);
INSERT INTO RoomAccess(RoomNum, EmpID) VALUES (302, 29);
