-- How many patients are missing BOTH their age AND their BMI?
-- Answer is 1. Only one patient had both their bmi and age records missing.

SELECT COUNT(*)
FROM patients
WHERE age is NULL AND bmi IS NULL;
