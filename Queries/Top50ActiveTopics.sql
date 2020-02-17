/*  Top 50 Active Topics - based on number of replies */

-- [params]
-- int :months_ago = 1

WITH query_period AS (
SELECT
date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' as period_start,
date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' + INTERVAL '1 month' - INTERVAL '1 second' as period_end
)

SELECT
t.id as topic_id,
t.category_id,
COUNT(p.id) as reply_count
FROM topics t
JOIN posts p
ON t.id = p.topic_id
JOIN query_period qp
ON p.created_at >= qp.period_start
AND p.created_at <= qp.period_end
WHERE t.archetype = 'regular'
AND t.user_id > 0
GROUP BY t.id
ORDER BY COUNT(p.id) DESC, t.score DESC
LIMIT 50
