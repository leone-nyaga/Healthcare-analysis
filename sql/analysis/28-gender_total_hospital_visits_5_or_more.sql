-- For patients with hospital_visits_per_year >= 5, show each gender and the total number of hospital visits. Only show gender groups where the total number of hospital visits is greater than 100.
-- male = 202, female = 190

SELECT gender, SUM(hospital_visits_per_year) AS total_visits
FROM patients
WHERE hospital_visits_per_year >= 5
GROUP BY gender
HAVING total_visits > 100;
