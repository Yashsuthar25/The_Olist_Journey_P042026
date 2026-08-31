/* Hello, I know I took around 1-2 days of break but I had to, but it is 11:37PM, like it is very much late, so
In this session I'll take a look at the next table olist_sellers, and also if possible perform the Duplicates 
And NULL's check, so let's beign with this. */

SELECT *
FROM
	olist_database.olist_sellers
LIMIT 
	10;
-- This table is very small, with only 4 columns with just basic seller details, so I'll be fast to get through. 

DESCRIBE olist_sellers;
-- seller_id is primary key, so duplicates are just one query away, let's go. 

SELECT 
	COUNT(*), 
    COUNT(DISTINCT(seller_id))
FROM
	olist_database.olist_sellers;
-- Both the ouput's match, so their are no Duplicate values. 

SELECT
COUNT(
		CASE WHEN seller_id IS NULL THEN 1 END) AS 'seller_NULLs',
COUNT(
		CASE WHEN seller_zip_code_prefix IS NULL THEN 1 END) AS 'seller_zip_NULLs',
COUNT(
		CASE WHEN seller_city IS NULL THEN 1 END) AS 'seller_city_NULLs',
COUNT(
		CASE WHEN seller_state IS NULL THEN 1 END) AS 'seller_state'
FROM
	olist_database.olist_sellers;
-- Their are no NULL's in any of the columns, to be honest, their is not much to check about, I can go a little more.

SELECT 
	seller_zip_code_prefix,
    COUNT(*)
FROM
	olist_database.olist_sellers
GROUP BY
	seller_zip_code_prefix
HAVING
	LENGTH(seller_zip_code_prefix) <> 5;
-- The zip code is exactly 5 digits, which is correct. 

-- I had to go, I'll complete this table by tomorrow. 



		