SELECT
	team_size,
	AVG(stress_score) as avg_stress_score,
	AVG(burnout_score) as avg_burnout_score,
	AVG(work_life_balance_score) as avg_work_life_balance_score,
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
GROUP BY team_size
ORDER BY team_size;