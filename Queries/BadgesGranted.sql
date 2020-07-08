-- [params]
-- string :interval = 1 month
-- string :trunc = month

SELECT user_id, count(id)
FROM user_badges WHERE granted_at > date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval)
AND granted_at < date_trunc(:trunc, CURRENT_TIMESTAMP)

GROUP BY user_id
ORDER BY count DESC
