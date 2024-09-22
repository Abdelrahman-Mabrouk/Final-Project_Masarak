import 'package:flutter/material.dart';
import 'package:masarak/AmrKhaled//bottomNavBar.dart';
import 'package:masarak/AmrKhaled/NavBarText.dart';

class BottomNavBar2 extends StatefulWidget {
  const BottomNavBar2({super.key});

  @override
  State<BottomNavBar2> createState() => _BottomNavBar2State();
}

class _BottomNavBar2State extends State<BottomNavBar2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          top: 40,
          child: Container(
            decoration: const BoxDecoration(
            color: Color.fromARGB(255, 86, 95, 95),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
            child: NavBarText()
          )
        ),
        const BottomNavBar(),
    ]);
    
  }
}