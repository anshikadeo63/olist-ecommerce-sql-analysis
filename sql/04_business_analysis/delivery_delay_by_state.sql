-- ============================================================
-- Delivery Delay by Customer State Analysis
-- ============================================================

-- Question:
-- Which customer states experience the worst delivery
-- performance?
-- What percentage of delivered orders arrive late, and how
-- many days late are delayed orders on average?

-- Only delivered orders are included so that delivery
-- performance is evaluated using completed deliveries.

-- Delivery delay is calculated by comparing the estimated
-- delivery date with the actual customer delivery date.

-- A negative value indicates that the order was delivered
-- after the estimated delivery date and is therefore late.

-- Late-delivery percentage is calculated for each state by
-- dividing the number of late orders by the total number of
-- delivered orders in that state.

-- Average days late is calculated using only late orders.

WITH Table_1 AS
(
	SELECT O1.customer_id, customer_state, order_estimated_delivery_date, order_delivered_customer_date,
	DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) as days_from_delivery
	FROM olist_orders_dataset AS O1
	LEFT JOIN olist_customers_dataset AS O2
	ON O1.customer_id = O2.customer_id
	WHERE order_status = "delivered"
), Table_2 AS
(
	SELECT customer_id, customer_state, days_from_delivery,
	COUNT(customer_state) OVER(PARTITION BY customer_state) AS all_orders_per_state,
	CASE
		WHEN days_from_delivery < 0 THEN 1
		ELSE 0
	END AS delivery_punctuality
	FROM Table_1
), Table_3 AS
(
	SELECT customer_state,
	SUM(delivery_punctuality) OVER(PARTITION BY customer_state) as order_not_punctual_per_state,
	all_orders_per_state,
	ROUND(AVG(CASE WHEN days_from_delivery < 0 THEN ABS(days_from_delivery) END)
	OVER(PARTITION BY customer_state),2) as avg_days_late
	FROM Table_2
)
SELECT DISTINCT customer_state,
order_not_punctual_per_state,
all_orders_per_state,
ROUND((order_not_punctual_per_state/all_orders_per_state)*100,2) AS percent_late_orders,
avg_days_late
FROM Table_3
ORDER BY percent_late_orders DESC;