/* Number of new topics per category in a given month */

-- [params]
-- int :months_ago = 1

WITH query_period as (
    SELECT
        date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' AS period_start,
        date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' + INTERVAL '1 month' - INTERVAL '1 second' AS period_end
)

SELECT
    t.category_id,
    count(1) AS topic_count
FROM topics t
RIGHT JOIN query_period qp
    ON t.created_at >= qp.period_start
        AND t.created_at <= qp.period_end
WHERE t.user_id > 0
    AND t.category_id IS NOT NULL
GROUP BY t.category_id
ORDER BY topic_count DESC
