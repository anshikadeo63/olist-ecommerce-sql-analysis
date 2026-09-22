-- ============================================================
-- Geographic Review Score Analysis
-- ============================================================

-- Question:
-- Which ZIP-code areas have the highest and lowest average
-- review scores, considering only areas with at least 50 reviews?

-- The 50-review minimum is used to reduce the influence of
-- ZIP codes with very small numbers of reviews.

-- Highest average review scores
WITH Table_1 AS 
(
	SELECT O1.order_id, O1.customer_id, O2.order_id as table_review_order_id, O2.review_score
	FROM olist_orders_dataset AS O1
	LEFT JOIN olist_order_reviews_dataset AS O2
	ON O1.order_id = O2.order_id
), Table_2 AS
(
	SELECT customer_zip_code_prefix, AVG(review_score) as average_review_scores, COUNT(review_score) AS number_reviews
	FROM olist_customers_dataset AS T1
	LEFT JOIN Table_1 AS T2
	ON T1.customer_id = T2.customer_id
	GROUP BY customer_zip_code_prefix
)
SELECT *, dense_rank() OVER(ORDER BY average_review_scores DESC) as highest_rank
FROM Table_2
WHERE number_reviews >= 50;

-- Lowest average review scores
WITH Table_1 AS 
(
	SELECT O1.order_id, O1.customer_id, O2.order_id as table_review_order_id, O2.review_score
	FROM olist_orders_dataset AS O1
	LEFT JOIN olist_order_reviews_dataset AS O2
	ON O1.order_id = O2.order_id
), Table_2 AS
(
	SELECT customer_zip_code_prefix, AVG(review_score) as average_review_scores, COUNT(review_score) AS number_reviews
	FROM olist_customers_dataset AS T1
	LEFT JOIN Table_1 AS T2
	ON T1.customer_id = T2.customer_id
	GROUP BY customer_zip_code_prefix
)
SELECT *, dense_rank() OVER(ORDER BY average_review_scores) as lowest_rank
FROM Table_2
WHERE number_reviews >= 50;

