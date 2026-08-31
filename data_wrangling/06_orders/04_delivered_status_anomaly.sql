SELECT
 *
FROM
 olist_database.olist_orders
WHERE
 order_delivered_customer_date IS NULL;
 
SELECT
 COUNT(*)
FROM
 olist_database.olist_orders
WHERE
 order_delivered_customer_date IS NULL AND order_status = 'shipped';
 
SELECT
 DISTINCT(order_status)
FROM
 olist_database.olist_orders
WHERE
 order_delivered_customer_date IS NULL; 
 
SELECT 
 *
FROM
 olist_database.olist_orders
WHERE
 order_delivered_customer_date IS NULL AND order_status = 'delivered';
 
SELECT 
 *
FROM
 olist_database.olist_orders
WHERE
 order_delivered_customer_date IS NULL AND order_status IS NULL;
 
 SELECT 
	*
FROM
 olist_database.olist_orders
WHERE
 order_status IN ('canceled', 'unavailable', 'processing', 'invoiced', 'approved', 'created') AND
	order_delivered_customer_date IS NULL;
    
SELECT *
FROM 
 olist_database.olist_orders
WHERE 
 order_delivered_customer_date IS NULL AND order_status = 'delivered';
 
 
 