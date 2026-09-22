USE olist;

-- Import each CSV using your local file path.
-- Replace <PATH_TO_DATASET> with the location of the Olist CSV files on your own computer before running.

-- 1. Customers
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_customers_dataset.csv'
INTO TABLE olist_customers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 2. Geolocation
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 3. Order Items
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_order_items_dataset.csv'
INTO TABLE olist_order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 4. Order Payments
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 5. Order Reviews
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 6. Orders
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 7. Products
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_products_dataset.csv'
INTO TABLE olist_products_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 8. Sellers
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/olist_sellers_dataset.csv'
INTO TABLE olist_sellers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 9. Category Translation
LOAD DATA LOCAL INFILE '<PATH_TO_DATASET>/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;