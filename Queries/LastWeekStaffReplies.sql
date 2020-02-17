/* Number of staff replies in the last week */

SELECT p.user_id, count(p.id) as Replies
    FROM posts p
    WHERE p.post_type = 1 AND
        p.post_number > 1 AND
            (p.created_at >= date_trunc('week', CURRENT_TIMESTAMP - INTERVAL '1 week') and
            p.created_at < date_trunc('week', CURRENT_TIMESTAMP)) AND
        p.user_id IN
        (select u.id
            from users u
            where u.primary_group_id = 41) AND
--            where u.admin = 't' OR u.moderator = 't') AND
        p.user_id not in ('-1', '-2') AND
        p.topic_id not in ('4','24','26','32','33','34','35','36','37','38','39','40')
GROUP BY p.user_id
ORDER BY Replies DESC
