package JDBC;

import java.sql.*;
import java.util.Scanner;

public class Reporting {

    // ORACLE URL
    private static final String DB_URL = "jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl";

    public static void main(String[] args) {

        // Must have at least username and password
        if (args.length < 2) {
            System.out.println("Usage: java Reporting <username> <password> [option]");
            return;
        }

        String username = args[0];
        String password = args[1];

        // If no option is provided → print menu and exit
        if (args.length == 2) {
            printMenu();
            return;
        }

        // Option provided
        String option = args[2];

        try (Connection conn = DriverManager.getConnection(DB_URL, username, password)) {

            switch (option) {

                case "1":
                    reportPatientBasic(conn);
                    break;

                case "2":
                    reportDoctorBasic(conn);
                    break;

                case "3":
                    reportAdmissionInfo(conn);
                    break;

                case "4":
                    updateAdmissionPayment(conn);
                    break;

                default:
                    System.out.println("Invalid option.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // MODE 0 — MAIN MENU
    private static void printMenu() {
        System.out.println("1- Report Patients Basic Information");
        System.out.println("2- Report Doctors Basic Information");
        System.out.println("3- Report Admissions Information");
        System.out.println("4- Update Admissions Payment");
    }

    // MODE 1 — PATIENT BASIC INFO
    private static void reportPatientBasic(Connection conn) throws SQLException {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Patient SSN: ");
        String ssn = sc.nextLine().trim();

        String sql = "SELECT SSN, FName, LName, Address FROM Patient WHERE SSN = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ssn);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Patient SSN: " + rs.getString("SSN"));
                    System.out.println("Patient First Name: " + rs.getString("FName"));
                    System.out.println("Patient Last Name: " + rs.getString("LName"));
                    System.out.println("Patient Address: " + rs.getString("Address"));
                } else {
                    System.out.println("No patient found with SSN: " + ssn);
                }
            }
        }
    }

    // MODE 2 - DOCTOR BASIC INFO
    private static void reportDoctorBasic(Connection conn) throws SQLException {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Doctor ID: ");
        int doctorId = Integer.parseInt(sc.nextLine().trim());

        String sql =
                "SELECT D.EmployeeID, E.FName, E.LName, D.Gender, D.GraduatedFrom, D.Specialty " +
                        "FROM Doctor D " +
                        "JOIN Employee E ON D.EmployeeID = E.EmployeeID " +
                        "WHERE D.EmployeeID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doctorId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Doctor ID: " + rs.getInt("EmployeeID"));
                    System.out.println("Doctor First Name: " + rs.getString("FName"));
                    System.out.println("Doctor Last Name: " + rs.getString("LName"));
                    System.out.println("Doctor Gender: " + rs.getString("Gender"));
                    System.out.println("Doctor Graduated From: " + rs.getString("GraduatedFrom"));
                    System.out.println("Doctor Specialty: " + rs.getString("Specialty"));
                } else {
                    System.out.println("No doctor found with ID: " + doctorId);
                }
            }
        }
    }


    // MODE 3 — ADMISSION INFO
    private static void reportAdmissionInfo(Connection conn) throws SQLException {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Admission Number: ");
        int admissionNum = Integer.parseInt(sc.nextLine().trim());

        // 1) Admission info
        String admissionSql =
                "SELECT Num, PatientSSN, AdmissionDate, TotalPayment " +
                        "FROM Admission WHERE Num = ?";

        try (PreparedStatement ps = conn.prepareStatement(admissionSql)) {
            ps.setInt(1, admissionNum);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("No admission found with number: " + admissionNum);
                    return;
                }
                System.out.println("Admission Number: " + rs.getInt("Num"));
                System.out.println("Patient SSN: " + rs.getString("PatientSSN"));
                System.out.println("Admission date (start date): " + rs.getDate("AdmissionDate"));
                System.out.println("Total Payment: " + rs.getInt("TotalPayment"));
            }
        }

        // 2) Rooms stayed in
        String roomSql =
                "SELECT RoomNum, StartDate, EndDate " +
                        "FROM StayIn WHERE AdmissionNum = ? ORDER BY StartDate";

        System.out.println("Rooms:");
        try (PreparedStatement ps = conn.prepareStatement(roomSql)) {
            ps.setInt(1, admissionNum);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    System.out.println("RoomNum: " + rs.getInt("RoomNum") +
                            "    FromDate: " + rs.getDate("StartDate") +
                            "    ToDate: " + rs.getDate("EndDate"));
                }
            }
        }

        // 3) Doctors examined the patient — distinct
        String doctorSql =
                "SELECT DISTINCT DoctorID FROM Examine WHERE AdmissionNum = ?";

        System.out.println("Doctors examined the patient in this admission:");
        try (PreparedStatement ps = conn.prepareStatement(doctorSql)) {
            ps.setInt(1, admissionNum);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    System.out.println("Doctor ID: " + rs.getInt("DoctorID"));
                }
            }
        }
    }

    // MODE 4 — UPDATE ADMISSION PAYMENT
    private static void updateAdmissionPayment(Connection conn) throws SQLException {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Admission Number: ");
        int admissionNum = Integer.parseInt(sc.nextLine().trim());

        System.out.print("Enter the new total payment: ");
        int newPayment = Integer.parseInt(sc.nextLine().trim());

        String updateSql = "UPDATE Admission SET TotalPayment = ? WHERE Num = ?";

        try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
            ps.setInt(1, newPayment);
            ps.setInt(2, admissionNum);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Successfully updated payment.");
            } else {
                System.out.println("No admission found with number: " + admissionNum);
            }
        }
    }
}
