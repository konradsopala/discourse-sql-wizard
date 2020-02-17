/* Number of new users by month */

SELECT concat(date_part('year', created_at), '-', date_part('month', created_at)) as Mth,
        count(id) AS count
FROM "users"
GROUP BY Mth
ORDER BY Mth DESC
