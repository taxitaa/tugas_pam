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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF5C88BF),
        title: Column(
          children: const [
            Text(
              'NAWASENA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 2,
                color: Color(0xFFFEE2E2),
              ),
            ),
            Text(
              'A Beautiful   Start to Forever',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Kelola persiapan pernikahan dengan praktis & rapi.',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            _buildMenuCard(
              context,
              icon: Icons.groups_rounded,
              title: 'Daftar Anggota Kelompok',
              subtitle: 'Informasi tim pengembang aplikasi',
              bgColor: const Color(0xFFE0F2FE),
              iconColor: const Color(0xFF0284C7),
              target: const MembersScreen(),
            ),
            _buildMenuCard(
              context,
              icon: Icons.calculate_outlined,
              title: 'Komputasi Estimasi Biaya',
              subtitle: 'Hitung katering & anggaran pesta',
              bgColor: const Color(0xFFFCE7F3),
              iconColor:const Color(0xFFF3C5C5),
              target: const ComputationScreen(),
            ),
            _buildMenuCard(
              context,
              icon: Icons.storefront_rounded,
              title: 'CRUD Layanan / Vendor',
              subtitle: 'Kelola data vendor & penyedia jasa',
              bgColor: const Color(0xFFE0F2FE),
              iconColor: const Color(0xFF0284C7),
              target: const VendorCrudScreen(),
            ),
            _buildMenuCard(
              context,
              icon: Icons.calendar_today_rounded,
              title: 'Perhitungan Pernikahan Weton',
              subtitle: 'Analisis kecocokan pernikahan berdasarkan kalender weton',
              bgColor: const Color(0xFFFCE7F3),
              iconColor: const Color(0xFFF3C5C5),
              target: const DateConverterScreen(mode: DateCalculatorMode.wetonMarriage),
            ),
            _buildMenuCard(
              context,
              icon: Icons.auto_awesome_outlined,
              title: 'Saka Bali & Adat Pernikahan',
              subtitle: 'Kalender Saka Bali dan rekomendasi adat pernikahan Bali',
              bgColor: const Color(0xFFE0F2FE),
              iconColor: const Color(0xFF0284C7),
              target: const DateConverterScreen(mode: DateCalculatorMode.sakaBaliMarriage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color bgColor,
    required Color iconColor,
    required Widget target,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF1E293B),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
        ),
      ),
    );
  }
}