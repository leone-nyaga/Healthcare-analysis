-- How many patients have BOTH age AND BMI recorded?
-- 89

SELECT COUNT(*)
FROM patients
WHERE bmi IS NOT NULL
AND age IS NOT NULL;
