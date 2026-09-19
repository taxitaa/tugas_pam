import 'package:flutter/material.dart';

class ComputationScreen extends StatefulWidget {
  const ComputationScreen({super.key});

  @override
  State<ComputationScreen> createState() => _ComputationScreenState();
}

class _ComputationScreenState extends State<ComputationScreen> {
  final _guestController = TextEditingController();
  final _priceController = TextEditingController(text: '75000');
  final _venueController = TextEditingController(text: '15000000');
  final _decorController = TextEditingController(text: '12000000');

  double? _cateringTotal;
  double? _venueTotal;
  double? _decorTotal;
  double? _grandTotal;

  void _calculate() {
    final guests = double.tryParse(_guestController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    final venue = double.tryParse(_venueController.text) ?? 0;
    final decor = double.tryParse(_decorController.text) ?? 0;

    final catering = guests * price * 2;
    final venueTotal = venue;
    final decorTotal = decor;

    setState(() {
      _cateringTotal = catering;
      _venueTotal = venueTotal;
      _decorTotal = decorTotal;
      _grandTotal = catering + venueTotal + decorTotal;
    });
  }

  Widget _summaryRow(String label, double? value, {bool isTotal = false}) {
    final formatted = 'Rp ${(value ?? 0).toStringAsFixed(0)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFF1E293B) : const Color(0xFF475569),
          ),
        ),
        Text(
          formatted,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFFF472B6) : const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Komputasi Biaya Pernikahan'),
        backgroundColor: const Color(0xFF5C88BF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _guestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Undangan (Tamu)',
                prefixIcon: const Icon(Icons.people_outline_rounded, color: Color(0xFF5C88BF)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Katering / Porsi (Rp)',
                prefixIcon: const Icon(Icons.restaurant_outlined, color: Color(0xFF5C88BF)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _venueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Biaya Gedung / Venue (Rp)',
                prefixIcon: const Icon(Icons.location_city_outlined, color: Color(0xFF5C88BF)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _decorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Biaya Dekorasi (Rp)',
                prefixIcon: const Icon(Icons.auto_awesome_outlined, color: Color(0xFF5C88BF)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C88BF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'HITUNG ESTIMASI BIAYA',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            ),
            if (_grandTotal != null) ...[
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE7F3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF472B6).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _summaryRow('Biaya Katering', _cateringTotal),
                    const SizedBox(height: 8),
                    _summaryRow('Biaya Gedung', _venueTotal),
                    const SizedBox(height: 8),
                    _summaryRow('Biaya Dekorasi', _decorTotal),
                    const Divider(height: 20, thickness: 1),
                    _summaryRow('TOTAL SEMUA BIAYA', _grandTotal, isTotal: true),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}