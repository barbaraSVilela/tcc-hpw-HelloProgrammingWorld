import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';
import 'package:tcc_hpw_hello_programming_world/features/welcome/welcome_page.dart';

void main() {
  LocatorService.setup();
  runApp(Theme(data: AppTheme.themeData, child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HPW',
      home: const WelcomePage()
    );
  }
}
