-- 1. CREATE DATABASE AND TABLES
CREATE DATABASE HospitalManagementDB;
USE HospitalManagementDB;

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    MedicalHistory TEXT
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Specialty VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Treatments Table
CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    Description TEXT,
    Cost DECIMAL(10,2),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Medications Table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Description TEXT,
    Cost DECIMAL(10,2)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    TreatmentID INT,
    MedicationID INT,
    Dosage VARCHAR(100),
    Frequency VARCHAR(100),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- Cashier Table
CREATE TABLE Cashiers (
    CashierID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Username VARCHAR(50) UNIQUE,
    CashierPassword varchar (255)
);

-- Billing Table
CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TreatmentID INT,
    MedicationID INT,
    CashierID INT,
    TotalAmount DECIMAL(10,2),
    BillDate DATETIME,
    Paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID),
    FOREIGN KEY (CashierID) REFERENCES Cashiers(CashierID)
); 
