-- ============================================================
-- Most Common Payment Method by Customer State
-- ============================================================

-- Question:
-- Which payment method is most commonly used in each customer
-- state?
-- What percentage of payment records in each state does the
-- most commonly used payment method represent?

-- Payment records are first connected with orders to identify
-- the customer associated with each payment.

-- Customer information is then joined to determine the state
-- associated with each payment record.

-- The total number of payment records is calculated for each
-- customer state.

-- Payment records are also counted for each payment type
-- within each state.

-- Payment share represents the percentage of a state's total
-- payment records associated with each payment method.

-- Payment methods are ranked within each customer state based
-- on their payment share.

-- Only the highest-ranked payment method for each state is
-- retained in the final result. Ties for the most commonly
-- used payment method are preserved.

WITH Table_1 AS
(
	SELECT customer_id, payment_type
	FROM olist_order_payments_dataset AS O1
	INNER JOIN olist_orders_dataset AS O2
	ON O1.order_id = O2.order_id
), Table_2 AS
(
	SELECT T1.customer_id, customer_state, payment_type, 
	COUNT(payment_type) OVER(PARTITION BY customer_state) as total_payments_per_state,
	COUNT(T1.customer_id) OVER(PARTITION BY customer_state, payment_type) as count_per_payment_per_state
	FROM Table_1 as T1
	INNER JOIN olist_customers_dataset AS T2
	ON T1.customer_id = T2.customer_id
), Table_3 AS 
(
	SELECT DISTINCT customer_state, payment_type, total_payments_per_state, count_per_payment_per_state,
	ROUND((count_per_payment_per_state/total_payments_per_state)*100,2) as percent_payment
	FROM Table_2
), Table_4 AS
(
	SELECT *, RANK() OVER(PARTITION BY customer_state ORDER BY percent_payment DESC) as ranked
	FROM Table_3
)
SELECT customer_state, payment_type AS most_used_payment_type, count_per_payment_per_state AS payment_count
, total_payments_per_state AS state_payment_count, percent_payment AS payment_share_percent
FROM Table_4
WHERE ranked = 1;
