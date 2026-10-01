# Healthcare Data Analysis

This is a learning and portfolio project focused on analyzing a healthcare dataset using **SQL** and **Python/Pandas**.

The project explores how raw healthcare data can be inspected, cleaned, structured, and analyzed using tools commonly used in backend development and data analysis.

The same dataset will be analyzed twice:

1. **SQL** — data profiling, cleaning, querying, aggregation, and statistical analysis.
2. **Python/Pandas** — data cleaning, analysis, and visualization.

The goal is not to make medical or clinical conclusions, but to develop practical skills in **data engineering, SQL, statistical analysis, and Python data analysis**.

Special thanks to Gladys Gatwiri, who provided me the dataset.

## Loading the dataset

I use a WSL2 terminal on windows 10, so the process is kinda tough.

I received the dataset via email and downloaded it to my local device (Downloads).

Using bash to locate the file:

```bash
ls -l "/mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv"
```

You get something like this confirming its present:

```bash
leone-nyaga@DESKTOP-MFAESEK:~$ ls -l "/mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv"
-rwxrwxrwx 1 leone-nyaga leone-nyaga 5736 Aug 17 19:00 /mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv
leone-nyaga@DESKTOP-MFAESEK:~$
```

In windows, the downloads folder path looks something like this:

```powershell
C:\Users\YourName\Downloads\
```

The equivalent in WSL2 is:

```bash
/mnt/c/Users/YourName/Downloads/
```

** mnt is short for mount**

** roughly means: “the Windows C: drive, made accessible under the Linux filesystem hierarchy.” **

Before we copy the dataset, let's preview the data in the file:

```bash
head "/mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv"
```

+ head: is a Linux command that shows the beginning of a file. 10 lines by default.

```bash
leone-nyaga@DESKTOP-MFAESEK:~$ head "/mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv"
Patient_ID,Age,Gender,BMI,Blood_Pressure,Cholesterol_Level,Diabetes,Hospital_Visits_Per_Year,Medication_Adherence,Smoking_Status,Exercise_Frequency
P001,69,Male,33.8,Hypertension,Normal,No,0,Poor,Non-Smoker,0
P002,32,Female,21.7,Hypertension,Normal,No,0,Good,Smoker,5
P003,78,Male,40,Hypertension,Low,No,7,Good,Smoker,
P004,38,Male,24.2,Normal,High,No,1,Good,Smoker,6
P005,,Female,,Prehypertension,High,No,11,Good,Smoker,0
P006,20,Male,27.3,Prehypertension,Low,No,7,Good,Non-Smoker,5
P007,39,Male,19.2,Hypertension,Low,No,6,Moderate,Non-Smoker,4
P008,70,Male,25.9,Normal,High,No,9,Moderate,Non-Smoker,4
P009,19,,32.1,Normal,Normal,No,9,Good,Smoker,1
```

SUCCESS!!!

## Let's copy the file

Since we now found the file, let's make a copy of the dataset that we'll do our analysis on.

```bash
mkdir -p ~/healthcare-analysis/data
```

+ **-p**: means parent. Tells **mkdir** to create the directory and any missing parent directories along the way.

Now, let's copy the dataset to our **healthcare-analysis**.

```bash
cp "/mnt/c/Users/Adelaide/Downloads/healthcare_dataset.csv" ~/healthcare-sql/data/
```

Let's verify the data:

```bash
ls -lh ~/healthcare-analysis/data/
```

+ **-l**: Long format. Instead of ```file1.txt```, you get ```-rw-r--r--  1 alice alice  1.2K Sep  4 10:30 file1.txt```.

+ **-h**: Human readable. Without ```-h```, sizes are usually displayed as raw bytes:```1234567```, With ```-h```: ```1.2M```.

Essentially: List files in detailed/long format, with file sizes formatted for humans.

Output:

```bash
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis$ ls -lh ~/healthcare-analysis/data/
total 8.0K
-rwxr-xr-x 1 leone-nyaga leone-nyaga 5.7K Sep  3 11:36 healthcare_dataset.csv
```

## REMEMBER

```bash
docker exec -it healthcare_mysql mysql -u healthcare_user -p
```

To access the MySQL container.

```bash
docker exec -it healthcare_mysql mysql -u root -p
```

For root access.
