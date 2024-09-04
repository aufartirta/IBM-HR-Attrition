## HR Analytics | Employee Attrition & Performance - IBM
Author: Aufar Tirta Firdaus

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

