import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';
import 'package:tcc_hpw_hello_programming_world/features/world/presentation/pages/world_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  static final List<Widget> _widgetOptions = <Widget>[
    const WorldPage(),
    const ChallengePage(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xffECEEEF),
        selectedItemColor: AppTheme.colorScheme.inversePrimary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Mundo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            label: 'Desafio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Amigos',
          ),
        ],
      ),
    );
  }
}
