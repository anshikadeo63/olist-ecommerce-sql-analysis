-- data-quality checks for Olist_order_items_dataset

USE olist;

-- null check
SELECT *
FROM olist_order_items_dataset
WHERE order_id IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE order_item_id IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE product_id IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE seller_id IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE shipping_limit_date IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE price IS NULL;

SELECT *
FROM olist_order_items_dataset
WHERE freight_value IS NULL;

-- price validity check
SELECT * 
FROM olist_order_items_dataset
WHERE price < 0;

-- freight_value validity check
SELECT * 
FROM olist_order_items_dataset
WHERE freight_value < 0;
