-- How many patients are missing either their age OR their BMI?
-- Answer is 19
-- 

SELECT COUNT(*)
FROM patients
WHERE age IS NULL OR bmi IS NULL;
