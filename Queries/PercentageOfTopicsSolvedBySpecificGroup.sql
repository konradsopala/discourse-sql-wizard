WITH users_solution AS (
	SELECT 
        user_id
	FROM user_actions ua
	WHERE ua.action_type = 15
	GROUP BY user_id
),

users_groups AS (
    SELECT 
        user_id, 
        g.id,
        g.name group_name 
    FROM users u
    LEFT JOIN users_solution us ON u.id = us.user_id
    LEFT JOIN groups g ON g.id = u.primary_group_id
    WHERE u.primary_group_id = 41
    GROUP BY user_id, g.id
),
    
tt_solution_by_month AS (
    SELECT 
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
		COUNT(*) AS "total"
	FROM user_actions ua
	WHERE ua.action_type = 15
	GROUP BY date_part('year', created_at), date_part('month', created_at)
	ORDER BY date_part('year', created_at) ASC, date_part('month', created_at)
),
	
tt_solution_groups_by_month AS (
    SELECT 
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
        ug.group_name,
    	COUNT(*) AS "tt_groups"
    FROM user_actions ua
    INNER JOIN users_groups ug ON ug.user_id = ua.user_id
    WHERE ua.action_type = 15
    GROUP BY ug.group_name, date_part('year', created_at), date_part('month', created_at)
    ORDER BY date_part('year', created_at) DESC, date_part('month', created_at), ug.group_name)
    
SELECT 
    ts.year,
    ts.month,
    TRUNC((tt_groups::decimal/total::decimal) *100,1) AS "%"
FROM tt_solution_groups_by_month tsg  
INNER JOIN tt_solution_by_month ts 
    ON ts.year = tsg.year AND ts.month = tsg.month
ORDER BY year DESC, month DESC
