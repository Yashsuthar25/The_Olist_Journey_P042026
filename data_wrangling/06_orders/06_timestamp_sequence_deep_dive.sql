SELECT
SUM(CASE WHEN order_approved_at < order_purchase_timestamp 
           THEN 1 ELSE 0 END) AS approved_before_purchase_sameday,
SUM(CASE WHEN order_delivered_carrier_date < order_approved_at 
           THEN 1 ELSE 0 END) AS carrier_before_approved_sameday,
SUM(CASE WHEN order_delivered_customer_date < order_delivered_carrier_date 
           THEN 1 ELSE 0 END) AS customer_before_carrier_sameday
FROM olist_orders;

SELECT
SUM(CASE WHEN order_approved_at < order_purchase_timestamp 
           AND DATE(order_approved_at) = DATE(order_purchase_timestamp) 
           THEN 1 ELSE 0 END) AS approved_before_purchase_sameday,
SUM(CASE WHEN order_delivered_carrier_date < order_approved_at 
           AND DATE(order_delivered_carrier_date) = DATE(order_approved_at) 
           THEN 1 ELSE 0 END) AS carrier_before_approved_sameday,
SUM(CASE WHEN order_delivered_customer_date < order_delivered_carrier_date 
           AND DATE(order_delivered_customer_date) = DATE(order_delivered_carrier_date) 
           THEN 1 ELSE 0 END) AS customer_before_carrier_sameday
FROM olist_orders;

SELECT 
  DATEDIFF(order_approved_at, order_delivered_carrier_date) AS days_early,
  COUNT(*) AS row_count
FROM olist_orders
WHERE order_delivered_carrier_date < order_approved_at
  AND DATE(order_delivered_carrier_date) != DATE(order_approved_at)
GROUP BY days_early
ORDER BY days_early;


SELECT *
FROM
 olist_database.staging_orders
LIMIT 50;

SELECT *
FROM
 olist_Database.olist_orders
LIMIT 10;

DESCRIBE staging_orders;

