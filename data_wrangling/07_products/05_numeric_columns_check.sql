/* Hello, sorry I didn't upload anything yesterday due to some unexpected tasks, today was the same but I thought
I should atleast complete even just 1%, so let's begin from where we left. */

SELECT *
FROM
	olist_database.olist_products
LIMIT 
	10;
-- So far, 3 columns are done with duplicates & NULL's check, but the rest of the columns are just INT's, so I think
-- It'll be just simple check.

DESCRIBE olist_products;

SELECT
COUNT(
	CASE WHEN product_name_lenght <= 0 THEN 1 END) AS '0_name_length',
COUNT(
	CASE WHEN product_description_lenght  <= 0 THEN 1 END) AS '0_description',
COUNT(
	CASE WHEN product_photos_qty  <= 0 THEN 1 END) AS '0_photos_qty',
COUNT(
	CASE WHEN product_weight_g  <= 0 THEN 1 END) AS '0_weight_g',
COUNT(
	CASE WHEN product_length_cm  <= 0 THEN 1 END) AS '0_length_cm',
COUNT(
	CASE WHEN product_height_cm  <= 0 THEN 1 END) AS '0_height_cm',
COUNT(
	CASE WHEN product_width_cm  <= 0 THEN 1 END) AS '0_width_cm'
FROM
	olist_database.olist_products;
-- their are 4 rows in product_weight columns which has 0 values, let's take a closer look at it.

SELECT
	*
FROM
	olist_database.olist_products
WHERE
	product_category_name = 'cama_mesa_banho';
-- After going through the rows, I think it is best to leave the rows as NULL, it will be more appropriate. 

SET SQL_SAFE_UPDATES = 0;

UPDATE olist_products
SET product_weight_g = NULL
WHERE product_weight_g = 0;
/* Done with this check and this is the max I can check for this table, like I've done all the necessary
Checks I could carry out for the data present in the table, so let's conclude the data cleaning process
For the olist_products table today, I'll begin with the next table in the next session. */


