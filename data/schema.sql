CREATE TABLE IF NOT EXISTS patients (
        patient_id VARCHAR(50) PRIMARY KEY,
        age INT NULL CHECK (age >= 0),
        gender VARCHAR(50) NULL CHECK (Gender IN ('Male', 'Female')),
        bmi FLOAT NULL CHECK (BMI >= 0),
        blood_pressure VARCHAR(50) NULL CHECK (Blood_Pressure IN (
                        'Normal',
                        'Prehypertension',
                        'Hypertension')),
        cholesterol_level VARCHAR(50) NULL CHECK (Cholesterol_Level IN (
                        'High',
                        'Low',
                        'Normal')),
        diabetes VARCHAR(50) NULL CHECK (Diabetes IN ('Yes', 'No')),
        hospital_visits_per_year INT NULL CHECK (Hospital_Visits_Per_Year >= 0),
        medication_adherence VARCHAR(50) NULL CHECK (Medication_Adherence IN (
                        'Good',
                        'Moderate',
                        'Poor')),
        smoking_status VARCHAR(50) NULL CHECK (Smoking_Status IN (
                        'Smoker',
                        'Non-Smoker')),
        exercise_frequency INT NULL CHECK (Exercise_Frequency >= 0)
);
