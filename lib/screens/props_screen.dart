import 'package:flutter/material.dart';
import 'ui_helpers.dart';

class PropsScreen extends StatefulWidget {
  const PropsScreen({super.key});

  @override
  State<PropsScreen> createState() => _PropsScreenState();
}

class _PropsScreenState extends State<PropsScreen> {
  String input = '';

  void onTapKey(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
      } else if (value == '<') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        if (input == '0') {
          input = value;
        } else {
          input += value;
        }
      }
    });
  }

  int? get number => int.tryParse(input);

  String get oddEvenText {
    if (number == null) return '-';
    return number! % 2 == 0 ? 'GENAP' : 'GANJIL';
  }

  bool get isPrime {
    final n = number;
    if (n == null || n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const labels = [
      '7', '8', '9', '<',
      '4', '5', '6', 'C',
      '1', '2', '3', '0',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Bilangan'),
        backgroundColor: AppColors.purpleDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.outerBg,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Column(
          children: [
            const PageTitle('CEK BILANGAN'),
            SoftPanel(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
              radius: 20,
              child: Column(
                children: [
                  Text(
                    input.isEmpty ? '0' : input,
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.resultOrange,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              oddEvenText == '-' ? 'GANJIL / GENAP' : oddEvenText,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: oddEvenText == 'GANJIL'
                                    ? const Color(0xFFD75A00)
                                    : AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.resultBlue,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              number == null
                                  ? 'PRIMA'
                                  : (isPrime ? 'PRIMA' : 'BUKAN PRIMA'),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1F5DFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            NumberPad(
              labels: labels,
              onTap: onTapKey,
              childAspectRatio: 1.13,
              iconMap: const {
                '<': Icons.backspace_outlined,
              },
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}