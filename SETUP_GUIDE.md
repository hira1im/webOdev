# E-Commerce Portal Implementation & Setup Guide

## 🚀 QUICK START

### Step 1: Database Setup

1. **Create Database**

   ```bash
   mysql -u root -p
   ```

2. **Run Schema Script**

   ```sql
   source schema.sql;
   ```

   Or copy-paste the contents of `schema.sql` into MySQL client.

3. **Verify Database Created**
   ```sql
   USE ecommerce_db;
   SHOW TABLES;
   ```

### Step 2: Configure Application

1. **Edit Database Connection**
   - Open: `ECommerce_Portal/src/main/java/com/ecommerce/util/DatabaseConnection.java`
   - Update these lines if needed:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce_db";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "";
   ```

### Step 3: Build Project

1. **Navigate to Project Directory**

   ```bash
   cd ECommerce_Portal
   ```

2. **Build with Maven**

   ```bash
   mvn clean install
   ```

3. **Expected Output**

   ```
   BUILD SUCCESS
   Total time: XX.XXXs
   ```

4. **WAR File Location**
   ```
   target/ecommerce-portal-1.0.0.war
   ```

### Step 4: Deploy to Tomcat

1. **Copy WAR File**

   ```bash
   cp target/ecommerce-portal-1.0.0.war $CATALINA_HOME/webapps/
   ```

   Or on Windows:

   ```
   copy target\ecommerce-portal-1.0.0.war "C:\Program Files\Apache Tomcat 9\webapps\"
   ```

2. **Start Tomcat**

   ```bash
   $CATALINA_HOME/bin/startup.sh
   ```

   Or on Windows:

   ```
   C:\Program Files\Apache Tomcat 9\bin\startup.bat
   ```

3. **Wait for Deployment**
   - Check: `$CATALINA_HOME/logs/catalina.out`
   - Wait for "INFO: Starting ProtocolHandler" message

### Step 5: Access Application

1. **Open Browser**
   - URL: `http://localhost:8080/ecommerce-portal`

2. **Homepage Should Display**
   - Welcome message
   - Login and Register buttons (if not logged in)

---

## 👤 TEST ACCOUNTS

### Admin Account

- **Username**: admin
- **Password**: admin123
- **Capabilities**: Product management, Order management

### Create User Account

1. Click "Register"
2. Fill in all fields
3. Submit form
4. Login with new credentials

---

## 🔄 APPLICATION WORKFLOW

### For Regular Users

1. **Register/Login**
   - Access: `http://localhost:8080/ecommerce-portal/auth?action=register`
   - Or: `http://localhost:8080/ecommerce-portal/auth?action=login`

2. **Browse Products**
   - Access: `http://localhost:8080/ecommerce-portal/products`
   - Search by keyword
   - Filter by category
   - View details

3. **Add to Cart**
   - Click "Add to Cart" on product
   - Specify quantity
   - Product added to cart

4. **View Shopping Cart**
   - Access: `http://localhost:8080/ecommerce-portal/cart`
   - Update quantities
   - Remove items
   - Clear cart

5. **Checkout**
   - Click "Proceed to Checkout"
   - Enter shipping address
   - Complete order

6. **View Orders**
   - Access: `http://localhost:8080/ecommerce-portal/orders`
   - Click "View Details" to see order items

### For Admin Users

1. **Admin Functions** (coming soon - requires additional development)
   - Would add admin dashboard
   - Product management interface
   - Order status updates
   - User management

---

## 🛠️ TROUBLESHOOTING

### Issue: Database Connection Failed

**Solution:**

1. Check MySQL is running
2. Verify credentials in `DatabaseConnection.java`
3. Ensure database exists: `SHOW DATABASES;`

### Issue: 404 - Page Not Found

**Solution:**

1. Check URL is correct: `http://localhost:8080/ecommerce-portal/products`
2. Verify WAR deployed: Check `webapps/ecommerce-portal` folder
3. Check Tomcat logs: `catalina.out`

### Issue: Login Failed - Invalid Username/Password

**Solution:**

1. Verify user exists:
   ```sql
   SELECT * FROM users WHERE username='admin';
   ```
2. Check password matches exactly
3. For admin: username=`admin`, password=`admin123`

### Issue: Cannot Add Product to Cart

**Solution:**

