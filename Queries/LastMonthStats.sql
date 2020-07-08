-- [params]
-- string :interval = 1 month

SELECT
    (SELECT count(*) AS Count
    FROM "users" WHERE (users.id > 0) AND (NOT EXISTS(
        SELECT 1 FROM user_custom_fields ucf
        WHERE ucf.user_id = users.id
        AND ucf.name = 'master_id'
        AND ucf.value::int > 0
        ))
    AND created_at >= CURRENT_DATE - INTERVAL :interval
    ) AS NewUsers,

    (SELECT count(*)
    FROM users u WHERE (u.last_posted_at >= date_trunc('month', CURRENT_TIMESTAMP - INTERVAL :interval)
    AND u.last_posted_at < date_trunc('month', CURRENT_TIMESTAMP))
    ) AS ActiveUsers,

    (SELECT count(*)
    FROM topics t WHERE t.created_at >= date_trunc('month', CURRENT_DATE - INTERVAL :interval)
    AND created_at < date_trunc('month', CURRENT_DATE)
    AND t.deleted_at IS NULL
    AND t.user_id NOT IN ('-1', '-2')
    ) AS NewTopics,

    (SELECT count(*)
    FROM posts p WHERE p.created_at >= date_trunc('month', CURRENT_DATE - INTERVAL :interval)
    AND p.created_at < date_trunc('month', CURRENT_DATE)
    AND p.deleted_at IS NULL
    AND p.user_id not in ('-1', '-2')
    AND p.post_type=1
    AND p.post_number > 1
    ) AS Replies,

    (SELECT count(p.id)
    FROM posts p WHERE (p.created_at >= date_trunc('month', CURRENT_TIMESTAMP - INTERVAL :interval)
    AND p.created_at < date_trunc('month', CURRENT_TIMESTAMP))
    AND p.user_id IN (SELECT u.id FROM users u WHERE u.primary_group_id = 41)
    AND p.user_id not in ('-1', '-2')
    AND p.post_type = 1
    AND p.post_number > 1
    ) AS emp_replies
