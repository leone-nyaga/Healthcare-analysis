-- Among patients who have an age greater than 40, show each medication adherence category and the average BMI. Only show categories where the average BMI is greater than 28.
-- poor = 28.713, good = 32.882, moderate = 30.025, null = 28.178

SELECT medication_adherence,
       ROUND(AVG(bmi), 3) AS avg_bmi
FROM patients
WHERE age > 40
GROUP BY medication_adherence
HAVING avg_bmi > 28;
