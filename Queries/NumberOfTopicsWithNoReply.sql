/* Number of topics with no reply per month */

SELECT date_part('month', created_at) as Month, date_part('year', created_at) AS Year, count(id) AS "Unanswered Topics"
FROM topics t
WHERE archetype <> 'private_message'
    AND deleted_at IS NULL
    AND posts_count = 1
    
GROUP BY Year, Month
ORDER BY Year DESC, Month DESC
