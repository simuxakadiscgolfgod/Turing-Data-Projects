WITH purchases AS (
SELECT event_date, user_pseudo_id, COUNT(*) AS purchase_count
FROM `turing_data_analytics.raw_events`
WHERE event_name = 'purchase' AND event_value_in_usd > 0
GROUP BY 1, 2
),

join_date AS (
SELECT user_pseudo_id, MIN(event_date) AS join_date
FROM `turing_data_analytics.raw_events`
GROUP BY 1
),

returning_users AS (
SELECT event_date, purchases.user_pseudo_id, join_date.join_date, purchases.purchase_count,
CASE WHEN join_date.join_date = event_date THEN 'new' ELSE 'returning' END AS user_type
FROM purchases
JOIN join_date ON purchases.user_pseudo_id = join_date.user_pseudo_id
),

first_touch AS (
SELECT event_date, user_pseudo_id, MIN(event_timestamp) AS first_touch_day
FROM `turing_data_analytics.raw_events`
GROUP BY 1, 2
ORDER BY 1
),

purchase_made AS (
SELECT event_date, user_pseudo_id, MIN(event_timestamp) AS purchase_made_day
FROM `turing_data_analytics.raw_events`
WHERE event_name = 'purchase' AND event_value_in_usd > 0
GROUP BY 1, 2
),

--calculate time difference between first touch and purchase in each day for each customer
diff_data AS (
SELECT 
  first_touch.event_date, 
  first_touch.user_pseudo_id,
  TIMESTAMP_DIFF(TIMESTAMP_MICROS(purchase_made_day), TIMESTAMP_MICROS(first_touch_day), SECOND) AS first_touch_to_purchase_second_diff,
  user_type,
  first_touch_day,
  purchase_made_day
FROM first_touch
LEFT JOIN purchase_made
ON purchase_made.event_date = first_touch.event_date AND purchase_made.user_pseudo_id = first_touch.user_pseudo_id
LEFT JOIN returning_users
ON returning_users.event_date = first_touch.event_date AND returning_users.user_pseudo_id = first_touch.user_pseudo_id
WHERE TIMESTAMP_DIFF(TIMESTAMP_MICROS(purchase_made_day), TIMESTAMP_MICROS(first_touch_day), SECOND) IS NOT NULL
)

SELECT user_type, event_name, AVG(sec_spent_in_event) AS avg_sec_spent_in_event
FROM
--pull some more data, like time_stamp_diff between events from first touch to purchase, page titles
(SELECT diff_data.event_date, diff_data.user_pseudo_id, diff_data.user_type, TIMESTAMP_MICROS(event_timestamp) AS time_stamp, event_name, page_title,
  IFNULL(TIMESTAMP_DIFF(LEAD(TIMESTAMP_MICROS(event_timestamp), 1) OVER (PARTITION BY diff_data.user_pseudo_id ORDER BY TIMESTAMP_MICROS(event_timestamp)), TIMESTAMP_MICROS(event_timestamp), SECOND), 0) AS sec_spent_in_event
FROM diff_data
JOIN `turing_data_analytics.raw_events` raw_events
ON raw_events.event_date = diff_data.event_date AND raw_events.user_pseudo_id = diff_data.user_pseudo_id
AND TIMESTAMP_MICROS(raw_events.event_timestamp) <= TIMESTAMP_MICROS(diff_data.purchase_made_day)) sub
GROUP BY 1, 2
ORDER BY 1, 2
