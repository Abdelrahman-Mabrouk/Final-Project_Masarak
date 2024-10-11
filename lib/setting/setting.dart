import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Settings'),
      ),
      bottomNavigationBar: BottomNavBar2(index: 1),
    );

  }
}