import 'package:flutter/material.dart';

enum DateCalculatorMode {
  wetonMarriage,
  sakaBaliMarriage,
}

class DateCalculatorHelper {
  static const List<String> pasaran = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
  static const List<String> sakaMonths = ['Kasa', 'Karo', 'Katiga', 'Kapat', 'Kalima', 'Kanem', 'Kapitu', 'Kawolu', 'Kasanga', 'Kadasa', 'Jyestha', 'Sadha'];

  static String getDayName(DateTime date) {
    const names = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return names[date.weekday % 7];
  }

  static int getPasaranIndex(DateTime date) {
    final diff = date.difference(DateTime(1900, 1, 1)).inDays;
    return diff % pasaran.length;
  }

  static String getWeton(DateTime date) {
    return pasaran[getPasaranIndex(date)];
  }

  static String getHijriDate(DateTime date) {
    final day = ((date.day + 13) % 30) + 1;
    final month = ((date.month + 4) % 12) + 1;
    final year = date.year - 579;
    return '$day-$month-$year H';
  }

  static String getHijriYear(DateTime date) {
    final hijriYear = date.year - 579;
    return '$hijriYear H';
  }

  static String getAgeDetail(DateTime birthDate, {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    final diff = now.difference(birthDate);
    final years = diff.inDays ~/ 365;
    final months = (diff.inDays % 365) ~/ 30;
    final days = (diff.inDays % 365) % 30;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;
    return '$years Tahun, $months Bulan, $days Hari, $hours Jam, $minutes Menit, $seconds Detik';
  }

  static String getCompatibilityStatus(DateTime first, DateTime second) {
    final difference = (getPasaranIndex(first) - getPasaranIndex(second)).abs();
    if (difference == 0) {
      return 'Cocok';
    }
    if (difference == 1 || difference == 2) {
      return 'Cukup cocok';
    }
    return 'Tidak cocok';
  }

  static String getWeddingRecommendation(DateTime first, DateTime second) {
    final status = getCompatibilityStatus(first, second);
    final bestDay = ['Senin', 'Kamis', 'Jumat'];
    final bestPasaran = ['Pahing', 'Wage', 'Legi'];
    final dayText = bestDay[(first.day + second.day) % bestDay.length];
    final pasaranText = bestPasaran[(first.month + second.month) % bestPasaran.length];

    if (status == 'Cocok') {
      return 'Rekomendasi tanggal pernikahan yang baik: hari $dayText dengan pasaran $pasaranText. Pilih tanggal yang jatuh pada hari baik dan tidak bertabrakan dengan acara keluarga.';
    }
    if (status == 'Cukup cocok') {
      return 'Rekomendasi tanggal pernikahan yang bagus: pilih hari $dayText atau Jumat, lalu pastikan pasaran $pasaranText sebagai penanda keseimbangan. Lakukan pertimbangan adat keluarga sebelum menetapkan hari akad.';
    }
    return 'Rekomendasi: pilih hari yang lebih seimbang secara weton, misalnya hari $dayText dengan pasaran $pasaranText dan konsultasikan dengan tokoh adat agar hasil pernikahan lebih optimal.';
  }

  static String getCompatibilityDetail(DateTime first, DateTime second) {
    final status = getCompatibilityStatus(first, second);
    final firstWeton = getWeton(first);
    final secondWeton = getWeton(second);

    switch (status) {
      case 'Cocok':
        return 'Keduanya memiliki pasaran yang harmonis sehingga cocok untuk menikah dengan peluang keseimbangan yang baik.';
      case 'Cukup cocok':
        return 'Pasaran mereka masih cukup sejalan, namun perlu mempertimbangkan hari baik dan pertimbangan keluarga.';
      default:
        return 'Pasaran mereka tidak terlalu selaras, sehingga sebaiknya dipertimbangkan kembali hari dan ritus pernikahan yang tepat.';
    }
  }

  static String toSakaBali(DateTime date) {
    final sakaYear = date.year - 78;
    final month = sakaMonths[(date.month - 1) % sakaMonths.length];
    return 'Tahun $sakaYear Saka ($month)';
  }

  static String getBaliMarriageAdvice(DateTime date) {
    final value = date.day + date.month + date.year;
    if (value % 2 == 0) {
      return 'Rekomendasi: pilih hari baik yang didukung oleh kalender Saka Bali serta rutinitas dan panduan adat keluarga.';
    }
    return 'Rekomendasi: fokus pada hari baik, upacara melasti, dan prosesi adat Bali yang sesuai dengan tradisi keluarga.';
  }

  static String getBaliDateQuality(DateTime date) {
    final dayScore = date.weekday;
    final dayName = getDayName(date);
    final pasaran = getWeton(date);

    final isGoodDay = dayScore == DateTime.monday || dayScore == DateTime.thursday || dayScore == DateTime.friday;
    final isGoodPasaran = pasaran == 'Pahing' || pasaran == 'Wage' || pasaran == 'Legi';

    if (isGoodDay && isGoodPasaran) {
      return 'Baik';
    }
    if (isGoodDay || isGoodPasaran) {
      return 'Cukup Baik';
    }
    return 'Kurang Baik';
  }

  static String getBaliDateQualityDetail(DateTime date) {
    final quality = getBaliDateQuality(date);
    final dayName = getDayName(date);
    final pasaran = getWeton(date);

    if (quality == 'Baik') {
      return 'Tanggal yang dipilih $dayName dengan pasaran $pasaran tergolong Baik untuk pernikahan Bali.';
    }
    if (quality == 'Cukup Baik') {
      return 'Tanggal yang dipilih $dayName dengan pasaran $pasaran tergolong Cukup Baik, namun masih perlu pengecekan hari baik secara adat.';
    }
    return 'Tanggal yang dipilih $dayName dengan pasaran $pasaran tergolong Kurang Baik untuk pernikahan Bali. Disarankan mengganti dengan hari yang lebih sesuai.';
  }
}

class DateConverterScreen extends StatefulWidget {
  final int initialTab;
  final DateCalculatorMode mode;

