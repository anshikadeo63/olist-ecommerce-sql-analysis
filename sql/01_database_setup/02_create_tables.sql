USE olist;

-- Create table for the Olist customers dataset
CREATE TABLE olist_customers_dataset (
    customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(100),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(20)
);

-- Create table for the Olist geolocation dataset
CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat DOUBLE,
    geolocation_lon DOUBLE,
    geolocation_city VARCHAR(50),
    geolocation_state VARCHAR(30)
);

-- Create table for the Olist products dataset
CREATE TABLE olist_products_dataset (
    product_id VARCHAR(100) PRIMARY KEY,
    product_category_name VARCHAR(70),
    product_name_length INT UNSIGNED,
    product_description_length INT UNSIGNED,
    product_photos_qty INT UNSIGNED,
    product_weight_g INT UNSIGNED,
    product_length_cm INT UNSIGNED,
    product_height_cm INT UNSIGNED,
    product_width_cm INT UNSIGNED
);

-- Create table for the Olist sellers dataset
CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(100) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(50),
    seller_state VARCHAR(20)
);

-- Create table for the product category name translation dataset
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(1000),
    product_category_name_english VARCHAR(1000)
);

-- Create table for the Olist orders dataset
CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    FOREIGN KEY (customer_id)
        REFERENCES olist_customers_dataset(customer_id),
    order_status VARCHAR(60),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- Create table for the Olist order items dataset
CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(100),
    order_item_id INT,
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date DATETIME,
    price DOUBLE UNSIGNED,
    freight_value FLOAT UNSIGNED,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (product_id)
        REFERENCES olist_products_dataset(product_id),
    FOREIGN KEY (seller_id)
        REFERENCES olist_sellers_dataset(seller_id)
);

-- Create table for the Olist order payments dataset
CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(100),
    payment_sequential INT UNSIGNED,
    payment_type VARCHAR(60),
    payment_installments INT UNSIGNED,
    payment_value DOUBLE,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id)
        REFERENCES olist_orders_dataset(order_id)
);

-- Create table for the Olist order reviews dataset
CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100),
    FOREIGN KEY (order_id)
        REFERENCES olist_orders_dataset(order_id),
    review_score INT UNSIGNED CHECK (review_score BETWEEN 1 AND 5),
    review_comment_title VARCHAR(100),
    review_comment_message VARCHAR(1000),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);