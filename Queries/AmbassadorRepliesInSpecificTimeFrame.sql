/* Number of ambassador replies in a specific time frame */

-- [params]
-- string :interval = 1 week

SELECT posts.user_id, count(posts.id) as replies
    FROM posts
    WHERE (posts.created_at >= date_trunc('week', CURRENT_TIMESTAMP - INTERVAL :interval) AND
        posts.created_at < date_trunc('week', CURRENT_TIMESTAMP)) AND
        posts.user_id IN
        (SELECT users.id FROM users WHERE users.primary_group_id = 42)
        AND posts.user_id NOT IN ('-1', '-2')
GROUP BY posts.user_id
ORDER BY Replies DESC
