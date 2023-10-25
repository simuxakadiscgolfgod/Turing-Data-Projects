WITH src AS (
SELECT *,
DATE_TRUNC(subscription_start, WEEK(SUNDAY)) AS start_week,
DATE_TRUNC(subscription_end, WEEK(SUNDAY)) AS end_week
FROM `turing_data_analytics.subscriptions`
),
users AS (
SELECT
start_week,
COUNT(DISTINCT user_pseudo_id) AS user_count
FROM src
GROUP BY 1
),
w0 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_0
FROM src
WHERE start_week < end_week OR end_week IS NULL
GROUP BY 1
),
w1 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_1
FROM src
WHERE DATE_ADD(start_week, INTERVAL 1 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
),
w2 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_2
FROM src
WHERE DATE_ADD(start_week, INTERVAL 2 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
),
w3 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_3
FROM src
WHERE DATE_ADD(start_week, INTERVAL 3 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
),
w4 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_4
FROM src
WHERE DATE_ADD(start_week, INTERVAL 4 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
),
w5 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_5
FROM src
WHERE DATE_ADD(start_week, INTERVAL 5 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
),
w6 AS (
SELECT
start_week,
COUNT (DISTINCT user_pseudo_id) AS week_6
FROM src
WHERE DATE_ADD(start_week, INTERVAL 6 WEEK) < end_week OR end_week IS NULL
GROUP BY 1
)
SELECT users.start_week, user_count, week_0, week_1, week_2, week_3, week_4, week_5, week_6
FROM users
JOIN w0 ON users.start_week = w0.start_week
JOIN w1 ON users.start_week = w1.start_week
JOIN w2 ON users.start_week = w2.start_week
JOIN w3 ON users.start_week = w3.start_week
JOIN w4 ON users.start_week = w4.start_week
JOIN w5 ON users.start_week = w5.start_week
JOIN w6 ON users.start_week = w6.start_week
ORDER BY 1
