-- ============================================================
-- Payment Behavior Analysis
-- ============================================================

-- Question:
-- How do payment method and installment usage relate to payment value?
-- Do customers tend to use more installments for higher-value payments?
-- Are certain payment methods associated with larger payment values?

-- Payments are grouped into value ranges to compare average
-- installment usage across lower-, medium-, and higher-value payments.

WITH Table_1 AS 
(
	SELECT *,
	CASE
		WHEN payment_value <= 2000 THEN "Lower priced purchases"
		WHEN payment_value <= 6500 THEN "Medium priced purchases"
		ELSE "Higher priced purchases"
	END AS purchase_type
	FROM olist_order_payments_dataset
)
SELECT purchase_type, AVG(payment_installments) as avg_installments
FROM Table_1
GROUP BY purchase_type;

-- Compare average payment value across payment methods.

SELECT payment_type, ROUND(AVG(payment_value),2) as avg_payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type;