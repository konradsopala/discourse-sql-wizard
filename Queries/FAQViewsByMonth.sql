SELECT
    concat(date_part('month', viewed_at), '-', date_part('year', viewed_at)) AS Month,
    count(*) AS Views
    FROM topic_views WHERE topic_id IN (SELECT id FROM topics WHERE category_id = '42' AND deleted_at IS NULL)
GROUP BY Month
ORDER BY Month ASC
