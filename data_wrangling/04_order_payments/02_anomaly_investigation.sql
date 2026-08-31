select DISTINCT(payment_type)
from
  olist_database.olist_order_payments;
  
  SELECT 
 COUNT(payment_value)
FROM
 olist_database.olist_order_payments
WHERE
 payment_value  = 0 AND payment_type = 'not_defined';
 
 SELECT order_id
FROM
 olist_database.olist_order_payments
WHERE
 payment_value = 0 AND payment_type = 'not_defined';
 
SELECT *
FROM
 olist_database.olist_order_items
WHERE
 order_id = '4637ca194b6387e2d538dc89b124b0ee';
 
 SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_id = '4637ca194b6387e2d538dc89b124b0ee';
 
SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_id = '00b1cb0320190ca0daa2c88b35206009';
 
SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_id = 'c8c528189310eaa44a745b8d9d26908b';
 
SELECT *
FROM
 olist_database.olist_order_payments;
 
 SELECT order_id
FROM
 olist_database.olist_order_payments
WHERE
 LENGTH(order_id) <> 32;
 
 SELECT *
FROM
 olist_database.olist_order_payments
WHERE
 payment_installments <= 0;
 
SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_id = '744bade1fcf9ff3f31d860ace076d422';
 
SELECT *
FROM
 olist_database.olist_orders
WHERE
 order_id = '744bade1fcf9ff3f31d860ace076d422';
 
 
 
 