SELECT
 *
FROM
 olist_database.olist_orders;
 
DESCRIBE olist_orders;

SELECT
COUNT(
	CASE WHEN LENGTH(order_id) != 32 THEN 1 END) AS inconsistent_order_id,
COUNT(
	CASE WHEN LENGTH(customer_id) != 32 THEN 1 END) AS inconsistent_customer_id
FROM
 olist_database.olist_orders;
 
SELECT 
 DISTINCT(order_status)
FROM
 olist_database.olist_orders;
 
SELECT 
 COUNT(DISTINCT(customer_id))
FROM
 olist_database.olist_orders;
 
SELECT COUNT(*) 
FROM olist_database.olist_orders
WHERE order_purchase_timestamp > order_approved_at
   OR order_approved_at > order_delivered_carrier_date
   OR order_delivered_carrier_date > order_delivered_customer_date;
   
