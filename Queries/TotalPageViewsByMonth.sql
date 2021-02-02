/* Return a number of total pageviews by group by month */

-- [params]
-- date :start_date
-- date :end_date

WITH data AS (
    SELECT
        ar.date,
        CASE 
          WHEN ar.req_type=6 THEN 'Crawlers'
          WHEN ar.req_type=7 THEN 'Logged in users'
          WHEN ar.req_type=8 THEN 'Anonymous users'
        END AS Pageview,
        ar.count AS views
    FROM application_requests ar
    WHERE req_type IN (6,7,8)
        AND ar.date::date BETWEEN :start_date::date
    	AND :end_date::date
    ORDER BY ar.date ASC, ar.req_type
)

SELECT Pageview, SUM(views) qtt_views
FROM data
GROUP BY Pageview
