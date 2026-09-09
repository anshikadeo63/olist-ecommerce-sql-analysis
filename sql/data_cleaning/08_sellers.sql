-- Data quality checks for Olist_sellers_dataset 

USE olist;

-- NULL checks
SELECT *
FROM olist_sellers_dataset
WHERE seller_id IS NULL;

SELECT *
FROM olist_sellers_dataset
WHERE seller_zip_code_prefix IS NULL;

SELECT *
FROM olist_sellers_dataset
WHERE seller_city IS NULL;

SELECT *
FROM olist_sellers_dataset
WHERE seller_state IS NULL;

-- Primary key uniqueness check
SELECT COUNT(seller_id), COUNT(distinct seller_id)
FROM olist_sellers_dataset;

-- Seller ZIP code validity check
SELECT *
FROM olist_sellers_dataset
WHERE seller_zip_code_prefix < 0;

-- Seller city value distribution
SELECT seller_city, COUNT(seller_city)
FROM olist_sellers_dataset
GROUP BY seller_city;

-- Seller state value distribution
SELECT seller_state, COUNT(seller_state)
FROM olist_sellers_dataset
GROUP BY seller_state;
