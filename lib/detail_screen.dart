import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'models/item_rental.dart';
import 'models/camera.dart';
import 'models/lensa.dart';
import 'models/aksesoris.dart';
import 'cart_data.dart';

class DetailScreen extends StatefulWidget {
  final ItemRental item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double userRating = 0;

  /// Icon fallback kalau gak ada gambar
  IconData _getIconForItem(ItemRental item) {
    if (item is Camera) return Icons.camera_alt;
    if (item is Lensa) return Icons.camera;
    if (item is Aksesoris) {
      if (item.getJenis.toLowerCase() == "tripod") return Icons.camera_roll;
      if (item.getJenis.toLowerCase().contains("mic")) return Icons.mic;
      if (item.getJenis.toLowerCase().contains("recorder")) {
        return Icons.record_voice_over;
      }
    }
    return Icons.category;
  }

  /// Mapping merk → file gambar
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
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
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
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Bagian gambar / icon fallback
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imagePath != null
                          ? Image.asset(
                              imagePath,
                              height: 180,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              _getIconForItem(item),
                              size: 100,
                              color: Colors.blueAccent,
                            ),
                    ),
                    const SizedBox(height: 20),

                    // Nama Item
                    Text(
                      item.getNama,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    // ⭐ Rating interaktif
                    Column(
                      children: [
                        RatingBar.builder(
                          initialRating: 4.0,
                          minRating: 1,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          unratedColor: Colors.grey.shade300,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              userRating = rating;
                            });
                          },
                        ),
                        const SizedBox(height: 6),
                        Text(
                          userRating == 0
                              ? "Belum diberi rating"
                              : "Rating kamu: ${userRating.toStringAsFixed(1)}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Harga
                    Text(
                      "Rp ${item.getHarga}/hari",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Detail info
                    Text(
                      item.infoDetail(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // Status tersedia
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: item.isTersedia
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.isTersedia ? "Status: Tersedia" : "Status: Disewa",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              item.isTersedia ? Colors.green : Colors.redAccent,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Tombol sewa
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (item.isTersedia) {
                            CartData.tambahKeKeranjang(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${item.getNama} ditambahkan ke keranjang"),
                                action: SnackBarAction(
                                  label: "Lihat Keranjang",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/cart');
                                  },
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${item.getNama} sedang tidak tersedia"),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: Text(
                          "Sewa Sekarang",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          elevation: 4,
                        ),
                      ),
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
