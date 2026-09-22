-- Data quality checks for Olist_products_dataset 

USE olist;

-- NULL checks
SELECT *
FROM olist_products_dataset
WHERE product_id IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_category_name IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_name_length IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_description_length IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_photos_qty IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_weight_g IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_length_cm IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_height_cm IS NULL;

SELECT *
FROM olist_products_dataset
WHERE product_width_cm IS NULL;

-- Primary key uniqueness check
SELECT COUNT(product_id) , COUNT(DISTINCT product_id)
FROM olist_products_dataset;

-- Product category value distribution
SELECT product_category_name, COUNT(product_category_name)
FROM olist_products_dataset
GROUP BY product_category_name;

-- Zero-value checks
SELECT *
FROM olist_products_dataset
WHERE product_weight_g = 0;

SELECT *
FROM olist_products_dataset
WHERE product_length_cm = 0;

SELECT *
FROM olist_products_dataset
WHERE product_height_cm = 0;

SELECT *
FROM olist_products_dataset
WHERE product_width_cm = 0;

