SELECT COUNT(*)
FROM
 olist_database.olist_order_reviews;
 
SELECT 
 COUNT(review_id) AS count_distinct,
 order_id,
 review_id
FROM
 olist_database.olist_order_reviews
GROUP BY
 review_id, order_id
HAVING
 count_distinct >1;
 
 
 
 