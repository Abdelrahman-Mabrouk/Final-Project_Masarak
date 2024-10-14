import 'package:flutter/material.dart';

class NavBarText extends StatelessWidget {
  const NavBarText({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('       سعر التذكرة        خريطة المترو         الرئيسية                مسارك                الاعدادات', style: TextStyle(color: Colors.white, fontSize: 12),),
      ],
      ),
    );
  }
}
