
SELECT
 COUNT(*)
FROM
 olist_database.olist_order_items;
 
SELECT
 order_id, 
 order_item_id,
 product_id,
 seller_id,
 shipping_limit_date,
 price,
 freight_value,
 COUNT(*) AS Unique_Row_count
FROM
 olist_database.olist_order_items
GROUP BY
order_id, 
 order_item_id,
 product_id,
 seller_id,
 shipping_limit_date,
 price,
 freight_value
HAVING 
 Unique_Row_count >1;
 
 SELECT
  order_id,
  order_item_id,
  COUNT(*) AS row_count
FROM olist_database.olist_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

SELECT
 price,
 freight_value
FROM
 olist_database.olist_order_items
WHERE
 price <=0 OR freight_value < 0;
 
 
 SELECT
  CASE
    WHEN freight_value < 0 THEN 'negative'
    WHEN freight_value = 0 THEN 'zero'
    ELSE 'positive'
  END AS value_type,
  COUNT(*) AS row_count
FROM 
 olist_database.olist_order_items
GROUP BY 
 value_type;
 
 SELECT
  CASE
    WHEN price < 0 THEN 'negative_price'
    WHEN price = 0 THEN 'zero_price'
    ELSE 'positive_price'
  END AS value_type_price,
  COUNT(*) AS row_count
FROM 
 olist_database.olist_order_items
GROUP BY 
 value_type_price;
 
 select *
 FROM
  olist_database.olist_order_items;
  
SELECT
 CASE
  WHEN LENGTH(order_id) <>32 THEN 'inconsistent_order_id'
  WHEN LENGTH(product_id) <>32 THEN 'inconsistent_product_id'
  WHEN LENGTH(seller_id) <>32 THEN 'inconsisten_seller_id'
  ELSE 'okay_boss'
  END AS length_consistency_check,
  COUNT(*) AS counts_case
FROM
 olist_database.olist_order_items
GROUP BY
 length_consistency_check;
 
SELECT
 CASE
  WHEN LOWER(order_id) <> order_id THEN 'inconsistent_order_id'
  WHEN LOWER(product_id) <> product_id THEN 'inconsistent_product_id'
  WHEN LOWER(seller_id) <> seller_id THEN 'inconsistent_seller_id'
  ELSE 'okay_boss'
  END AS case_consistency_check,
  COUNT(*) AS counts_casesenstitivity
FROM
 olist_database.olist_order_items
GROUP BY
 case_consistency_check;
 
 SELECT
 MIN(price),
 MAX(price),
 AVG(price)
FROM 
 olist_database.olist_order_items;
 
 SELECT
 MIN(freight_value),
 MAX(freight_value),
 AVG(freight_value)
FROM 
 olist_database.olist_order_items
WHERE
 freight_value <>0;
 
 SELECT *
FROM
 olist_database.olist_order_items AS A
LEFT JOIN 
 olist_database.olist_orders AS B
 ON A.order_id = B.order_id
WHERE
 B.order_id IS NULL;
 
 SELECT *
FROM
 olist_database.olist_order_items AS A
LEFT JOIN 
 olist_database.olist_products AS B
 ON A.product_id = B.product_id
WHERE
 B.product_id IS NULL;
 
 SELECT *
FROM
 olist_database.olist_order_items AS A
LEFT JOIN 
 olist_database.olist_sellers AS B
 ON A.seller_id = B.seller_id
WHERE
 B.seller_id IS NULL;
 
 


 


 
