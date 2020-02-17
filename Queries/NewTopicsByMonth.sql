/* Number of new topics by month */

SELECT concat(date_part('year', created_at), '-', date_part('month', created_at)) AS Mth,
    count(id) AS "New_Topics"
FROM topics
WHERE archetype <> 'private_message'
    AND user_id NOT IN ('-1', '-2')
    AND date_part('year', created_at) > '2017'
GROUP BY Mth
ORDER BY Mth DESC
