# FullStack ECommerce App - WorthShop

Bu proje, SwiftUI ile geliştirilen mobil arayüz ve Node.js/Express.js, PostgreSQL & JWT tabanlı backend entegrasyonu ile modern bir e-ticaret deneyimi sunar. Aşağıda, uygulamanın temel fonksiyonlarının kısa açıklamaları yer almaktadır.

---

## 1. Giriş Yap (Login)
**Açıklama:**
- "Welcome Back!" başlıklı ekranda kullanıcı adı (e-posta/telefon) ve şifre girilerek sisteme giriş yapılır.
- "Login" butonuna basıldığında bilgiler doğrulanır ve başarılı giriş sonrası kullanıcı anasayfaya veya profil ekranına yönlendirilir.

---

## 2. Kayıt Ol (Sign Up)
**Açıklama:**
- Henüz kayıtlı olmayan kullanıcılar, gerekli bilgileri girerek yeni hesap oluşturur.
- Hesap oluşturma adımlarında doğrulama (SMS/E-posta) ile hesap aktif hale getirilir.

---

## 3. Ürünleri Göster (View Products)
**Açıklama:**
- Anasayfa veya "My Products" sekmesinde, ürünlerin fotoğraf, isim ve fiyat bilgileri liste halinde görüntülenir.
- "New Arrivals" gibi bölümlerde öne çıkan ürünler vurgulanır.

---

## 4. Ürünlerin Detaylarını Görüntüle (View Product Details)
**Açıklama:**
- Listelenen ürünlerden birine tıklanarak, ürünün görseli, açıklaması ve fiyat bilgileri detay sayfasında sunulur.
- Kayıtlı olmayan kullanıcılar, sepete ekleme işlemi yapmadan önce giriş yapmaları gerektiği konusunda bilgilendirilir.

---

## 5. Sepete Ekle (Add to Cart)
**Açıklama:**
- Ürün detay sayfasındaki "Add to cart" butonuna basılarak seçilen ürün alışveriş sepetine eklenir.
- Ürün adedi, detay veya sepet ekranındaki seçeneklerle ayarlanabilir ve işlem sonrası sepet güncellenir.

---

## 6. Sepetten Kaldır (Remove from Cart)
**Açıklama:**
- Kullanıcı, sepet ekranında istemediği ürünü kaldırarak sepet içeriğini günceller.
- İşlem sonrasında sepetin toplam tutarı ve ürün adedi otomatik olarak yeniden hesaplanır.

---

## 7. Sepeti Görüntüle (View Cart)
**Açıklama:**
- Sepet ekranında eklenen ürünlerin isim, fiyat, adet ve toplam tutarı detaylı olarak gösterilir.
- Kullanıcı, "Proceed to checkout" butonuna basarak ödeme aşamasına geçebilir.

---

## 8. Checkout Sayfasını Görüntüle (View Checkout Page)
**Açıklama:**
- Sepet özetini, adres ve fatura bilgilerini içeren checkout sayfasına erişim sağlanır.
- Eksik bilgi durumunda kullanıcı ilgili ekrana yönlendirilir.

---

## 9. Ödeme Ekranını Görüntüle (View Payment Page)
**Açıklama:**
- Checkout işlemi sonrası, ödeme seçeneklerinin sunulduğu ekrana geçiş yapılır.
- Toplam tutar, vergi detayları ve ödeme seçenekleri net olarak gösterilir.

---

## 10. Stripe İle Ödeme (Online Payment via Stripe)
**Açıklama:**
- Kullanıcı, Stripe üzerinden kredi kartı bilgilerini girerek güvenli ödeme yapar.
- API entegrasyonu ve gerekirse 3D Secure doğrulama adımları ile ödeme işlemi tamamlanır.

---

## 11. Kredi Kartı İle Ödeme (Credit Card Payment)
**Açıklama:**
- Kullanıcı, uygulama içi form aracılığıyla kredi kartı bilgilerini (kart numarası, son kullanma tarihi, CVC) girerek ödeme yapar.
- Form validasyonu ve ödeme servisi entegrasyonu sayesinde işlem güvenle tamamlanır.

---

## 12. Profili Görüntüle (View Profile)
**Açıklama:**
- Kayıtlı müşteri, profil ekranında kullanıcı adı, adres ve diğer kişisel bilgilerini görüntüler.
- Profil ekranı üzerinden ayrıca bilgilerin güncellenmesi ve çıkış (signout) işlemi yapılabilir.

---

## 13. Profili Güncelle (Update Profile)
**Açıklama:**
- Kullanıcı, profilindeki kişisel bilgileri (isim, adres vb.) güncelleyerek veritabanına kaydeder.
- Güncelleme sırasında gerekli validasyonlar uygulanır ve hata durumunda kullanıcı bilgilendirilir.

---

## 14. Satıcının Ürün Panelini Görüntüle (Admin View Product Panel)
**Açıklama:**
- Satıcı, "Ürünlerim" gibi bir panel üzerinden kendi eklediği ürünlerin listesini görüntüler.
- Ürün özet bilgileri (isim, fiyat, görsel) ve yönetim aksiyonları (ekleme, düzenleme, silme) sunulur.

---

## 15. Satıcının Ürün Detayları Sayfasını Görüntüle (Admin View Product Details)
**Açıklama:**
- Satıcı, panelde listelenen bir ürünün detaylarına erişir.
- Ürün detay sayfasında açıklama, fiyat, isim ve görseller sunulur; düzenleme veya silme aksiyonları bulunur.

---

## 16. Satıcı Ürün Ekleme (Admin Add Product)
**Açıklama:**
- Satıcı, "Add Product" ekranı aracılığıyla yeni ürün ekler.
- Ürün adı, açıklaması, fiyatı ve görsel bilgileri girildikten sonra, doğrulama işlemi ile ürün sisteme eklenir.

---

## 17. Satıcı Ürün Silme (Admin Delete Product)
**Açıklama:**
- Satıcı, ürün detay sayfasında "Delete" butonunu kullanarak istenmeyen ürünü siler.
- Silme işlemi onay alındıktan sonra gerçekleştirilir ve ürün, sistemdeki listeden kaldırılır.
