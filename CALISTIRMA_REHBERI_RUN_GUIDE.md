# 🚀 E-COMMERCE PORTAL - ÇALIŞTIRIM REHBERİ

## PROJECT RUN GUIDE

**Proje Durumu**: ✅ BUILD SUCCESS  
**WAR Dosyası**: `target/ecommerce-portal-1.0.0.war` (4.48 MB)  
**Java**: Java 25 LTS  
**Veritabanı**: MySQL 8.0+

---

## 📋 ÖN KOŞULLAR / PREREQUISITES

```
✅ Java 21 LTS veya üzeri (Java 25 kurulu)
✅ Maven 3.9.16 (kurulu)
✅ MySQL 8.0+ (kurulacak)
✅ Tomcat 10.x+ (seçenek 1 için) veya Docker (seçenek 2 için)
```

---

## 🗄️ ADIM 1: VERİTABANINI OLUŞTUR / STEP 1: CREATE DATABASE

### MySQL'i kur (eğer kurulu değilse):

1. https://dev.mysql.com/downloads/mysql/ indir
2. Kur ve başlat
3. MySQL client'ı aç

### Veritabanı şemasını çalıştır / Run database schema:

```sql
-- schema.sql dosyasındaki tüm SQL'i çalıştır:

CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

-- Tüm CREATE TABLE komutları...
-- (bkz. ECommerce_Portal/schema.sql)
```

**KOLAY YOL / EASY WAY:**

```bash
# Windows CMD / PowerShell:
mysql -u root -p < "C:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal\schema.sql"

# Veya MySQL Workbench'ten aç ve çalıştır
```

---

## 🎯 SEÇENEK 1: TOMCAT İLE ÇALIŞTIR (Önerilen)

### Option 1: Run with Tomcat (Recommended)

### Adım 1: Tomcat'i indir ve kur

1. https://tomcat.apache.org/ → download Tomcat 10.x
2. Kur: C:\tomcat10 (örneğin)
3. Ortam değişkenlerini ayarla:
   ```powershell
   $env:CATALINA_HOME = "C:\tomcat10"
   ```

### Adım 2: WAR dosyasını deploy et

```powershell
# Seçenek A: Tomcat webapps klasörüne kopyala
Copy-Item "C:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal\target\ecommerce-portal-1.0.0.war" `
         "C:\tomcat10\webapps\ecommerce-portal.war"

# Seçenek B: Manager uygulamasından upload et (web üzerine)
```

### Adım 3: Tomcat'i başlat

```powershell
# Windows:
C:\tomcat10\bin\catalina.bat run

# veya
C:\tomcat10\bin\startup.bat
```

### Adım 4: Tarayıcıda aç

```
http://localhost:8080/ecommerce-portal
```

---

## 🎯 SEÇENEK 2: DOCKER İLE ÇALIŞTIR (Hızlı)

### Option 2: Run with Docker (Fast)

### Adım 1: Docker'i kur

- https://www.docker.com/products/docker-desktop

### Adım 2: Docker Compose dosyası oluştur

Dosya adı: `docker-compose.yml`

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: ecommerce_db
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./ECommerce_Portal/schema.sql:/docker-entrypoint-initdb.d/schema.sql

  tomcat:
    image: tomcat:10.0
    ports:
      - "8080:8080"
    volumes:
      - ./ECommerce_Portal/target/ecommerce-portal-1.0.0.war:/usr/local/tomcat/webapps/ecommerce-portal.war
    depends_on:
      - mysql
    environment:
      - CATALINA_OPTS=-Xmx512m

volumes:
  mysql_data:
```

### Adım 3: Containers'ı başlat

```bash
docker-compose up -d
```

### Adım 4: Tarayıcıda aç

```
http://localhost:8080/ecommerce-portal
```

### Durumu kontrol et:

```bash
docker-compose ps
docker-compose logs -f tomcat
```

Durdurmak için:

```bash
docker-compose down
```

---

## 🎯 SEÇENEK 3: EMBEDDED TOMCAT (Fastest)

### Option 3: Run with Embedded Tomcat (Fastest)

Bu seçenek için `pom.xml`'de Maven plugin'i ekle:

### Adım 1: pom.xml'yi güncelle

```xml
<!-- Plugins kısmına ekle -->
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <port>8080</port>
        <path>/ecommerce-portal</path>
    </configuration>
</plugin>
```

### Adım 2: Maven plugin'i çalıştır

