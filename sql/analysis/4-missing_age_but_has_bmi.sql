-- How many patients have a missing age BUT have a BMI value?
-- Answer is 8. 

SELECT COUNT(*)
FROM patients
WHERE age is NULL AND bmi IS NOT NULL;
