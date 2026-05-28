# E-Commerce Portal - Quick Start Guide

## 🚀 How to Run the Project

### Prerequisites
- Java JDK 21 or higher
- Apache Tomcat 7 or higher (recommended: Tomcat 10+)
- MySQL 8.0 or higher
- Maven 3.8+

---

## ⚙️ Step-by-Step Setup

### Step 1: Setup Database
1. Open MySQL Workbench or MySQL Command Line
2. Execute the `schema.sql` file:
   ```sql
   SOURCE /path/to/ECommerce_Portal/schema.sql
   ```
3. Verify tables were created:
   ```sql
   USE ecommerce_db;
   SHOW TABLES;
   ```

### Step 2: Build the Project
1. Open terminal in `ECommerce_Portal` directory
2. Run Maven build:
   ```bash
   mvn clean package
   ```
3. This creates: `target/ecommerce-portal-1.0.0.war`

### Step 3: Deploy to Tomcat
1. Copy the WAR file to Tomcat's `webapps` directory:
   ```bash
   cp target/ecommerce-portal-1.0.0.war /path/to/tomcat/webapps/
   ```
2. Start Tomcat:
   ```bash
   # On Windows
   catalina.bat start
   
   # On Linux/Mac
   ./catalina.sh start
   ```

### Step 4: Access the Application
1. Open browser and go to: `http://localhost:8080/ecommerce-portal/`
2. You should see the homepage

---

## 🔓 Login Credentials

### Admin Account
- **Username**: admin
- **Password**: admin123
- **Role**: Administrator (can manage products and view all orders)

### Create New User Account
1. Click "Register" on the homepage
2. Fill in the registration form
3. Click "Register"
4. Login with your credentials

---

## 📂 Project Structure

```
ECommerce_Portal/
├── src/main/
│   ├── java/com/ecommerce/
│   │   ├── controller/      # Servlet controllers
│   │   ├── dao/             # Data access objects
│   │   ├── model/           # Entity classes
│   │   └── util/            # Utility classes
│   └── webapp/
│       ├── pages/           # JSP files
│       │   ├── admin/       # Admin pages
│       │   ├── header.jsp   # Header template
│       │   └── footer.jsp   # Footer template
│       ├── css/             # Stylesheets
│       ├── images/          # Product images
│       ├── WEB-INF/
│       │   └── web.xml      # Web configuration
│       └── index.jsp        # Homepage
├── pom.xml                  # Maven configuration
├── schema.sql               # Database schema
└── README.md                # Documentation
```

---

## 🌐 Application URLs

### Public Pages
- Homepage: `http://localhost:8080/ecommerce-portal/`
- Products: `http://localhost:8080/ecommerce-portal/products`
- Cart: `http://localhost:8080/ecommerce-portal/cart`
- Login: `http://localhost:8080/ecommerce-portal/auth?action=login`
- Register: `http://localhost:8080/ecommerce-portal/auth?action=register`

### Authenticated Pages
- My Orders: `http://localhost:8080/ecommerce-portal/orders`
- Checkout: `http://localhost:8080/ecommerce-portal/checkout`

### Admin Pages (Login as admin required)
- Admin Dashboard: `http://localhost:8080/ecommerce-portal/admin?action=dashboard`
- Add Product: `http://localhost:8080/ecommerce-portal/pages/admin/add-product.jsp`
- All Orders: `http://localhost:8080/ecommerce-portal/admin?action=orders`

---

## 🔧 Configuration

### Database Connection Settings
**File**: `src/main/java/com/ecommerce/util/DatabaseConnection.java`

If your MySQL setup is different, update these values:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "";
```

---

## 📌 Common Issues & Solutions

### Issue: "Connection refused" error
**Solution**: Ensure MySQL is running on port 3306

### Issue: "Database not found" error
**Solution**: Execute `schema.sql` to create the database and tables

### Issue: 404 errors on static resources
**Solution**: Ensure the WAR was deployed correctly and Tomcat has the right permissions

### Issue: Session issues on login
**Solution**: Check Tomcat session timeout in `web.xml` (currently set to 30 minutes)

---

## ✅ Features Implemented

### User Management
- ✓ User Registration
- ✓ User Login
- ✓ User Logout
- ✓ Session Management
- ✓ Role-Based Access Control

### Product Management
- ✓ View All Products
- ✓ Product Search
- ✓ Filter by Category
- ✓ View Product Details
- ✓ Admin: Add Products
- ✓ Admin: Edit Products
- ✓ Admin: Delete Products

### Shopping Cart
- ✓ Add to Cart
- ✓ View Cart
- ✓ Update Quantities
- ✓ Remove Items
- ✓ Clear Cart

### Orders
- ✓ Checkout Process
- ✓ Order Creation
- ✓ View My Orders
- ✓ View Order Details
- ✓ Admin: View All Orders

### UI/UX
- ✓ Responsive Design
- ✓ JSTL Templates
- ✓ Error Handling
- ✓ Status Messages
- ✓ Form Validation

---

## 📞 Support

For issues or questions, check:
1. The error message in the console
2. The application logs in Tomcat
3. The database connection settings
4. Ensure all required files are in place

---

**Last Updated**: May 23, 2026
**Version**: 1.0.0
