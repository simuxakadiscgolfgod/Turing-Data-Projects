WITH session_data AS 
--- splitting raw data into sessions by 30 minute idle cut-off (Google Analytics default value)
--- multiple sessions are identified by user_pseudo_id and user_session_id
(
SELECT 
  EXTRACT(DAYOFWEEK FROM time_stamp) AS week_day,
  time_stamp, event_name, user_pseudo_id, country, category, browser, campaign, event_value_in_usd,
  SUM(is_new_session) OVER (PARTITION BY user_pseudo_id ORDER BY time_stamp) AS user_session_id
FROM
(SELECT *,
CASE WHEN TIMESTAMP_DIFF(time_stamp, last_event, MINUTE) >= 30 OR last_event IS NULL THEN 1 ELSE 0 END AS is_new_session
FROM
(
SELECT *,
  LAG(time_stamp) OVER (PARTITION BY user_pseudo_id ORDER BY time_stamp) AS last_event
FROM
(SELECT TIMESTAMP_MICROS(event_timestamp) AS time_stamp, event_name, user_pseudo_id, country, category, browser, campaign, event_value_in_usd
FROM `turing_data_analytics.raw_events`) sub1) sub2) sub3
)

--- if the session spans into the next day, it belongs to the day it began (therefore using MIN())
--- campaign is assigned to session by the first non null event campaign tag present in that session (therefore using LIMIT 1); if all null, then null; priotirizing adsense campaigns over other campaigns (therefore ORDER BY campaign)
--- browser is assigned to session by the first browser value present in that session (therefore using LIMIT 1); there were 2 occurences where 2 different browsers where used in the same session -> assigned the first one which was used
SELECT user_pseudo_id, user_session_id, MIN(week_day) AS week_day, STRING_AGG(DISTINCT country) AS country, STRING_AGG(DISTINCT browser LIMIT 1) AS browser, STRING_AGG(DISTINCT campaign ORDER BY campaign DESC LIMIT 1) AS campaign, SUM(event_value_in_usd) session_value_in_usd,
  TIMESTAMP_DIFF(MAX(time_stamp), MIN(time_stamp), SECOND) AS time_spent_in_session
FROM session_data
GROUP BY 1, 2
ORDER BY 1, 2
