/* New posts by month */

SELECT concat(date_part('year', created_at), '-', date_part('month', created_at)) AS Mth,
    count(id) AS "New_Posts"
FROM posts
WHERE post_type = 1
    AND user_id not in ('-1', '-2')
    AND post_number > 1
GROUP BY Mth
ORDER BY Mth DESC
