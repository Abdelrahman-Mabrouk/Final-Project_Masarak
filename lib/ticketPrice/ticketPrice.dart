import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';

class TicketPrice extends StatelessWidget {
  const TicketPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ticket Price'),
      ),
      bottomNavigationBar: BottomNavBar2(index: 5),
    );
  }
}