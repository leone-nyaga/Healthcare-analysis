-- For each diabetes category, show the number of patients AND their average hospital visits per year.
-- No diabetes => patient_count = 73, avg hospital visit = 5.373
-- Null => patient_count = 10, avg hospital visit = 5.222
-- Yes => patient_count = 17, avy hospital visit = 4.857

SELECT
diabetes,
COUNT(*) AS patient_count,
ROUND(AVG(hospital_visits_per_year), 3) AS average_hospital_visits
FROM patients
GROUP BY diabetes;
