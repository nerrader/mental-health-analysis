SELECT
	ROUND(salary_usd, -4) as salary_bucket,
	ROUND(AVG(job_satisfaction_score), 2) as avg_job_satisfaction_score,
	ROUND(AVG(stress_score), 2) as avg_stress_score,
	ROUND(AVG(burnout_score), 2) as avg_burnout_score,
	ROUND(AVG(phq9_score), 2) as avg_phq9_score,
	ROUND(AVG(gad7_score), 2) as avg_gad7_score,
FROM `ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
GROUP BY salary_bucket
HAVING COUNT(1) >= 100 -- filters data if num_of_employees in that salary bracket are less than 100
ORDER BY salary_bucket;

-- This was just to see how many number of employees were in each salary bucket
SELECT ROUND(salary_usd, -4) as salary_bucket, COUNT(1) as num_of_employees
FROM `ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
GROUP BY salary_bucket 
ORDER BY salary_bucket;

-- somehow all of these correlations are 0 so you cant use these 3 for a responsibility index
SELECT
	CORR(salary_usd, work_hours_per_week) as salary_hours_corr,
	CORR(salary_usd, deadline_pressure_score) as salary_deadline_pressure_corr,
	CORR(deadline_pressure_score, work_hours_per_week) as deadline_hours_corr,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health;

-- this will show a positive correlation, as the higher the int_seniority_level, the higher the avg salary usd
SELECT 
	CASE
		WHEN LOWER(seniority_level) = 'junior' THEN 1
		WHEN LOWER(seniority_level) = 'mid' THEN 2
		WHEN LOWER(seniority_level) = 'senior' THEN 3
		WHEN LOWER(seniority_level) = 'lead' THEN 4
		WHEN LOWER(seniority_level) = 'manager' THEN 5
		WHEN LOWER(seniority_level) = 'principal' THEN 6
		ELSE 0
	END AS int_seniority_level,
	AVG(salary_usd) as salary_usd,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
GROUP BY int_seniority_level
ORDER BY int_seniority_level;
