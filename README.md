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

📡 Gerçek Zamanlı Veri Altyapısı:

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

Uygulama İçi Görüntüler
<img width="1080" height="1920" alt="Screenshot_1750177044" src="https://github.com/user-attachments/assets/0c7212b7-d325-4ecb-a28f-33bde9fdd30b" />

Öğrenci Kısmı
![success_attendance jpeg](https://github.com/user-attachments/assets/ab14bc87-0bf1-47f4-81da-bc74d9f3ad6c)
<img width="1080" height="1920" alt="ogrenci_profil" src="https://github.com/user-attachments/assets/735400b6-c10f-41e3-9b29-37e70690e3c2" />
<img width="1080" height="1920" alt="ogrenci_kayitt" src="https://github.com/user-attachments/assets/0590386f-fc94-452c-80eb-064cc41b8600" />
<img width<img width="1080" height="1920" alt="ogrenci_istekk" src="https://github.com/user-attachments/assets/a584a0ee-65b7-4b33-b32b-5e84ae720eb3" />
="1080" height="1920" alt="ogrenci_istekler" src="https://github.com/user-attachments/assets/a6d295a6-1450-4c97-af0f-45b8c82f3293" />

<img width="1080" height="1920" alt="ogrenci_gir<img width="1080" height="1920" alt="ogrenci_ders_detay2" src="https://github.com/user-attachments/assets/24bc0aa5-cb07-4625-8449-fc575be8d91e" />
is" src="https://github.com/user-attachments/assets/8f663f9d-c30f-4b93-b683-10a12cd198aa" />
![Uploading ogrenci_ders_detay2.png…]()

<img width="1080" height="1920" alt="ogrenci_ders_detay" src="https://github.com/user-attachments/assets/0c5efc2a-442b-415a-8f33-70f98155224c" />
<img width="1080" height="1920" alt="ogrenci_ana_ekran" src="https://github.com/user-attachments/assets/3be14634-894a-4744-941c-eaac9bab51e0" />
<img width="1080" height="1920" alt="istek_olusturma" src="https://github.com/user-attachments/assets/3e05c9fa-2d24-4d37-b6f1-85c520294af0" />
<img width="1080" height="1920" alt="giris" src="https://github.com/user-attachments/assets/1577e949-0dd9-44cd-b63b-c35287443908" />

Öğretmen Kısmı
<img width="1080" height="1920" alt="ogretmen_yoklama_baslat" src="https://github.com/user-attachments/assets/ce7f562a-1feb-4ae4-901c-f2f85cc16bfd" />
<img width="1080" height="1920" alt="ogretmen_profil" src="https://github.com/user-attachments/assets/7ca4f106-fd48-4198-bcd7-f2ddba99c1fa" />
<img width="1080" height="1920" alt="yoklama_rapor3" src="https://github.com/user-attachments/assets/556ab2cf-4efb-4596-945e-a56734a8f05b" />
<img width="1080" height="1920" alt="yoklama_rapor1" src="https://github.com/user-attachments/assets/d3928a4c-3204-4120-bba6-8f6fff37ffe0" />
<img width="1080" height="1920" alt="yoklama_disa_aktar" src="https://github.com/user-attachments/assets/1bc8209a-ddae-4348-914a-0fa3b8c6a8b1" />
<img width="1080" height="1920" alt="yoklama_detay_two" src="https://github.com/user-attachments/assets/b5de423b-1579-4bcb-bd7e-a164fde28e32" />
<img width="1080" height="1920" alt="yoklama_detay_one" src="https://github.com/user-attachments/assets/e933a967-7dc1-4505-b641-83bd2d45e5af" />
<img width="1080" height="1920" alt="yoklama_basladi" src="https://github.com/user-attachments/assets/a4766b78-91ff-4b51-8b38-f80fbc0287aa" />
<img width="1080" height="1920" alt="Screenshot_1750196233" src="https://github.com/user-attachments/assets/b24d740e-2c29-40a0-8e03-eb6dfa3187fa" />
<img width="1080" height="1920" alt="Screenshot_1750196082" src="https://github.com/user-attachments/assets/49d54105-3f5d-43ee-8b87-0ce1eafd3ac9" />
<img width="1080" height="1920" alt="Screenshot_1750191878" src="https://github.com/user-attachments/assets/08a5b144-2d11-4b84-8a69-071a7f020a99" />
<img width="1080" height="1920" alt="Screenshot_1748457708" src="https://github.com/user-attachments/assets/70e14055-5e39-43df-88e3-8f14f88a6486" />
<img width="1080" height="1920" alt="Screenshot_1748457286" src="https://github.com/user-attachments/assets/eaf397ca-8908-4a46-badc-b570f85e0afc" />




