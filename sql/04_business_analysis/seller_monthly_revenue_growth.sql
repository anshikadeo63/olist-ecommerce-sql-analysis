-- ============================================================
-- Seller Monthly Revenue Growth Analysis
-- ============================================================

-- Question:
-- How does each seller's monthly revenue change over time?
-- What is the revenue growth or decline compared with the
-- seller's previous active month?

-- Only delivered orders are included in the analysis.

-- Seller revenue is calculated using the price of products sold
-- in each year and month.

-- Revenue is first aggregated so that each row represents one
-- seller in one active month.

-- LAG() is used to retrieve the revenue from the seller's
-- previous active month.

-- Revenue change is calculated as the difference between the
-- current month's revenue and the previous active month's revenue.

-- Growth percentage is calculated relative to the previous
-- active month's revenue.

-- If a seller has no sales in a calendar month, that month does
-- not appear in the data. Therefore, the comparison is with the
-- previous active month rather than necessarily the immediately
-- preceding calendar month.

WITH Table_1 AS
(
	SELECT seller_id, order_delivered_customer_date, price, YEAR(order_delivered_customer_date) as year_delivered,
    MONTH(order_delivered_customer_date) AS month_delivered
	FROM olist_order_items_dataset AS O1
	INNER JOIN olist_orders_dataset AS O2
	ON O1.order_id = O2.order_id
	WHERE order_status = "delivered"
), Table_2 AS
(
	SELECT seller_id, year_delivered, month_delivered, ROUND(SUM(price),2) AS monthly_revenue_each_seller
	FROM Table_1
	GROUP BY seller_id, year_delivered, month_delivered
), Table_3 AS
(
	SELECT *, LAG(monthly_revenue_each_seller) OVER(PARTITION BY seller_id 
	ORDER BY year_delivered, month_delivered) as previous_month_revenue
	FROM Table_2
), Table_4 AS
(
	SELECT *, (monthly_revenue_each_seller - previous_month_revenue) AS revenue_change
	FROM Table_3
)
SELECT *, ROUND((revenue_change/previous_month_revenue)*100,2) AS growth_percent
FROM Table_4;