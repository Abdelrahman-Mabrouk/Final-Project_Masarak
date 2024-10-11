import 'package:flutter/material.dart';

import 'bottomNavBar2.dart';

class PageTest3 extends StatelessWidget {
  const PageTest3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page Test 3'),
      ),
      bottomNavigationBar: BottomNavBar2(index: 3,),
    );
  }
}
