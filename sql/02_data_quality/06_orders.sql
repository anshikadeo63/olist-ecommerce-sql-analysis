-- Data quality checks for Olist_orders_dataset 

USE olist;

-- NULL checks
SELECT *
FROM olist_orders_dataset
WHERE order_id IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE customer_id IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE order_status IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE order_approved_at IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NULL;

SELECT *
FROM olist_orders_dataset
WHERE order_estimated_delivery_date IS NULL;

-- Primary key uniqueness check
SELECT COUNT(order_id) , COUNT(DISTINCT order_id)
FROM olist_orders_dataset;

-- Foreign key reference check
SELECT O1.customer_id, O2.customer_id
FROM olist_orders_dataset AS O1
LEFT JOIN olist_customers_dataset AS O2
ON O1.customer_id = O2.customer_id
WHERE O2.customer_id IS NULL;

-- Order status value distribution
SELECT order_status , COUNT(order_status)
FROM olist_orders_dataset
GROUP BY order_status;

-- Order timestamp consistency checks
SELECT order_approved_at, order_purchase_timestamp
FROM olist_orders_dataset
WHERE order_approved_at < order_purchase_timestamp;

SELECT order_delivered_customer_date, order_purchase_timestamp
FROM olist_orders_dataset
WHERE order_delivered_customer_date < order_purchase_timestamp;

SELECT order_estimated_delivery_date, order_purchase_timestamp
FROM olist_orders_dataset
WHERE order_estimated_delivery_date < order_purchase_timestamp;

