/* Number of staff replies in the last week */

SELECT posts.user_id, count(posts.id) AS replies
    FROM posts
      WHERE posts.post_type = 1 AND
            posts.post_number > 1 AND
            (posts.created_at >= date_trunc('week', CURRENT_TIMESTAMP - INTERVAL '1 week')
            AND posts.created_at < date_trunc('week', CURRENT_TIMESTAMP)) 
            AND posts.user_id IN
              (SELECT u.id FROM users u WHERE u.primary_group_id = 41)
              AND posts.user_id NOT IN ('-1', '-2') 
              AND posts.topic_id NOT IN ('4','24','26','32','33','34','35','36','37','38','39','40')
GROUP BY posts.user_id
ORDER BY Replies DESC
