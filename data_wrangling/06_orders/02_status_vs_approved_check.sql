describe olist_orders;

SELECT DISTINCT(order_status)
FROM
 olist_database.olist_orders;
 
SELECT 
    order_approved_at,
    order_status,
    count(*)
FROM
 olist_database.olist_orders
GROUP BY
 order_status, order_approved_at
HAVING
 order_approved_at IS NULL;
