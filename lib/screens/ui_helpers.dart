import 'package:flutter/material.dart';

class AppColors {
  static const outerBg = Color(0xFFDCDCDC);
  static const appBg = Color(0xFFF4F4F4);
  static const panel = Color(0xFFEDEDED);
  static const panelBorder = Color(0xFFD7D7D7);

  static const purpleDark = Color(0xFF6367FF);
  static const purpleMid = Color(0xFF8494FF);
  static const purpleLight = Color(0xFFC9BEFF);
  static const pinkLight = Color(0xFFFFDBFD);

  static const textDark = Color(0xFF33435C);
  static const titleGrey = Color(0xFF97A2B3);

  static const resultOrange = Color(0xFFF4DFC2);
  static const resultBlue = Color(0xFFDCE8FA);
}

Color keypadColor(String label) {
  if (['7', '8', '9', '-'].contains(label)) return AppColors.purpleDark;
  if (['4', '5', '6', '+'].contains(label)) return AppColors.purpleMid;
  if (['1', '2', '3', '='].contains(label)) return AppColors.purpleLight;
  return AppColors.pinkLight;
}

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.titleGrey,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class SoftPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double? height;

  const SoftPanel({
    super.key,
    required this.child,
    this.padding,
    this.radius = 18,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.panelBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double height;
  final Color? color;
  final double fontSize;
  final IconData? icon;

  const CalcButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 58,
    this.color,
    this.fontSize = 18,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? keypadColor(label);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: bg.withOpacity(0.18),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: AppColors.textDark, size: 22)
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: label == '7' ||
                              label == '8' ||
                              label == '9' ||
                              label == '-' ||
                              label == '4' ||
                              label == '5' ||
                              label == '6' ||
                              label == '+'
                          ? Colors.white
                          : AppColors.textDark,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class NumberPad extends StatelessWidget {
  final List<String> labels;
  final void Function(String) onTap;
  final double childAspectRatio;
  final Map<String, IconData>? iconMap;

  const NumberPad({
    super.key,
    required this.labels,
    required this.onTap,
    this.childAspectRatio = 1.35,
    this.iconMap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: labels.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final label = labels[index];
        return CalcButton(
          label: label,
          icon: iconMap?[label],
          onTap: () => onTap(label),
        );
      },
    );
  }
}