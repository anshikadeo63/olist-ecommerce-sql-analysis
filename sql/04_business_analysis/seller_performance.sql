-- ============================================================
-- Seller Performance vs Customer Satisfaction
-- ============================================================

-- Question:
-- Is there a relationship between a seller's sales performance
-- and customer review scores?

-- Seller revenue is calculated for each seller-order combination.
-- Review scores are then joined using order_id to compare seller
-- sales performance with customer satisfaction.

WITH Table_1 AS
(
	SELECT order_id, seller_id, SUM(price) OVER(PARTITION BY seller_id, order_id) AS seller_price_revenue
	FROM olist_order_items_dataset
), Table_2 AS
(
	SELECT order_id, review_score
    FROM olist_order_reviews_dataset
)
SELECT T1.order_id, seller_id, seller_price_revenue, AVG(review_score) OVER (PARTITION BY seller_id, order_id) as seller_review
FROM Table_1 AS T1
INNER JOIN Table_2 AS T2
ON T1.order_id = T2.order_id
ORDER BY seller_review DESC;