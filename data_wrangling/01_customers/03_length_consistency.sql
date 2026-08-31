SELECT *
FROM
 olist_database.olist_customers;
 
 SELECT
  customer_id 
FROM
 olist_database.olist_customers
WHERE
 LENGTH(customer_id) <> 32;
 
 SELECT
  customer_unique_id 
FROM
 olist_database.olist_customers
WHERE
 LENGTH(customer_unique_id) <> 32;
 
 SELECT
  customer_zip_code_prefix 
FROM
 olist_database.olist_customers
WHERE
 LENGTH(customer_zip_code_prefix) <> 5;
 
 
 SELECT
  DISTINCT customer_state,
  COUNT(*) AS count_state
FROM 
 olist_database.olist_customers
 GROUP BY
  customer_state;
 
