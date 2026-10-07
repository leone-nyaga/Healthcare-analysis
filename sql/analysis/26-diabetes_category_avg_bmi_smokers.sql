-- Show each diabetes category and its average BMI, but only include patients who are smokers, and only show diabetes categories whose average BMI is greater than 30.
-- yes = 32.567

SELECT
    diabetes,
    ROUND(AVG(bmi), 3) AS avg_bmi
FROM patients
WHERE smoking_status = "Smoker"
GROUP BY diabetes
HAVING avg_bmi > 30;
