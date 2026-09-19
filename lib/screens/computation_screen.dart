import 'package:flutter/material.dart';

class ComputationScreen extends StatefulWidget {
  const ComputationScreen({super.key});

  @override
  State<ComputationScreen> createState() => _ComputationScreenState();
}

class _ComputationScreenState extends State<ComputationScreen> {
  final _guestsController = TextEditingController();
  final _pricePerGuestController = TextEditingController(text: '75000');
  double _totalCost = 0;
  final double _decorCost = 15000000;

  void _calculate() {
    int guests = int.tryParse(_guestsController.text) ?? 0;
    double price = double.tryParse(_pricePerGuestController.text) ?? 0;
    setState(() {
      _totalCost = (guests * price * 2) + _decorCost; // Estimasi 2 porsi/tamu + Dekorasi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Komputasi Biaya Pernikahan')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _guestsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah Undangan (Tamu)', prefixIcon: Icon(Icons.people)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pricePerGuestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga Katering / Porsi (Rp)', prefixIcon: Icon(Icons.restaurant)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE91E63), foregroundColor: Colors.white),
              onPressed: _calculate,
              child: const Text('HITUNG ESTIMASI BIAYA'),
            ),
            const SizedBox(height: 24),
            if (_totalCost > 0)
              Card(
                color: Colors.pink.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text('Total Estimasi Anggaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text('Rp ${_totalCost.toStringAsFixed(0)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFE91E63))),
                      const SizedBox(height: 8),
                      const Text('*Termasuk Katering (2 porsi/tamu) & Dekorasi Standar', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}