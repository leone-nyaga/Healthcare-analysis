-- Show each diabetes category and the average number of hospital visits, but only show categories where the average hospital visits is greater than 5.
-- no diabetes = 5.373, null = 5.222

SELECT
    diabetes,
    ROUND(AVG(hospital_visits_per_year), 3) AS avg_hospital_visits,
FROM patients
GROUP BY diabetes
HAVING avg_hospital_visits > 5;
