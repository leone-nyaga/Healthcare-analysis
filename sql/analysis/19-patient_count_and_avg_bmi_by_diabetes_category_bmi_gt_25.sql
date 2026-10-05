-- For each diabetes category, show the number of patients and their average BMI, but only include patients whose BMI is greater than 25.-- No diabetes => 47 patients => avg bmi =32.347
-- NULL => 10 patients => avg bmi 31.62
-- yes diabetes => 11 patients => avg bmi 33.327

SELECT
diabetes,
COUNT(*) AS patient_count,
ROUND(AVG(bmi), 3) AS average_bmi
FROM patients
WHERE bmi > 25
GROUP BY diabetes;
