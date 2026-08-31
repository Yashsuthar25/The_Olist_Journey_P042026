SELECT 
 *
FROM 
 olist_database.olist_customers;
 
 SELECT 
 COUNT(customer_id)
FROM 
 olist_database.olist_customers
WHERE 
 customer_id IS NULL;
 
 SELECT 
 COUNT(
    CASE WHEN customer_id IS NULL THEN 1 END) AS Null_count_customer_id,
 COUNT(
    CASE WHEN customer_unique_id IS NULL THEN 1 END) AS Null_count_customer_unique_id,
COUNT(
    CASE WHEN customer_zip_code_prefix IS NULL THEN 1 END) AS Null_count_customer_zip_code_prefix,
COUNT(
    CASE WHEN customer_city IS NULL THEN 1 END) AS Null_count_customer_city,
COUNT(
    CASE WHEN customer_state IS NULL THEN 1 END) AS Null_count_customer_state
FROM 
 olist_database.olist_customers;
 
 
 SELECT 
 COUNT(customer_state)
FROM
 olist_database.olist_customers
WHERE
 LENGTH(customer_state) > 2;







