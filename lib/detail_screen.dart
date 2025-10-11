import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart' as badges;

import 'models/item_rental.dart';
import 'models/camera.dart';
import 'models/lensa.dart';
import 'models/aksesoris.dart';
import 'cart_data.dart';

ValueNotifier<int> cartCount = ValueNotifier<int>(0); // <-- tambahkan ini jika belum ada

class DetailScreen extends StatefulWidget {
  final ItemRental item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  IconData _getIconForItem(ItemRental item) {
    if (item is Camera) return Icons.camera_alt;
    if (item is Lensa) return Icons.camera;
    if (item is Aksesoris) {
      if (item.getJenis.toLowerCase() == "tripod") return Icons.camera_roll;
      if (item.getJenis.toLowerCase().contains("mic")) return Icons.mic;
      if (item.getJenis.toLowerCase().contains("recorder")) return Icons.record_voice_over;
    }
    return Icons.category;
  }

  String? _getImageForItem(ItemRental item) {
    final Map<String, String> imageMap = {
      "Canon EOS 5D": "assets/canon_5d.jpg",
      "Sony A7 III": "assets/sony_camera.jpg",
      "Fujifilm X-T4": "assets/fujifilm_camera.jpg",
      "Nikon Z6 II": "assets/nikon_camera.jpg",
      "Sony FE 24-70mm": "assets/sony_lensa.jpg",
      "Canon RF 50mm f/1.8": "assets/lensa_24_70.jpg",
      "Fujinon XF 16-55mm": "assets/fujifilm_lensa.jpg",
      "Rode VideoMic Pro": "assets/mic.jpg",
      "BOYA BY-M1": "assets/boya.jpg",
      "Zoom H1n": "assets/zoom.jpg",
      "Tripod Manfrotto": "assets/trippod.jpg",
      "GorillaPod 3K": "assets/gorillapod.jpg",
      "Weifeng WT-3110A": "assets/yunteng.jpg",
    };
    return imageMap[item.getNama];
  }

  void _showSnackBar(String message, bool success) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: success ? 'Berhasil!' : 'Gagal!',
        message: message,
        contentType: success ? ContentType.success : ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final imagePath = _getImageForItem(item);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Detail Item",
          style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    badgeColor: Colors.redAccent,
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                  cartCount.value = CartData.keranjang.length; // update badge saat kembali
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6F9FC), Color(0xFFE3EDF7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imagePath != null
                          ? Image.asset(imagePath, height: 220, fit: BoxFit.cover)
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .scaleXY(begin: 0.8, end: 1.0, duration: 600.ms)
                          : Icon(
                              _getIconForItem(item),
                              size: 100,
                              color: Colors.blueAccent,
                            ).animate().fadeIn(duration: 600.ms),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item.infoDetail(),
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87, height: 1.5),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 800.ms),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: item.isTersedia
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.isTersedia ? "Status: Tersedia" : "Status: Disewa",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: item.isTersedia ? Colors.green : Colors.redAccent,
                        ),
                      ),
                    ).animate().fadeIn(duration: 1000.ms),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (item.isTersedia) {
                            CartData.tambahKeKeranjang(item);
                            cartCount.value = CartData.keranjang.length; // update badge
                            _showSnackBar("${item.getNama} ditambahkan ke keranjang", true);
                          } else {
                            _showSnackBar("${item.getNama} sedang tidak tersedia", false);
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: Text(
                          "Sewa Sekarang",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          elevation: 6,
                        ),
                      ).animate().fadeIn(duration: 1200.ms),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
