import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuccessScreen extends StatefulWidget {
  final String deliveryMethod;

  const SuccessScreen({
    super.key,
    required this.deliveryMethod,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  double userRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Animasi icon success
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withValues(alpha: 0.1),
                ),
                padding: const EdgeInsets.all(24),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 120,
                ),
              ),
              const SizedBox(height: 30),

              // Judul sukses
              Text(
                "Pembayaran Berhasil!",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Deskripsi
              Text(
                "Barang Anda sedang diproses dan segera dikirim.\n"
                "Terima kasih sudah mempercayai layanan kami.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Informasi metode pengembalian
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Metode Pengembalian: ${widget.deliveryMethod}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Tombol kembali ke home
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                label: Text(
                  "Kembali ke Home",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
              ),

              const SizedBox(height: 50),

              // ⭐ Rating aplikasi
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 20),
              Text(
                "Bagaimana pengalamanmu dengan aplikasi ini?",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 32,
                unratedColor: Colors.grey.shade300,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  setState(() => userRating = rating);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Terima kasih! Kamu memberi rating ${rating.toStringAsFixed(1)} ⭐ untuk aplikasi ini.",
                        style: const TextStyle(color: Colors.white),
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
  }
}
