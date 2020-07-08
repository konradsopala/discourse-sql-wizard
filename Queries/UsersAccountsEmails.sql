-- [params]
-- string :interval = 365 days
-- string :trunc = day

WITH t AS (
  SELECT date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval) AS start,
    date_trunc(:trunc, CURRENT_TIMESTAMP) AS end
)

SELECT user_id, email, created_at FROM user_emails ue, t
WHERE ue.created_at > t.start AND ue.created_at < t.end
ORDER BY ue.created_at DESC
