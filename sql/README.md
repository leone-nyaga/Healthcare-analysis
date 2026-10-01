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

This is the top-level section where you define the containers/services your application needs.

In this case we only have one service i.e. MySQL.

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

### 3. container_name

```
container_name: healthcare_mysql
```

Normally Docker generates a container name automatically. This explicitly names your container: ```healthcare_mysql```.

### 4. restart: unless-stopped

```
restart: unless-stopped
```

This tells Docker to automatically restart the MySQL container if it stops unexpectedly. So, if mysql crashes and docker notices, docker will keep restarting it unless you explicitly stop it.

### 5. environments

```
environments:
```

This section provides environment variables to the MySQL container.

These variables are particularly important because the official MySQL Docker image uses them during its initial setup.

In this case, we have four:

```
MYSQL_DATABASE: healthcare_analysis
MYSQL_USER: healthcare_user
MYSQL_PASSWORD: healthcare_password
MYSQL_ROOT_PASSWORD: root_password
```

### 6. MYSQL DATABASE

```
MYSQL_DATABASE: healthcare_analysis
```

This tells MySQL to create a database called ```healthcare_analysis```.

So after MySQL initializes, you'll have:

```
MySQL server
└── healthcare_analysis
```

Your tables will eventually live inside this database.

### 7. MYSQL USER

```
MYSQL_USER: healthcare_user
```

This creates a MySQL user: ```healthcare_user```. This is intended to be your application's normal database user.

### 8. MYSQL PASSWORD

```
MYSQL_PASSWORD: healthcare_password
```

This sets the password for: ```healthcare_user```

So you effectively have:

```
Username: healthcare_user
Password: healthcare_password
```

Your application can use those credentials to connect to the database.

### 9. MYSQL ROOT PASSWORD

```
MYSQL_ROOT_PASSWORD: root_password
```

MySQL has a special administrative user called: ```root```

This sets the root user's password to: ```root_password```

Conceptually:

```
MySQL
│
├── root
│   └── root_password
│
└── healthcare_user
    └── healthcare_password
```

Important: these passwords are fine for a local development project, but you shouldn't use simple/default-looking passwords like these in production.

### 10. Ports

```
ports:
  - "3307:3306"
```

This is one of the most important lines.

It maps a port on your computer to a port inside the Docker container.

The format is: ```HOST_PORT:CONTAINER_PORT```

So: ```3307:3306```

means:

```
Your computer              Docker container
     │                           │
     │  localhost:3307           │
     └──────────────────────────> │ MySQL:3306
```

MySQL normally listens on: ```3306```

inside the container.

You've exposed it on: ```3307```

on your machine.

Therefore, from your Ubuntu/WSL terminal, you could connect using: ```localhost:3307```

For example:

```bash
mysql -h 127.0.0.1 -P 3307 -u healthcare_user -p
```

Then enter: ```healthcare_password```

***Why 3307 instead of 3306?***: Probably because you want to avoid a conflict with another MySQL instance already using port 3306 on your computer.

Think of it as:

```
Host machine
localhost:3307
       ↓
Docker
container:3306
       ↓
MySQL
```

Inside Docker, MySQL still uses its normal port 3306.

### 11. volumes

```
volumes:
  - mysql_data:/var/lib/mysql
```

This is very important for your database.

MySQL stores its actual database files inside: ```/var/lib/mysql```

inside the container.

You're attaching a Docker volume called: ```mysql_data``` to that directory.

So:

```
Docker volume
mysql_data
     │
     ↓
/var/lib/mysql
     │
     ↓
MySQL database files
```

*** Why do we need this? ***

Imagine you don't have the volume.

You start MySQL:

```
docker compose up
```

You create:

```
patients
hospitals
treatments
```

Then you delete the container.

Without persistent storage, your database data could disappear along with the container.

With:

```
mysql_data:/var/lib/mysql
```

the data is stored separately from the container.

So you can recreate the container and retain the database.

### 12. Top-level volumes

At the bottom:

```
volumes:
  mysql_data:
```

This declares the Docker volume.

You're basically telling Docker:

"Create/manage a persistent volume called mysql_data."

The two pieces work together:

```
services:
  mysql:
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

The first part uses the volume.

The second part declares it.

### What happens when you run it?

When you execute:

```
docker compose up -d
```

Docker Compose roughly does this:

```
1. Read docker-compose.yml
          ↓
2. Find mysql service
          ↓
3. Download mysql:8.0 if necessary
          ↓
