-- What is the minimum, maximum, and average age of the patients?
-- min = 18, max = 82, mean = 50.978

SELECT
MIN(age) AS youngest_age,
MAX(age) AS oldest_age,
ROUND(AVG(age),3) AS mean_age
FROM patients;
