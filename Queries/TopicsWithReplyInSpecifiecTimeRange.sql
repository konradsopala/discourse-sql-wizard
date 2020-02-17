/* Number of topics with reply in a specified time range */

-- [params]
-- string :month = 1
-- string :year = 2018

WITH timeframe AS (
    SELECT ID
    FROM topics
    WHERE archetype <> 'private_message'
        AND user_id not in ('-1', '-2')
        AND deleted_at IS NULL
        AND date_part('year', created_at) = :year
        AND date_part('month', created_at) = :month
    ),

posts AS (
    SELECT DISTINCT(topic_id), created_at
    FROM posts, timeframe
    WHERE topic_id IN (SELECT * FROM timeframe)
    )
SELECT count(*)
FROM posts
WHERE date_part('year', created_at) = :year
    AND date_part('month', created_at) = :month
