-- [params]
-- string :quarter = 1
-- string :year = 2018

SELECT count(date_part('quarter', created_at)) AS Count
FROM "users"  WHERE (users.id > 0)
    AND (NOT EXISTS(
        SELECT 1
            FROM user_custom_fields ucf WHERE ucf.user_id = users.id
            AND ucf.name = 'master_id'
            AND ucf.value::int > 0
        ))
    AND date_part('quarter', created_at) = :quarter
    AND date_part('year', created_at) = :year
