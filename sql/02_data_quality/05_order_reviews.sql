-- Data quality checks for Olist_order_reviews_dataset 

USE olist;

-- NULL checks
SELECT *
FROM olist_order_reviews_dataset
WHERE review_id IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE order_id IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE review_score IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE review_creation_date IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE review_answer_timestamp IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE review_comment_title IS NULL;

SELECT *
FROM olist_order_reviews_dataset
WHERE review_comment_message IS NULL;

-- Primary key uniqueness check
SELECT COUNT(review_id), COUNT(DISTINCT review_id)
FROM olist_order_reviews_dataset;

-- Foreign key reference check
SELECT O1.order_id, O2.order_id
FROM olist_order_reviews_dataset AS O1
LEFT JOIN olist_orders_dataset AS O2
ON O1.order_id = O2.order_id
WHERE O2.order_id IS NULL;

-- Review date range checks
SELECT MIN(review_creation_date), MAX(review_creation_date)
FROM olist_order_reviews_dataset;

SELECT MIN(review_answer_timestamp), MAX(review_answer_timestamp)
FROM olist_order_reviews_dataset;

-- Review score value distribution
SELECT review_score, COUNT(review_score)
FROM olist_order_reviews_dataset
GROUP BY review_score;

-- Review timestamp consistency check
SELECT *
FROM olist_order_reviews_dataset
WHERE review_creation_date > review_answer_timestamp;
