# E-Commerce Portal - Java MVC with JSTL

## Proje Açıklaması / Project Description

Bu proje, Java MVC mimarisi ve JSTL (JavaServer Pages Standard Tag Library) kullanarak geliştirilmiş temel bir e-ticaret portalıdır. Sistem, kullanıcı yönetimi, ürün yönetimi, alışveriş sepeti ve sipariş yönetimini içerir.

This project is a basic e-commerce portal developed using Java MVC architecture and JSTL (JavaServer Pages Standard Tag Library). The system includes user management, product management, shopping cart, and order management.

## Özellikler / Features

### Kullanıcı Yönetimi / User Management

- Kayıt (Registration)
- Giriş (Login/Logout)
- Kullanıcı profili (User Profile)
- Admin ve Normal Kullanıcı Rolleri (Admin and User Roles)

### Ürün Yönetimi / Product Management

- Ürünleri Listele (List Products)
- Ürün Detayları (Product Details)
- Kategoriye Göre Filtreleme (Filter by Category)
- Ürün Arama (Product Search)
- Admin Tarafından Ürün Ekleme/Düzenleme/Silme (Admin - Add/Edit/Delete Products)

### Alışveriş Sepeti / Shopping Cart

- Sepete Ürün Ekleme (Add to Cart)
- Sepeti Görüntüleme (View Cart)
- Sepet Miktarını Güncelleme (Update Quantity)
- Sepetten Ürün Çıkarma (Remove from Cart)

### Siparişler / Orders

- Sipariş Oluşturma (Create Order)
- Siparişleri Görüntüleme (View Orders)
- Sipariş Detayları (Order Details)
- Admin Tarafından Sipariş Durumunu Güncelleme (Admin - Update Order Status)

## Teknolojiler / Technologies

- **Backend**: Java with Servlet & JSP
- **Frontend**: HTML, CSS, JSTL
- **Database**: MySQL
- **Build Tool**: Maven
- **Architecture**: MVC (Model-View-Controller)

## Proje Yapısı / Project Structure

```
ECommerce_Portal/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/ecommerce/
│       │       ├── controller/     # Servlets (AuthController, ProductController, CartController, OrderController)
│       │       ├── dao/            # Data Access Objects (UserDAO, ProductDAO, CartDAO, OrderDAO, etc.)
│       │       ├── model/          # Entity Classes (User, Product, Category, Cart, Order, OrderDetail)
│       │       └── util/           # Utility Classes (DatabaseConnection)
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml         # Web Configuration
│           ├── css/
│           │   └── style.css       # Stylesheet
│           ├── js/
│           │   └── script.js       # JavaScript Files
│           ├── pages/
│           │   ├── login.jsp       # Login Page
│           │   ├── register.jsp    # Register Page
│           │   ├── products.jsp    # Products Listing
│           │   ├── product-detail.jsp
│           │   ├── cart.jsp        # Shopping Cart
│           │   ├── checkout.jsp    # Checkout
│           │   ├── orders.jsp      # My Orders
│           │   ├── order-detail.jsp
│           │   ├── header.jsp      # Header Component
│           │   └── footer.jsp      # Footer Component
│           └── index.jsp           # Home Page
├── sql/
│   └── schema.sql                  # Database Schema
└── pom.xml                         # Maven Configuration
```

## Veritabanı Kurulumu / Database Setup

1. MySQL'de yeni bir veritabanı oluşturun:

```sql
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
```

2. `sql/schema.sql` dosyasını çalıştırın:

```sql
source sql/schema.sql;
```

## Kurulum ve Çalıştırma / Installation and Running

### Ön Koşullar / Prerequisites

- Java 11 veya üstü (Java 11 or Higher)
- Maven 3.6+
- MySQL Server
- Apache Tomcat 9+

### Adımlar / Steps

