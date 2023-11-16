import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';

class PillContainer extends StatelessWidget {
  const PillContainer({
    super.key,
    required this.text,
    this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTheme.themeData.textTheme.labelLarge!.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
