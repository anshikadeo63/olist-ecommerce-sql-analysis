-- ============================================================
-- Delivery Performance vs Customer Satisfaction
-- ============================================================

-- Question:
-- How does delivery lateness affect customer satisfaction?

-- Delivered orders are grouped based on the number of days
-- between the estimated and actual delivery dates.

-- The average review score and number of orders are calculated
-- for each delivery group to compare customer satisfaction
-- as delivery delays increase.

WITH Table_1 AS
(
	SELECT O1.order_id, review_score, order_status, order_delivered_customer_date,order_estimated_delivery_date,
	CASE
		WHEN order_delivered_customer_date > order_estimated_delivery_date THEN "Late"
		WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN "On time"
	END AS status_order
	FROM olist_order_reviews_dataset as O1
	INNER JOIN olist_orders_dataset AS O2
	ON O1.order_id = O2.order_id
	WHERE order_estimated_delivery_date IS NOT NULL 
), Table_2 AS
(
	SELECT *, DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) as days_late
	FROM Table_1
	WHERE order_status = "delivered"
), Table_3 AS
(
	SELECT *,
	CASE
		WHEN days_late BETWEEN 1 AND 3 THEN "Few days late"
		WHEN days_late BETWEEN 4 AND 7 Then "Medium days late"
		WHEN days_late >= 8 THEN "Very late"
        ELSE "On time"
	END AS days_late_string
	FROM Table_2
)
SELECT days_late_string, ROUND(AVG(review_score),2) as average_score, COUNT(order_id) as no_of_orders
FROM Table_3
GROUP BY days_late_string;

