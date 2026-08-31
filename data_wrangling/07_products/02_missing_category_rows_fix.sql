-- Let's begin with where we left, As I mentioned in the earlier session, I found 610 rows which contained NULL's in 3 columns that too in a sequence, let's find out. 

/* These are the columns
product_name_lenght = 610
product_description_lenght = 610
product_photos_qty = 610 */

SELECT *
FROM
	olist_database.olist_products
WHERE
		product_name_lenght IS NULL AND
		product_description_lenght IS NULL AND
        product_photos_qty IS NULL;
        
/* This is interesting, when I ran deeper with the current query, their are actually 4 columns, the product_category_name is also Blank, 
Let me just quickly get to the internet to know about this issue, it is better to seek internet help rather than always finding yourself.*/

/* After digging through the internet, this issue is faced by everyone who have used this dataset, so their is no root cause for this which can be fixed,
So, it is better to flag it and move on because these rows are just not useful for me because they lack the names, I can still try, 
Their are 2 options, I'll first try to do something about the NULL's or I'll just flag them, depends on the option 1 results completely. */

-- Let's update the column rather than leaving them blank.

SET SQL_SAFE_UPDATES = 0;

UPDATE olist_products
SET product_category_name = 'N/A',
	product_name_lenght = 0,
    product_description_lenght = 0,
    product_photos_qty = 0
WHERE 
	product_category_name = '';
    
    
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
/* The issue is fixed, I've flagged it now, but I just noticed that our weight, length, height, and width columns have 
Exactly 2 NULL's in them, but I've gone through the internet, it is best to leave them intact, rather than messing
With them because they don't have a root cause and I can't really fix them.*/
-- I'll be leaving it here today, will continue tomorrow with other checks. 
