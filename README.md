📱 QR Kod Tabanlı Mobil Yoklama Sistemi
Bu proje, üniversite derslerinde geleneksel yoklama yöntemlerinin yerine geçen, QR kod ve konum doğrulama (GPS) tabanlı, gerçek zamanlı, mobil bir yoklama sistemi sunmaktadır. Öğrencilerin ders sırasında yoklamaya katılımını güvenli ve hızlı hale getiren bu sistem, öğretmen ve öğrenci rollerini aynı uygulama üzerinden yönetebilecek şekilde Flutter ile geliştirilmiştir. Uygulama Android ve iOS platformlarında çalışacak şekilde tasarlanmıştır.

🚀 Temel Amaç
Sahte katılımın önlenmesi (başkası adına yoklama, fotoğrafla QR paylaşımı, uzaktan tarama vb.)

Gerçek zamanlı veri yönetimi ve eş zamanlı yoklama takibi

Öğrenci ve öğretmen arasında etkili ve pratik bir yoklama süreci sunmak

🎯 Öne Çıkan Özellikler
🕒 Dinamik QR Kod Üretimi:
Her yoklama başlangıcında, öğretmen tarafından sistem üzerinden yalnızca belirli saniyeler boyunca geçerli olacak şekilde dinamik olarak değişen QR kodlar oluşturulur. Bu QR kodlar Firebase Hosting üzerinden web sayfasında yayınlanır ve öğrenciler tarafından mobil uygulama aracılığıyla taranarak yoklamaya katılım sağlanır. Dinamik yapısı sayesinde, daha önceki derslere ait QR kodların ya da geçmiş oturumlarda kullanılan kodların okutulması engellenir. Böylece yalnızca aktif ders ve belirlenen süre içinde geçerli olan kodlarla yoklama alınarak güvenlik artırılır

📍 Konum Doğrulama:
Öğrencinin konumu, QR kodda gömülü öğretmen konumuna göre kontrol edilir. Konum farkı 100 metreden fazla ise yoklama kabul edilmez. Böylece fiziksel katılım zorunlu hale getirilir.

🔐 Mock Location & Root Tespiti:
Sahte konum uygulamaları (mock location) ve root erişimli cihazlar tespit edilerek sistemden dışlanır. Bu sayede katılım manipülasyonları önlenir.

📡 Gerçek Zamanlı Veri Altyapısı:<img width="1080" height="1920" alt="giris" src="https://github.com/user-attachments/assets/53b8a299-33a7-4e87-a923-917dceaca98b" />

Firebase Realtime Database ile kullanıcılar, yoklamalar, dersler, talepler gibi tüm veriler senkronize edilir.

📂 Excel Entegrasyonu:
Öğretmen, yeni ders oluştururken derse ait öğrenci bilgi sisteminin çıktısı (.xlsx uzantılı) ile oluşturur.  Dosya kontrolü sistem tarafından yapılır ve uygun formatta ise otomatik ders kaydı gerçekleşir.

📄 PDF Raporlama:
Geçmişe ait yoklamalar ve derse devam durumu analiz edilir, sistemden PDF olarak dışa aktarılabilir ve e-posta/paylaşım yoluyla iletilebilir.

📲 Tek Uygulama, Çoklu Rol Desteği:
Aynı uygulama üzerinden öğrenci ve öğretmen ayrı rollerle giriş yapabilir. Her role özel arayüz ve yetki alanı tanımlanmıştır.

🛠️ Kullanılan Teknolojiler
Katman	Araç / Teknoloji
Mobil UI	Flutter, Dart
Backend	Firebase Firestore, Firebase Auth, Firebase Hosting, Firebase Storage
Konum	geolocator
QR Kod	mobile_scanner, qr_flutter
Dosya İşlemleri	file_picker, excel
Raporlama	pdf, printing, share_plus
Erişim Yönetimi	permission_handler
Durum Yönetimi	provider, get_it
Çoklu Dil	easy_localization

👤 Kullanım Senaryoları
🧑‍🎓 Öğrenci:
Üniversite mailiyle kayıt olur, giriş yapar.

Kayıtlı dersleri ve geçmiş yoklamaları görüntüler.

Yoklama anında QR kodu tarar ve konum kontrolü geçerse yoklamaya katılır.

Ders kaydı veya yoklama sorunu için talep oluşturur.

👨‍🏫 Öğretmen:
Üniversite mailiyle kayıt olur, giriş yapar.

Ders oluşturur (Excel dosyasıyla).

QR kodlu yoklama başlatır, süresini belirler.

Geçmiş yoklamaları PDF olarak dışa aktarır.

Derse devam durumunu analiz edip PDF olarak dışa aktarır.

Gelen talepleri onaylar ve yönetir.
