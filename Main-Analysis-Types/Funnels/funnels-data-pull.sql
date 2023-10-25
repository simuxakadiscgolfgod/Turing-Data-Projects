-- unique events cte - only 1 unique event per user_pseudo_id
WITH unique_events AS
(SELECT user_pseudo_id, event_name, MIN(TIMESTAMP_MICROS(event_timestamp)) AS time_stamp
FROM `turing_data_analytics.raw_events`
GROUP BY 1, 2),

-- additional info - like country, category, campaign - to be joined later to unique events cte
additional_info AS
(SELECT user_pseudo_id, event_name, (TIMESTAMP_MICROS(event_timestamp)) AS time_stamp, country, category, campaign
FROM `turing_data_analytics.raw_events`),

-- unique events cte plus additional info
whole_info AS
(SELECT unique_events.user_pseudo_id, unique_events.event_name, unique_events.time_stamp, country, category, campaign
FROM unique_events
LEFT OUTER JOIN additional_info ON
unique_events.user_pseudo_id = additional_info.user_pseudo_id AND
unique_events.event_name = additional_info.event_name AND
unique_events.time_stamp = additional_info.time_stamp),

-- top 3 countries based on number of events
top_3_countries AS
(SELECT ROW_NUMBER() OVER (ORDER BY event_count DESC) AS spot, country
FROM
(SELECT country, COUNT(*) AS event_count
FROM whole_info
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3) sub),

-- chosen events to be used in funnel analysis
events AS
(SELECT ROW_NUMBER() OVER (ORDER BY event_count DESC) AS event_order, event_name
FROM
(SELECT event_name, COUNT(*) AS event_count
FROM whole_info
WHERE event_name IN ('session_start', 'scroll', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY 1) sub),

-- event count for top 3 countries
country_events AS
(SELECT event_name,
COUNT(CASE WHEN country = (SELECT country FROM top_3_countries WHERE spot = 1) THEN 1 END) AS country_1_events,
COUNT(CASE WHEN country = (SELECT country FROM top_3_countries WHERE spot = 2) THEN 1 END) AS country_2_events,
COUNT(CASE WHEN country = (SELECT country FROM top_3_countries WHERE spot = 3) THEN 1 END) AS country_3_events
FROM whole_info
GROUP BY 1)

-- events cte plus country events cte and other required columns
SELECT events.event_order, events.event_name, country_1_events, country_2_events, country_3_events,
(country_1_events + country_2_events + country_3_events) /
(SELECT country_1_events + country_2_events + country_3_events FROM country_events WHERE event_name = (SELECT event_name FROM events WHERE event_order = 1)) AS full_perc,
country_1_events / (SELECT country_1_events FROM country_events WHERE event_name = (SELECT event_name FROM events WHERE event_order = 1)) AS country_1_perc_drop,
country_2_events / (SELECT country_2_events FROM country_events WHERE event_name = (SELECT event_name FROM events WHERE event_order = 1)) AS country_2_perc_drop,
country_3_events / (SELECT country_3_events FROM country_events WHERE event_name = (SELECT event_name FROM events WHERE event_order = 1)) AS country_3_perc_drop
FROM events
LEFT OUTER JOIN country_events
ON events.event_name = country_events.event_name
