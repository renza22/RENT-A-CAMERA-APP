import 'item_rental.dart';

class Aksesoris extends ItemRental {
  final String _jenis;

  Aksesoris(super.nama, super.harga, super.deskripsi, super.tersedia, this._jenis);
      

  String get getJenis => _jenis;

  @override
  String infoDetail() {
    return "Aksesoris ($_jenis): $getNama\nDeskripsi: $getDeskripsi\nHarga: Rp $getHarga per hari";
  }
}
