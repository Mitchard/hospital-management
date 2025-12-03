
/* QUERIES */

/* Return all doctors that graduated from WPI*/
SELECT *
FROM Doctor
WHERE GraduatedFrom = 'WPI';

/* Return employee id, names and salary for division manager with id number 10*/
SELECT E.EmployeeID, E.FName, E.LName, E.Salary
FROM Employee E
WHERE SupervisorID = 10;

/* Return patient SSN and how much money was covered by insurance for their visits */
SELECT A.PatientSSN, SUM(InsurancePayment) AS TotalInsurance
FROM Admission A
GROUP BY A.PatientSSN;

/* Return patient SSN, name and their number of visits */
SELECT P.SSN, P.FName, P.LName, COUNT(A.Num) AS NumVisits
FROM Patient P
         JOIN Admission A ON P.SSN = A.PatientSSN
GROUP BY P.SSN, P.FName, P.LName;

/* Return room numbers with equipment unit with serial number 'A01-02X' */
SELECT E.RoomNum
FROM Equipment E
WHERE E.SerialNumber = 'A01-02X';

/* Return employee with access to largest number of rooms */
WITH AccessCount AS (
    Select RA.EmpID, COUNT(*) AS RoomCount
    FROM RoomAccess RA
    GROUP BY RA.EmpID
),
     MaxCount AS (
         SELECT MAX(RoomCount) AS MaxRooms
         FROM AccessCount
     )
SELECT A.EmpID, A.RoomCount
FROM AccessCount A, MaxCount M
WHERE A.RoomCount = M.MaxRooms;

/* Report the type of employees as well as how many each of them there are */
SELECT E.EmployeeRank AS Type, COUNT(*) AS Count
FROM Employee E
WHERE E.EmployeeRank IN ('Regular', 'Division Manager', 'General Manager')
GROUP BY E.EmployeeRank;

/* Return the SSN and name and visit date of patients with a future visit */
WITH LatestAD AS (
    SELECT A.PatientSSN, A.AdmissionDate, A.FutureVisit
    FROM Admission A
             JOIN (
        SELECT PatientSSN, MAX(AdmissionDate) AS LatestDate
        FROM Admission
        GROUP BY PatientSSN
    ) L ON A.PatientSSN = L.PatientSSN AND A.AdmissionDate = L.LatestDate
)
SELECT P.SSN, P.FName, P.LName, L.FutureVisit
FROM LatestAD L
         JOIN Patient P
              ON P.SSN = L.PatientSSN
WHERE L.FutureVisit IS NOT NULL;

/* Return all equipment types with less than two techinicians that can repair them */
WITH TechCount AS (
    SELECT C.EquipmentType AS TypeID, COUNT(C.EmployeeID) AS TechnicianCount
    FROM CanRepairEquipment C
    GROUP BY C.EquipmentType
)
SELECT T.TypeID
FROM TechCount T
WHERE T.TechnicianCount < 2;

/* Report the date of the coming future visit for patient with SSN = 111-22-3333 */
SELECT A.FutureVisit
FROM Admission A
WHERE PatientSSN = '111-22-3333' AND A.AdmissionDate = (
    SELECT MAX(AdmissionDate) FROM Admission WHERE PatientSSN = '111-22-3333');

/* For patient with SSN = 111-22-3333, report the id of the doctors who have examined
this patient more than 2 times */
SELECT E.DoctorID
FROM Examine E
         JOIN Admission A ON E.AdmissionNum = A.Num
WHERE A.PatientSSN = '111-22-3333'
GROUP BY E.DoctorID
HAVING COUNT(*) > 2;

/* Return the equipment types ID for which the hospital has purchased
equipment units in both 2010 and 2011 */
SELECT DISTINCT TypeID
FROM Equipment E
WHERE PurchaseYear IN (2010, 2011)
GROUP BY TypeID
HAVING COUNT(DISTINCT PurchaseYear) = 2;
