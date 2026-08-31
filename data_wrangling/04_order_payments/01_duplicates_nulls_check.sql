SELECT *
FROM
 olist_database.olist_order_payments;
 
SELECT
 order_id, 
 COUNT(*) AS count_order_id,
 payment_sequential
FROM
 olist_database.olist_order_payments
GROUP BY
 order_id, payment_sequential
HAVING 
count_order_id >1;

SELECT
 COUNT(
  CASE WHEN order_id IS NULL THEN 1 END) AS 'Null_found_id',
 COUNT(
  CASE WHEN payment_installments IS NULL THEN 1 END) AS 'Null_found_installments',
 COUNT(
  CASE WHEN payment_sequential IS NULL THEN 1 END) AS 'Null_found_sequentials',
 COUNT(
  CASE WHEN payment_type IS NULL THEN 1 END) AS 'Null_found_type',
 COUNT(
  CASE WHEN payment_value IS NULL THEN 1 END) AS 'Null_found_value'
FROM
 olist_database.olist_order_payments;
 
 DESCRIBE olist_database.olist_order_payments;
 
 SELECT
  DISTINCT(payment_type)
FROM
 olist_database.olist_order_payments;
 
 SELECT 
  DISTINCT( payment_installments) 
FROM
 olist_database.olist_order_payments;
 
SELECT 
 COUNT(payment_value)
FROM
 olist_database.olist_order_payments
WHERE
 payment_value <=0;

 
 