  const DateConverterScreen({
    super.key,
    this.initialTab = 0,
    this.mode = DateCalculatorMode.wetonMarriage,
  });

  @override
  State<DateConverterScreen> createState() => _DateConverterScreenState();
}

class _DateConverterScreenState extends State<DateConverterScreen> {
  DateTime? _firstPartnerDate;
  DateTime? _secondPartnerDate;
  DateTime? _weddingDate;

  Future<void> _pickDate({
    required bool futureAllowed,
    required String title,
    DateTime? initialDate,
    required void Function(DateTime) onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: futureAllowed ? DateTime(2100, 12, 31) : DateTime.now(),
      helpText: title,
    );

    if (picked != null) {
      setState(() {
        onPicked(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWetonMode = widget.mode == DateCalculatorMode.wetonMarriage;
    final appTitle = isWetonMode
        ? 'Perhitungan Pernikahan Weton'
        : 'Kalender Saka Bali & Adat Pernikahan';

    final tabs = isWetonMode
        ? const [Tab(text: 'Kecocokan Weton'), Tab(text: 'Detail Weton')]
        : const [Tab(text: 'Kalender Saka Bali'), Tab(text: 'Adat Pernikahan')];

    final firstTab = isWetonMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF472B6),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.favorite_rounded),
                label: Text(
                  _firstPartnerDate == null
                      ? 'Pilih Tanggal Lahir Pengantin 1'
                      : 'Ubah Pengantin 1 (${_firstPartnerDate!.day}/${_firstPartnerDate!.month}/${_firstPartnerDate!.year})',
                ),
                onPressed: () => _pickDate(
                  futureAllowed: false,
                  title: 'Tanggal lahir pengantin 1',
                  onPicked: (picked) => _firstPartnerDate = picked,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC4899),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.favorite_border_rounded),
                label: Text(
                  _secondPartnerDate == null
                      ? 'Pilih Tanggal Lahir Pengantin 2'
                      : 'Ubah Pengantin 2 (${_secondPartnerDate!.day}/${_secondPartnerDate!.month}/${_secondPartnerDate!.year})',
                ),
                onPressed: () => _pickDate(
                  futureAllowed: false,
                  title: 'Tanggal lahir pengantin 2',
                  onPicked: (picked) => _secondPartnerDate = picked,
                ),
              ),
              const SizedBox(height: 20),
              if (_firstPartnerDate != null && _secondPartnerDate != null) ...[
                Card(
                  child: ListTile(
                    title: const Text('Kecocokan Weton', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Pengantin 1: ${DateCalculatorHelper.getDayName(_firstPartnerDate!)} - ${DateCalculatorHelper.getWeton(_firstPartnerDate!)}\n'
                      'Pengantin 2: ${DateCalculatorHelper.getDayName(_secondPartnerDate!)} - ${DateCalculatorHelper.getWeton(_secondPartnerDate!)}\n\n'
                      'Status: ${DateCalculatorHelper.getCompatibilityStatus(_firstPartnerDate!, _secondPartnerDate!)}\n'
                      '${DateCalculatorHelper.getCompatibilityDetail(_firstPartnerDate!, _secondPartnerDate!)}',
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Umur Pengantin', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Pengantin 1: ${DateCalculatorHelper.getAgeDetail(_firstPartnerDate!)}\n\n'
                      'Pengantin 2: ${DateCalculatorHelper.getAgeDetail(_secondPartnerDate!)}',
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Tanggal Hijriah', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Pengantin 1: ${DateCalculatorHelper.getHijriDate(_firstPartnerDate!)}\n'
                      'Pengantin 2: ${DateCalculatorHelper.getHijriDate(_secondPartnerDate!)}\n\n'
                      'Tahun Hijriah: ${DateCalculatorHelper.getHijriYear(_firstPartnerDate!)} / ${DateCalculatorHelper.getHijriYear(_secondPartnerDate!)}',
                    ),
                  ),
                ),
              ] else
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Pilih tanggal lahir kedua pengantin untuk melihat hasil kecocokan weton.'),
                ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF60A5FA),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.calendar_month_rounded),
                label: Text(
                  _weddingDate == null
                      ? 'Pilih Tanggal Pernikahan'
                      : 'Ubah Tanggal (${_weddingDate!.day}/${_weddingDate!.month}/${_weddingDate!.year})',
                ),
                onPressed: () => _pickDate(
                  futureAllowed: true,
                  title: 'Tanggal pernikahan Bali',
                  initialDate: _weddingDate ?? DateTime.now().add(const Duration(days: 365)),
                  onPicked: (picked) => _weddingDate = picked,
                ),
              ),
              const SizedBox(height: 20),
              if (_weddingDate != null) ...[
                Card(
                  color: const Color(0xFFE0F2FE),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.temple_hindu_rounded, size: 42, color: Color(0xFF0284C7)),
                        const SizedBox(height: 8),
                        Text(
                          DateCalculatorHelper.toSakaBali(_weddingDate!),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tanggal: ${_weddingDate!.day}/${_weddingDate!.month}/${_weddingDate!.year}\n'
                          'Hari: ${DateCalculatorHelper.getDayName(_weddingDate!)}\n'
                          'Pasaran: ${DateCalculatorHelper.getWeton(_weddingDate!)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Pilih tanggal pernikahan untuk melihat kalender Saka Bali dan hari baik.'),
                ),
            ],
          );

    final secondTab = isWetonMode
        ? Column(
            children: [
              if (_firstPartnerDate != null && _secondPartnerDate != null)
                Card(
                  child: ListTile(
                    title: const Text('Ringkasan Weton Pernikahan', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Pengantin 1: ${DateCalculatorHelper.getDayName(_firstPartnerDate!)} - ${DateCalculatorHelper.getWeton(_firstPartnerDate!)}\n'
                      'Umur: ${DateCalculatorHelper.getAgeDetail(_firstPartnerDate!)}\n\n'
                      'Pengantin 2: ${DateCalculatorHelper.getDayName(_secondPartnerDate!)} - ${DateCalculatorHelper.getWeton(_secondPartnerDate!)}\n'
                      'Umur: ${DateCalculatorHelper.getAgeDetail(_secondPartnerDate!)}\n\n'
                      'Tanggal Hijriah: ${DateCalculatorHelper.getHijriDate(_firstPartnerDate!)} / ${DateCalculatorHelper.getHijriDate(_secondPartnerDate!)}\n\n'
                      'Kesimpulan: ${DateCalculatorHelper.getCompatibilityStatus(_firstPartnerDate!, _secondPartnerDate!)}\n'
                      '${DateCalculatorHelper.getCompatibilityDetail(_firstPartnerDate!, _secondPartnerDate!)}\n\n'
                      '${DateCalculatorHelper.getWeddingRecommendation(_firstPartnerDate!, _secondPartnerDate!)}',
                    ),
                  ),
                )
              else
                const Text('Pilih tanggal lahir kedua pengantin untuk melihat ringkasan pernikahan.'),
            ],
          )
        : Column(
            children: [
              if (_weddingDate != null)
                Card(
                  child: ListTile(
                    title: const Text('Adat Pernikahan Bali', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Kalender Saka Bali: ${DateCalculatorHelper.toSakaBali(_weddingDate!)}\n'
                      'Tanggal: ${_weddingDate!.day}/${_weddingDate!.month}/${_weddingDate!.year}\n'
                      'Hari: ${DateCalculatorHelper.getDayName(_weddingDate!)}\n'
                      'Status tanggal: ${DateCalculatorHelper.getBaliDateQuality(_weddingDate!)}\n\n'
                      '${DateCalculatorHelper.getBaliDateQualityDetail(_weddingDate!)}\n\n'
                      'Pernikahan Bali menekankan hari baik, penentuan tanggal yang tepat, dan ritual adat seperti melasti serta prosesi keluarga.\n\n'
                      '${DateCalculatorHelper.getBaliMarriageAdvice(_weddingDate!)}',
                    ),
                  ),
                )
              else
                const Text('Pilih tanggal pernikahan untuk menilai hari baik adat Bali.'),
            ],
          );

    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTab,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(
          children: [firstTab, secondTab],
        ),
      ),
    );
  }
}