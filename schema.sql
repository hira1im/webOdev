-- Create E-Commerce Database Schema
CREATE DATABASE
IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Users Table
CREATE TABLE
IF NOT EXISTS users
(
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR
(50) NOT NULL UNIQUE,
    password VARCHAR
(255) NOT NULL,
    email VARCHAR
(100) NOT NULL UNIQUE,
    full_name VARCHAR
(100) NOT NULL,
    role VARCHAR
(20) DEFAULT 'USER',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_is_active (is_active)
);

-- Categories Table
CREATE TABLE
IF NOT EXISTS categories
(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR
(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category_name
(category_name),
    INDEX idx_is_active
(is_active)
);

-- Products Table
CREATE TABLE
IF NOT EXISTS products
(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR
(150) NOT NULL,
    description TEXT,
    price DECIMAL
(10, 2) NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    image_url VARCHAR
(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY
(category_id) REFERENCES categories
(category_id),
    INDEX idx_product_name
(product_name),
    INDEX idx_category_id
(category_id),
    INDEX idx_is_active
(is_active)
);

-- Cart Table
CREATE TABLE
IF NOT EXISTS cart
(
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY
(user_id) REFERENCES users
(user_id),
    FOREIGN KEY
(product_id) REFERENCES products
(product_id),
    INDEX idx_user_id
(user_id),
    INDEX idx_product_id
(product_id)
);

-- Orders Table
CREATE TABLE
IF NOT EXISTS orders
(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL
(10, 2) NOT NULL,
    status VARCHAR
(50) DEFAULT 'PENDING',
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY
(user_id) REFERENCES users
(user_id),
    INDEX idx_user_id
(user_id),
    INDEX idx_status
(status),
    INDEX idx_order_date
(order_date)
);

-- Order Details Table
CREATE TABLE
IF NOT EXISTS order_details
(
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL
(10, 2) NOT NULL,
    subtotal DECIMAL
(10, 2) NOT NULL,
    FOREIGN KEY
(order_id) REFERENCES orders
(order_id),
    FOREIGN KEY
(product_id) REFERENCES products
(product_id),
    INDEX idx_order_id
(order_id),
    INDEX idx_product_id
(product_id)
);

-- Insert Sample Data
-- Insert Categories
INSERT INTO categories
    (category_name, description)
VALUES
    ('Electronics', 'Electronic devices and gadgets'),
    ('Clothing', 'Apparel and fashion items'),
    ('Books', 'Books and educational materials'),
    ('Home & Garden', 'Home and garden products'),
    ('Sports & Outdoors', 'Sports and outdoor equipment');

-- Insert Admin User
INSERT INTO users
    (username, password, email, full_name, role)
VALUES
    ('admin', 'admin123', 'admin@ecommerce.com', 'Administrator', 'ADMIN');

-- Insert Sample Products
INSERT INTO products
    (category_id, product_name, description, price, quantity_in_stock)
VALUES
    (1, 'Wireless Mouse', 'High-precision wireless mouse with USB receiver', 29.99, 50),
    (1, 'USB-C Cable', '1.5m USB-C charging and data cable', 9.99, 100),
    (2, 'T-Shirt', 'Comfortable cotton t-shirt', 19.99, 75),
    (2, 'Jeans', 'Classic blue denim jeans', 49.99, 40),
    (3, 'Java Programming Book', 'Complete guide to Java programming', 39.99, 30),
    (4, 'Plant Pot', 'Ceramic plant pot 20cm', 14.99, 60),
    (5, 'Running Shoes', 'Professional running shoes', 89.99, 25);

COMMIT;
