import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';
import 'package:masarak/StartScreenAndNavBar/homePage.dart';
import 'package:masarak/StartScreenAndNavBar/pagetest2.dart';
import 'package:masarak/StartScreenAndNavBar/pagetest3.dart';
import 'package:masarak/metroLines/metrolines.dart';
import 'package:masarak/setting/setting.dart';
// import 'package:masarak/homePage/homePage.dart';
import 'package:masarak/ticketPrice/ticketPrice.dart';


import 'Map/mainOfRouteAndMap.dart';



void main() {
  runApp(const MasarakApp());
}

class MasarakApp extends StatelessWidget {
  const MasarakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/pagetest1': (context) => Settings(),
        '/pagetest2': (context) => PageTest2(),//Replace PageTest2 with your page
        '/pagetest3': (context) => PageTest3(),//Replace PageTest3 with your page
        '/pagetest4': (context) => MetroLines(),
        '/pagetest5': (context) => TicketPrice(),
        // Define your page here
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Homepage(),
    );
  }
}