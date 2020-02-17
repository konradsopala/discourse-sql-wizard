/* Number of  staff replies since forum creation - insert your date */

SELECT posts.user_id, count(posts.id) as replies
    FROM posts
    WHERE posts.post_type = 1 
          AND posts.post_number > 1 
          AND (posts.created_at >= date('2017-10-01') 
          AND posts.created_at < date(CURRENT_TIMESTAMP)) 
          AND posts.user_id IN
            (SELECT u.id FROM users u WHERE u.primary_group_id = 41) 
            AND posts.user_id NOT IN ('-1', '-2') 
            AND posts.topic_id NOT IN ('4','24','26','32','33','34','35','36','37','38','39','40')
GROUP BY posts.user_id
ORDER BY Replies DESC
