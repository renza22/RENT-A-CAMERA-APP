import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'models/item_rental.dart';
import 'models/camera.dart';
import 'models/lensa.dart';
import 'models/aksesoris.dart';
import 'cart.dart';
import 'package:google_fonts/google_fonts.dart';

// notifier global untuk jumlah item di cart
ValueNotifier<int> cartCount = ValueNotifier<int>(0);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text("Ya, Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<ItemRental>> kategori = {
      "Kamera": [
        Camera("Canon EOS 5D", 500000, "Kamera mirrorless full-frame", true),
        Camera("Sony A7 III", 400000, "Kamera mirrorless untuk videografi", false),
        Camera("Fujifilm X-T4", 350000, "Kamera mirrorless APS-C untuk foto & video", true),
        Camera("Nikon Z6 II", 380000, "Kamera mirrorless full-frame Nikon", true),
      ],
      "Lensa": [
        Lensa("Sony FE 24-70mm", 150000, "Lensa zoom serbaguna", true, 70),
        Lensa("Canon RF 50mm f/1.8", 120000, "Lensa fix dengan bokeh indah", true, 50),
        Lensa("Fujinon XF 16-55mm", 130000, "Lensa kit premium Fujifilm", false, 55),
      ],
      "Mic": [
        Aksesoris("Rode VideoMic Pro", 100000, "Mic shotgun untuk kamera", true, "Microphone"),
        Aksesoris("BOYA BY-M1", 50000, "Mic clip-on untuk smartphone & kamera", true, "Microphone"),
        Aksesoris("Zoom H1n", 150000, "Recorder portable untuk audio profesional", false, "Recorder"),
      ],
      "Tripod": [
        Aksesoris("Tripod Manfrotto", 50000, "Tripod untuk kamera DSLR/Mirrorless", true, "Tripod"),
        Aksesoris("GorillaPod 3K", 60000, "Tripod fleksibel untuk vlog", true, "Tripod"),
        Aksesoris("Weifeng WT-3110A", 40000, "Tripod budget untuk pemula", false, "Tripod"),
      ],
    };

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            title: Text(
              "Rental Items",
              style: GoogleFonts.robotoSlab(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.indigo,
            actions: [
              ValueListenableBuilder<int>(
                valueListenable: cartCount,
                builder: (context, value, child) {
                  return IconButton(
                    icon: badges.Badge(
                      showBadge: value > 0,
                      badgeContent: Text(
                        value.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                      ),
                      child: const Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    tooltip: "Keranjang",
                    onPressed: () async {
                      // buka halaman cart
                      await Navigator.pushNamed(context, '/cart');
                      // update count setelah balik dari cart
                      cartCount.value = Cart.items.length;
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                tooltip: "Logout",
                onPressed: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
          ListView.builder(
            itemCount: kategori.length,
            itemBuilder: (context, kategoriIndex) {
              final kategoriNama = kategori.keys.elementAt(kategoriIndex);
              final items = kategori[kategoriNama]!;

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 600 + (kategoriIndex * 200)),
                curve: Curves.easeOut,
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 20),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Card(
                    color: Colors.white.withValues(alpha: 0.9),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ExpansionTile(
                      leading: const Icon(Icons.category, color: Colors.indigo),
                      title: Text(
                        kategoriNama,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      children: [
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return TweenAnimationBuilder<double>(
                              duration: Duration(milliseconds: 500 + (index * 150)),
                              curve: Curves.easeOut,
                              tween: Tween(begin: 0, end: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, (1 - value) * 15),
                                    child: child,
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.indigo.shade100,
                                    child: const Icon(Icons.photo_camera, color: Colors.indigo),
                                  ),
                                  title: Text(
                                    item.getNama,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    "Rp ${item.getHarga}/hari",
                                    style: TextStyle(
                                      color: item.isTersedia ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add_shopping_cart, color: Colors.indigo),
                                    onPressed: () {
                                      if (item.isTersedia) {
                                        Cart.tambah(item);
                                        cartCount.value = Cart.items.length; // update badge
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("${item.getNama} ditambahkan ke keranjang"),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text("${item.getNama} sedang tidak tersedia"),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/detail', arguments: item);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
