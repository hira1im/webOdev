-- Create Database
CREATE DATABASE
IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Users Table
CREATE TABLE
IF NOT EXISTS users
(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR
(100) UNIQUE NOT NULL,
    password VARCHAR
(255) NOT NULL,
    email VARCHAR
(100) UNIQUE NOT NULL,
    full_name VARCHAR
(150) NOT NULL,
    phone VARCHAR
(20),
    address TEXT,
    role VARCHAR
(50) DEFAULT 'USER',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Categories Table
CREATE TABLE
IF NOT EXISTS categories
(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR
(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category_name (category_name),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Products Table
CREATE TABLE
IF NOT EXISTS products
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    product_name VARCHAR
(200) NOT NULL,
    description TEXT,
    price DECIMAL
(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR
(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY
(category_id) REFERENCES categories
(category_id) ON
DELETE RESTRICT,
    INDEX idx_category_id (category_id),
    INDEX idx_product_name
(product_name),
    INDEX idx_price
(price),
    INDEX idx_is_active
(is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cart Table
CREATE TABLE
IF NOT EXISTS cart
(
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY
(user_id) REFERENCES users
(user_id) ON
DELETE CASCADE,
    FOREIGN KEY (product_id)
REFERENCES products
(product_id) ON
DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_product_id
(product_id),
    UNIQUE KEY unique_user_product
(user_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Orders Table
CREATE TABLE
IF NOT EXISTS orders
(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL
(10, 2) NOT NULL,
    shipping_address TEXT NOT NULL,
    order_status VARCHAR
(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY
(user_id) REFERENCES users
(user_id) ON
DELETE RESTRICT,
    INDEX idx_user_id (user_id),
    INDEX idx_order_date
(order_date),
    INDEX idx_order_status
(order_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order Details Table
CREATE TABLE
IF NOT EXISTS order_details
(
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL
(10, 2) NOT NULL,
    subtotal DECIMAL
(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY
(order_id) REFERENCES orders
(order_id) ON
DELETE CASCADE,
    FOREIGN KEY (product_id)
REFERENCES products
(product_id) ON
DELETE RESTRICT,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id
(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Data
-- Admin Users
INSERT IGNORE
INTO users
(username, password, email, full_name, role)
VALUES
('admin', 'admin123', 'admin@ecommerce.com', 'Administrator', 'ADMIN'),
('superuser', 'Super123!', 'superuser@kunduras.com', 'Super User', 'ADMIN');

-- Sample Categories - KUNDURAŞ (Ayakkabı Satışı)
INSERT INTO categories
    (category_name, description)
VALUES
    ('Erkek Ayakkabı', 'Erkeklere yönelik günlük ve spor ayakkabılar'),
    ('Kadın Ayakkabı', 'Kadınlara yönelik moda ayakkabıları'),
    ('Çocuk Ayakkabı', 'Çocuklar için rahat ve sağlam ayakkabılar'),
    ('Spor Ayakkabı', 'Tüm yaşlar için performans spor ayakkabıları'),
    ('Ayakkabı Aksesuar', 'Ayakkabı temizliği ve bakım ürünleri');

-- Sample Products - KUNDURAŞ
INSERT INTO products
    (category_id, product_name, description, price, quantity_in_stock, image_url)
VALUES
    (1, 'Klasik Deri Ayakkabı', 'Ofis için uygun, yüksek kaliteli deri erkek ayakkabısı', 299.99, 15, 'images/kunduras-deri.svg'),
    (1, 'Günlük Rahat Ayakkabı', 'Günlük kullanım için konforlu erkek ayakkabısı', 149.99, 25, 'images/kunduras-gunluk.svg'),
    (2, 'Stiletto Topuklu', 'Özel günler için zarif kadın ayakkabısı', 399.99, 12, 'images/kunduras-stiletto.svg'),
    (2, 'Rahat Babet', 'Günlük rahat kullanım için kadın babet', 119.99, 30, 'images/kunduras-babet.svg'),
    (3, 'Çocuk Spor Ayakkabı', 'Çocuklar için koşu ve oyun ayakkabısı', 89.99, 40, 'images/kunduras-cocuk.svg'),
    (4, 'Koşu Ayakkabısı', 'Profesyonel koşu performansı için', 449.99, 20, 'images/kunduras-kosu.svg'),
    (4, 'Gym Ayakkabısı', 'Antrenman ve fitness için uygun ayakkabı', 199.99, 18, 'images/kunduras-gym.svg'),
    (5, 'Ayakkabı Temizlik Fırçası', 'Ayakkabı bakımı için özel fırça', 29.99, 50, 'images/kunduras-care.svg');
