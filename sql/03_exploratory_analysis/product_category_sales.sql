-- ============================================================
-- Product Category Sales Analysis
-- ============================================================

-- Question:
-- Which product categories have the highest and lowest
-- number of items sold?

-- Sales volume is measured by counting order-item records
-- associated with each product category.

-- Highest-selling product categories
WITH Table_1 AS
(
	SELECT O1.product_id as id_O1, product_category_name, O2.product_id AS id_O2
	FROM olist_products_dataset AS O1
	RIGHT JOIN olist_order_items_dataset AS O2
	ON O1.product_id = O2.product_id
), Table_2 AS 
(
	SELECT product_category_name_english ,COUNT(product_category_name_english) AS product_sold_count
	FROM Table_1 as T1
	INNER JOIN product_category_name_translation AS T2
	ON T1.product_category_name = T2.product_category_name
	GROUP BY product_category_name_english
)
SELECT *, dense_rank() OVER(ORDER BY product_sold_count DESC) AS highest_rank
FROM Table_2;

-- Lowest-selling product categories
WITH Table_1 AS
(
	SELECT O1.product_id as id_O1, product_category_name, O2.product_id AS id_O2
	FROM olist_products_dataset AS O1
	RIGHT JOIN olist_order_items_dataset AS O2
	ON O1.product_id = O2.product_id
), Table_2 AS 
(
	SELECT product_category_name_english ,COUNT(product_category_name_english) AS product_sold_count
	FROM Table_1 as T1
	INNER JOIN product_category_name_translation AS T2
	ON T1.product_category_name = T2.product_category_name
	GROUP BY product_category_name_english
)
SELECT *, dense_rank() OVER(ORDER BY product_sold_count) AS lowest_rank
FROM Table_2;
