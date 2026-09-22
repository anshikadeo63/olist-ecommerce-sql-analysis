-- ============================================================
-- Product Price Segment Revenue Analysis
-- ============================================================

-- Question:
-- How do low-, medium-, and high-priced items compare in terms
-- of sales volume, total revenue, and contribution to overall revenue?

-- Price segments were selected after inspecting the dataset's
-- price distribution (average price ≈ 400 and maximum price ≈ 7000).

WITH Table_1 AS
(
	SELECT product_id, price,
    -- Categorize order items into price segments based on observed price distribution
	CASE
		WHEN price < 500 THEN "Low priced"
		WHEN price BETWEEN 500 AND 2000 THEN "Medium priced"
		WHEN price > 2000 THEN "High priced"
	END AS price_group
	FROM olist_order_items_dataset
), Table_2 AS
(
	SELECT price_group, COUNT(product_id) OVER(PARTITION BY price_group) as items_sold, 
	SUM(price) OVER(partition by price_group) as revenue, 
	SUM(price) OVER() as total_revenue
	FROM Table_1
)
SELECT DISTINCT price_group, items_sold,
revenue, total_revenue,
(revenue/total_revenue)*100 as revenue_share_percent
FROM Table_2
ORDER BY revenue_share_percent DESC;