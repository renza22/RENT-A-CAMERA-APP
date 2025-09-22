import 'package:flutter/material.dart';
import 'models/item_rental.dart';
import 'cart_data.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _returnOption = "Dijemput Kurir";

  int get totalHarga {
    return CartData.keranjang.fold(0, (sum, item) => sum + item.getHarga);
  }

  @override
  Widget build(BuildContext context) {
    final keranjang = CartData.keranjang;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pembayaran",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: keranjang.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text(
                    "Keranjang kosong,\nTidak ada yang bisa dibayar.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: keranjang.length,
                    itemBuilder: (context, index) {
                      final ItemRental item = keranjang[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.check_circle,
                              color: Colors.green, size: 30),
                          title: Text(
                            item.getNama,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Rp ${item.getHarga}/hari",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 🔹 Opsi Pengembalian Barang
                      Text(
                        "Opsi Pengembalian",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // ignore: deprecated_member_use
                      RadioListTile<String>(
                        title: const Text("Dijemput Kurir"),
                        value: "Dijemput Kurir",
                        // ignore: deprecated_member_use
                        groupValue: _returnOption,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _returnOption = value!;
                          });
                        },
                      ),
                      // ignore: deprecated_member_use
                      RadioListTile<String>(
                        title: const Text("Dikembalikan Sendiri"),
                        value: "Dikembalikan Sendiri",
                        // ignore: deprecated_member_use
                        groupValue: _returnOption,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _returnOption = value!;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // 🔹 Total Harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "Rp $totalHarga",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 🔹 Tombol Bayar
                      ElevatedButton.icon(
                        icon: const Icon(Icons.payment),
                        label: Text(
                          "Bayar Sekarang",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          // setelah bayar, kosongkan keranjang
                          CartData.kosongkanKeranjang();

                          // contoh: kirim pilihan opsi pengembalian
                          debugPrint("Opsi Pengembalian: $_returnOption");

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/success',
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
