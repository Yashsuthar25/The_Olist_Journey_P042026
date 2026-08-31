/* Hello, let's begin the today's session, I did complete the Duplicates & NULL's check in the last 2 session,
Today, I'll proceed with the other checks but I may keep today's session short, sorry about that.*/

SELECT
	*
FROM
	olist_database.olist_products
LIMIT
	10;
    
DESCRIBE olist_products;

-- Let's complete the product_id first.
SELECT
 COUNT(*)
FROM
	olist_database.olist_products
WHERE
	length(product_id) <> 32;
-- The output is 0

-- Let's test the product_id against JOIN
SELECT
	A.*
FROM
olist_database.olist_products AS A
LEFT JOIN
	olist_database.olist_order_items AS B
ON 
	A.product_id = B.product_id
WHERE 
	B.product_id IS NULL;
    
SELECT
	A.*
FROM
olist_database.olist_order_items AS A
LEFT JOIN
	olist_database.olist_products AS B
ON 
	A.product_id = B.product_id
WHERE 
	B.product_id IS NULL;
-- The output is 0 rows, the product_id is reliable and also done the cleaning process for the table. 

-- Now, next columns is product_category_name, which I remember needs translation is to be done, I'll do it in the next session. 
	

