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