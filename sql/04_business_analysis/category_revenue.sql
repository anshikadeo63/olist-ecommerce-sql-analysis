-- ============================================================
-- Product Category Revenue Contribution and Concentration Analysis
-- ============================================================

-- Question:
-- How much does each product category contribute to total revenue,
-- and how concentrated is revenue across product categories?

-- Revenue contribution is calculated as each category's percentage
-- of total product revenue. Cumulative percentage shows how quickly
-- total revenue is concentrated among the highest-revenue categories.

WITH Table_1 AS 
(
	SELECT O1.product_id, product_category_name, O1.price, SUM(price) OVER(PARTITION BY product_category_name) as product_category_sale, 
	SUM(price) OVER() as total_sale
	FROM olist_order_items_dataset as O1
	INNER JOIN olist_products_dataset AS O2
	ON O1.product_id = O2.product_id
), Table_2 AS
(
	SELECT DISTINCT product_category_name, (product_category_sale/ total_sale) * 100 as percent_sales
	FROM Table_1
)
SELECT T2.product_category_name_english, percent_sales, SUM(percent_sales) OVER(ORDER BY percent_sales DESC) as cumulative_percentage
FROM Table_2 AS T1
LEFT JOIN product_category_name_translation AS T2
ON T1.product_category_name = T2.product_category_name;