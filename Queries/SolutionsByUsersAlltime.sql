SELECT user_id, COUNT(1) AS solved_count
FROM user_actions
WHERE action_type = 15

GROUP BY user_id
ORDER BY solved_count DESC
