-- How many patients are missing their BMI?
-- Answer is 11

SELECT COUNT(*)
FROM patients
WHERE bmi IS NULL;
