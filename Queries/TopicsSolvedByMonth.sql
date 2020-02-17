/* Topics marked as solved by month - insert your date */

SELECT concat(
        date_part('year', created_at), '-',
        date_part('month', created_at)) AS Month,
    count(id) AS total_solved
FROM user_actions
WHERE action_type = '15'
    AND date_part('year', created_at) > '2017'
GROUP BY Month
ORDER BY Month
