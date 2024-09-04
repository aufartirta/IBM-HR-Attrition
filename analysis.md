## HR Analytics | Employee Attrition & Performance - IBM
Author: Aufar Tirta Firdaus

### 1. Employee Demographic
```sql
-- Check number of employee
SELECT COUNT(*)
FROM hr_attrition;
```
Result: 1470.
There are total of 1470 employee in the dataset.

```sql
-- Check number and percentage of employee atrrition
SELECT 
	attrition,
	COUNT(attrition),
	ROUND((COUNT(attrition) * 100.0 / (SELECT COUNT(*) FROM hr_attrition)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY attrition
```
Result:
attrition|employee_count|attrition_percentage
---|---|---
No|	1233|	83.88
Yes|	237|	16.12

Attrition accounts for 16.12% of the total workforce.

```sql
-- Check age distribution
SELECT 
    MAX(age) AS max_age,
    MIN(age) AS min_age,
    ROUND(AVG(age),2) AS avg_age,
    ROUND(STDDEV(age),2) AS stddev_age
FROM 
    hr_attrition;
```
Result:
max_age|min_age|avg_age|stddev_age
---|---|---|---
60|	18|	36.92|	9.14

The age ranges from 18-60 years old, with average of 36.92 years old.

```sql
-- Check gender ratio
SELECT 
	gender,
	COUNT(gender) AS gender_count,
	ROUND((COUNT(gender) * 100.0 / (SELECT COUNT(*) FROM hr_attrition)), 2) AS gender_percentage
FROM hr_attrition
GROUP BY gender;
```
Result:
gender|gender_count|gender_ration
---|---|---
Female|	588|	40.00
Male|	882|	60.00

The gender composition is quite balanced, with 40% female employee and 60& male employee.

```sql
SELECT 
    MAX(monthly_income) AS max_income,
    MIN(monthly_income) AS min_income,
    ROUND(AVG(monthly_income),2) AS avg_income,
    ROUND(STDDEV(monthly_income),2) AS stddev_income
FROM 
    hr_attrition;
```
Result:
max_inocme|min_income|avg_income|stddev_income
---|---|---|---
19999|	1009|	6502.93|	4707.96

Monthly income ranges from a minimum of 1,009 to a maximum of 19,999, with an average of 6,502.93.

### 2. Identifying Factors of Attrition

```sql
SELECT
	gender,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY gender
ORDER BY attrition_percentage DESC;
```
Result:
gender|attrition_percentage
---|---
Male|	17.01
Female|	14.80

There is a slight difference in attrition rates between genders, with 17.01% of male employees experiencing attrition compared to 14.80% of female employees.

```sql
-- Attrition percentage based on job role
SELECT
	job_role,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage DESC;
```
Result:
job_role|attrition_percentage
---|---
Sales Representative|	39.76
Laboratory Technician|	23.94
Human Resources|	23.08
Sales Executive|	17.48
Research Scientist|	16.10
Manufacturing Director|	6.90
Healthcare Representative|	6.87
Manager|	4.90
Research Director|	2.50

The job roles with the highest attrition rates are Sales Representatives (39.76%), Laboratory Technicians (23.94%), and Human Resources (23.08%). On the other hand, the roles with the lowest attrition rates are Research Directors (2.50%), Managers (6.87%), and Healthcare Representatives (6.87%).

```sql
-- Attrition percentage based on job satisfaction level
SELECT
	job_satisfaction,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_satisfaction
ORDER BY job_satisfaction;
```
Result:
job_satisfaction|attrition_percentage
---|---
1|	22.84
2|	16.43
3|	16.52
4|	11.33

Job satisfaction level is described as: </br>
1: Low </br>
2: Medium </br>
3: High </br>
4: Very High </br>

Employees with low job satisfaction level tend to have higher attrition rates (22.84% on 'Low' satisfaction).

```sql
-- Attrition percentage based on job involvement level
SELECT
	job_involvement,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_involvement
ORDER BY job_involvement;
```
Result:
job_involvment|attrition_percentage
---|---
1	33.73
2	18.93
3	14.40
4	9.03

Job involvment level is described as: </br>
1: Low </br>
2: Medium </br>
3: High </br>
4: Very High </br>

Employees with low job involvement level tend to have higher attrition rates (33.73% on 'Low' job involvement level). 
