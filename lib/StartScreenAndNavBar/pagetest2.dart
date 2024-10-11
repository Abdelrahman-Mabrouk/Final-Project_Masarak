import 'package:flutter/material.dart';

import 'bottomNavBar2.dart';

class PageTest2 extends StatelessWidget {
  const PageTest2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page Test 2'),
      ),
      bottomNavigationBar: BottomNavBar2(index: 2,),
    );
  }
}
