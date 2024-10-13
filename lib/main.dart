import 'package:flutter/material.dart';

import 'package:masarak/homePage/homePage.dart';
import 'package:masarak/metroLines/lines.dart';
import 'package:masarak/setting/Setting.dart';
import 'package:masarak/ticketPrice/ticket.dart';
import 'package:masarak/ticketPrice/ticketPrice.dart';
import 'package:masarak/tripDetails/tripDetails.dart';
import 'StartScreenAndNavBar/splashScreen.dart';




void main() {
  runApp(const  MasarakApp());
}

class MasarakApp extends StatelessWidget {
  const MasarakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Setting': (context) => Setting(),
        '/TripDetails': (context) => TripDetails(metroRouteFinder: null,),
        '/homePage': (context) => homePage(),
        '/MetroLines': (context) => LinePage(),
        '/TicketPrice': (context) => TicketPage(),
        // Define your page here
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Splashscreen(),
    );
  }
}