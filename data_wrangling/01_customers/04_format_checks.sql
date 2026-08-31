SELECT 
 *
FROM
 olist_database.olist_customers;
 
DESCRIBE
 olist_database.olist_customers;
 
 SELECT
 customer_zip_code_prefix
FROM 
 olist_database.olist_customers
WHERE
 customer_zip_code_prefix NOT REGEXP'^[0-9]+$';
 
 SELECT
  COUNT(DISTINCT UPPER(TRIM(customer_city)))
FROM
 olist_database.olist_customers;
 
 SELECT
  COUNT(DISTINCT(customer_city))
  FROM
   olist_database.olist_customers;
 