import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/navigation/presentation/main_page.dart';

class NavigationRoutes {
  static MaterialPageRoute Function() challengePageRoute =
      () => MaterialPageRoute(
            builder: (context) => const ChallengePage(),
          );

  static MaterialPageRoute Function() mainPageRoute = () => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );
}
