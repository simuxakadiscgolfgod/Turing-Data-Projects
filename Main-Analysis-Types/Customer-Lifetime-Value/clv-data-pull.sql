WITH customers AS (
SELECT user_pseudo_id, MIN(DATE_TRUNC(DATE(TIMESTAMP_MICROS(event_timestamp)), WEEK(SUNDAY))) AS registration_date
FROM `turing_data_analytics.raw_events`
GROUP BY 1
),
sales AS (
SELECT user_pseudo_id, DATE_TRUNC(DATE(TIMESTAMP_MICROS(event_timestamp)), WEEK(SUNDAY)) AS sale_date, SUM(event_value_in_usd) AS Total
FROM `turing_data_analytics.raw_events`
WHERE event_value_in_usd IS NOT NULL
GROUP BY 1, 2
)
SELECT customers.registration_date, sales.user_pseudo_id, sales.sale_date, sales.Total
FROM sales
JOIN customers
ON sales.user_pseudo_id = customers.user_pseudo_id
