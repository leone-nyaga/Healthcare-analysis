-- Which diabetes status has the most patients?
-- Answer is No

SELECT diabetes, count(*) as patient_count
FROM patients
GROUP BY diabetes
ORDER BY patient_count DESC;