1. **Veritabanı Bağlantısını Yapılandırın / Configure Database Connection**
   - `src/main/java/com/ecommerce/util/DatabaseConnection.java` dosyasını açın
   - MySQL bağlantı bilgilerini güncelleyin:

   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce_db";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "";
   ```

2. **Projeyi Derleyin / Build the Project**

   ```
   mvn clean install
   ```

3. **WAR Dosyasını Tomcat'e Deploy Edin / Deploy WAR to Tomcat**
   - `target/ecommerce-portal-1.0.0.war` dosyasını Tomcat'in `webapps` klasörüne kopyalayın
   - Tomcat sunucusunu başlatın

4. **Uygulamaya Erişin / Access the Application**
   ```
   http://localhost:8080/ecommerce-portal
   ```

## Kullanıcı Hesapları / User Accounts

### Test İçin / For Testing

- **Admin Kullanıcı / Admin User**:
  - Username: admin
  - Password: admin123
  - Aşağıdaki SQL sorgusu ile veritabanına ekleyin:

  ```sql
  INSERT INTO users (username, password, email, full_name, role)
  VALUES ('admin', 'admin123', 'admin@ecommerce.com', 'Administrator', 'ADMIN');
  ```

- **Normal Kullanıcı / Regular User**:
  - Kayıt sayfasından yeni hesap oluşturun

## Kontroller / Controllers

### AuthController (`/auth`)

- GET `?action=login` - Giriş sayfasını göster
- GET `?action=register` - Kayıt sayfasını göster
- GET `?action=logout` - Çıkış yap
- POST `action=login` - Giriş işlemi
- POST `action=register` - Kayıt işlemi

### ProductController (`/products`)

- GET - Tüm ürünleri listele
- GET `?action=view&id={id}` - Ürün detaylarını göster
- GET `?action=category&id={id}` - Kategoriye göre ürünleri listele
- GET `?action=search&keyword={keyword}` - Ürün ara
- POST `action=add` - Ürün ekle (Admin)
- POST `action=update` - Ürün güncelle (Admin)
- POST `action=delete` - Ürün sil (Admin)

### CartController (`/cart`)

- GET - Sepeti göster
- GET `?action=clear` - Sepeti temizle
- POST `action=add` - Sepete ürün ekle
- POST `action=remove` - Sepetten ürün çıkar
- POST `action=update` - Sepet miktarını güncelle

### OrderController (`/orders`)

- GET - Kullanıcının siparişlerini listele
- GET `?action=view&id={id}` - Sipariş detaylarını göster
- GET `?action=admin-list` - Tüm siparişleri listele (Admin)
- POST `action=checkout` - Sipariş oluştur
- POST `action=updateStatus` - Sipariş durumunu güncelle (Admin)

## Veri Erişim Nesneleri (DAOs) / Data Access Objects

- **UserDAO**: Kullanıcı işlemleri
- **ProductDAO**: Ürün işlemleri
- **CategoryDAO**: Kategori işlemleri
- **CartDAO**: Sepet işlemleri
- **OrderDAO**: Sipariş işlemleri
- **OrderDetailDAO**: Sipariş detayı işlemleri

## Model Sınıfları / Model Classes

- **User**: Kullanıcı bilgileri
- **Product**: Ürün bilgileri
- **Category**: Kategori bilgileri
- **Cart**: Sepet öğeleri
- **Order**: Sipariş bilgileri
- **OrderDetail**: Sipariş detayları

## Güvenlik Notları / Security Notes

- Parolalar mevcut olarak düz metin olarak depolanıyor. Üretim ortamında şifrelenmiş parolalar kullanın.
- Admin işlemleri için role kontrolleri yapılmaktadır.
- Session kontrolleri uygulanmıştır.

## Gelecek Geliştirmeler / Future Enhancements

- Parola şifreleme (Password Encryption)
- Payment Gateway Entegrasyonu (Payment Gateway Integration)
- Email Notifications
- Sepet ve Favoriler (Wishlist)
- Ürün Değerlendirmeleri (Product Reviews)
- Geliştirilmiş Admin Paneli (Advanced Admin Dashboard)
- Responsive Design Geliştirmeleri

## Lisans / License

Bu proje eğitim amaçlı olarak oluşturulmuştur.

---

**Geliştirici / Developer**: E-Commerce Team
**Son Güncelleme / Last Update**: 2024
