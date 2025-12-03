
DROP TABLE CANREPAIREQUIPMENT;
DROP TABLE EXAMINE;
DROP TABLE ROOMACCESS;
DROP TABLE ROOMSERVICE;
DROP TABLE STAYIN;
DROP TABLE EQUIPMENT;
DROP TABLE EQUIPMENTTYPE;
DROP TABLE ADMISSION;
DROP TABLE EQUIPMENTTECHNICIAN;
DROP TABLE ROOM;
DROP TABLE PATIENT;
DROP TABLE DOCTOR;
DROP TABLE EMPLOYEE;

/* CREATE TABLES */
CREATE TABLE Employee (
                          EmployeeID INT PRIMARY KEY,
                          FName VARCHAR(50) NOT NULL,
                          LName VARCHAR(50) NOT NULL,
                          Salary INT NOT NULL,
                          JobTitle VARCHAR(50) NOT NULL,
                          OfficeNum INT NOT NULL,
                          EmployeeRank VARCHAR(50) NOT NULL,
                          SupervisorID INT,
                          AddressStreet VARCHAR(50) NOT NULL,
                          AddressCity VARCHAR(50) NOT NULL
);

CREATE TABLE Doctor(
                       EmployeeID INT PRIMARY KEY,
                       Gender VARCHAR(50) NOT NULL,
                       Specialty VARCHAR(50) NOT NULL,
                       GraduatedFrom VARCHAR(50) NOT NULL,

                       FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE EquipmentTechnician(
                                    EmployeeID INT PRIMARY KEY,

                                    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE EquipmentType(
                              EquipID INT PRIMARY KEY,
                              EquipDesc VARCHAR(100),
                              EquipModel VARCHAR(50),
                              Instructions VARCHAR(100),
                              NumberOfUnits INT NOT NULL
);

CREATE TABLE Room(
                     RoomNum NUMBER PRIMARY KEY,
                     IsOccupied NUMBER(1) DEFAULT 0 NOT NULL
);

CREATE TABLE Equipment(
                          SerialNumber VARCHAR(20),
                          TypeID INT,
                          PurchaseYear INT NOT NULL,
                          LastInspection DATE NOT NULL,
                          RoomNum INT NOT NULL,

                          FOREIGN KEY (TypeID) REFERENCES EquipmentType(EquipID),
                          FOREIGN KEY (RoomNum) REFERENCES Room(RoomNum),

                          CONSTRAINT PK_EQUIPMENT PRIMARY KEY (SerialNumber, TypeID)
);

CREATE TABLE CanRepairEquipment(
                                   EmployeeID INT,
                                   EquipmentType INT,

                                   FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
                                   FOREIGN KEY (EquipmentType) REFERENCES EquipmentType(EquipID),

                                   CONSTRAINT PK_CRE PRIMARY KEY (EmployeeID, EquipmentType)
);

CREATE TABLE RoomService(
                            RoomNum INT,
                            Service VARCHAR(50),

                            FOREIGN KEY (RoomNum) REFERENCES Room(RoomNum),

                            CONSTRAINT PK_RS PRIMARY KEY (RoomNum, Service)
);

CREATE TABLE RoomAccess(
                           RoomNum INT,
                           EmpID INT,

                           FOREIGN KEY (EmpID) REFERENCES Employee(EmployeeID),
                           FOREIGN KEY (RoomNum) REFERENCES Room(RoomNum),

                           CONSTRAINT PK_RA PRIMARY KEY (RoomNum, EmpID)
);

CREATE TABLE Patient(
                        SSN VARCHAR(20)PRIMARY KEY,
                        FName VARCHAR(50) NOT NULL,
                        LName VARCHAR(50) NOT NULL,
                        Address VARCHAR(50) NOT NULL,
                        TelNum VARCHAR(50) NOT NULL
);

CREATE TABLE Admission(
                          Num INT PRIMARY KEY,
                          AdmissionDate DATE NOT NULL,
                          LeaveDate DATE NOT NULL,
                          TotalPayment INT NOT NULL,
                          InsurancePayment INT NOT NULL,
                          PatientSSN VARCHAR(20) NOT NULL,
                          FutureVisit DATE,

                          FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN)
);

CREATE TABLE Examine(
                        DoctorID INT NOT NULL,
                        AdmissionNum INT NOT NULL,
                        DoctorNotes VARCHAR(50) NOT NULL,

                        FOREIGN KEY (DoctorID) REFERENCES Doctor(EmployeeID),
                        FOREIGN KEY (AdmissionNum) REFERENCES Admission(Num),

                        CONSTRAINT PK_EXAMINE PRIMARY KEY (DoctorID, AdmissionNum)
);

CREATE TABLE StayIn(
                       AdmissionNum INT,
                       RoomNum INT,
                       StartDate DATE,
                       EndDate DATE,

                       FOREIGN KEY (AdmissionNum) REFERENCES Admission(Num),
                       FOREIGN KEY (RoomNum) REFERENCES Room(RoomNum),

                       CONSTRAINT PK_STAY PRIMARY KEY (AdmissionNum, RoomNum, StartDate, EndDate)
);