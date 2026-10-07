-- For patients with BMI greater than 25, show each blood-pressure category and the average age. Only show blood-pressure groups where the average age is greater than 45.
-- hypertension = 52.917, normal = 56.300, null = 45.500

SELECT
    blood_pressure,
    ROUND(AVG(age), 3) AS avg_age
FROM patients
WHERE bmi > 25
GROUP BY blood_pressure
HAVING avg_age > 45;
