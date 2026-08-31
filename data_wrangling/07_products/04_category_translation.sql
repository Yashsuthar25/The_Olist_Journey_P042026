-- Hello, let's begin with the today's session. 
-- So, to be honest, I'm not feeling today to do anything but still it is best to even move 1% forward. 

SELECT 
	*
FROM
	olist_database.olist_products
LIMIT 
	 10;
-- I've to replace the product category names first, let's begin with that. 

CREATE TABLE olist_products_backup AS
SELECT * FROM olist_products;
-- This step was carried out because I wanted to make sure that if anything goes wrong, I do have a backup.

DESCRIBE product_category_name_translation; 

-- Now, As I gone through the data, I think it is best to add a new translated column, rather than updating the existing one.
ALTER TABLE
	olist_products 
ADD COLUMN product_category_name_english VARCHAR(100);

SET SQL_SAFE_UPDATES = 0;

UPDATE olist_products AS A
JOIN product_category_name_translation AS B
  ON A.product_category_name = B.product_category_name
SET A.product_category_name_english = B.product_category_name_english;

SELECT 
	DISTINCT(product_category_name_english) 
FROM
	olist_database.olist_products;
    
SELECT 
	COUNT(DISTINCT(product_category_name))
FROM
	olist_database.olist_products
WHERE
	product_category_name = 'N/A';
    
SELECT 
	DISTINCT(product_category_name)
FROM
	olist_database.olist_products;
    
SELECT
	*
FROM
	olist_database.olist_products
WHERE
	product_category_name = 'pcs';
    
SELECT DISTINCT p.product_category_name
FROM olist_products p
LEFT JOIN product_category_name_translation t
  ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL
  AND p.product_category_name IS NOT NULL;
  
INSERT INTO product_category_name_translation (product_category_name, product_category_name_english)
VALUES 
  ('pc_gamer', 'pc_gamer'),
  ('portateis_cozinha_e_preparadores_de_alimentos', 'portable_kitchen_food_preparation');
  
SELECT 
	DISTINCT(product_category_name_english) 
FROM
	olist_database.olist_products;
    

/* The people who are wondering what I did up their, Actually I've used AI in this, not completely but to understand and 
Also to understand & write the query's,
So, I inserted a complete new column in the products table, with that I matched the category name with translated english
Names by including a JOIN & SET, their were 2 values which didn't match, I found them and translated them as well.
I know this was very lengthy, it was really to be honest, but I though I'll complete this columns today, I did. */

SELECT *
FROM
	olist_database.olist_products
LIMIT 
	10;

  

    


