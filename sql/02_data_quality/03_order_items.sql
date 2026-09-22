-- Data quality checks for olist_order_items_dataset

USE olist;

-- NULL checks
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

-- Price validity check
SELECT * 
FROM olist_order_items_dataset
WHERE price < 0;

-- Freight value validity check
SELECT * 
FROM olist_order_items_dataset
WHERE freight_value < 0;

-- Composite primary key uniqueness check
WITH Table_1 AS
(
	SELECT *, COUNT(order_id) as count_duplicate_pairs
	FROM olist_order_items_dataset
	GROUP BY order_item_id, order_id
)
SELECT *
FROM Table_1
where count_duplicate_pairs > 1;

-- Shipping date validity check
SELECT MIN(shipping_limit_date), MAX(shipping_limit_date)
FROM olist_order_items_dataset;

SELECT O1.order_id, shipping_limit_date, order_purchase_timestamp
FROM olist_order_items_dataset AS O1
LEFT JOIN olist_orders_dataset AS O2
ON O1.order_id = O2.order_id
WHERE shipping_limit_date < order_purchase_timestamp;

-- Foreign key reference checks
SELECT O1.product_id as child_product, O2.product_id AS parent_product
FROM olist_order_items_dataset as O1
LEFT JOIN olist_products_dataset AS O2
ON O1.product_id = O2.product_id
WHERE O2.product_id IS NULL;

SELECT O1.seller_id as child_seller, O2.seller_id AS parent_seller
FROM olist_order_items_dataset as O1
LEFT JOIN olist_sellers_dataset AS O2
ON O1.seller_id = O2.seller_id
WHERE O2.seller_id IS NULL;
