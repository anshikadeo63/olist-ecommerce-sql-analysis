-- Data quality checks for olist_geolocation_dataset

USE olist;

-- NULL checks
SELECT *
FROM olist_geolocation_dataset
WHERE geolocation_zip_code_prefix IS NULL;

SELECT *
FROM olist_geolocation_dataset
WHERE geolocation_lat IS NULL;

SELECT *
FROM olist_geolocation_dataset
WHERE geolocation_lon IS NULL;

SELECT *
FROM olist_geolocation_dataset
WHERE geolocation_city IS NULL;

SELECT *
FROM olist_geolocation_dataset
WHERE geolocation_state IS NULL;

-- Compare total vs. distinct ZIP prefixes
SELECT COUNT(DISTINCT geolocation_zip_code_prefix)
FROM olist_geolocation_dataset;

SELECT COUNT(geolocation_zip_code_prefix)
FROM olist_geolocation_dataset;

-- Compare total vs. distinct cities (5,969 unique cities)
SELECT COUNT(distinct geolocation_city)
FROM olist_geolocation_dataset;

SELECT COUNT(geolocation_city)
FROM olist_geolocation_dataset;

-- Compare total vs. distinct states (27 unique states)
SELECT COUNT(distinct geolocation_state)
FROM olist_geolocation_dataset;

SELECT COUNT(geolocation_state)
FROM olist_geolocation_dataset;

-- Latitude validity check
SELECT COUNT(geolocation_lat)
FROM olist_geolocation_dataset
WHERE geolocation_lat BETWEEN -90 AND 90;

SELECT COUNT(geolocation_lat)
FROM olist_geolocation_dataset;

-- Longitude validity check
SELECT COUNT(geolocation_lon)
FROM olist_geolocation_dataset
WHERE geolocation_lon BETWEEN -180 AND 180;
 
SELECT COUNT(geolocation_lon)
FROM olist_geolocation_dataset;

-- City formatting check
SELECT *, CONCAT_WS("", LEFT(UPPER(geolocation_city),1), SUBSTRING(LOWER(geolocation_city), 2)) 
as formatted_geolocation_city
FROM olist_geolocation_dataset;

-- State formatting check
SELECT *, UPPER(geolocation_state) as formatted_geolocation_state
FROM olist_geolocation_dataset;


