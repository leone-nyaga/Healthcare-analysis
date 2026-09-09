# Meet the dataset

Before touching the dataset, we should get to know it first.

## How many records are in the dataset?

We use the ```wc``` command. Stands for **word count**.
```wc``` can count more than just words, in this case, records.

```bash
wc -l healthcare_dataset.csv
```

+ **-l**: means lines.

Essentially: Count the number of lines in healthcare_dataset.csv.

Output:

```bash
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ wc -l healthcare_dataset.csv
101 healthcare_dataset.csv
```

**THERE ARE 100 PATIENT RECORDS IN THE DATASET.**

```wc``` treats the header line as a record.

```
101 total lines
−  1 header
────────────
100 patient records
```

## How many columns do we have?

```bash
head -n 1 healthcare_dataset.csv | awk -F',' '{print NF}'
```

output

```
11
```

+ ```head -n 1 healthcare_dataset.csv```: gets the first line, usually the header.

+ ```|```: passes that line to awk.

+ ```awk```: is a command-line tool for processing text one line at a time.

+ ```-F```: means Field Separator.

+ ```'{print NF}'```: This is the part that tells awk what to do.NF is a special awk variable meaning: Number of Fields


## How many duplicates do we have?

```bash
awk -F',' 'NR > 1 {print $1}' healthcare_dataset.csv | sort | uniq -c
```

+ ```-F','```: Tells awk that the fields are separated by commas.

So a row like: John Smith,45,Male,Diabetes becomes: $1 = John Smith $2 = 45 $3 = Male $4 = Diabetes

+ ```NR > 1```: NR = Number of Records processed so far. So NR > 1 means skip the first line (the header).

+ ```{print $1}```: Prints the first column of every remaining row.

+ ```sort```: Sorts those values alphabetically/numerically so identical values are next to each other.

+ ```uniq -c```: Counts consecutive identical values.

Example: if the first column contains

```
John
Mary
John
John
Mary
```

after sort:

```John
John
John
Mary
Mary
```

Then uniq -c produces:

```
      3 John
      2 Mary
```

in short: Take the first column, ignore the header, sort the values, and count how many times each value occurs.

The output to the command:

```bash
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' 'NR > 1 {print $1}' healthcare_dataset.csv | sort | uniq -c
      1 P001
      1 P002
      1 P003
      1 P004
      1 P005
      1 P006
      1 P007
      1 P008
      1 P009
      1 P010
      1 P011
      1 P012
      1 P013
      1 P014
      1 P015
      1 P016
      1 P017
      1 P018
      1 P019
      1 P020
      1 P021
      1 P022
      1 P023
      1 P024
      1 P025
      1 P026
      1 P027
      1 P028
      1 P029
      1 P030
      1 P031
      1 P032
      1 P033
      1 P034
      1 P035
      1 P036
      1 P037
      1 P038
      1 P039
      1 P040
      1 P041
      1 P042
      1 P043
      1 P044
      1 P045
      1 P046
      1 P047
      1 P048
      1 P049
      1 P050
      1 P051
      1 P052
      1 P053
      1 P054
      1 P055
      1 P056
      1 P057
      1 P058
      1 P059
      1 P060
      1 P061
      1 P062
      1 P063
      1 P064
      1 P065
      1 P066
      1 P067
      1 P068
      1 P069
      1 P070
      1 P071
      1 P072
      1 P073
      1 P074
      1 P075
      1 P076
      1 P077
      1 P078
      1 P079
      1 P080
      1 P081
      1 P082
      1 P083
      1 P084
      1 P085
      1 P086
      1 P087
      1 P088
      1 P089
      1 P090
      1 P091
      1 P092
      1 P093
      1 P094
      1 P095
      1 P096
      1 P097
      1 P098
      1 P099
      1 P100
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$
```

This shows that there are no duplicates.

### awk's indexing

```bash
CSV line:
P001,45,Female,24.5
 │   │   │      │
 │   │   │      └── $4
 │   │   └───────── $3
 │   └───────────── $2
 └───────────────── $1
```

Therefore:

```bash
$1 = Patient_ID
$2 = Age
$3 = Gender
$4 = BMI
```
It's field numbering, not zero-based array indexing.

## How many missing data do we have?

```bash
awk -F',' '{print $2}' healthcare_dataset.csv | grep '^$' | wc -l
```

+ ```'{print $2}'```: Prints the second column

+ ```grep '^$'```: keeps only empty lines.

```^$``` is a regular expression that matches an empty line. ^ for the beginning and $ for the end of the line.

Literal meaning: The start of the line is immediately followed by the end of the line.

This can only happens when **there's nothing between the start and the end of the line.**

+ ```wc -l```: counts those empty lines.


Let's put the command to use:

```bash
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $2}' healthcare_dataset.csv | grep '^$' | wc -l
9
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $3}' healthcare_dataset.csv | grep '^$' | wc -
l
9
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $4}' healthcare_dataset.csv | grep '^$' | wc -
l
11
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $5}' healthcare_dataset.csv | grep '^$' | wc -
l
5
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $6}' healthcare_dataset.csv | grep '^$' | wc -
l
11
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $7}' healthcare_dataset.csv | grep '^$' | wc -
l
10
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $8}' healthcare_dataset.csv | grep '^$' | wc -
l
10
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $9}' healthcare_dataset.csv | grep '^$' | wc -
l
15
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $10}' healthcare_dataset.csv | grep '^$' | wc
-l
9
leone-nyaga@DESKTOP-MFAESEK:~/healthcare-analysis/data$ awk -F',' '{print $11}' healthcare_dataset.csv | grep '^$' | wc
-l
0
```

so, here's the complete table for the missing data:

| Column                   | Missing | Present |
| ------------------------ | ------: | ------: |
| Patient_ID               |       0 |     100 |
| Age                      |       9 |      91 |
| Gender                   |       9 |      91 |
| BMI                      |      11 |      89 |
| Blood_Pressure           |       5 |      95 |
| Cholesterol_Level        |      11 |      89 |
| Diabetes                 |      10 |      90 |
| Hospital_Visits_Per_Year |      10 |      90 |
| Medication_Adherence     |  **15** |      85 |
| Smoking_Status           |       9 |      91 |
| Exercise_Frequency       |   **0** |     100 |


