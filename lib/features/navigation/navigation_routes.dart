import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';

class NavigationRoutes {
  static MaterialPageRoute Function() challengePageRoute =
      () => MaterialPageRoute(
            builder: (context) => const ChallengePage(),
          );
}
