import 'package:flutter/material.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedDelivery; // pilihan user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metode Pembayaran"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Metode Pengantaran:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // RadioGroup: groupValue + onChanged wajib, child menampung Radio
            RadioGroup<String>(
              groupValue: _selectedDelivery,
              onChanged: (value) => setState(() => _selectedDelivery = value),
              child: Column(
                children: [
                  ListTile(
                    leading: Radio<String>(value: 'Dijemput Kurir'),
                    title: const Text('Dijemput Kurir'),
                    onTap: () => setState(() => _selectedDelivery = 'Dijemput Kurir'),
                  ),
                  ListTile(
                    leading: Radio<String>(value: 'Diantar Sendiri'),
                    title: const Text('Diantar Sendiri'),
                    onTap: () => setState(() => _selectedDelivery = 'Diantar Sendiri'),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDelivery == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessScreen(
                              deliveryMethod: _selectedDelivery!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
