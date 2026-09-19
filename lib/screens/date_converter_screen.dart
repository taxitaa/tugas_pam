import 'package:flutter/material.dart';
import 'dart:async';

class DateConverterScreen extends StatefulWidget {
  final int initialTab;
  const DateConverterScreen({super.key, this.initialTab = 0});

  @override
  State<DateConverterScreen> createState() => _DateConverterScreenState();
}

class _DateConverterScreenState extends State<DateConverterScreen> {
  DateTime? _selectedDate;
  Timer? _timer;
  Duration _ageDuration = Duration.zero;

  // Pasaran Weton Jawa & Saka Bali
  final List<String> _pasaran = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
  final List<String> _sakaMonths = ['Kasa', 'Karo', 'Katiga', 'Kapat', 'Kalima', 'Kanem', 'Kapitu', 'Kawolu', 'Kasanga', 'Kadasa', 'Jyestha', 'Sadha'];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_selectedDate != null) {
        setState(() {
          _ageDuration = DateTime.now().difference(_selectedDate!);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _toHijri(DateTime date) {
    int day = ((date.day + 13) % 30) + 1;
    int month = ((date.month + 4) % 12) + 1;
    int year = date.year - 579;
    return '$day-$month-$year H';
  }

  String _getWeton(DateTime date) {
    int diff = date.difference(DateTime(1900, 1, 1)).inDays;
    String p = _pasaran[diff % 5];
    return p;
  }

  String _toSakaBali(DateTime date) {
    int sakaYear = date.year - 78;
    String month = _sakaMonths[(date.month - 1) % 12];
    return 'Tahun $sakaYear Saka ($month)';
  }

  @override
  Widget build(BuildContext context) {
    int years = _ageDuration.inDays ~/ 365;
    int months = (_ageDuration.inDays % 365) ~/ 30;
    int days = (_ageDuration.inDays % 365) % 30;
    int hours = _ageDuration.inHours % 24;
    int minutes = _ageDuration.inMinutes % 60;
    int seconds = _ageDuration.inSeconds % 60;

    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Konversi Tanggal & Weton'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Umur, Hijriah & Weton'),
              Tab(text: 'Kalender Saka Bali'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE91E63), foregroundColor: Colors.white),
                    icon: const Icon(Icons.date_range),
                    label: Text(_selectedDate == null ? 'Pilih Tanggal Lahir Pengantin' : 'Ubah Tanggal (${_selectedDate.toString().split(' ')[0]})'),
                    onPressed: _pickDate,
                  ),
                  const SizedBox(height: 20),
                  if (_selectedDate != null) ...[
                    Card(
                      child: ListTile(
                        title: const Text('Umur Presisi Saat Ini', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('$years Tahun, $months Bulan, $days Hari\n$hours Jam, $minutes Menit, $seconds Detik'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Konversi Hijriah', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(_toHijri(_selectedDate!)),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Kalender Weton Jawa', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Hari Pasaran: ${_getWeton(_selectedDate!)}'),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            // Tab 2 (Saka Bali)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Konversi ke Kalender Saka Bali', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  if (_selectedDate != null)
                    Card(
                      color: Colors.pink.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Icon(Icons.temple_hindu_rounded, size: 50, color: Color(0xFFE91E63)),
                            const SizedBox(height: 10),
                            Text(_toSakaBali(_selectedDate!), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  else
                    const Text('Pilih tanggal lahir terlebih dahulu di Tab 1.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}