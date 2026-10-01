-- How many patients are missing their gender?
-- Answer is 9

SELECT COUNT(*)
FROM patients
WHERE gender is NULL;
