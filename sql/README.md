# SQL ANALYSIS

The schema will be:

```sql
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
```

## Docker setup

Since I have issues connecting to a database via WSL2, I opted to use Docker desktop. The ```docker-compose.yml```:

```bash
services:
  mysql:
    image: mysql:8.0
    container_name: healthcare_mysql
    restart: unless-stopped

    environment:
      MYSQL_DATABASE: healthcare_analysis
      MYSQL_USER: healthcare_user
      MYSQL_PASSWORD: healthcare_password
      MYSQL_ROOT_PASSWORD: root_password

    ports:
      - "3307:3306"

    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

### 1. Services

```bash
services:
  mysql:
```

This is the top-level section where you define the containers/services your application needs. In this case we only have one service i.e. MySQL.
```mysql``` is the service name.
The service name can be any name you choose: banana, my_db, database etc.

### 2. image

```bash
image: mysql:8.0
```

This tells Docker which image to use to create the container. In this case, we are using mysql:8.0

This means:
+ mysql: is the official MySQL image.
+ 8.0: is the MySQL version.

So essentially, we are instructing Docker to create a MySQl database container.
We don't need to manually install MySQL on our machine.



