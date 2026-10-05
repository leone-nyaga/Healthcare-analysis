-- For each smoking status, show the smoking status, the number of patients, and the average age — but only include patients whose age is greater than 30.
-- Non-smoker => patient_count = 50, average_age = 60.880
-- smoker => patient_count =14, average_age = 57
-- null => patient_count = 6, average_age = 55.667

SELECT
    smoking_status,
    COUNT(*) AS patient_count,
    ROUND(AVG(age), 3) AS average_age
FROM patients
WHERE age > 30
GROUP BY smoking_status;
