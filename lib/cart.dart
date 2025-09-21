import 'models/item_rental.dart';
import 'cart_data.dart';

/// Wrapper untuk mengakses keranjang melalui CartData
class Cart {
  static List<ItemRental> get items => CartData.keranjang;

  static void tambah(ItemRental item) {
    CartData.tambahKeKeranjang(item);
  }

  static void hapus(ItemRental item) {
    CartData.hapusDariKeranjang(item);
  }

  static void kosongkan() {
    CartData.kosongkanKeranjang();
  }
}
