import 'package:flutter/material.dart';
import 'package:masarak/AmrKhaled/bottomNavBar2.dart';
import 'package:masarak/tripDetails/tripDetails.dart';
import 'package:masarak/AmrKhaled/homePage.dart';

import 'Map/mainOfRouteAndMap.dart';



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
      home: RouteAndMapSection(),
    );
  }
}