4. Create mysql_data volume
          ↓
5. Create healthcare_mysql container
          ↓
6. Configure MySQL environment variables
          ↓
7. Map localhost:3307 → container:3306
          ↓
8. Start MySQL
```

You can then check it with:

```
docker ps
```

and see your MySQL container running.

To stop it:

```
docker compose down
```

The container is removed, but mysql_data normally remains, which is why your database data persists.

If you instead run:

```
docker compose down -v
```

the ```-v``` removes the volumes too.

That means your MySQL data will be deleted.

To sum it all up:

```
Run MySQL 8.0 in a container called healthcare_mysql, create a database called healthcare_analysis and a user called healthcare_user, expose MySQL to my computer on port 3307, and permanently store the database data in a Docker volume called mysql_data.
```

## Let's Enter MySQL

run:

```bash
docker exec -it healthcare_mysql mysql -u healthcare_user -p
```

And enter the password: ```healthcare_password``` when requested.

Then:

```sql
USE healthcare_analysis;
```

We have the schema in the ```schema.sql```  let's execute it

```bash
SOURCE /tmp/schema.sql;
```

After that, we should have:

```bash
mysql> SOURCE /tmp/schema.sql;
Query OK, 0 rows affected (0.05 sec)

mysql> describe patients;
+--------------------------+-------------+------+-----+---------+-------+
| Field                    | Type        | Null | Key | Default | Extra |
+--------------------------+-------------+------+-----+---------+-------+
| patient_id               | varchar(50) | NO   | PRI | NULL    |       |
| age                      | int         | YES  |     | NULL    |       |
| gender                   | varchar(50) | YES  |     | NULL    |       |
| bmi                      | float       | YES  |     | NULL    |       |
| blood_pressure           | varchar(50) | YES  |     | NULL    |       |
| cholesterol_level        | varchar(50) | YES  |     | NULL    |       |
| diabetes                 | varchar(50) | YES  |     | NULL    |       |
| hospital_visits_per_year | int         | YES  |     | NULL    |       |
| medication_adherence     | varchar(50) | YES  |     | NULL    |       |
| smoking_status           | varchar(50) | YES  |     | NULL    |       |
| exercise_frequency       | int         | YES  |     | NULL    |       |
+--------------------------+-------------+------+-----+---------+-------+
11 rows in set (0.00 sec)
```

Let's check to see which directory MySQL allows for file imports/exports inside your Docker container.

We'll use this command:

```bash
docker exec -it healthcare_mysql mysql -u healthcare_user -p -e "SHOW VARIABLES LIKE 'secure_file_priv';"
```

A quick breakdown of the command:

+ ```docker```: Tells the computer that you want to interact with docker.

+ ```exec```: Run a command inside an already-running Docker container.

+ ```-it```: lets you interact with the command normally. ```-i``` keeps the input open so you can type. ```-t```  give you an interactive terminal.

+ ```healthcare_mysql mysql -u healthcare_user```: Our SQL docker.

+ ```-e```: Execute the SQL statement that follows.

+ ```"SHOW VARIABLES LIKE 'secure_file_priv';"```: The SQL query. It asks sql to "Show me the MySQL configuration variable called secure_file_priv."

Output:

```
+------------------+-----------------------+
| Variable_name    | Value                 |
+------------------+-----------------------+
| secure_file_priv | /var/lib/mysql-files/ |
+------------------+-----------------------+
```

## How should we handle blank data

There are several possibilities:

+ blank → 0

+ blank → "blank"

+ blank → "Unknown"

+ blank → NULL

My decision was: CSV blank -> SQL NULL

Why: NULL means the value is missing/not provided.

## Let's copy the CSV data into the MySQL container

So, MySQL reported that:

```bash
secure_file_priv = /var/lib/mysql-files/
```

This means MySQL's server-side file operations are restricted to that directory.

The CSV was copied into the container using:

```bash
docker cp data/healthcare_dataset.csv \ healthcare_mysql:/var/lib/mysql-files/healthcare_dataset.csv
```

Verified with:

```bash
docker exec healthcare_mysql \ ls -l /var/lib/mysql-files/
```

Output showed:

```
healthcare-dataset.csv
```

The data flow becomes:

```
~/healthcare-analysis/data/healthcare_dataset.csv
		|
		| docker cp
		\/
	healthcare-dataset.csv
		|
		\/
