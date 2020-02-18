/* Number of external users replies in a month */

SELECT u.username, count(p.id) AS "Total"
FROM posts p, topics t, users u
WHERE p.post_number > 1
    AND (p.created_at >= date_trunc('month', CURRENT_TIMESTAMP - INTERVAL '1 month')
    AND p.created_at < date_trunc('month', CURRENT_TIMESTAMP))
    AND p.user_id > 0
    AND t.archetype <> 'private_message'
    AND t.id = p.topic_id
    AND u.primary_group_id IS NULL
    AND u.id = p.user_id
GROUP BY u.username
ORDER BY "Total" DESC
