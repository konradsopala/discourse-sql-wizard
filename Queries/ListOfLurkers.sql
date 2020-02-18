/* list of lurkers - users reading a lot but not posting */

--[params]
-- int :num_of_posts = 100

WITH posts_by_user AS (
    SELECT COUNT(*) AS posts, user_id
    FROM posts
    GROUP BY user_id
),

posts_read_by_user AS (
    SELECT SUM(posts_read) AS posts_read, user_id
    FROM user_visits
    GROUP BY user_id
)

SELECT
    u.id,
    u.username_lower AS "username",
    u.created_at,
    u.last_seen_at,
    COALESCE(pbu.posts, 0) AS "posts_created",
    COALESCE(prbu.posts_read, 0) AS "posts_read"
FROM users u
LEFT JOIN posts_by_user pbu ON pbu.user_id = u.id
LEFT JOIN posts_read_by_user prbu ON prbu.user_id = u.id
WHERE u.active = true
AND posts IS NULL
AND posts_read > :num_of_posts
ORDER BY  posts_read DESC
