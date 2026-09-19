import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchHelpScreen extends StatefulWidget {
  const StopwatchHelpScreen({super.key});

  @override
  State<StopwatchHelpScreen> createState() => _StopwatchHelpScreenState();
}

class _StopwatchHelpScreenState extends State<StopwatchHelpScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _toggleStopwatch() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetStopwatch() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSecs) {
    int mins = totalSecs ~/ 60;
    int secs = totalSecs % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stopwatch & Bantuan'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.timer), text: 'Stopwatch Acara'),
              Tab(icon: Icon(Icons.help_outline), text: 'Bantuan Aplikasi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Stopwatch
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_formatTime(_seconds), style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFFE91E63))),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: _isRunning ? Colors.orange : Colors.green, foregroundColor: Colors.white),
                        onPressed: _toggleStopwatch,
                        child: Text(_isRunning ? 'PAUSE' : 'MULAI'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        onPressed: _resetStopwatch,
                        child: const Text('RESET'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Bantuan
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ExpansionTile(
                  title: Text('1. Cara Login & Sesi'),
                  children: [Padding(padding: EdgeInsets.all(8), child: Text('Gunakan username: admin dan password: 123. Sesi login akan tetap tersimpan meski aplikasi ditutup.'))],
                ),
                ExpansionTile(
                  title: Text('2. Cara Mengelola Layanan (CRUD)'),
                  children: [Padding(padding: EdgeInsets.all(8), child: Text('Tekan tombol + di menu Vendor untuk menambah item baru. Gunakan ikon pensil/sampah untuk edit/hapus.'))],
                ),
                ExpansionTile(
                  title: Text('3. Fitur Konversi & Weton'),
                  children: [Padding(padding: EdgeInsets.all(8), child: Text('Pilih tanggal lahir pengantin untuk melihat umur presisi, kalender Hijriah, Weton Jawa, dan Saka Bali secara otomatis.'))],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}