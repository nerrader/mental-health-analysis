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