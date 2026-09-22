-- Data quality checks for olist_customers_dataset

USE olist;

-- null values check
SELECT * 
FROM olist_customers_dataset
WHERE customer_id IS NULL;

SELECT * 
FROM olist_customers_dataset
WHERE customer_unique_id IS NULL;

SELECT * 
FROM olist_customers_dataset
WHERE customer_zip_code_prefix IS NULL;

SELECT * 
FROM olist_customers_dataset
WHERE customer_city IS NULL;

SELECT * 
FROM olist_customers_dataset
WHERE customer_state IS NULL;

-- City formatting check
SELECT *, CONCAT_WS("", LEFT(UPPER(customer_city),1), SUBSTRING(LOWER(customer_city), 2)) as capitalized_customer_city
FROM olist_customers_dataset;

-- check duplicate customer_id
SELECT COUNT(DISTINCT customer_id)
FROM olist_customers_dataset;

SELECT COUNT(customer_id)
FROM olist_customers_dataset;

-- customer_unique_id is not unique in this table;
-- repeated values are expected because one customer can place multiple orders.

-- State formatting check
SELECT *, UPPER(customer_state) as formatted_customer_state
FROM olist_customers_dataset;
