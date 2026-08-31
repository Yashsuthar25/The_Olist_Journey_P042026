DESCRIBE olist_orders;

SELECT COUNT(*)
FROM
 olist_database.olist_orders;
 
SET SQL_SAFE_UPDATES = 0;
 
DELETE 
FROM
 olist_database.olist_orders
WHERE
 order_id IS NULL
 OR order_id = '0'
 OR order_id = '';
 
SELECT COUNT(*)
FROM
 olist_database.olist_orders; 

SELECT COUNT(DISTINCT(order_id))
FROM
 olist_database.olist_orders;
 
SELECT 
    COUNT(
        CASE WHEN customer_id IS NULL THEN 1 END) AS 'Nulls_cus_id',
    COUNT(
        CASE WHEN order_status IS NULL THEN 1 END) AS 'Nulls_order_status',
    COUNT(
        CASE WHEN order_purchase_timestamp IS NULL THEN 1 END) AS 'Nulls_purchase',
    COUNT(
        CASE WHEN order_approved_at IS NULL THEN 1 END) AS 'Nulls_approved',
    COUNT(
        CASE WHEN order_delivered_carrier_date IS NULL THEN 1 END) AS 'Nulls_delivered_date',
    COUNT(
        CASE WHEN order_delivered_customer_date IS NULL THEN 1 END) AS 'Nulls_delivered_customer',
    COUNT(
        CASE WHEN order_estimated_delivery_date IS NULL THEN 1 END) AS 'Nulls_estimated_delivery'
FROM 
 olist_database.olist_orders;
