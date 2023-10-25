-- get each page_view event for newyear and blackfriday campaign
WITH events AS
(SELECT event_date, event_name, user_pseudo_id, campaign
FROM `turing_data_analytics.raw_events`
WHERE (campaign LIKE 'New%' OR (campaign LIKE '%Friday%' AND event_date LIKE '2020%')) AND event_name = 'page_view'),

-- get count of unique user_pseudo_ids who had page_view in these campaigns
src AS
(SELECT *
FROM `turing_data_analytics.adsense_monthly`
JOIN
(SELECT campaign AS sel_campaign, COUNT(DISTINCT user_pseudo_id) AS Page_Views
FROM events
GROUP BY 1) sub
ON Campaign = sel_campaign
WHERE Campaign LIKE 'New%' OR (Campaign LIKE '%Friday%' AND Month = 202011))

-- add COV and STD
SELECT Month, Campaign, Impressions, Page_Views,
Page_Views/Impressions AS COV,
SQRT(((Page_Views/Impressions)*(1-(Page_Views/Impressions))/Impressions)) AS STD,
Cost
FROM src
