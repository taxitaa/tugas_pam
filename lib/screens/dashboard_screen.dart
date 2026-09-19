import 'package:flutter/material.dart';
import 'members_screen.dart';
import 'computation_screen.dart';
import 'vendor_crud_screen.dart';
import 'date_converter_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventSmart Wedding Planner', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFE91E63),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Menu Utama',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFE91E63)),
              ),
              const SizedBox(height: 20),

              // 5 Menu Vertikal
              _buildMenuButton(
                context,
                icon: Icons.people_alt_rounded,
                title: 'Daftar Anggota Kelompok',
                color: Colors.pink.shade400,
                target: const MembersScreen(),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                icon: Icons.calculate_rounded,
                title: 'Komputasi Estimasi Biaya',
                color: Colors.pink.shade500,
                target: const ComputationScreen(),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                icon: Icons.inventory_2_rounded,
                title: 'CRUD Layanan / Vendor',
                color: Colors.pink.shade600,
                target: const VendorCrudScreen(),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                icon: Icons.calendar_month_rounded,
                title: 'Konversi Tanggal & Weton',
                color: Colors.pink.shade700,
                target: const DateConverterScreen(),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                icon: Icons.auto_awesome_rounded,
                title: 'Saka Bali & Adat Pernikahan',
                color: Colors.pink.shade800,
                target: const DateConverterScreen(initialTab: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, {required IconData icon, required String title, required Color color, required Widget target}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
      ),
      icon: Icon(icon, size: 28),
      label: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
    );
  }
}