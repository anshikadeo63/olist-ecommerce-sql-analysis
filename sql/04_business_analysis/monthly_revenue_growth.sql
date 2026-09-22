-- ============================================================
-- Monthly Revenue and Growth Analysis
-- ============================================================

-- Question:
-- How does revenue change over time?
-- Which year-month periods generate the highest revenue?
-- Which months experience the largest increases or decreases
-- in revenue compared with the previous month?

-- Only delivered orders are included in the analysis.
-- Revenue is aggregated by year and month to prevent months
-- from different years from being combined.

-- ------------------------------------------------------------
-- Monthly Revenue Ranking
-- ------------------------------------------------------------

-- Monthly revenue is ranked from highest to lowest using
-- DENSE_RANK() to identify the highest-revenue periods.

WITH Table_1 AS 
(
	SELECT O1.order_id, order_status, payment_value, order_delivered_customer_date, 
	EXTRACT(MONTH FROM order_delivered_customer_date) as order_month,
    EXTRACT(YEAR FROM order_delivered_customer_date) as order_year
	FROM olist_order_payments_dataset as O1
	INNER JOIN olist_orders_dataset AS O2
	ON O1.order_id = O2.order_id
	WHERE order_status = "delivered"
), Table_2 AS 
(
	SELECT order_month, order_year, ROUND(SUM(payment_value),2) AS monthly_revenue
	FROM Table_1
	WHERE order_month BETWEEN 1 AND 12
	GROUP BY order_month, order_year
)
SELECT 
dense_rank() OVER(ORDER BY monthly_revenue DESC) as month_ranked_rev,
order_year,
CASE
	WHEN order_month = 1 THEN "Jan"
    WHEN order_month = 2 THEN "Feb"
    WHEN order_month = 3 THEN "Mar"
    WHEN order_month = 4 THEN "Apr"
    WHEN order_month = 5 THEN "May"
    WHEN order_month = 6 THEN "Jun"
    WHEN order_month = 7 THEN "Jul"
    WHEN order_month = 8 THEN "Aug"
    WHEN order_month = 9 THEN "Sep"
    WHEN order_month = 10 THEN "Oct"
    WHEN order_month = 11 THEN "Nov"
    WHEN order_month = 12 THEN "Dec"
END AS month_name,
monthly_revenue
FROM Table_2;

-- ------------------------------------------------------------
-- Month-over-Month Revenue Growth
-- ------------------------------------------------------------

-- LAG() is used to retrieve the previous month's revenue.
-- Absolute revenue change is calculated by subtracting the
-- previous month's revenue from the current month's revenue.

-- Growth percentage measures the month-over-month revenue
-- change relative to the previous month's revenue.

WITH Table_1 AS 
(
	SELECT O1.order_id, order_status, payment_value, order_delivered_customer_date, 
	EXTRACT(MONTH FROM order_delivered_customer_date) as order_month,
    EXTRACT(YEAR FROM order_delivered_customer_date) as order_year
	FROM olist_order_payments_dataset as O1
	INNER JOIN olist_orders_dataset AS O2
	ON O1.order_id = O2.order_id
	WHERE order_status = "delivered"
), Table_2 AS 
(
	SELECT order_month, order_year, ROUND(SUM(payment_value),2) AS monthly_revenue
	FROM Table_1
	WHERE order_month BETWEEN 1 AND 12
	GROUP BY order_month, order_year
), Table_3 AS
(
	SELECT order_year,
	CASE
		WHEN order_month = 1 THEN "Jan"
		WHEN order_month = 2 THEN "Feb"
		WHEN order_month = 3 THEN "Mar"
		WHEN order_month = 4 THEN "Apr"
		WHEN order_month = 5 THEN "May"
		WHEN order_month = 6 THEN "Jun"
		WHEN order_month = 7 THEN "Jul"
		WHEN order_month = 8 THEN "Aug"
		WHEN order_month = 9 THEN "Sep"
		WHEN order_month = 10 THEN "Oct"
		WHEN order_month = 11 THEN "Nov"
		WHEN order_month = 12 THEN "Dec"
	END AS month_name, monthly_revenue,
	LAG(monthly_revenue) OVER(ORDER BY order_year, order_month) as prev_month_revenue
	FROM Table_2
), Table_4 AS
(
	SELECT order_year, month_name, monthly_revenue, prev_month_revenue,
	ROUND(monthly_revenue - prev_month_revenue,2) AS change_revenue
	FROM Table_3
)
SELECT order_year, month_name, change_revenue, ROUND((change_revenue/ prev_month_revenue) * 100,2) as growth_percent
FROM Table_4;