/* List of active readers for the past month */

SELECT user_id,
    count(1) AS visits,
    sum(posts_read) AS posts_read
FROM user_visits
WHERE posts_read > 0
AND visited_at > CURRENT_TIMESTAMP - INTERVAL '30 days'
GROUP BY user_id
ORDER BY visits DESC, posts_read DESC
