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
-- Check income distribution
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
-- Attrition percentage based on gender
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
-- Attrition percentage based on age group
SELECT 
	CASE
        WHEN age >=18 AND age <=25 THEN '18-25 years old'
		WHEN age >25 AND age <=40 THEN '25-40 years old'
		WHEN age >40 AND age <=60 THEN '40-60 years old'
        ELSE '>60 years'
    END AS age_group,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY age_group
ORDER BY age_group;
```
Result:
age_group|attritio_percentage
---|---
18-25 years old|	35.77
25-40 years old|	15.99
40-60 years old|	11.18

Younger employees generally exhibit higher attrition rates. Those aged 18-25 have a significantly higher attrition rate of 35.77% compared to older age groups.

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
job_involvement|attrition_percentage
---|---
1	33.73
2	18.93
3	14.40
4	9.03

Job involvement level is described as: </br>
1: Low </br>
2: Medium </br>
3: High </br>
4: Very High </br>

Employees with low job involvement level tend to have higher attrition rates (33.73% on 'Low' job involvement level). 

```sql
-- Attrition percentage based on job education level
SELECT
	education,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY education
ORDER BY education;
```
Result:
education|attrition_percentage
---|---
1|	18.24
2|	15.60
3|	17.31
4|	14.57
5|	10.42

Education level is described as: </br>
1: Below College </br>
2: College </br>
3: Bachelor </br>
4: Master </br>
5: Doctor </br>

Employees without a college degree show a slightly higher attrition rate (18.24%) compared to those with a college education. Notably, employees with a bachelor's degree also experience a relatively high attrition rate (17.31%), which may be attributed to their ongoing search for better career opportunities.

```sql
-- Attrition percentage based on income
WITH IncomeQuartile AS(
	SELECT
    	NTILE(4) OVER (ORDER BY monthly_income) AS income_quartile,
		attrition
	FROM
		hr_attrition
)
SELECT
	income_quartile,
    ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM IncomeQuartile
GROUP BY income_quartile
ORDER BY income_quartile;
```
Result:
income_quartile|attrition_percentage
---|---
1|	29.35
2|	14.13
3|	10.63
4|	10.35

Employees with low income (1st quartile) tend to have higher attrition rates. On the contrary, higher income (3rd and 4th quartile) related to lower attrition rate.

```sql
-- Attrition percentage based on tenure
SELECT 
	CASE
        WHEN years_at_company >=0 AND years_at_company <=2 THEN '0-2 years'
		WHEN years_at_company >2 AND years_at_company <=5 THEN '2-5 years'
		WHEN years_at_company >5 AND years_at_company <=8 THEN '5-8 years'
		WHEN years_at_company >8 AND years_at_company <=10 THEN '8-10 years'
        ELSE '>10 years'
    END AS tenure,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY tenure
ORDER BY tenure;
```
Result:
tenure|attrition_percentage
---|---
0-2 years|	29.82
2-5 years|	13.82
5-8 years|	11.79
8-10 years|	12.87
`>`10 years|	8.13

As tenure increases, the attrition rate decreases. The longer an employee remains with the company, the less likely they are to leave. Newer employees have a higher attrition rate, with 29.82% leaving.

```sql
-- Attrition percentage based on professional experience
SELECT 
	CASE
        WHEN total_working_years >=0 AND total_working_years <=5 THEN '0-5 years'
		WHEN total_working_years >5 AND total_working_years <=10 THEN '5-10 years'
		WHEN total_working_years >10 AND total_working_years <=20 THEN '10-20 years'
        ELSE '>20 years'
    END AS professional_experience,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY professional_experience
ORDER BY attrition_percentage DESC
```
Result:
professional_experience|attrition_percentage
---|---
0-5 years|	28.80
5-10 years|	14.99
10-20 years|	11.47
`>`20 years|	7.73

The more professional experience an employee has, the lower their attrition rate becomes, with those having over 20 years of experience showing an attrition rate of just 7.73%. In contrast, employees who are early in their careers (0-5 years of experience) have a much higher attrition rate of 28.80%.

```sql
-- Attrition percentage based on job environment condition satisfaction
SELECT
	environment_satisfaction,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY environment_satisfaction
ORDER BY environment_satisfaction;
```
Result:
environment_satisfaction|attrition_percentage
---|---
1|	25.35
2|	14.98
3|	13.69
4|	13.45

Environment satisfaction is described as: </br>
1: Low </br>
2: Medium </br>
3: High </br>
4: Very High </br>

Low levels of environmental satisfaction result in higher attrition rates (25.35%). Conversely, higher levels of environmental satisfaction are associated with lower attrition rates (13.45%).

```sql
-- Attrition percentage based on work life balance
SELECT
	work_life_balance,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY work_life_balance
ORDER BY work_life_balance;
```
Result:
work_life_balance|attrition_percentage
---|---
1	|31.25
2	|16.86
3	|14.22
4	|17.65

Work-life balance is described as: <\br>
1: Bad <\br>
2: Good <\br>
3: Better <\br>
4: Best <\br>

Poor work-life balance is associated with a higher attrition rate (31.25%). In contrast, good to excellent work-life balance conditions result in comparatively lower attrition rates.


```sql
-- Attrition percentage based on living distance
SELECT 
	CASE
		WHEN distance_from_home >0 AND distance_from_home <=5 THEN '<5 km'
		WHEN distance_from_home >5 AND distance_from_home <=10 THEN '5-10 km'
		ELSE '>10 km'
	END AS living_distance,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY living_distance
