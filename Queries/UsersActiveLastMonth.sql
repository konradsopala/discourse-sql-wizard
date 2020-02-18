/* Number of users active last month */

-- [params]
-- string :interval = 1 month
-- string :trunc = month

WITH t AS (
  SELECT date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval) AS start,
    date_trunc(:trunc, CURRENT_TIMESTAMP) AS END
)
SELECT count(id) AS Monthly_Active
FROM users, t
WHERE last_seen_at BETWEEN t.start AND t.end
