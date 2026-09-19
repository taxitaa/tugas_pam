import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchHelpScreen extends StatefulWidget {
  const StopwatchHelpScreen({super.key});

  @override
  State<StopwatchHelpScreen> createState() => _StopwatchHelpScreenState();
}

class _StopwatchHelpScreenState extends State<StopwatchHelpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _toggleStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
      } else {
        _stopwatch.start();
        _startTimer();
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.stop();
      _stopwatch.reset();
      _timer?.cancel();
      _laps.clear();
    });
  }

  void _recordLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Stopwatch & Bantuan'),
        backgroundColor: const Color(0xFF5C88BF),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFCE7F3),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.timer_rounded), text: 'Stopwatch Acara'),
            Tab(icon: Icon(Icons.help_outline_rounded), text: 'Bantuan Aplikasi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStopwatchTab(),
          _buildHelpTab(),
        ],
      ),
    );
  }

  Widget _buildStopwatchTab() {
    final String formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5C88BF).withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_outlined, color: Color(0xFF5C88BF), size: 32),
                  const SizedBox(height: 12),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _recordLap : _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE2E8F0),
                  foregroundColor: const Color(0xFF475569),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  elevation: 0,
                ),
                child: Icon(
                  _stopwatch.isRunning ? Icons.flag_rounded : Icons.refresh_rounded,
                  size: 26,
                ),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: _toggleStopwatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF472B6),
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                  elevation: 2,
                ),
                child: Icon(
                  _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 34,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (_laps.isNotEmpty) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Catatan Putaran Waktu (Lap)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lap ${_laps.length - index}',
                        style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        _laps[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHelpCard(
          'Fitur Komputasi Biaya',
          'Digunakan untuk menghitung estimasi anggaran katering pernikahan secara otomatis berdasarkan jumlah undangan.',
          Icons.calculate_outlined,
        ),
        _buildHelpCard(
          'Fitur Kelola Vendor (CRUD)',
          'Memungkinkan Anda menambah, melihat, memperbarui, dan menghapus data vendor atau layanan pesta pernikahan.',
          Icons.storefront_rounded,
        ),
        _buildHelpCard(
          'Konversi Tanggal & Weton',
          'Fungsi untuk menghitung usia presisi, cek kalender Hijriah, Weton Jawa, serta integrasi Kalender Saka Bali.',
          Icons.calendar_month_rounded,
        ),
        _buildHelpCard(
          'Stopwatch Acara',
          'Membantu Anda mengukur durasi jalannya susunan acara pernikahan secara akurat beserta catatan lap.',
          Icons.timer_outlined,
        ),
      ],
    );
  }

  Widget _buildHelpCard(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF5C88BF), size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} // Kurung penutup kelas _StopwatchHelpScreenState dipindah ke paling bawah di sini