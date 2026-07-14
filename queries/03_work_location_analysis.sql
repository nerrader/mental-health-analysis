SELECT
	work_mode,
	CASE
		WHEN sleep_hours_per_night < 7 THEN 'Sleep Deprived'
		WHEN work_hours_per_week > 50 THEN 'High Hours'
		WHEN LOWER(seniority_level) IN ('lead', 'manager', 'principal') THEN 'High Seniority'
		ELSE 'Normal'
	END as risk_profile,
	AVG(job_satisfaction_score) as avg_job_satisfaction_score,
	AVG(burnout_score) as avg_burnout_score,
	AVG(stress_score) as avg_stress,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health 
GROUP BY work_mode, risk_profile;

-- that one time where i wrote three different queries for thsi for sm reason
SELECT
	work_mode,
	AVG(job_satisfaction_score) as avg_job_satisfaction_score,
	AVG(burnout_score) as avg_burnout_score,
	AVG(stress_score) as avg_stress,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health 
WHERE sleep_hours_per_night > 7
GROUP BY work_mode;

SELECT
	work_mode,
	AVG(job_satisfaction_score) as avg_job_satisfaction_score,
	AVG(burnout_score) as avg_burnout_score,
	AVG(stress_score) as avg_stress,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health 
WHERE LOWER(seniority_level) IN ('lead', 'manager', 'principal')
GROUP BY work_mode;

SELECT
	work_mode,
	AVG(job_satisfaction_score) as avg_job_satisfaction_score,
	AVG(burnout_score) as avg_burnout_score,
	AVG(stress_score) as avg_stress,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health 
WHERE work_hours_per_week > 50
GROUP BY work_mode;
