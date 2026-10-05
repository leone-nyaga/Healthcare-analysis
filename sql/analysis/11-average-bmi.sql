-- What is the average BMI of the patients?
-- 30.08876412638118
-- ROUND(AGGREGATE(COLUMN), NUMBEROFDP)

SELECT ROUND(AVG(bmi),3)
FROM patients;
