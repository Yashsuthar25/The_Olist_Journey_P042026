SELECT *
FROM
 olist_database.olist_orders
LIMIT
 1000;
 
 DROP TABLE IF EXISTS
 olist_order_items;
 
 SHOW FULL processlist;
 
 KILL QUERY 56 ;
  KILL QUERY 62;
   KILL QUERY 63 ;
    KILL QUERY 64 ;
     KILL QUERY 70 ;
      KILL QUERY 71 ;
       KILL QUERY 73 ;
        KILL QUERY 79 ;
         KILL QUERY 58 ;
          KILL QUERY 5 ;
          
SELECT *
FROM
 olist_database.olist_order_items
LIMIT
 500;
 
 SELECT 
  shipping_limit_date,
STR_TO_DATE(shipping_limit_date,'%Y-%m-%d %H:%i:%s')
FROM
 olist_database.staging_order_items
LIMIT 5;

DESCRIBE staging_order_items;

SHOW FULL PROCESSLIST;

DROP TABLE IF EXISTS
 olist_order_items;
 
 USE olist_database;

-- STEP 1: Create the fresh, properly-typed table
CREATE TABLE olist_order_items (
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

-- STEP 2: Populate it from staging, converting text to proper types
INSERT INTO olist_order_items
SELECT 
    order_id,
    CAST(order_item_id AS UNSIGNED),
    product_id,
    seller_id,
    STR_TO_DATE(shipping_limit_date, '%Y-%m-%d %H:%i:%s'),
    CAST(price AS DECIMAL(10,2)),
    CAST(freight_value AS DECIMAL(10,2))
FROM staging_order_items
WHERE order_id IS NOT NULL AND order_id <> '';

-- STEP 3: Verify — should show 112650 (real dataset size) minus any known blank rows
SELECT COUNT(*) AS total_rows FROM olist_order_items;
SELECT COUNT(*) AS null_dates FROM olist_order_items WHERE shipping_limit_date IS NULL;

SELECT
 shipping_limit_date
FROM
 olist_database.olist_order_items;