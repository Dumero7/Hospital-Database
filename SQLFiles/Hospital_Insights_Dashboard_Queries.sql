-- 1. Total Registered Patients
SELECT COUNT(*) AS TotalPatients FROM Patients;

-- 2. Patients by Gender Distribution
SELECT Gender, COUNT(*) AS Count FROM Patients GROUP BY Gender;

-- 3. Age Distribution of Patients
SELECT 
         CASE 
             WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 0 AND 18 THEN '0-18'
             WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 19 AND 35 THEN '19-35'
             WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 36 AND 60 THEN '36-60'
             ELSE '60+'
         END AS AgeGroup,
         COUNT(*) AS Count
     FROM Patients
     GROUP BY AgeGroup;

-- 4. Most Common Medical Histories (tag-based)
SELECT MedicalHistory, COUNT(*) AS Count FROM Patients GROUP BY MedicalHistory ORDER BY Count DESC LIMIT 10;

-- 5. Top 10 Frequent Patient Visitors
SELECT p.FullName, COUNT(*) AS VisitCount FROM Appointments a JOIN Patients p ON a.PatientID = p.PatientID GROUP BY a.PatientID ORDER BY VisitCount DESC LIMIT 10;

-- 6. Doctors by Specialty
SELECT Specialty, COUNT(*) AS DoctorCount FROM Doctors GROUP BY Specialty;

-- 7. Top 5 Busiest Doctors
SELECT d.FullName, COUNT(*) AS AppointmentCount FROM Appointments a JOIN Doctors d ON a.DoctorID = d.DoctorID GROUP BY a.DoctorID ORDER BY AppointmentCount DESC LIMIT 5;

-- 8. Doctor Appointment Load by Day
SELECT DoctorID, DATE(AppointmentDate) AS Day, COUNT(*) AS AppointmentCount FROM Appointments GROUP BY DoctorID, Day ORDER BY Day;

-- 9. Appointment Status Breakdown
SELECT Status, COUNT(*) AS Count FROM Appointments GROUP BY Status;

-- 10. Appointments Per Month
SELECT DATE_FORMAT(AppointmentDate, '%Y-%m') AS Month, COUNT(*) AS TotalAppointments FROM Appointments GROUP BY Month ORDER BY Month;

-- 11. Appointment Cancellation Rate
SELECT (SELECT COUNT(*) FROM Appointments WHERE Status = 'Cancelled') / COUNT(*) * 100 AS CancellationRate FROM Appointments;

-- 12. Top 10 Common Treatments
SELECT Description, COUNT(*) AS Count FROM Treatments GROUP BY Description ORDER BY Count DESC LIMIT 10;

-- 13. Average Treatment Cost
SELECT AVG(Cost) AS AverageTreatmentCost FROM Treatments;

-- 14. Top Prescribed Medications
SELECT m.Name, COUNT(*) AS PrescriptionCount FROM Prescriptions p JOIN Medications m ON p.MedicationID = m.MedicationID GROUP BY m.MedicationID ORDER BY PrescriptionCount DESC LIMIT 10;

-- 15. Average Medications per Treatment
SELECT AVG(MedCount) AS AvgMedications FROM (SELECT COUNT(*) AS MedCount FROM Prescriptions GROUP BY TreatmentID) AS MedsPerTreatment;

-- 16. Total Paid Revenue
SELECT SUM(TotalAmount) AS Revenue FROM Billing WHERE Paid = TRUE;

-- 17. Outstanding Bills Count and Value
SELECT COUNT(*) AS UnpaidCount, SUM(TotalAmount) AS UnpaidTotal FROM Billing WHERE Paid = FALSE;

-- 18. Revenue by Cashier
SELECT c.FullName, SUM(b.TotalAmount) AS Revenue FROM Billing b JOIN Cashiers c ON b.CashierID = c.CashierID WHERE b.Paid = TRUE GROUP BY b.CashierID;

-- 19. Daily Billing Trends
SELECT DATE(BillDate) AS BillDay, SUM(TotalAmount) AS DailyRevenue FROM Billing WHERE Paid = TRUE GROUP BY BillDay ORDER BY BillDay;

-- 20. Average Billing Per Patient
SELECT AVG(Total) AS AvgCostPerVisit FROM (SELECT PatientID, SUM(TotalAmount) AS Total FROM Billing GROUP BY PatientID) AS PatientCosts;

