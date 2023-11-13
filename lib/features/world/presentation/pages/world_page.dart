import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/features/navigation/navigation_routes.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({super.key});

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:ElevatedButton(
          onPressed: () async {
            Navigator.push(context, NavigationRoutes.rewardsPageRoute.call());
          },
          child: Text("Loja")
        ) );
  }
}