/var/lib/mysql-files/healthcare_dataset.csv
```

## Why do we use MySQL User Variables

The CSV column order matches the MySQL table, but the CSV can contain blank fields.

Example:

```
P003,78,Male,40,Hypertension,Low,No,7,Good,Smoker,
```

The last field is blank.

We therefore temporarily load CSV values into user variables:

```sql
( 
@patient_id,
@age,
@gender,
@bmi,
@blood_pressure,
@cholesterol_level,
@diabetes,
@hospital_visits,
@medication_adherence,
@smoking_status,@exercise_frequency
)
```

Then use ```NULLIF()```:

```sql
SET
    bmi = NULLIF(@bmi, ''),
    ...
```

syntax to NULLIF():
```sql
NULLIF(valuea, valueb)
```

Meaning that if valuea is equal to valueb, return NULL. Otherwise, return valuea.

So, if:

```sql
NULLIF(@bmi, '')
```

means: If @bmi is an empty string (''), turn it into NULL. Otherwise, keep whatever is in @bmi.

Example:

| `@bmi`   | `NULLIF(@bmi, '')` |
| -------- | ------------------ |
| `'25.4'` | `'25.4'`           |
| `'18.7'` | `'18.7'`           |
| `''`     | `NULL`             |
| `'30'`   | `'30'`             |

## The first import statement

```sql
LOAD DATA INFILE '/var/lib/mysql-files/healthcare_dataset.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    @patient_id,
    @age,
    @gender,
    @bmi,
    @blood_pressure,
    @cholesterol_level,
    @diabetes,
    @hospital_visits,
    @medication_adherence,
    @smoking_status,
    @exercise_frequency
)
SET
    patient_id = NULLIF(@patient_id, ''),
    age = NULLIF(@age, ''),
    gender = NULLIF(@gender, ''),
    bmi = NULLIF(@bmi, ''),
    blood_pressure = NULLIF(@blood_pressure, ''),
    cholesterol_level = NULLIF(@cholesterol_level, ''),
    diabetes = NULLIF(@diabetes, ''),
    hospital_visits_per_year = NULLIF(@hospital_visits, ''),
    medication_adherence = NULLIF(@medication_adherence, ''),
    smoking_status = NULLIF(@smoking_status, ''),
    exercise_frequency = NULLIF(@exercise_frequency, '');
```

## Import Errors!!

The first LOAD DATA INFILE attempt produced:

```bash
ERROR 1045 (28000): Access denied for user 'healthcare_user'@'%'
```
Initially this looked like an authentication problem.

I checked:

```sql
SELECT USER(), CURRENT_USER(), DATABASE();
```

and:

```sql
SHOW GRANTS FOR 'healthcare_user'@'%';
```

The user had:

```sql
GRANT USAGE ON *.*
GRANT ALL PRIVILEGES ON healthcare_analysis.*
```

The important discovery was that the user did not have the global:

```bash
FILE
```

privilege.

## Let's understand the Database Priviledges vs FILE

The user had full privileges on:

```sql
healthcare_analysis.*
```

but that does not automatically give permission to read files from the MySQL server filesystem.

Conceptually:

```
healthcare_user
│
├── healthcare_analysis.*
│ └── ALL PRIVILEGES (yes)
│
└── FILE
  └── missing (no)
```

```LOAD DATA INFILE``` performs a server-side file read, so MySQL requires the FILE privilege.

## Granting FILE

I initially tried:

```sql
GRANT FILE ON *.* TO 'healthcare_user'@'%';
```

while logged in as healthcare_user.

This failed:

```bash
ERROR 1045 (28000):
Access denied for user 'healthcare_user'@'%'
```

The reason:

+ A normal user cannot grant itself a privilege it does not have.

I then logged in as root:

```bash
docker exec -it healthcare_mysql mysql -u root -p
```

and ran:

```sql
GRANT FILE ON *.* TO 'healthcare_user'@'%';
```

This succeeded:

```bash
Query OK, 0 rows affected
```

Verified with:

```sql
SHOW GRANTS FOR 'healthcare_user'@'%';
```

Now the grants included:

```
GRANT FILE ON *.*
GRANT ALL PRIVILEGES ON healthcare_analysis.*
```

## Second Import Error — Windows Line Endings

After fixing the privilege problem, the import actually reached the CSV.

Then MySQL produced an error involving:

```
exercise_frequency

