import 'package:flutter/material.dart';
import 'package:masarak/AmrKhaled/bottomNavBar2.dart';



void main() {
  runApp(const MasarakApp());
}

class MasarakApp extends StatelessWidget {
  const MasarakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Scaffold(
        // body: Homepage(),
        bottomNavigationBar: BottomNavBar2(),
      ),
    );
  }
}

