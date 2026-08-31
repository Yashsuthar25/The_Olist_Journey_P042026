SELECT *
FROM
 olist_database.olist_products;

 SELECT *
 FROM 
  olist_database.product_category_name_translation;

  SELECT *
  FROM 
   olist_database.olist_sellers;
   
   
SELECT 
 'olist_sellers', 
 COUNT(*) 
  FROM olist_sellers
UNION ALL
SELECT 
 'product_category_name_translation', 
  COUNT(*) 
   FROM product_category_name_translation
UNION ALL
SELECT 
 'olist_products', 
  COUNT(*) 
   FROM olist_products;