at row 3.
```

Instead of guessing, I inspected the raw CSV:

```bash
sed -n '1,4p' data/healthcare_dataset.csv | cat -A
```

The output contained:

```bash
^M$
```

For example:

```
P003,78,Male,40,Hypertension,Low,No,7,Good,Smoker,^M$
```

The ```^M``` revealed that the CSV uses Windows-style line endings:

```
\r\n
```

rather than Unix/Linux:

```
\n
```

The problem was particularly visible because the last CSV field was blank.

Instead of MySQL seeing: ```''``` it was effectively seeing the carriage-return character: ```'\r'```.

Therefore: ```NULLIF(@exercise_frequency, '')``` did not convert it to NULL.

## Fixing the line ending

The original import used:

LINES TERMINATED BY ```'\n'```

The CSV actually uses Windows line endings, so it was changed to:

+ LINES TERMINATED BY ```'\r\n'```

The CSV itself was not modified.

This preserved the raw source data.

## Final Successful Import

The final LOAD DATA INFILE was:

```sql
LOAD DATA INFILE '/var/lib/mysql-files/healthcare_dataset.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES (
    @patient_id,
    @age,
    @gender,
    @bmi,
    @blood_pressure,
    @cholesterol_level,
    @diabetes,
    @hospital_visits,
    @medication_adherence,
    @smoking_status,
    @exercise_frequency
)
SET
    patient_id = NULLIF(@patient_id, ''),
    age = NULLIF(@age, ''),
    gender = NULLIF(@gender, ''),
    bmi = NULLIF(@bmi, ''),
    blood_pressure = NULLIF(@blood_pressure, ''),
    cholesterol_level = NULLIF(@cholesterol_level, ''),
    diabetes = NULLIF(@diabetes, ''),
    hospital_visits_per_year = NULLIF(@hospital_visits, ''),
    medication_adherence = NULLIF(@medication_adherence, ''),
    smoking_status = NULLIF(@smoking_status, ''),
    exercise_frequency = NULLIF(@exercise_frequency, '');
```

## Let's Verify whether it worked

1. First test

```sql
SELECT COUNT(*) AS row_count
FROM patients;
```

Result

```
100
```

So all 100 patient records are present.

2. second test

```sql
SELECT *
FROM patients
LIMIT 5;
```

Results:

```bash
mysql> select * from patients limit 5;
+------------+------+--------+------+-----------------+-------------------+----------+--------------------------+----------------------+----------------+--------------------+
| patient_id | age  | gender | bmi  | blood_pressure  | cholesterol_level | diabetes | hospital_visits_per_year | medication_adherence | smoking_status | exercise_frequency |
+------------+------+--------+------+-----------------+-------------------+----------+--------------------------+----------------------+----------------+--------------------+
| P001       |   69 | Male   | 33.8 | Hypertension    | Normal            | No       |                        0 | Poor                 | Non-Smoker     |                  0 |
| P002       |   32 | Female | 21.7 | Hypertension    | Normal            | No       |                        0 | Good                 | Smoker         |                  5 |
| P003       |   78 | Male   |   40 | Hypertension    | Low               | No       |                        7 | Good                 | Smoker         |               NULL |
| P004       |   38 | Male   | 24.2 | Normal          | High              | No       |                        1 | Good                 | Smoker         |                  6 |
| P005       | NULL | Female | NULL | Prehypertension | High              | No       |                       11 | Good                 | Smoker         |                  0 |
+------------+------+--------+------+-----------------+-------------------+----------+--------------------------+----------------------+----------------+--------------------+
5 rows in set (0.00 sec)
```

The output showed that missing values were stored as NULL.

## Lessons Learned

1. A successful database connection doesn't necessarily mean a database is selected

```sql
USE healthcare_analysis;
```
selects the database for the current session.

2. Database privileges and server privileges are different

A user can have:

+ ALL PRIVILEGES ON healthcare_analysis.*

while still lacking:

```
FILE
```

3. secure_file_priv controls where server-side file operations can access files

```
SHOW VARIABLES LIKE 'secure_file_priv';
```

returned:

```
/var/lib/mysql-files/
```

4. User variables are useful when importing and transforming data

```
CSV
 ↓
@variable
 ↓
transformation
 ↓
table column
```

5. NULL is different from zero or a string such as "blank"

+ 0       → known zero

+ NULL    → value is missing

+ "blank" → actual text

6. File formats matter

The CSV came from a Windows environment and used:

```
\r\n
```

line endings.

MySQL needed:

```sql
LINES TERMINATED BY '\r\n'
```

7. Don't blindly modify raw data to make an import work

The original CSV was preserved.

Instead, the import process was adjusted to correctly interpret the source data.
