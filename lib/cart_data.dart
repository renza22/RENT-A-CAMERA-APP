import 'models/item_rental.dart';

class CartData {
  static List<ItemRental> keranjang = [];

  static void tambahKeKeranjang(ItemRental item) {
    keranjang.add(item);
  }

  static void hapusDariKeranjang(ItemRental item) {
    keranjang.remove(item);
  }

  static void kosongkanKeranjang() {
    keranjang.clear();
  }
}
