/* Number of topics with no reply */

-- [params]
-- string :interval = 1 month

SELECT count(*)
FROM topics
WHERE (created_at >= date_trunc('month', CURRENT_TIMESTAMP - INTERVAL :interval)
  AND created_at < date_trunc('month', CURRENT_TIMESTAMP))
  AND posts_count > 1
  AND deleted_at IS NULL
