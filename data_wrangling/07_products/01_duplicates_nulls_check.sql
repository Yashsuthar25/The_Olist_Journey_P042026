-- Let's start todays session with the 7th table 'olist_products', first I'll just take a glimpse of the data and then decide how to proceed.
SELECT *
FROM
 olist_database.olist_products;
 
 DESCRIBE olist_products;
-- The describe function tells me, this table looks huge but it'll be easy to go on, let's go.

-- First, I'll check the usual ones, the duplicates & NULL's, the product_id is Primary key, so it will be unique.
SELECT
	COUNT(DISTINCT(product_id))
FROM
	olist_database.olist_products;
-- The count is 32951, which is exactly correct according to the Metadata. 

-- Then their are no duplicates in this table, let's go with the NULL's now. 
SELECT
COUNT(
	CASE WHEN product_id IS NULL THEN 1 END) AS 'Nulls_product_id',
COUNT(
	CASE WHEN product_category_name IS NULL THEN 1 END) AS 'Nulls_category_name',
COUNT(
	CASE WHEN product_name_lenght IS NULL THEN 1 END) AS 'Nulls_name_length',
COUNT(
	CASE WHEN product_description_lenght IS NULL THEN 1 END) AS 'Nulls_description',
COUNT(
	CASE WHEN product_photos_qty IS NULL THEN 1 END) AS 'Nulls_photos_qty',
COUNT(
	CASE WHEN product_weight_g IS NULL THEN 1 END) AS 'Nulls_weight_g',
COUNT(
	CASE WHEN product_length_cm IS NULL THEN 1 END) AS 'Nulls_length_cm',
COUNT(
	CASE WHEN product_height_cm IS NULL THEN 1 END) AS 'Nulls_height_cm',
COUNT(
	CASE WHEN product_width_cm IS NULL THEN 1 END) AS 'Nulls_width_cm'
FROM
	olist_database.olist_products;
/* this is weird, their are exactly 610 Null's in 3 columns, that too in a sequence.
product_name_lenght = 610
product_description_lenght = 610
product_photos_qty = 610
I've to find the root cause, it'll be correlated that is for sure. */
	
