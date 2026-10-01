-- How many patients have a missing value for age?
-- Answer is 9

SELECT COUNT(*)
FROM patients
WHERE age IS NULL;


