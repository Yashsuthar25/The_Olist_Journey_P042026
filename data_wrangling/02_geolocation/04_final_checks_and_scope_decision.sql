SELECT
	*
FROM
	olist_database.olist_geolocation
LIMIT
	10;
    
SELECT
	COUNT(DISTINCT(geolocation_state))
FROM
	olist_database.olist_geolocation;
    
/* When I checked my last session on this table, I've not carried out any Duplicate or NULL's check,
So, let's get the basics done first. */

DESCRIBE olist_geolocation;

SELECT
COUNT(
		CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 END) AS 'NULL_zip_code',
COUNT(
		CASE WHEN geolocation_lat IS NULL THEN 1 END) AS 'NULL_gelocation_lat',
COUNT(
		CASE WHEN geolocation_lng IS NULL THEN 1 END) AS 'NULL_geolocation_lng',
COUNT(
		CASE WHEN geolocation_city IS NULL THEN 1 END) AS 'NULL_geolocation_city',
COUNT(
		CASE WHEN geolocation_state IS NULL THEN 1 END) AS 'NULL_state'
FROM
	olist_database.olist_geolocation;
-- Their are no NULL's in any of the columns, which is good. 

/* Now, I was wondering around the geolocation_city column, I found out their are more than 8,000 distinct city names, 
But many of them are just extra due to name format inconsistency, then I realized I would use geolocation_state for
Location purposes and not geolocation_city, so it is best to leave it as it is. 
With that I don't have any real use of geolocation latitude & longitude columns as well, I will be leaving them as well.
Because, in this project I'll rely on State, and it is better to leave it now, if I ever decide to dig deeper, 
I'll check the data beforehand.*/

-- With this, my data wrangling process for entire olist_dataset is over, I'll still not conclude this & think & research 
-- about the olist_geolocationl. 