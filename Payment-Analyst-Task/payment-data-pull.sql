---pulls out interesting data about delivered orders from olist database

WITH product_data AS 
(
SELECT order_id, STRING_AGG(DISTINCT category_name, ', ') AS category_name, SUM(price) AS total_price, SUM(freight_value) AS total_freight_value, SUM(product_weight_g) AS total_product_weight_g, SUM(product_volume_cm3) AS total_product_volume_cm3
FROM `olist_db.olist_order_items_dataset` items
JOIN
(SELECT product_id, trans.string_field_1 AS category_name, product_weight_g, product_height_cm * product_length_cm * product_width_cm AS product_volume_cm3
FROM `tc-da-1.olist_db.olist_products_dataset` prod
LEFT JOIN `olist_db.product_category_name_translation` trans
ON trans.string_field_0 = prod.product_category_name) sub
ON sub.product_id = items.product_id
GROUP BY 1
),

seller_data AS
(
SELECT order_id, STRING_AGG(DISTINCT seller_state, ', ') AS seller_state
FROM `tc-da-1.olist_db.olist_order_items_dataset` items
JOIN `olist_db.olist_sellers_dataset` sell
ON sell.seller_id = items.seller_id
GROUP BY 1
),

payment_data AS
(
SELECT order_id, STRING_AGG(DISTINCT payment_type, ', ') AS payment_type, SUM(payment_value) AS total_payment
FROM `tc-da-1.olist_db.olist_order_payments_dataset`
GROUP BY 1
),

orders_data AS
(
SELECT ord.order_id,
  order_purchase_timestamp,
  TIMESTAMP_DIFF(order_delivered_carrier_date, order_purchase_timestamp, DAY) AS order_assemble_days,
  TIMESTAMP_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS order_delivered_days,
  TIMESTAMP_DIFF(order_estimated_delivery_date, order_purchase_timestamp, DAY) AS order_estimated_days,
  customer_state AS deliver_state,
  seller_state,
  payment_type,
  total_payment,
  category_name,
  total_price,
  total_freight_value,
  total_product_weight_g,
  product_data.total_product_volume_cm3
FROM `olist_db.olist_orders_dataset` ord
JOIN `olist_db.olist_customesr_dataset` cust
ON cust.customer_id = ord.customer_id
JOIN seller_data
ON ord.order_id = seller_data.order_id
JOIN payment_data
ON payment_data.order_id = ord.order_id
JOIN product_data
ON product_data.order_id = ord.order_id
WHERE order_status = 'delivered' 
)

SELECT *
FROM orders_data
ORDER BY 2
