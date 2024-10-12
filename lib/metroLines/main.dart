
import 'package:flutter/material.dart';
import 'package:masarak/metroLines/ticket.dart';



class MyAp extends StatelessWidget {
  const MyAp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: LinePage(),
        body: TicketPage(),
      ),
    );
  }
}
