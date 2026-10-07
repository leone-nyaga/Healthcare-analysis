-- Among patients who have a BMI greater than 25, show each diabetes category and the number of patients in that category. Only show diabetes categories that have more than 10 patients.
-- no = 47, yes = 11

SELECT
    diabetes,
    COUNT(*) AS patient_count
FROM patients
WHERE bmi > 25
GROUP BY diabetes
HAVING patient_count > 10;
