-- STEP 1: Create a staging table with ALL columns as TEXT.
-- This can never fail on import, since text accepts anything.

DROP TABLE IF EXISTS staging_orders;

CREATE TABLE staging_orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);

-- Temporarily relax strict mode so a stray trailing blank line
-- (common artifact from file writing) doesn't cause a fatal error.
SET SESSION sql_mode = '';

-- STEP 2: Load the cleaned CSV into staging, with 4 extra dummy columns
-- to safely absorb any trailing empty fields, whatever their count.

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_orders_cleaned3.csv'
INTO TABLE staging_orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at,
 order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date,
 @dummy1, @dummy2, @dummy3, @dummy4, @dummy5, @dummy6, @dummy7, @dummy8);

-- STEP 3: Check it actually loaded (should be 99441)
SELECT COUNT(*) FROM staging_orders;

-- ============================================
-- PART A: Move staging_orders → real olist_orders table
-- ============================================

TRUNCATE TABLE olist_orders;

INSERT INTO olist_orders
SELECT
    order_id,
    customer_id,
    order_status,
    COALESCE(STR_TO_DATE(NULLIF(order_purchase_timestamp,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(order_purchase_timestamp,''), '%d-%m-%Y')),
    COALESCE(STR_TO_DATE(NULLIF(order_approved_at,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(order_approved_at,''), '%d-%m-%Y')),
    COALESCE(STR_TO_DATE(NULLIF(order_delivered_carrier_date,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(order_delivered_carrier_date,''), '%d-%m-%Y')),
    COALESCE(STR_TO_DATE(NULLIF(order_delivered_customer_date,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(order_delivered_customer_date,''), '%d-%m-%Y')),
    COALESCE(STR_TO_DATE(NULLIF(order_estimated_delivery_date,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(order_estimated_delivery_date,''), '%d-%m-%Y'))
FROM staging_orders;

SELECT COUNT(*) AS orders_final_count FROM olist_orders;


-- ============================================
-- PART B: order_items (staging approach, same cleaning method)
-- ============================================

-- Clean the raw file the same way (strip trailing commas, fix escaping)
SET SESSION sql_mode = '';

SELECT REGEXP_REPLACE(
           REGEXP_REPLACE(
               LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_items_dataset.csv'),
               ',+\r?\n', '\n'
           ),
           ',+$', ''
       )
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_items_cleaned.csv'
FIELDS ESCAPED BY ''
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS staging_order_items;
CREATE TABLE staging_order_items (
    order_id TEXT, order_item_id TEXT, product_id TEXT, seller_id TEXT,
    shipping_limit_date TEXT, price TEXT, freight_value TEXT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_items_cleaned.csv'
INTO TABLE staging_order_items
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value,
 @dummy1, @dummy2, @dummy3, @dummy4, @dummy5, @dummy6, @dummy7, @dummy8);

SELECT COUNT(*) AS staging_order_items_count FROM staging_order_items;

TRUNCATE TABLE olist_order_items;

INSERT INTO olist_order_items
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    COALESCE(STR_TO_DATE(NULLIF(shipping_limit_date,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(shipping_limit_date,''), '%d-%m-%Y')),
    NULLIF(price,''),
    NULLIF(freight_value,'')
FROM staging_order_items
WHERE order_id IS NOT NULL AND order_id <> '';

SELECT COUNT(*) AS order_items_final_count FROM olist_order_items;


-- ============================================
-- PART C: order_payments (no dates — try direct load first)
-- ============================================

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS order_payments_final_count FROM olist_order_payments;


-- ============================================
-- PART D: order_reviews (staging approach, has 2 date columns)
-- ============================================

SELECT REGEXP_REPLACE(
           REGEXP_REPLACE(
               LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_reviews_dataset.csv'),
               ',+\r?\n', '\n'
           ),
           ',+$', ''
       )
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_reviews_cleaned.csv'
FIELDS ESCAPED BY ''
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS staging_order_reviews;
CREATE TABLE staging_order_reviews (
    review_id TEXT, order_id TEXT, review_score TEXT, review_comment_title TEXT,
    review_comment_message TEXT, review_creation_date TEXT, review_answer_timestamp TEXT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_reviews_cleaned.csv'
INTO TABLE staging_order_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(review_id, order_id, review_score, review_comment_title, review_comment_message,
 review_creation_date, review_answer_timestamp,
 @dummy1, @dummy2, @dummy3, @dummy4, @dummy5, @dummy6, @dummy7, @dummy8);

SELECT COUNT(*) AS staging_order_reviews_count FROM staging_order_reviews;

TRUNCATE TABLE olist_order_reviews;

INSERT INTO olist_order_reviews
SELECT
    review_id,
    order_id,
    NULLIF(review_score,''),
    NULLIF(review_comment_title,''),
    NULLIF(review_comment_message,''),
    COALESCE(STR_TO_DATE(NULLIF(review_creation_date,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(review_creation_date,''), '%d-%m-%Y')),
    COALESCE(STR_TO_DATE(NULLIF(review_answer_timestamp,''), '%d-%m-%Y %H:%i'), STR_TO_DATE(NULLIF(review_answer_timestamp,''), '%d-%m-%Y'))
FROM staging_order_reviews
WHERE review_id IS NOT NULL AND review_id <> '';

SELECT COUNT(*) AS order_reviews_final_count FROM olist_order_reviews;

SELECT *
 FROM
  olist_database.olist_customers;

SELECT *
 FROM
  olist_database.olist_geolocation;

SELECT *
 FROM
  olist_database.olist_order_items;

SELECT *
 FROM
  olist_database.olist_order_payments;

SELECT *
 FROM
  olist_database.olist_order_reviews;


SELECT *
 FROM
  olist_database.olist_orders;

SELECT *
 FROM
  olist_database.olist_products;

SELECT *
 FROM
  olist_database.olist_sellers;

SELECT *
 FROM
  olist_database.product_category_name_translation;