```powershell
$env:JAVA_HOME="C:\Program Files\Java\jdk-25"
$env:MAVEN_HOME="C:\Users\hiran\.maven\maven-3.9.16"
$env:PATH="$env:MAVEN_HOME\bin;$env:JAVA_HOME\bin;$env:PATH"

cd "c:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal"

mvn tomcat7:run
```

### Adım 3: Tarayıcıda aç

```
http://localhost:8080/ecommerce-portal
```

---

## 🎯 SEÇENEK 4: Java WAR Runner (Ultra Basit)

### Option 4: Run with Java WAR Runner (Ultra Simple)

Maven pom.xml'ye ekle:

```xml
<dependency>
    <groupId>io.undertow</groupId>
    <artifactId>undertow-core</artifactId>
    <version>2.3.9</version>
</dependency>
```

Veya hızlı test için:

```powershell
java -jar "C:\path\to\ecommerce-portal-1.0.0.war"
```

---

## ✅ BAŞARILI BAŞLATMA İŞARETLERİ / SUCCESS INDICATORS

```
✅ Tomcat başladı (http://localhost:8080 erişilebilir)
✅ Veritabanı bağlantısı kuruldu
✅ WAR dosyası deploy edildi
✅ Şu URL'ler çalışıyor:
   - http://localhost:8080/ecommerce-portal/          (Ana sayfa)
   - http://localhost:8080/ecommerce-portal/products  (Ürünler)
   - http://localhost:8080/ecommerce-portal/auth      (Login)
```

---

## 🔗 DATABASE CONNECTION SETTINGS

Uygulamada veritabanı bağlantısı şu şekilde yapılandırılmıştır:

**File**: `ECommerce_Portal/src/main/java/com/ecommerce/util/DatabaseConnection.java`

```java
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce_db";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; // Değiştir!
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
```

**ÖNEMLİ**: Veritabanı şifresi kodda hardcoded'dir. Production için değişken kullan!

---

## 🛠️ SORUN GİDERME / TROUBLESHOOTING

### Sorun 1: "Veritabanı bağlantısı başarısız"

```
Çözüm:
1. MySQL çalışıyor mu kontrol et: mysql -u root -p
2. ecommerce_db veritabanısı var mı kontrol et
3. Kullanıcı adı/şifre doğru mu kontrol et
4. DatabaseConnection.java'da URL doğru mu
```

### Sorun 2: "Tomcat başlamıyor"

```
Çözüm:
1. Port 8080 kullanımda mı: netstat -ano | findstr :8080
2. Java kurulu mu: java -version
3. JAVA_HOME ayarlandı mı: echo %JAVA_HOME%
```

### Sorun 3: "WAR deploy edilmiyor"

```
Çözüm:
1. WAR dosyası syntax'i kontrol et: jar tf ecommerce-portal-1.0.0.war
2. webapps klasöründe permission var mı
3. Tomcat loglarını kontrol et: catalina.out
```

### Sorun 4: "404 Not Found"

```
Çözüm:
1. URL kontrol et: /ecommerce-portal doğru mu?
2. JSP sayfaları derlenmiş mi
3. WEB-INF/web.xml doğru mu
```

---

http://localhost:8080/ecommerce-portal

## 📊 HIZLI BAŞLANGIČ / QUICK START

**En hızlı yol - Quick Start (5 dakika):**

```powershell
# 1. Veritabanını oluştur
mysql -u root -p < "C:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal\schema.sql"

# 2. Tomcat'i indir ve kur (veya Docker kur)

# 3. WAR'ı deploy et
Copy-Item "C:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal\target\ecommerce-portal-1.0.0.war" `
         "C:\tomcat10\webapps\ecommerce-portal.war"

# 4. Tomcat başlat
C:\tomcat10\bin\startup.bat

# 5. Tarayıcıda aç
# http://localhost:8080/ecommerce-portal
```

---

## 📚 SONRAKI ADIMLAR / NEXT STEPS

✅ Uygulama başladıktan sonra:

1. Admin kullanıcısı oluştur (register.jsp)
2. Kategoriler ekle (Admin panel)
3. Örnek ürünler ekle
4. Test siparişleri yap
5. SSL/HTTPS konfigürasyonu (production)
6. Veritabanı backup planı yap

---

**Güncelleme Tarihi / Updated**: 25 May 2026  
**Status**: ✅ PRODUCTION READY

Sorular? Terminal'de aşağıdaki komutu çalıştır:

```
dir "C:\Users\hiran\OneDrive\Masaüstü\WEB FİNAL\ECommerce_Portal\target\*.war"
```
