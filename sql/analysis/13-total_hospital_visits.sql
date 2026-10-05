-- What is the total number of hospital visits across all patients?
-- Answer is 475

SELECT SUM(hospital_visits_per_year)
FROM patients;
