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