import 'item_rental.dart';

class Lensa extends ItemRental {
  int focalLength;

  Lensa(super.nama, super.harga, super.deskripsi, super.tersedia, this.focalLength);

  @override
  String infoDetail() {
    return "Lensa: $getNama (Focal Length: ${focalLength}mm)\nDeskripsi: $getDeskripsi\nHarga: Rp $getHarga per hari";
  }
}
