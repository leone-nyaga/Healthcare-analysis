-- How many patients are in each medication-adherence group?
-- poor = 17, good = 37, moderate = 31, null = 15

SELECT medication_adherence, COUNT(*)
FROM patients
GROUP BY medication_adherence;
