/* Return number of consolidated pageviews for crawlers, logged in and anonymous users by month */

-- [params]
-- date :start_date
-- date :end_date

SELECT
    ar.date,
    CASE 
      WHEN ar.req_type=6 THEN 'Crawlers'
      WHEN ar.req_type=7 THEN 'Logged in users'
      WHEN ar.req_type=8 THEN 'Anonymous users'
    END,
    ar.count AS views
FROM application_requests ar
WHERE req_type IN (6,7,8)
    AND ar.date::date BETWEEN :start_date::date
	AND :end_date::date
ORDER BY ar.date ASC, ar.req_type