1. Ensure logged in (session attribute `userId` set)
2. Verify product exists and has stock
3. Check browser console for errors

### Issue: Checkout Not Working

**Solution:**

1. Verify cart has items
2. Ensure logged in
3. Enter complete shipping address
4. Check console for errors

---

## 📊 DATABASE STRUCTURE

### Users Table

- `user_id` - Primary Key
- `username` - Unique identifier
- `password` - User password (plain text in dev)
- `email` - Email address
- `full_name` - Full name
- `role` - USER or ADMIN
- `is_active` - Account status

### Products Table

- `product_id` - Primary Key
- `category_id` - Foreign Key to categories
- `product_name` - Product name
- `description` - Product description
- `price` - Product price
- `quantity_in_stock` - Available quantity
- `image_url` - Product image URL
- `is_active` - Product active status

### Orders Table

- `order_id` - Primary Key
- `user_id` - Foreign Key to users
- `order_date` - Date order created
- `total_amount` - Total order amount
- `status` - PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED
- `shipping_address` - Delivery address

### Order Details Table

- `order_detail_id` - Primary Key
- `order_id` - Foreign Key to orders
- `product_id` - Foreign Key to products
- `quantity` - Quantity ordered
- `unit_price` - Price per unit
- `subtotal` - Total for this item

---

## 🔐 SECURITY NOTES

### Current Security Implementation

- ✅ Session-based authentication
- ✅ Role-based access control
- ✅ SQL Prepared Statements
- ✅ Input validation
- ⚠️ Plain text passwords (development only)

### Production Recommendations

- [ ] Implement password hashing (bcrypt)
- [ ] Add HTTPS/SSL
- [ ] Implement CSRF protection
- [ ] Add rate limiting
- [ ] Implement audit logging
- [ ] Use OAuth/JWT for authentication
- [ ] Add input sanitization
- [ ] Implement CORS properly

---

## 📁 KEY FILES REFERENCE

| File                      | Purpose                     |
| ------------------------- | --------------------------- |
| `DatabaseConnection.java` | Database connectivity       |
| `AuthController.java`     | User authentication         |
| `ProductController.java`  | Product management          |
| `CartController.java`     | Shopping cart operations    |
| `OrderController.java`    | Order processing            |
| `UserDAO.java`            | User database operations    |
| `ProductDAO.java`         | Product database operations |
| `schema.sql`              | Database initialization     |
| `pom.xml`                 | Maven configuration         |
| `style.css`               | UI styling                  |

---

## 📱 RESPONSIVE DESIGN

The application includes responsive CSS for:

- **Desktop**: Full grid layout
- **Tablet**: Adjusted column widths
- **Mobile**: Single column layout

CSS media queries applied at 768px breakpoint.

---

## 🔍 URL ENDPOINTS

| Endpoint                            | Method | Purpose                 |
| ----------------------------------- | ------ | ----------------------- |
| `/auth?action=login`                | GET    | Show login page         |
| `/auth`                             | POST   | Process login           |
| `/auth?action=register`             | GET    | Show register page      |
| `/auth?action=logout`               | GET    | Logout user             |
| `/products`                         | GET    | List products           |
| `/products?action=view&id=X`        | GET    | View product detail     |
| `/products?action=search&keyword=X` | GET    | Search products         |
| `/cart`                             | GET    | View shopping cart      |
| `/cart`                             | POST   | Add/update/remove items |
| `/orders`                           | GET    | List user orders        |
| `/orders?action=view&id=X`          | GET    | View order details      |

---

## 📚 ADDITIONAL RESOURCES

- MySQL Documentation: https://dev.mysql.com/doc/
- Apache Tomcat: https://tomcat.apache.org/
- Java Servlet API: https://jakarta.ee/specifications/servlet/
- JSTL Documentation: https://projects.eclipse.org/projects/ee4j.jsp

---

## ✅ DEPLOYMENT CHECKLIST

Before going to production:

- [ ] Database backup configured
- [ ] Error handling implemented
- [ ] Logging configured
- [ ] Performance testing completed
- [ ] Security audit completed
- [ ] SSL/TLS certificate installed
- [ ] Password hashing implemented
- [ ] Admin panel complete
- [ ] User documentation prepared
- [ ] Monitoring configured

---

**Version**: 1.0.0  
**Last Updated**: 2026-05-23  
**Status**: Ready for Testing
