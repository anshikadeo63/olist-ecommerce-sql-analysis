-- ============================================================
-- Customer Geographic Distribution
-- ============================================================

-- Question:
-- Which states have the largest number of unique customers?

-- customer_unique_id is used instead of customer_id because it
-- represents the same customer across multiple orders.

SELECT customer_state, COUNT(DISTINCT customer_unique_id) as unique_customer_count
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY unique_customer_count DESC;
