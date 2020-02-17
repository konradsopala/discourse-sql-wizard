/* Number of active users (posted at least) by time period */

--[params]
--string :interval = 1 month
--string :trunc = month

SELECT count(*)
FROM users u
WHERE (u.last_posted_at >= date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval)
      AND u.last_posted_at < date_trunc(:trunc, CURRENT_TIMESTAMP))
