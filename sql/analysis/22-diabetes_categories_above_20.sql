-- Show each diabetes category and the number of patients in it, but only show categories that have more than 20 patients.
-- diabetes = no, patient_count = 73

SELECT diabetes, COUNT(*) AS patient_count
FROM patients
GROUP BY diabetes
HAVING patient_count > 20;
