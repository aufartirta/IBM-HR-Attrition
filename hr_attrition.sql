---PART 1---

-- Check number of employee
SELECT COUNT(*)
FROM hr_attrition;

-- Check number and percentage of employee atrrition
SELECT 
	attrition,
	COUNT(attrition) AS employee_count,
	ROUND((COUNT(attrition) * 100.0 / (SELECT COUNT(*) FROM hr_attrition)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY attrition;

-- Check age distribution
SELECT 
    MAX(age) AS max_age,
    MIN(age) AS min_age,
    ROUND(AVG(age),2) AS avg_age,
    ROUND(STDDEV(age),2) AS stddev_age
FROM 
    hr_attrition;

-- Check gender ratio
SELECT 
	gender,
	COUNT(gender) AS gender_count,
	ROUND((COUNT(gender) * 100.0 / (SELECT COUNT(*) FROM hr_attrition)), 2) AS gender_percentage
FROM hr_attrition
GROUP BY gender;

-- Check monthly income distribution
SELECT 
    MAX(monthly_income) AS max_income,
    MIN(monthly_income) AS min_income,
    ROUND(AVG(monthly_income),2) AS avg_income,
    ROUND(STDDEV(monthly_income),2) AS stddev_income
FROM 
    hr_attrition;

-- Job satisfaction vs monthly income
SELECT
	job_satisfaction,
	AVG(monthly_income) as average_income
FROM hr_attrition
GROUP BY job_satisfaction
ORDER BY average_income DESC;

---PART 2---

-- Attrition percentage based on gender
SELECT
	gender,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY gender
ORDER BY attrition_percentage DESC;

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

-- Attrition percentage based on job role
SELECT
	job_role,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage DESC;

-- Attrition percentage based on job satisfaction level
SELECT
	job_satisfaction,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

-- Attrition percentage based on job involvement level
SELECT
	job_involvement,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_involvement
ORDER BY job_involvement;

-- Attrition percentage based on job education level
SELECT
	education,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY education
ORDER BY education;

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
ORDER BY attrition_percentage DESC;

-- Attrition percentage based on job environment condition
SELECT
	environment_satisfaction,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY environment_satisfaction
ORDER BY environment_satisfaction;

-- Attrition percentage based on work life balance
SELECT
	work_life_balance,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY work_life_balance
ORDER BY work_life_balance;

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
ORDER BY attrition_percentage;

---PART 3---

--Age Group vs Income
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

--Average Age vs Job Role
SELECT
	job_role,
	ROUND(AVG(age),2) AS average_age,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage;

--Job Role vs Involvement Level
SELECT 
	job_role,
	ROUND(AVG(job_involvement),2) AS involvement_level,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY involvement_level;

--Job Role vs Income
SELECT 
	job_role,
	ROUND(AVG(monthly_income),2) AS average_income,
	ROUND((COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS attrition_percentage
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_percentage;
