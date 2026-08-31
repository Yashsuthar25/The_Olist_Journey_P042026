SELECT *
FROM
 olist_database.olist_geolocation;
 
 SELECT 
  geolocation_zip_code_prefix,
  geolocation_state
FROM
 olist_database.olist_geolocation
WHERE
 LENGTH(geolocation_state) <> 2 OR
 LENGTH(geolocation_zip_code_prefix) <> 4 AND
 LENGTH(geolocation_zip_code_prefix) <> 5;
 
  SELECT 
  geolocation_lat,
  geolocation_lng
FROM 
 olist_database.olist_geolocation
WHERE
 geolocation_lat NOT BETWEEN -90 AND 90 OR
 geolocation_lng NOT BETWEEN -180 AND 180;
 
 
 DESCRIBE olist_database.olist_geolocation;