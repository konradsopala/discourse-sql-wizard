WITH data_month AS (
    SELECT 
        date_part('year', created_at) AS year, 
        date_part('month', created_at) AS month,
        COUNT(*) AS "new_users_month"
    FROM users
    GROUP BY date_part('year', created_at), date_part('month', created_at)
    ORDER BY date_part('year', created_at) ASC, date_part('month', created_at)
)

SELECT
  month, 
  year, 
  SUM(new_users_month) over (ORDER BY year, month rows between unbounded preceding AND current row) AS total
FROM data_month ORDER BY year DESC, month DESC
