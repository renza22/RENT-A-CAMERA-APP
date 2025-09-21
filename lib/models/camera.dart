import 'item_rental.dart';

class Camera extends ItemRental {
  Camera(super.nama, super.harga, super.deskripsi, super.tersedia);
      

  @override
  String infoDetail() {
    return "Kamera: $getNama\nDeskripsi: $getDeskripsi\nHarga: Rp $getHarga per hari";
  }
}
