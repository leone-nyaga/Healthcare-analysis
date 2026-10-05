-- How many patients are in each gender group?
-- Male = 47, female = 44, null = 9

SELECT gender, COUNT(*)
FROM patients
GROUP BY gender;
