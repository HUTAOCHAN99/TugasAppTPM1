import 'package:flutter/material.dart';
import 'ui_helpers.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String current = '0';
  String expression = '';
  double? firstNumber;
  String? op;
  bool resetOnNextInput = false;

  void onButtonTap(String value) {
    setState(() {
      if (value == 'C') {
        current = '0';
        expression = '';
        firstNumber = null;
        op = null;
        resetOnNextInput = false;
        return;
      }

      if (value == '<') {
        if (resetOnNextInput) {
          current = '0';
          resetOnNextInput = false;
          return;
        }
        if (current.length > 1) {
          current = current.substring(0, current.length - 1);
        } else {
          current = '0';
        }
        return;
      }

      if (value == '+' || value == '-') {
        firstNumber = double.tryParse(current) ?? 0;
        op = value;
        expression = current + value;
        resetOnNextInput = true;
        return;
      }

      if (value == '=') {
        if (firstNumber != null && op != null) {
          final second = double.tryParse(current) ?? 0;
          double result = 0;
          if (op == '+') result = firstNumber! + second;
          if (op == '-') result = firstNumber! - second;

          expression = '${formatNum(firstNumber!)}$op${formatNum(second)}=';
          current = formatNum(result);
          firstNumber = null;
          op = null;
          resetOnNextInput = true;
        }
        return;
      }

      if (value == '.') {
        if (resetOnNextInput) {
          current = '0.';
          resetOnNextInput = false;
          return;
        }
        if (!current.contains('.')) {
          current += '.';
        }
        return;
      }

      if (resetOnNextInput || current == '0') {
        current = value;
        resetOnNextInput = false;
      } else {
        current += value;
      }
    });
  }

  String formatNum(double n) {
    if (n == n.toInt()) return n.toInt().toString();
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    const labels = [
      '7', '8', '9', '-',
      '4', '5', '6', '+',
      '1', '2', '3', '=',
      'C', '0', '.', '<',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
        backgroundColor: AppColors.purpleDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.outerBg,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                decoration: BoxDecoration(
                  color: AppColors.appBg,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        expression,
                        style: const TextStyle(
                          color: AppColors.titleGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          current,
                          style: const TextStyle(
                            color: Color(0xFF2E3748),
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    NumberPad(
                      labels: labels,
                      onTap: onButtonTap,
                      childAspectRatio: 1.15,
                      iconMap: const {
                        '<': Icons.backspace_outlined,
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}