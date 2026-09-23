-- ============================================================
-- Order Size vs Customer Satisfaction Analysis
-- ============================================================

-- Question:
-- Does customer satisfaction change depending on the number
-- of items contained in an order?

-- The number of items is first calculated for each order using
-- the order items table.

-- Orders are then grouped into four order-size categories:
-- 1 item, 2 items, 3 items, and 4+ items.

-- Review scores are joined at the order level, and the average
-- review score is calculated for each order-size group.

WITH Table_1 AS
(
SELECT O1.order_id, COUNT(order_item_id) as no_of_items, AVG(review_score) as avg_review_score
FROM olist_order_items_dataset AS O1
INNER JOIN olist_order_reviews_dataset AS O2
ON O1.order_id = O2.order_id
GROUP BY O1.order_id
), Table_2 AS
(
SELECT *,
CASE
	WHEN no_of_items = 1 THEN "1 item"
	WHEN no_of_items = 2 THEN "2 items"
	WHEN no_of_items = 3 THEN "3 items"
	ELSE "4+ items"
END AS order_size
FROM Table_1
)
SELECT order_size, ROUND(AVG(avg_review_score),2) as avg_review_score, COUNT(order_id) as number_of_orders
FROM Table_2
GROUP BY order_size
ORDER BY MIN(no_of_items);