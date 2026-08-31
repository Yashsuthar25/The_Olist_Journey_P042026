SELECT
    *
FROM
    olist_database.olist_geolocation
LIMIT
    10;
    
SELECT  
    DISTINCT(geolocation_zip_code_prefix)
FROM    
    olist_database.olist_geolocation;


DESCRIBE olist_geolocation;

/* Now, I've already got the root cause when I was querying this table earlier, 
The zip_code just needs a 0 digit at the start where length of zip_code is <5.*/

SET SQL_SAFE_UPDATES = 0;

UPDATE 
	olist_geolocation
SET 
	geolocation_zip_code_prefix = LPAD(geolocation_zip_code_prefix, 5, '0')
WHERE 
	LENGTH(geolocation_zip_code_prefix) < 5;
-- 245733 rows got affected, let's verify.

SELECT
	COUNT(*)
FROM
	olist_database.olist_geolocation
WHERE
	LENGTH(geolocation_zip_code_prefix) = 5;
-- 1000163 is the count, which is correct, the first issue has been solved, I'll continue tomorrow.
    
