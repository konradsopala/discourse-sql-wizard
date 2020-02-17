/* Number of topics assigned per user */

SELECT value::int user_id,
count(*)::varchar || ',/u/' || username_lower || '/activity/assigned' assigned_url
FROM topic_custom_fields tf
JOIN topics t on t.id = topic_id
JOIN users u on u.id = value::int
WHERE tf.name = 'assigned_to_id'
  AND t.deleted_at IS NULL
GROUP BY value::int, username_lower
ORDER BY count(*) DESC, username_lower
