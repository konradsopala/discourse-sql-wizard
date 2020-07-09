SELECT p.user_id, count(p.id) AS Replies
    FROM posts p
    WHERE p.post_type = 1
    AND p.post_number > 1
    AND (p.created_at >= '2018-09-01' AND p.created_at <= '2020-07-01')
    AND p.user_id IN (SELECT u.id FROM users u WHERE u.primary_group_id = 41)
    AND P.user_id NOT in ('-1', '-2')
    AND p.topic_id NOT in ('4','24','26','32','33','34','35','36','37','38','39','40')
GROUP BY p.user_id
ORDER BY Replies DESC
