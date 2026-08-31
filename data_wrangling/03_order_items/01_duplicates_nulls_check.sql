DESCRIBE olist_order_items;

SELECT 
 order_id,
 COUNT(order_id) AS Count_orders
FROM
 olist_database.olist_order_items
GROUP BY
 order_id
HAVING
 Count_orders <>1;
 
 SELECT
 order_id, 
 order_item_id,
 COUNT(*) AS total_count
FROM 
 olist_database.olist_order_items
GROUP BY 
 order_id, order_item_id
HAVING
 total_count <>1;
 
 SELECT 
 COUNT(
  CASE WHEN order_id IS NULL THEN 1 END) AS Null_Count_order_id,
COUNT(
  CASE WHEN order_item_id IS NULL THEN 1 END) AS Null_Count_order_item_id,
COUNT(
  CASE WHEN product_id IS NULL THEN 1 END) AS Null_Count_product_id,
COUNT(
  CASE WHEN seller_id IS NULL THEN 1 END) AS Null_Count_seller_id,
COUNT(
  CASE WHEN shipping_limit_date IS NULL THEN 1 END) AS Null_Count_shipping_limit_date,
COUNT(
  CASE WHEN price IS NULL THEN 1 END) AS Null_Count_price,
COUNT(
  CASE WHEN freight_value IS NULL THEN 1 END) AS Null_Count_freight_value
FROM
 olist_database.olist_order_items;
 
SELECT
 shipping_limit_date
FROM
 staging_order_items
LIMIT
 5;
 
