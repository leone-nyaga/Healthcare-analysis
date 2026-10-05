-- For each medication adherence category, show the category and the number of patients in that category.
-- poor = 17, good = 37, moderate = 31, null = 15

SELECT medication_adherence, COUNT(*) AS patient_count
FROM patients
GROUP BY medication_adherence;
