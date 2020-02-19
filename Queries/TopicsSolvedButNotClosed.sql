/* List of topics that are solved but not closed */

SELECT 'https://community.auth0.com/t/' || id AS "TopicID", title
FROM topics
WHERE id IN (
        SELECT target_topic_id FROM user_actions WHERE action_type = '15')
        AND closed is false
