-- ============================================================
-- Delivery Performance Analysis
-- ============================================================

-- Question:
-- What percentage of delivered orders arrive early/on time
-- versus late?

-- Only delivered orders are included so that delivery performance
-- is evaluated using completed deliveries.

WITH Table_1 AS
(
	SELECT order_id, order_delivered_customer_date, order_estimated_delivery_date, COUNT(order_id) OVER() as total_count,
	CASE
		WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
		ELSE 0
	END AS late_orders,
	CASE
		WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
		ELSE 0
	END AS on_time_orders
	FROM olist_orders_dataset
    WHERE order_status = "delivered"
)
SELECT (SUM(late_orders) OVER()/total_count)*100 as late_orders_percent , (SUM(on_time_orders) OVER()/total_count)*100 as on_time_orders_percent
FROM Table_1
LIMIT 1;

-- ------------------------------------------------------------
-- Delivery Timing Analysis
-- ------------------------------------------------------------

-- Question:
-- On average, how many days late are late deliveries,
-- and how many days early are early/on-time deliveries?

-- DATEDIFF is used to measure the difference between the
-- estimated delivery date and the actual delivery date.

-- Average days late
WITH Table_1 AS
(
	SELECT order_id, order_delivered_customer_date, order_estimated_delivery_date,
		CASE
			WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
			ELSE 0
		END AS late_orders,
		CASE
			WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
			ELSE 0
		END AS on_time_orders, DATEDIFF(DATE(order_estimated_delivery_date), DATE(order_delivered_customer_date)) as days
		FROM olist_orders_dataset
		WHERE order_status = "delivered"
)
SELECT ROUND(ABS(AVG(days)),2) as average_late_days
FROM Table_1
WHERE late_orders = 1;

-- Average days early/on-time
WITH Table_1 AS
(
	SELECT order_id, order_delivered_customer_date, order_estimated_delivery_date,
		CASE
			WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
			ELSE 0
		END AS late_orders,
		CASE
			WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
			ELSE 0
		END AS on_time_orders, DATEDIFF(DATE(order_estimated_delivery_date), DATE(order_delivered_customer_date)) as days
		FROM olist_orders_dataset
		WHERE order_status = "delivered"
)
SELECT ROUND(ABS(AVG(days)),2) as average_days_early
FROM Table_1
WHERE on_time_orders = 1;