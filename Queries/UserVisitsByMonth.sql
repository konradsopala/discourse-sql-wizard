SELECT
    concat(date_part('month', visited_at), '-', date_part('year', visited_at)) AS Month,
    count(distinct(user_id))
    FROM user_visits WHERE date_part('year', visited_at) > '2017'
GROUP BY Month
ORDER BY Month
