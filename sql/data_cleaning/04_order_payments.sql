-- Data quality checks for Olist_order_payments_dataset 

USE olist;

-- NULL checks
SELECT *
FROM olist_order_payments_dataset
WHERE order_id IS NULL;

SELECT *
FROM olist_order_payments_dataset
WHERE payment_type IS NULL;

SELECT *
FROM olist_order_payments_dataset
WHERE payment_installments IS NULL;

SELECT *
FROM olist_order_payments_dataset
WHERE payment_value IS NULL;

-- Payment type value distribution
SELECT payment_type, COUNT(payment_type) as num
FROM olist_order_payments_dataset
GROUP BY payment_type;
SELECT *
FROM olist_order_payments_dataset
WHERE payment_sequential IS NULL;

-- Composite primary key uniqueness check
WITH Table_1 AS 
(
	SELECT COUNT(order_id) as duplicate_count_check
	FROM olist_order_payments_dataset
	GROUP BY order_id, payment_sequential
)
SELECT *
FROM Table_1
WHERE duplicate_count_check > 1;

-- Negative value check
SELECT payment_installments, payment_value
FROM olist_order_payments_dataset
WHERE (payment_installments < 0) OR (payment_value < 0);

-- Payment installments range check
SELECT MIN(payment_installments) as minimum , MAX(payment_installments) as maximum
FROM olist_order_payments_dataset;

-- Zero payment value check
SELECT *
FROM olist_order_payments_dataset
WHERE payment_value = 0;

-- Foreign key reference check
SELECT O1.order_id, O2.order_id
FROM olist_order_payments_dataset as O1
LEFT JOIN olist_orders_dataset AS O2
ON O1.order_id = O2.order_id
WHERE O2.order_id IS NULL;
