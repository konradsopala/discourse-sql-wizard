-- [params]
-- string :month = 6
-- string :year = 2020

SELECT
    concat(((1 - ((SELECT COUNT(id)
        FROM topics
        WHERE archetype <> 'private_message'
            AND deleted_at IS NULL
            AND posts_count = 1
            AND date_part('month', created_at) = :month
            AND date_part('year', created_at) = :year
            -- If you want to remove some category from reply rate
            -- AND category_id <> 42 --Remove 'FAQ' category

    )::float /
    (SELECT COUNT(id)
    FROM topics
    WHERE archetype <> 'private_message'
        AND user_id not in ('-1', '-2')
        AND date_part('month', created_at) = :month
        AND date_part('year', created_at) = :year
        -- The same here if you want to remove some category from reply rate
        -- AND category_id <> 42 --Remove 'FAQ' category
    ))) * 100)::decimal(4,2),'%') AS "Reply Rate"
