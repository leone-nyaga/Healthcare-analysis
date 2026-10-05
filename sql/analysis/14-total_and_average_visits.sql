--  What is the total number of hospital visits AND the average number of hospital visits per year?
-- Total visits = 475, average visits = 5.2778

SELECT
SUM(hospital_visits_per_year) AS total_hospital_visits,
ROUND(AVG(hospital_visits_per_year), 2) AS average_hospital_visits
FROM patients;
