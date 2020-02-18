/* Number of inactive vs active users */

-- [params]
-- string :interval = 1 month
-- string :trunc = month

WITH t AS (
SELECT date_trunc(:trunc, CURRENT_TIMESTAMP - INTERVAL :interval) AS start,
  date_trunc(:trunc, CURRENT_TIMESTAMP) AS end),

tu AS (
SELECT count(id) AS "Total_Users"
  FROM users
  WHERE active = true
  AND created_at < '2018-01-01'),

active AS (
SELECT count(id) AS "Active_Users"
  FROM users, t
  WHERE last_seen_at BETWEEN t.start AND t.end)

SELECT "Total_Users",
    "Active_Users",
    (COALESCE("Total_Users",0) - COALESCE("Active_Users",0)) AS "Inactive_Users"
FROM tu, active
