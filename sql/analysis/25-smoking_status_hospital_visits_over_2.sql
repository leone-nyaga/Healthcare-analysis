-- Among patients who have more than 2 hospital visits per year, show each smoking status and the number of patients in that status. Only show smoking-status groups that have at least 10 patients.
-- smoker = 14, non smoker = 41

SELECT smoking_status, COUNT(*) AS patient_count
FROM patients
WHERE hospital_visits_per_year > 2
GROUP BY smoking_status
HAVING patient_count >= 10;
