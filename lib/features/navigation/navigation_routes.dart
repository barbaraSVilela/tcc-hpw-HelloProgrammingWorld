import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/get_help/presentation/get_help_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/presentation/give_help_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/navigation/presentation/main_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/presentation/pages/rewards_page.dart';

class NavigationRoutes {
  static MaterialPageRoute Function() challengePageRoute =
      () => MaterialPageRoute(
            builder: (context) => const ChallengePage(),
          );

  static MaterialPageRoute Function() mainPageRoute = () => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );

  static MaterialPageRoute Function() rewardsPageRoute =
      () => MaterialPageRoute(builder: (context) => const RewardsPage());

  static MaterialPageRoute Function(Challenge challenge) giveHelpRoute =
      (Challenge challenge) => MaterialPageRoute(
          builder: (context) => GiveHelpPage(
                challenge: challenge,
              ));

  static MaterialPageRoute Function(Challenge challenge) getHelpRoute =
      (Challenge challenge) => MaterialPageRoute(
          builder: (context) => GetHelpPage(
                challenge: challenge,
              ));
}
