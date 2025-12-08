
-- Final Working SQL Code For Submission

-- DROP AND RE-ADD TABLES --
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


/* ADD TRIGGERS */

-- Trigger to ensure DoctorNotes is provided if ICU stay exists in Examine
-- Q1
CREATE OR REPLACE TRIGGER checkRequireCommentIcu
    BEFORE INSERT OR UPDATE ON Examine
    FOR EACH ROW
DECLARE
    icuCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO icuCount
    FROM StayIn S JOIN RoomService RS ON RS.RoomNum = S.RoomNum
    WHERE S.AdmissionNum = :NEW.AdmissionNum AND RS.Service = 'ICU';

    IF icuCount > 0 THEN
        IF :NEW.DoctorNotes IS NULL OR TRIM(:NEW.DoctorNotes) = '' THEN
            raise_application_error(-20001, 'Doctor must leave a comment when admission included an ICU stay.');
        END IF;
    END IF;
END;

-- Trigger to calculate InsurancePayment as 65% of TotalPayment on Admission
-- Q2
CREATE OR REPLACE TRIGGER admissionInsuranceCalc
    BEFORE INSERT OR UPDATE ON Admission
    FOR EACH ROW
BEGIN
    IF :NEW.TotalPayment IS NULL THEN
        raise_application_error(-20002, 'TotalPayment must be provided.');
    ELSE
        :NEW.InsurancePayment := ROUND(:NEW.TotalPayment * 0.65);
    END IF;
END;

-- Trigger to enforce Employee supervisor hierarchy rules
-- Q3 & Q4
CREATE OR REPLACE TRIGGER employeeSupervisorCheck
    BEFORE INSERT OR UPDATE ON Employee
    FOR EACH ROW
DECLARE
    superRank VARCHAR2(100);
BEGIN
    IF :NEW.EmployeeRank = 'General Manager' THEN
        IF :NEW.SupervisorID IS NOT NULL THEN
            raise_application_error(-20010, 'General Manager must not have a supervisor.');
        END IF;
        RETURN;
    END IF;

    IF :NEW.EmployeeRank IN ('Regular', 'Division Manager') THEN
        IF :NEW.SupervisorID IS NULL THEN
            raise_application_error(-20011, 'Regular and Division Manager employees must have a supervisor.');
        END IF;

        BEGIN
            SELECT EmployeeRank INTO superRank FROM Employee WHERE EmployeeID = :NEW.SupervisorID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20012, 'Supervisor does not exist.');
        END;

        IF :NEW.EmployeeRank = 'Regular' AND superRank <> 'Division Manager' THEN
            raise_application_error(-20013, 'Regular employees must have a Division Manager as supervisor.');
        ELSIF :NEW.EmployeeRank = 'Division Manager' AND superRank <> 'General Manager' THEN
            raise_application_error(-20014, 'Division Managers must have a General Manager as supervisor.');
        END IF;
    ELSE
        NULL;
    END IF;
END;

-- Trigger to prevent deletion of Employees who supervise others
-- Q3 & Q4
CREATE OR REPLACE TRIGGER preventDeleteIfSupervises
    BEFORE DELETE ON Employee
    FOR EACH ROW
DECLARE
    empCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO empCount FROM Employee WHERE SupervisorID = :OLD.EmployeeID;
    IF empCount > 0 THEN
        raise_application_error(-20015, 'Cannot delete employee: they are a supervisor of other employees.');
    END IF;
END;

-- Trigger to set FutureVisit date for emergency stays in StayIn
-- Q5
CREATE OR REPLACE TRIGGER setFutureVisitForEmergency
    AFTER INSERT ON StayIn
    FOR EACH ROW
DECLARE
    emergencyCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO emergencyCount
    FROM RoomService RS
    WHERE RS.RoomNum = :NEW.RoomNum
      AND RS.Service = 'Emergency';

    IF emergencyCount > 0 THEN
        UPDATE Admission
        SET FutureVisit = ADD_MONTHS(:NEW.StartDate, 2)
        WHERE Num = :NEW.AdmissionNum
          AND FutureVisit IS NULL;
    END IF;
END;

