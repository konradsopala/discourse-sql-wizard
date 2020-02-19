/* Number of inactive users with no posts */

SELECT
    users.id,
    users.username_lower AS "username",
    users.created_at,
    users.last_seen_at
FROM users
WHERE users.active = false
ORDER BY users.id
