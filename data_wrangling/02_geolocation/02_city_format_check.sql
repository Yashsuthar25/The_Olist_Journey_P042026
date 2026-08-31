SELECT *
FROM
 olist_database.olist_geolocation;
 
 DESCRIBE olist_database.olist_geolocation;
 
 SELECT geolocation_city, COUNT(*) AS total
FROM olist_database.olist_geolocation
GROUP BY geolocation_city
ORDER BY geolocation_city;

SELECT 
    COUNT(DISTINCT geolocation_city) AS raw_count,
    COUNT(DISTINCT CONVERT(geolocation_city USING ascii)) AS no_accent_count
FROM olist_database.olist_geolocation;

SELECT DISTINCT geolocation_city
FROM olist_database.olist_geolocation
WHERE geolocation_city REGEXP '[^a-zA-Z0-9 ]'
LIMIT 20;