ORDER BY living_distance;
```
Result:
living_distance | attrition_percentage
---|---
<5 km|	13.77
5-10 km|	14.47
`>`10 km|	20.95

The living distance is divided into three categories: less than 5 km, 5-10 km, and more than 10 km. Employees who live farther from the office, particularly those residing more than 10 km away, experience a higher attrition rate (20.95%).

### 3. Exploring Factors Affecting Attrition Rates
Based on the analysis, the top three factors most likely to influence employee attrition are **age, job role, and job involvement**. These factors will be examined in greater detail to gain a deeper understanding of how they interact with other variables contributing to employee attrition.

```sql
---Age Group vs Income
SELECT 
	CASE
        WHEN age >=18 AND age <=25 THEN '18-25 years old'
		WHEN age >25 AND age <=40 THEN '25-40 years old'
		WHEN age >40 AND age <=60 THEN '40-60 years old'
        ELSE '>60 years'
    END AS age_group,
	ROUND(AVG(monthly_income),2) AS average_income,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY age_group
ORDER BY age_group;
```
Result:
age_group|average_income|attrition_percentage
---|---|---
18-25 years old|	2972.89|35.77
25-40 years old|	5396.52|15.99
40-60 years old|	9535.31|11.18

Employees in younger age groups with lower incomes are more likely to leave the company, while those in older age groups, who earn more, are more likely to stay.

```sql
SELECT
	job_role,
	ROUND(AVG(age),2) AS average_age,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage
```
Result:
job_role|average_age|attrition_percentage
---|---|---
Research Director|	44.00|	2.50
Manager|	46.76|	4.90
Healthcare Representative|	39.81|	6.87
Manufacturing Director|	38.30|	6.90
Research Scientist|	34.24|	16.10
Sales Executive|	36.89|	17.48
Human Resources|	35.50|	23.08
Laboratory Technician|	34.10|	23.94
Sales Representative|	30.36|	39.76

Roles with older employees, such as Research Directors and Managers, tend to have much lower attrition rates. These roles likely offer more job stability, higher pay, and long-term career satisfaction. Younger employees, especially in roles like Sales Representative and Laboratory Technician, face significantly higher attrition rates. These roles may be more transient, with employees looking for upward mobility or higher-paying opportunities. Technical and senior leadership roles like Research Director and Manager have lower attrition, while sales and support roles (Sales Representative, Human Resources) have much higher attrition, possibly due to job stress, performance pressures, or limited career progression.

```sql
SELECT 
	job_role,
	ROUND(AVG(job_involvement),2) AS involvement_level,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY involvement_level;
```
Result:
job_role|involvement_level|atrition_percentage
---|---|---
Sales Representative|	2.65|	39.76
Manufacturing Director|	2.68|	6.90
Laboratory Technician|	2.69|	23.94
Sales Executive|	2.71|	17.48
Human Resources|	2.71|	23.08
Healthcare Representative|	2.73|	6.87
Manager|	2.77|	4.90
Research Director|	2.78|	2.50
Research Scientist|	2.80|	16.10

There is generally a correlation between higher involvement levels and lower attrition rates. Employees who feel more engaged and connected to their roles tend to stay longer, as seen with Managers and Research Directors. Employees in roles like Sales Representative, Sales Executive, and Human Resources show low to moderate involvement levels and higher attrition rates, suggesting that improving engagement could help reduce turnover in these areas. In some cases, even roles with moderate involvement (e.g., Healthcare Representative, Manufacturing Director) still have low attrition, likely due to other factors like job security, seniority, or compensation. Conversely, Research Scientists, despite their high involvement, still show relatively high turnover, which could be due to external factors like career progression or job demands.

```sql
SELECT 
	job_role,
	ROUND(AVG(monthly_income),2) AS average_income,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage;
```
Result:

job_role|average_income|attrition_percentage
---|---|---
Research Director|	16033.55|	2.50
Manager|	17181.68|	4.90
Healthcare Representative|	7528.76|	6.87
Manufacturing Director|	7295.14|	6.90
Research Scientist|	3239.97|	16.10
Sales Executive|	6924.28|	17.48
Human Resources|	4235.75|	23.08
Laboratory Technician|	3237.17|	23.94
Sales Representative|	2626.00|	39.76


There is a clear trend showing that higher income levels are associated with lower attrition rates. Employees in senior and well-compensated roles, such as Managers and Research Directors, tend to stay longer, while those in lower-paying roles, like Sales Representatives and Laboratory Technicians, have much higher turnover. Entry-Level Roles: Senior roles with higher responsibilities, such as Managers and Directors, have higher incomes and correspondingly low attrition rates. On the other hand, entry-level or lower-paying roles like Sales Representatives and Laboratory Technicians tend to have high attrition, likely due to lower job satisfaction, limited career growth, and inadequate compensation.
Both Sales Representatives and Sales Executives have high attrition, even though Sales Executives earn more. This may indicate that sales roles, regardless of pay, often come with high job pressure and targets that drive turnover.

