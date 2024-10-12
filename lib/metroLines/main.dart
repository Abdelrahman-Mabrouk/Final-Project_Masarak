
import 'package:flutter/material.dart';
import 'package:masarak/metroLines/lines.dart';
import 'package:masarak/metroLines/ticket.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         body: LinePage(),
        //body: TicketPage(),
      ),
    );
  }
}
