WITH monthly_posts AS (
	SELECT
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
		COUNT(*) AS posts_count
	FROM posts p
	WHERE p.deleted_at IS NULL
		AND p.post_type = 1
	GROUP BY date_part('year', created_at), date_part('month', created_at)
	ORDER BY date_part('year', created_at) ASC, date_part('month', created_at)
),

monthly_solutions AS (
	SELECT
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
		COUNT(*) AS solutions_count
	FROM user_actions ua
	WHERE ua.action_type = 15
	GROUP BY date_part('year', created_at), date_part('month', created_at)
	ORDER BY date_part('year', created_at) ASC, date_part('month', created_at)
),

monthly_likes AS (
	SELECT
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
		COUNT(*) AS likes_count
	FROM user_actions ua
	WHERE ua.action_type = 2
	GROUP BY date_part('year', created_at), date_part('month', created_at)
	ORDER BY date_part('year', created_at) ASC, date_part('month', created_at)
)

SELECT
    mp.month,
    mp.year,
    SUM(COALESCE(posts_count,0) + 
        COALESCE(solutions_count, 0) + 
        COALESCE(likes_count, 0)) 
        over (ORDER BY mp.year, mp.month rows between unbounded preceding AND current row) AS count
FROM monthly_posts mp
LEFT JOIN monthly_solutions ms ON ms.year = mp.year AND ms.month = mp.month
LEFT JOIN monthly_likes ml ON ml.year = mp.year AND ml.month = mp.month
ORDER BY mp.year DESC, mp.month DESC
