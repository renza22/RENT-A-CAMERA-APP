abstract class ItemRental {
  final String _nama;
  final int _harga;
  final String _deskripsi;
  final bool _tersedia;

  ItemRental(this._nama, this._harga, this._deskripsi, this._tersedia);

  // Encapsulation: pakai getter
  String get getNama => _nama;
  int get getHarga => _harga;
  String get getDeskripsi => _deskripsi;
  bool get isTersedia => _tersedia;

  // Polymorphism: tiap subclass override method ini
  String infoDetail();

  @override
  String toString() {
    return "$_nama - Rp $_harga/hari (${_tersedia ? "Tersedia" : "Disewa"})";
  }
}
