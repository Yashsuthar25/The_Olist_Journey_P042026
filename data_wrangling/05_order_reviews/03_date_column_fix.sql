SELECT *
FROM
 olist_database.staging_order_reviews;

DESCRIBE staging_order_reviews;

SELECT
  o.review_id,
  o.review_creation_date AS old_value,
  STR_TO_DATE(NULLIF(s.review_creation_date,''), '%Y-%m-%d %H:%i:%s') AS new_value
FROM olist_order_reviews AS o
JOIN staging_order_reviews AS s
  ON o.review_id = s.review_id
LIMIT 5;

SET SQL_SAFE_UPDATES = 0;

UPDATE olist_order_reviews AS o
JOIN staging_order_reviews AS s
  ON o.review_id = s.review_id
SET
  o.review_creation_date = STR_TO_DATE(NULLIF(s.review_creation_date,''), '%Y-%m-%d %H:%i:%s'),
  o.review_answer_timestamp = STR_TO_DATE(NULLIF(s.review_answer_timestamp,''), '%Y-%m-%d %H:%i:%s')
WHERE
  s.review_id IS NOT NULL AND s.review_id <> '';
  
SHOW FULL PROCESSLIST;

KILL QUERY 16;

SET SQL_SAFE_UPDATES = 0;

TRUNCATE TABLE olist_order_reviews;

INSERT INTO olist_order_reviews
SELECT
    review_id,
    order_id,
    NULLIF(review_score,''),
    NULLIF(review_comment_title,''),
    NULLIF(review_comment_message,''),
    STR_TO_DATE(NULLIF(review_creation_date,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(review_answer_timestamp,''), '%Y-%m-%d %H:%i:%s')
FROM staging_order_reviews
WHERE review_id IS NOT NULL AND review_id <> '';

SELECT * FROM staging_order_reviews 
WHERE review_creation_date = 'f63f9a7699e3674c80a4ba92e56dfbb8';

SELECT * FROM staging_order_reviews 
WHERE review_creation_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}';

INSERT INTO olist_order_reviews
SELECT
    review_id,
    order_id,
    NULLIF(review_score,''),
    NULLIF(review_comment_title,''),
    NULLIF(review_comment_message,''),
    STR_TO_DATE(NULLIF(review_creation_date,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(review_answer_timestamp,''), '%Y-%m-%d %H:%i:%s')
FROM staging_order_reviews
WHERE review_id IS NOT NULL 
  AND review_id <> ''
  AND review_creation_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}';
  
SELECT COUNT(*) FROM staging_order_reviews;

SELECT COUNT(*) FROM staging_order_reviews WHERE review_id IS NULL OR review_id = '';

SELECT COUNT(*) FROM staging_order_reviews WHERE review_creation_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}';

SELECT * 
 FROM 
  olist_database.olist_order_reviews 
WHERE 
 review_answer_timestamp < review_creation_date;