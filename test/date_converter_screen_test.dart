import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_pam/screens/date_converter_screen.dart';

void main() {
  test('tanggal lahir pengantin yang memiliki pasaran sama terdeteksi cocok', () {
    final first = DateTime(1999, 1, 1);
    final second = DateTime(2000, 1, 1);

    expect(DateCalculatorHelper.isCompatible(first, second), isTrue);
  });

  test('tahun hijriah ditampilkan dalam format yang jelas', () {
    final date = DateTime(2026, 9, 19);

    expect(DateCalculatorHelper.getHijriYear(date), contains('H'));
  });
}
