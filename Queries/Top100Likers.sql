/* List of top 100 likers in a specified time range */

-- [params]
-- int :months_ago = 1

WITH query_period AS (
    SELECT
        date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' AS period_start,
        date_trunc('month', CURRENT_DATE) - INTERVAL ':months_ago months' + INTERVAL '1 month' - INTERVAL '1 second' AS period_end
        )
        
    SELECT
        ua.user_id,
        count(1) AS like_count
    FROM user_actions ua
    INNER JOIN query_period qp
    ON ua.created_at >= qp.period_start
    AND ua.created_at <= qp.period_end
    WHERE ua.action_type = 1
    GROUP BY ua.user_id
    ORDER BY like_count DESC
    LIMIT 100
