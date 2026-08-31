SELECT
  r.review_id,
  r.order_id,
  o.customer_id
FROM
  olist_database.olist_order_reviews AS r
LEFT JOIN
  olist_database.olist_orders AS o
  ON r.order_id = o.order_id
WHERE
  r.review_id IN (
    SELECT review_id
    FROM olist_database.olist_order_reviews
    GROUP BY review_id
    HAVING COUNT(*) > 1
  )
ORDER BY
  r.review_id;
  
SELECT *
FROM
 olist_database.olist_order_reviews; 
 
SELECT
 COUNT(
    CASE WHEN review_id IS NULL THEN 1 END) AS 'Null_found_review_id',
 COUNT( 
    CASE WHEN order_id IS NULL THEN 1 END) AS 'Null_found_review_id',
 COUNT(
    CASE WHEN review_score IS NULL THEN 1 END) AS 'Null_found_review_score'
FROM
 olist_database.olist_order_reviews;
 
DESCRIBE olist_order_reviews;

SELECT
 COUNT(
    CASE WHEN LENGTH(review_id) <> 32 THEN 1 END) AS 'inconsistent_review_id',
 COUNT(
    CASE WHEN LENGTH(order_id) <> 32 THEN 1 END) AS 'inconsistent_order_id'
FROM 
 olist_database.olist_order_reviews;
 
SELECT *
FROM 
 olist_database.olist_order_reviews
WHERE
 review_score NOT BETWEEN 1 AND 5;
 
