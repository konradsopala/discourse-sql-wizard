/* Number of users with no activity since joining */

SELECT concat(date_part('year', new_since), '-', date_part('month', new_since)) AS month,
    count(user_id) AS count_users
FROM user_stats
WHERE first_post_created_at IS NOT NULL
    AND topic_count > 0
GROUP BY month
ORDER BY month DESC