-- Trigger to set FutureVisit date on Admission insert if existing emergency stays
-- Q5
CREATE OR REPLACE TRIGGER setFutureVisitExistStays
    BEFORE INSERT ON Admission
    FOR EACH ROW
DECLARE
    stayCount INTEGER;
    firstStart DATE;
BEGIN
    SELECT COUNT(*) INTO stayCount
    FROM StayIn S
             JOIN RoomService RS ON RS.RoomNum = S.RoomNum
    WHERE S.AdmissionNum = :NEW.Num
      AND RS.Service = 'Emergency';

    IF stayCount > 0 THEN
        SELECT MIN(S.StartDate) INTO firstStart
        FROM StayIn S
                 JOIN RoomService RS ON RS.RoomNum = S.RoomNum
        WHERE S.AdmissionNum = :NEW.Num AND RS.Service = 'Emergency';

        IF :NEW.FutureVisit IS NULL THEN
            :NEW.FutureVisit := ADD_MONTHS(NVL(firstStart, :NEW.AdmissionDate), 2);
        END IF;
    END IF;
END;

-- Trigger to update LastInspection in Equipment if technician can repair and inspection is old
-- Q6
CREATE OR REPLACE TRIGGER updateInspectionIfTechExists
    BEFORE INSERT OR UPDATE ON Equipment
    FOR EACH ROW
DECLARE
    repairCount INTEGER;
BEGIN
    IF :NEW.TypeID IS NOT NULL THEN
        IF :NEW.LastInspection IS NULL OR :NEW.LastInspection < ADD_MONTHS(SYSDATE, -1) THEN
            SELECT COUNT(*) INTO repairCount
            FROM CanRepairEquipment C
            WHERE C.EquipmentType = :NEW.TypeID;

            IF repairCount > 0 THEN
                :NEW.LastInspection := SYSDATE;
            END IF;
        END IF;
    END IF;
END;

/* INSERT VIEWS AND SQL QUERIES */

-- View to identify patients with multiple ICU admissions
CREATE OR REPLACE VIEW CriticalCases AS
SELECT P.SSN AS Patient_SSN, P.FName AS firstName, P.LName AS lastName, COUNT(*) AS numberOfAdmissionsToICU
FROM Patient P
         JOIN Admission A ON P.SSN = A.PatientSSN
         JOIN StayIn S ON S.AdmissionNum = A.Num
         JOIN RoomService RS ON RS.RoomNum = S.RoomNum
WHERE RS.Service = 'ICU'
GROUP BY P.SSN, P.FName, P.LName
HAVING COUNT(*) >= 2;

-- View to determine doctor workload based on number of admissions examined
CREATE OR REPLACE VIEW DoctorsLoad AS
SELECT D.EmployeeID AS DoctorID, D.GraduatedFrom,
       CASE
           WHEN COUNT(DISTINCT E.AdmissionNum) > 10 THEN 'Overloaded'
           ELSE 'Underloaded'
           END AS load
FROM Doctor D
         LEFT JOIN Examine E ON D.EmployeeID = E.DoctorID
GROUP BY D.EmployeeID, D.GraduatedFrom;

-- Query to find patients with more than 4 ICU admissions
SELECT Patient_SSN, firstName, lastName, numberOfAdmissionsToICU
FROM CriticalCases
WHERE numberOfAdmissionsToICU > 4;

-- Query to list doctors who are overloaded and graduated from WPI
SELECT DL.DoctorID, E.FName, E.LName
FROM DoctorsLoad DL JOIN Employee E ON DL.DoctorID = E.EmployeeID
WHERE DL.load = 'Overloaded' AND DL.graduatedFrom = 'WPI';

-- Query to get comments from underloaded doctors for critical patients
SELECT EX.DoctorID, CC.Patient_SSN, EX.DoctorNotes AS DoctorComment
FROM Examine EX
         JOIN Admission A ON EX.AdmissionNum = A.Num
         JOIN CriticalCases CC ON CC.Patient_SSN = A.PatientSSN
         JOIN DoctorsLoad DL ON DL.DoctorID = EX.DoctorID
WHERE DL.load = 'Underloaded';