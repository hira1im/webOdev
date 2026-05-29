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
-- Insert Categories - KUNDURAS
INSERT INTO categories
    (category_name, description)
VALUES
    ('Erkek Ayakkabi', 'Erkeklere yonelik gunluk ve spor ayakkabilar'),
    ('Kadin Ayakkabi', 'Kadinlara yonelik moda ayakkabilari'),
    ('Cocuk Ayakkabi', 'Cocuklar icin rahat ve saglam ayakkabilar'),
    ('Spor Ayakkabi', 'Tum yaslar icin performans spor ayakkabilari'),
    ('Ayakkabi Aksesuar', 'Ayakkabi temizligi ve bakim urunleri');

-- Insert Admin Users
INSERT IGNORE
INTO users
(username, password, email, full_name, role)
VALUES
('admin', 'admin123', 'admin@ecommerce.com', 'Administrator', 'ADMIN'),
('superuser', 'Super123!', 'superuser@kunduras.com', 'Super User', 'ADMIN');

-- Insert Sample Products - KUNDURAS
INSERT INTO products
    (category_id, product_name, description, price, quantity_in_stock, image_url)
VALUES
    (1, 'Klasik Deri Ayakkabi', 'Ofis icin uygun, yuksek kaliteli deri erkek ayakkabisi', 299.99, 15, 'images/kunduras-deri.svg'),
    (1, 'Gunluk Rahat Ayakkabi', 'Gunluk kullanim icin konforlu erkek ayakkabisi', 149.99, 25, 'images/kunduras-gunluk.svg'),
    (2, 'Stiletto Topuklu', 'Ozel gunler icin zarif kadin ayakkabisi', 399.99, 12, 'images/kunduras-stiletto.svg'),
    (2, 'Rahat Babet', 'Gunluk rahat kullanim icin kadin babet', 119.99, 30, 'images/kunduras-babet.svg'),
    (3, 'Cocuk Spor Ayakkabi', 'Cocuklar icin kosu ve oyun ayakkabisi', 89.99, 40, 'images/kunduras-cocuk.svg'),
    (4, 'Kosu Ayakkabisi', 'Profesyonel kosu performansi icin', 449.99, 20, 'images/kunduras-kosu.svg'),
    (4, 'Gym Ayakkabisi', 'Antrenman ve fitness icin uygun ayakkabi', 199.99, 18, 'images/kunduras-gym.svg'),
    (5, 'Ayakkabi Temizlik Firca', 'Ayakkabi bakimi icin ozel firca', 29.99, 50, 'images/kunduras-care.svg');

COMMIT;
