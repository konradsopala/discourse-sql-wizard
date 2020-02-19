/* Number of users active last month */

-- [params]
-- string :interval = 1 month
-- string :trunc = month

WITH timeframe AS (
  SELECT date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval) AS start,
    date_trunc(:trunc, CURRENT_TIMESTAMP) AS end
)
SELECT count(id) AS Monthly_Active
FROM users, timeframe
WHERE last_seen_at BETWEEN timeframe.start AND timeframe.end
