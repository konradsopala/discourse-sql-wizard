WITH intervals AS (
    SELECT n AS start_time, CURRENT_TIMESTAMP AS end_time
    FROM generate_series(CURRENT_TIMESTAMP - INTERVAL '30 days',
                         CURRENT_TIMESTAMP - INTERVAL '1 day',
                         INTERVAL '1 day') n
)

SELECT COUNT(1) AS users_seen_since, CURRENT_TIMESTAMP - i.start_time AS time_ago
FROM USERS u RIGHT JOIN intervals i
ON u.last_seen_at >= i.start_time AND u.last_seen_at < i.end_time

GROUP BY i.start_time, i.end_time
ORDER BY i.start_time DESC
