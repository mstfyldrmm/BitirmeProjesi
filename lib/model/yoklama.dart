class Yoklama {
  DateTime? alinanTarih;
  List<Ogrenci>? katilanOgrenciler;

  Yoklama(this.alinanTarih, this.katilanOgrenciler);
}

class Ogrenci {
  final String adi;
  final String soyadi;
  final int numara;

  Ogrenci(this.numara, {required this.adi, required this.soyadi});
}

List<Ogrenci> ogrenciler = List.generate(
  100,
  (index) => Ogrenci(
    1000 + index, // 1000’den başlayarak numara veriyoruz
    adi: "Öğrenci${index + 1}",
    soyadi: "Soyad${index + 1}",
  ),
);

// Rastgele 50 öğrenci seçen fonksiyon
List<Ogrenci> rastgeleOgrenciSec(int adet) {
  ogrenciler.shuffle(); // Listeyi karıştır
  return ogrenciler.take(adet).toList();
}

// 5 farklı yoklama oluştur
List<Yoklama> yoklamaListesi = [
  Yoklama(DateTime(2024, 3, 1), rastgeleOgrenciSec(50)),
  Yoklama(DateTime(2024, 3, 3), rastgeleOgrenciSec(50)),
  Yoklama(DateTime(2024, 3, 5), rastgeleOgrenciSec(50)),
  Yoklama(DateTime(2024, 3, 7), rastgeleOgrenciSec(50)),
  Yoklama(DateTime(2024, 3, 9), rastgeleOgrenciSec(50)),
];
