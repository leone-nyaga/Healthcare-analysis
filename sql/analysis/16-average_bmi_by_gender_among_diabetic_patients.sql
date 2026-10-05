-- Among diabetic patients only, what is the average BMI for each gender?
-- Male = 36.475, Female = 30.4, NULL = 27.95

SELECT gender, ROUND(AVG(bmi), 3) AS avg_bmi
FROM patients
WHERE diabetes = "Yes"
GROUP BY gender;
