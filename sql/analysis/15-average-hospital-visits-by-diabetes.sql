-- What is the average hospital visits per year for each diabetes category?
-- No = 5.373, NULL = 5.222, Yes = 4.857

SELECT
diabetes,
ROUND(AVG(hospital_visits_per_year), 3) AS avg_hospital_visits
FROM patients
GROUP BY diabetes;
