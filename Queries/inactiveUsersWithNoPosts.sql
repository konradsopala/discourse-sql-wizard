/* Number of inactive users with no posts */

SELECT
    u.id,
    u.username_lower AS "username",
    u.created_at,
    u.last_seen_at
FROM users u
WHERE u.active = false
ORDER BY u.id
