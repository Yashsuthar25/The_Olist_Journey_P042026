SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_status = 'delivered' AND order_approved_at IS NULL;
 
SELECT 
 COUNT(*)
FROM
 olist_database.olist_orders
WHERE
 order_delivered_carrier_date IS NULL AND order_delivered_customer_date IS NULL;
 
SELECT 
 COUNT(
 CASE WHEN order_delivered_carrier_date IS NULL AND  order_delivered_customer_date IS NULL AND order_status = 'canceled' THEN 1 END) AS canceled_orders,
 COUNT(
 CASE WHEN order_delivered_carrier_date IS NULL AND  order_delivered_customer_date IS NULL AND order_status = 'unavailable' THEN 1 END) AS unavailable_orders,
 COUNT(
 CASE WHEN order_delivered_carrier_date IS NULL AND order_delivered_customer_date IS NULL AND order_status = 'processing' THEN 1 END) AS processing_orders,
 COUNT(
 CASE WHEN order_delivered_carrier_date IS NULL AND order_delivered_customer_date IS NULL AND order_status = 'invoiced' THEN 1 END) AS invoiced_orders
FROM
 olist_database.olist_orders;
 
SELECT 
	*
FROM
 olist_database.olist_orders
WHERE
 order_status NOT IN ('canceled', 'unavailable', 'processing', 'invoiced') AND
 order_delivered_carrier_date IS NULL AND order_delivered_customer_date IS NULL;
