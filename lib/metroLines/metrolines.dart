import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';

class MetroLines extends StatelessWidget {
  const MetroLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Metro Lines'),
      ),
      bottomNavigationBar: BottomNavBar2(index: 4),
    );
  }
}