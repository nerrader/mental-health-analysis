SELECT
	country,
	SAFE_DIVIDE(
		COUNTIF(seeks_mental_health_support = TRUE), 
		COUNT(1)) * 100
	as seeking_mental_health_percentage
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
WHERE 
	phq9_score > 10 AND
	gad7_score > 10
GROUP BY country
ORDER BY seeking_mental_health_percentage DESC;

-- my first approach OR
SELECT
	country,
	phq9_score,
	gad7_score,
	seeks_mental_health_support
FROM
	`ivory-streamer-489402-u7`.mental_health_analysis.core_mental_health
WHERE 
	phq9_category = 'Moderate (10-14)' OR
	phq9_category = 'Moderately Severe (15-19)' OR
	phq9_category = 'Severe (20-27)' OR
	gad7_category = 'Moderate (10-14)' OR
	gad7_category = 'Severe (15-21)'

GROUP BY country
ORDER BY seeking_mental_health_percentage DESC;