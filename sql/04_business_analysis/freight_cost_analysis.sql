-- ============================================================
-- Freight Cost Analysis
-- ============================================================

-- Question:
-- How does freight cost vary relative to product price across
-- product categories?
-- Which product categories have the highest average
-- freight-to-price ratio?

-- The freight-to-price ratio is calculated for each order item
-- by dividing freight value by product price and multiplying
-- by 100.

-- Products are grouped by category to compare average product
-- price, average freight value, and average freight-to-price
-- ratio across categories.

-- Categories are ordered from highest to lowest average
-- freight-to-price ratio.

WITH Table_1 AS
(
	SELECT O1.product_id, O2.product_category_name, O1.price, O1.freight_value, ROUND((O1.freight_value/O1.price)*100,2) as freight_to_price_ratio
	FROM olist_order_items_dataset AS O1
	INNER JOIN olist_products_dataset AS O2
	ON O1.product_id = O2.product_id
)
SELECT product_category_name,
       ROUND(AVG(price),2) as avg_price,
       ROUND(AVG(freight_value),2) as avg_freight_value,
       ROUND(AVG(freight_to_price_ratio),2) AS avg_freight_to_price_ratio
FROM Table_1
GROUP BY product_category_name
ORDER BY avg_freight_to_price_ratio DESC;